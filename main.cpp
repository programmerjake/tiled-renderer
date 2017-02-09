/*
 * Copyright (C) 2017 Jacob R. Lifshay
 * This file is part of Tiled-Renderer.
 *
 * Tiled-Renderer is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Tiled-Renderer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Tiled-Renderer; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 */
#include "value_list.h"
#include "vector_list.h"
#include "matrix_list.h"
#include "image.h"
#include "rasterize_chunk.h"
#include <iostream>
#include <fstream>
#include <cstdint>
#include <cassert>
#include <string>
#include <chrono>
#include <vector>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <memory>
#include <deque>
#include <sstream>
#include "SDL.h"

using namespace tiled_renderer;

typedef ValueList<float, ValueListSize> FloatList;
typedef ValueList<std::int32_t, ValueListSize> I32List;
typedef ValueList<Bool32, ValueListSize> Bool32List;
typedef Vector4List<float, ValueListSize> Vector4FList;
typedef Vector4List<float, 1> Vector4F;
typedef Vector4List<std::int32_t, ValueListSize> Vector4I32List;
typedef Vector3List<float, ValueListSize> Vector3FList;
typedef Image<float> DepthImage;
typedef Vector4List<std::uint8_t, 1> Color;
typedef Image<Color> ColorImage;
typedef Matrix4x4List<1> Matrix4x4;

void writeImage(const std::string &fileName, const ColorImage &image)
{
    assert(image);
    assert(image.getLayers() >= 1);
    std::ofstream os(fileName, std::ios::binary);
    for(std::size_t layer = 0; layer < image.getLayers(); layer++)
    {
        os << "P6\n" << image.getWidth() << " " << image.getHeight() << "\n255\n";
        for(std::size_t y = 0; y < image.getHeight(); y++)
        {
            for(std::size_t x = 0; x < image.getWidth(); x++)
            {
                auto pixelValue = image.getElementUnchecked(x, y, layer);
                os.put(pixelValue.x.arrayValue[0]);
                os.put(pixelValue.y.arrayValue[0]);
                os.put(pixelValue.z.arrayValue[0]);
            }
        }
    }
}

template <typename T>
void clearImage(Image<T> &image, std::size_t layer, T clearColor) noexcept
{
    assert(layer < image.getLayers());
    for(std::size_t y = 0; y < image.getHeight(); y++)
    {
        for(std::size_t x = 0; x < image.getWidth(); x++)
        {
            image.setElementUnchecked(x, y, layer, clearColor);
        }
    }
}

template <std::size_t...>
struct LevelList final
{
};

template <std::size_t Level, std::size_t... Levels>
struct MakeLevelList;
template <std::size_t... Levels>
struct MakeLevelList<0, Levels...> final
{
    typedef LevelList<0, Levels...> type;
};
template <std::size_t Level, std::size_t... Levels>
struct MakeLevelList final
{
    typedef typename MakeLevelList<Level - 1, Level, Levels...>::type type;
};

constexpr std::size_t EdgeEquationFractionalBits = 18;

struct TriangleRenderState final
{
    struct Colors final
    {
        Color colors[ValueListSize];
        Colors() : colors{}
        {
        }
        Colors(Color color) : colors{}
        {
            for(auto &v : colors)
                v = color;
        }
        Colors(Vector4FList colorsF) : colors{}
        {
            for(std::size_t i = 0; i < ValueListSize; i++)
            {
                std::int32_t r = colorsF.x[i] * 0x100;
                r = r < 0 ? 0 : r > 0xFF ? 0xFF : r;
                std::int32_t g = colorsF.y[i] * 0x100;
                g = g < 0 ? 0 : g > 0xFF ? 0xFF : g;
                std::int32_t b = colorsF.z[i] * 0x100;
                b = b < 0 ? 0 : b > 0xFF ? 0xFF : b;
                std::int32_t a = colorsF.w[i] * 0x100;
                a = a < 0 ? 0 : a > 0xFF ? 0xFF : a;
                colors[i].x = r;
                colors[i].y = g;
                colors[i].z = b;
                colors[i].w = a;
            }
        }
    };
    struct PerLevelState final
    {
        I32List subchunks[3];
        I32List trivialReject[3];
        I32List trivialAccept[3];
    };
    ColorImage &colorImage;
    DepthImage &depthImage;
    const Vector4FList triangleP1;
    const Vector4FList triangleP2;
    const Vector4FList triangleP3;
    const Colors drawColors;
    const std::size_t triangleCount;
    PerLevelState perLevelStates[ValueListSize][MaxChunkLevel + 1];
    Bool32List drawTriangleMask;
    I32List edgeEquationConstants[3];
    I32List edgeEquationXSteps[3];
    I32List edgeEquationYSteps[3];
    Bool32List trivialReject;
    Bool32List trivialAccepts[3];
    const std::int32_t scissorX;
    const std::int32_t scissorY;
    const std::int32_t scissorWidth;
    const std::int32_t scissorHeight;
    bool good;
    TriangleRenderState(ColorImage &colorImage,
                        DepthImage &depthImage,
                        Vector4FList triangleP1,
                        Vector4FList triangleP2,
                        Vector4FList triangleP3,
                        Colors drawColors,
                        std::size_t triangleCount,
                        std::int32_t scissorX,
                        std::int32_t scissorY,
                        std::int32_t scissorWidth,
                        std::int32_t scissorHeight) noexcept : colorImage(colorImage),
                                                               depthImage(depthImage),
                                                               triangleP1(triangleP1),
                                                               triangleP2(triangleP2),
                                                               triangleP3(triangleP3),
                                                               drawColors(drawColors),
                                                               triangleCount(triangleCount),
                                                               perLevelStates{},
                                                               drawTriangleMask(true),
                                                               edgeEquationConstants{},
                                                               edgeEquationXSteps{},
                                                               edgeEquationYSteps{},
                                                               trivialReject(false),
                                                               trivialAccepts{},
                                                               scissorX(scissorX),
                                                               scissorY(scissorY),
                                                               scissorWidth(scissorWidth),
                                                               scissorHeight(scissorHeight),
                                                               good(true)
    {
        good = setup();
    }
    static Bool32List checkEdgeEquationList(const FloatList &constant,
                                            const FloatList &xStep,
                                            const FloatList &yStep,
                                            const FloatList &x,
                                            const FloatList &y) noexcept
    {
        return constant + xStep * x + yStep * y >= 0;
    }
    static Bool32List checkEdgeEquationList(const I32List &constant,
                                            const I32List &xStep,
                                            const I32List &yStep,
                                            const I32List &x,
                                            const I32List &y) noexcept
    {
        return constant + xStep * x + yStep * y >= 0;
    }
    template <std::size_t Level>
    char fillPerLevelStates(std::size_t triangleIndex) noexcept
    {
        PerLevelState &perLevelState = perLevelStates[triangleIndex][Level];
        for(std::size_t i = 0; i < 3; i++)
        {
            perLevelState.subchunks[i] =
                I32List(edgeEquationXSteps[i][triangleIndex]) * ChunkLevel<Level>::getXPositions()
                + I32List(edgeEquationYSteps[i][triangleIndex])
                      * ChunkLevel<Level>::getYPositions();
            perLevelState.trivialAccept[i] = perLevelState.subchunks[i];
            perLevelState.trivialReject[i] = perLevelState.subchunks[i];
            I32List oppositeX =
                I32List((ChunkLevel<Level>::xStepSize - 1) * edgeEquationXSteps[i][triangleIndex]);
            I32List oppositeY =
                I32List((ChunkLevel<Level>::yStepSize - 1) * edgeEquationYSteps[i][triangleIndex]);
            if(edgeEquationXSteps[i][triangleIndex] > 0)
                perLevelState.trivialReject[i] += oppositeX;
            else
                perLevelState.trivialAccept[i] += oppositeX;
            if(edgeEquationYSteps[i][triangleIndex] > 0)
                perLevelState.trivialReject[i] += oppositeY;
            else
                perLevelState.trivialAccept[i] += oppositeY;
        }
        return 0;
    }
    template <std::size_t... Levels>
    void fillAllPerLevelStates(std::size_t triangleIndex, const LevelList<Levels...> *) noexcept
    {
        char unused[] = {fillPerLevelStates<Levels>(triangleIndex)...};
        static_cast<void>(unused);
    }

private:
    bool setup() noexcept
    {
        Bool32List triangleCountMask(true);
        for(std::size_t i = triangleCount; i < ValueListSize; i++)
            triangleCountMask[i] = false;
        FloatList signedArea =
            (triangleP1.w * triangleP2.x - triangleP2.w * triangleP1.x) * triangleP3.y
            + (triangleP3.w * triangleP1.x - triangleP1.w * triangleP3.x) * triangleP2.y
            + (triangleP2.w * triangleP3.x - triangleP3.w * triangleP2.x) * triangleP1.y;
        drawTriangleMask &= signedArea > FloatList(0);
        drawTriangleMask &= triangleCountMask;
        if(!reduce(
               [](Bool32 a, Bool32 b)
               {
                   return a | b;
               },
               drawTriangleMask))
            return false;
        FloatList edgeEquationConstantsF[3] = {
            triangleP2.x * triangleP3.y - triangleP3.x * triangleP2.y,
            triangleP3.x * triangleP1.y - triangleP1.x * triangleP3.y,
            triangleP1.x * triangleP2.y - triangleP2.x * triangleP1.y,
        };
        FloatList edgeEquationXStepsF[3] = {
            triangleP2.y * triangleP3.w - triangleP3.y * triangleP2.w,
            triangleP3.y * triangleP1.w - triangleP1.y * triangleP3.w,
            triangleP1.y * triangleP2.w - triangleP2.y * triangleP1.w,
        };
        FloatList edgeEquationYStepsF[3] = {
            triangleP3.x * triangleP2.w - triangleP2.x * triangleP3.w,
            triangleP1.x * triangleP3.w - triangleP3.x * triangleP1.w,
            triangleP2.x * triangleP1.w - triangleP1.x * triangleP2.w,
        };
        FloatList edgeEquationSigns[3] = {
            signedArea * triangleP1.w, signedArea * triangleP2.w, signedArea * triangleP3.w,
        };
        for(std::size_t i = 0; i < 3; i++)
        {
            FloatList scaleFactor = map(
                [](float a, float b) -> float
                {
                    return static_cast<float>(static_cast<std::uint64_t>(1)
                                              << EdgeEquationFractionalBits)
                           / (std::fabs(a) + std::fabs(b));
                },
                edgeEquationXStepsF[i],
                edgeEquationYStepsF[i]);
            scaleFactor = select(edgeEquationSigns[i] > 0, scaleFactor, -scaleFactor);
            edgeEquationConstantsF[i] *= scaleFactor;
            edgeEquationXStepsF[i] *= scaleFactor;
            edgeEquationYStepsF[i] *= scaleFactor;
        }
        FloatList edgeEquationTrivialRejectX[3] = {};
        FloatList edgeEquationTrivialRejectY[3] = {};
        FloatList edgeEquationTrivialAcceptX[3] = {};
        FloatList edgeEquationTrivialAcceptY[3] = {};
        for(std::size_t i = 0; i < 3; i++)
        {
            auto compareResultX = edgeEquationXStepsF[i] > 0;
            auto compareResultY = edgeEquationYStepsF[i] > 0;
            edgeEquationTrivialRejectX[i] =
                select(compareResultX, FloatList(colorImage.getWidth() + 1), FloatList(-1.0f));
            edgeEquationTrivialRejectY[i] =
                select(compareResultY, FloatList(colorImage.getHeight() + 1), FloatList(-1.0f));
            edgeEquationTrivialAcceptX[i] =
                select(compareResultX, FloatList(-1.0f), FloatList(colorImage.getWidth() + 1));
            edgeEquationTrivialAcceptY[i] =
                select(compareResultY, FloatList(-1.0f), FloatList(colorImage.getHeight() + 1));
        }
        trivialReject = Bool32List(false);
        Bool32List trivialAccept = drawTriangleMask;
        for(std::size_t i = 0; i < 3; i++)
        {
            trivialReject |= !checkEdgeEquationList(edgeEquationConstantsF[i],
                                                    edgeEquationXStepsF[i],
                                                    edgeEquationYStepsF[i],
                                                    edgeEquationTrivialRejectX[i],
                                                    edgeEquationTrivialRejectY[i]);
            trivialAccepts[i] = checkEdgeEquationList(edgeEquationConstantsF[i],
                                                      edgeEquationXStepsF[i],
                                                      edgeEquationYStepsF[i],
                                                      edgeEquationTrivialAcceptX[i],
                                                      edgeEquationTrivialAcceptY[i]);
            trivialAccept &= trivialAccepts[i];
        }
        drawTriangleMask &= !trivialReject;
        drawTriangleMask &= triangleCountMask;
        if(!reduce(
               [](Bool32 a, Bool32 b)
               {
                   return a | b;
               },
               drawTriangleMask))
            return false;
        trivialAccept |= !triangleCountMask;
        if(reduce(
               [](Bool32 a, Bool32 b)
               {
                   return a & b;
               },
               trivialAccept))
            return true;
        for(std::size_t i = 0; i < 3; i++)
            edgeEquationXSteps[i] = static_cast<I32List>(edgeEquationXStepsF[i]);
        for(std::size_t i = 0; i < 3; i++)
            edgeEquationYSteps[i] = static_cast<I32List>(edgeEquationYStepsF[i]);
        for(std::size_t i = 0; i < 3; i++)
        {
            edgeEquationConstants[i] = static_cast<I32List>(edgeEquationConstantsF[i]);
            // handle top-left fill rule
            Bool32List isNonTopEdge = (edgeEquationXSteps[i] != 0) | (edgeEquationYSteps[i] <= 0);
            Bool32List isNonLeftEdge = edgeEquationXSteps[i] <= 0;
            edgeEquationConstants[i] += reinterpret<std::int32_t>(isNonTopEdge & isNonLeftEdge);
        }
        for(std::size_t triangleIndex = 0; triangleIndex < triangleCount; triangleIndex++)
            if(drawTriangleMask[triangleIndex] & !trivialAccept[triangleIndex])
                fillAllPerLevelStates(
                    triangleIndex,
                    static_cast<const MakeLevelList<MaxChunkLevel>::type *>(nullptr));
        return true;
    }
};

template <std::size_t Level,
          bool needsEdgeEquation0,
          bool needsEdgeEquation1,
          bool needsEdgeEquation2,
          bool needsScissorNX,
          bool needsScissorPX,
          bool needsScissorNY,
          bool needsScissorPY>
struct RenderTriangleHelper;

template <bool needsEdgeEquation0,
          bool needsEdgeEquation1,
          bool needsEdgeEquation2,
          bool needsScissorNX,
          bool needsScissorPX,
          bool needsScissorNY,
          bool needsScissorPY>
struct RenderTriangleHelper<0,
                            needsEdgeEquation0,
                            needsEdgeEquation1,
                            needsEdgeEquation2,
                            needsScissorNX,
                            needsScissorPX,
                            needsScissorNY,
                            needsScissorPY> final
{
    static constexpr std::size_t Level = 0;
    static void run(const TriangleRenderState &renderState,
                    std::size_t triangleIndex,
                    std::int32_t xOrigin,
                    std::int32_t yOrigin,
                    std::int32_t originEdgeEquation0Constant,
                    std::int32_t originEdgeEquation1Constant,
                    std::int32_t originEdgeEquation2Constant) noexcept
    {
        auto &perLevelState = renderState.perLevelStates[triangleIndex][Level];
        I32List xPositions = I32List(xOrigin) + ChunkLevel<Level>::getXPositions();
        I32List yPositions = I32List(yOrigin) + ChunkLevel<Level>::getYPositions();
        Bool32List passingPixels(true);
        if(needsEdgeEquation0)
            passingPixels &=
                I32List(originEdgeEquation0Constant) + perLevelState.trivialAccept[0] >= I32List(0);
        if(needsEdgeEquation1)
            passingPixels &=
                I32List(originEdgeEquation1Constant) + perLevelState.trivialAccept[1] >= I32List(0);
        if(needsEdgeEquation2)
            passingPixels &=
                I32List(originEdgeEquation2Constant) + perLevelState.trivialAccept[2] >= I32List(0);
        if(needsScissorNX)
            passingPixels &= xPositions >= I32List(renderState.scissorX);
        if(needsScissorNY)
            passingPixels &= yPositions >= I32List(renderState.scissorY);
        if(needsScissorPX)
            passingPixels &= xPositions < I32List(renderState.scissorX + renderState.scissorWidth);
        if(needsScissorPY)
            passingPixels &= yPositions < I32List(renderState.scissorY + renderState.scissorHeight);
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            if(passingPixels[i])
            {
#warning finish
                auto previousColor =
                    renderState.colorImage.getElementUnchecked(xPositions[i], yPositions[i], 0);
                renderState.colorImage.setElementUnchecked(
                    xPositions[i], yPositions[i], 0, renderState.drawColors.colors[triangleIndex]);
            }
        }
    }
};

template <std::size_t Level,
          bool needsEdgeEquation0,
          bool needsEdgeEquation1,
          bool needsEdgeEquation2,
          bool needsScissorNX,
          bool needsScissorPX,
          bool needsScissorNY,
          bool needsScissorPY>
struct RenderTriangleHelper final
{
    template <bool newNeedsEdgeEquation0, bool newNeedsEdgeEquation1, bool newNeedsEdgeEquation2>
    static void runSubchunk(const TriangleRenderState &renderState,
                            std::size_t triangleIndex,
                            std::int32_t xOrigin,
                            std::int32_t yOrigin,
                            std::int32_t originEdgeEquation0Constant,
                            std::int32_t originEdgeEquation1Constant,
                            std::int32_t originEdgeEquation2Constant,
                            const TriangleRenderState::PerLevelState &perLevelState,
                            const I32List &xPositions,
                            const I32List &yPositions,
                            std::size_t valueListIndex) noexcept
    {
#if 0
#warning debug code enabled
#else
        RenderTriangleHelper<Level - 1,
                             newNeedsEdgeEquation0,
                             newNeedsEdgeEquation1,
                             newNeedsEdgeEquation2,
                             needsScissorNX,
                             needsScissorPX,
                             needsScissorNY,
                             needsScissorPY>::
            run(renderState,
                triangleIndex,
                xPositions[valueListIndex],
                yPositions[valueListIndex],
                newNeedsEdgeEquation0 ?
                    originEdgeEquation0Constant + perLevelState.subchunks[0][valueListIndex] :
                    0,
                newNeedsEdgeEquation1 ?
                    originEdgeEquation1Constant + perLevelState.subchunks[1][valueListIndex] :
                    0,
                newNeedsEdgeEquation2 ?
                    originEdgeEquation2Constant + perLevelState.subchunks[2][valueListIndex] :
                    0);
#endif
    }
    static void run(const TriangleRenderState &renderState,
                    std::size_t triangleIndex,
                    std::int32_t xOrigin,
                    std::int32_t yOrigin,
                    std::int32_t originEdgeEquation0Constant,
                    std::int32_t originEdgeEquation1Constant,
                    std::int32_t originEdgeEquation2Constant) noexcept
    {
        auto &perLevelState = renderState.perLevelStates[triangleIndex][Level];
        I32List xPositions = I32List(xOrigin) + ChunkLevel<Level>::getXPositions();
        I32List yPositions = I32List(yOrigin) + ChunkLevel<Level>::getYPositions();
        Bool32List passingSubchunks(true);
        Bool32List triviallyAcceptedSubchunks[3] = {
            Bool32List(true), Bool32List(true), Bool32List(true),
        };
        if(needsScissorNX)
            passingSubchunks &=
                xPositions > I32List(renderState.scissorX - ChunkLevel<Level>::xStepSize);
        if(needsScissorNY)
            passingSubchunks &=
                yPositions > I32List(renderState.scissorY - ChunkLevel<Level>::yStepSize);
        if(needsScissorPX)
            passingSubchunks &=
                xPositions < I32List(renderState.scissorX + renderState.scissorWidth);
        if(needsScissorPY)
            passingSubchunks &=
                yPositions < I32List(renderState.scissorY + renderState.scissorHeight);
        if(needsEdgeEquation0)
        {
            passingSubchunks &=
                I32List(originEdgeEquation0Constant) + perLevelState.trivialReject[0] >= I32List(0);
            triviallyAcceptedSubchunks[0] =
                I32List(originEdgeEquation0Constant) + perLevelState.trivialAccept[0] >= I32List(0);
        }
        if(needsEdgeEquation1)
        {
            passingSubchunks &=
                I32List(originEdgeEquation1Constant) + perLevelState.trivialReject[1] >= I32List(0);
            triviallyAcceptedSubchunks[1] =
                I32List(originEdgeEquation1Constant) + perLevelState.trivialAccept[1] >= I32List(0);
        }
        if(needsEdgeEquation2)
        {
            passingSubchunks &=
                I32List(originEdgeEquation2Constant) + perLevelState.trivialReject[2] >= I32List(0);
            triviallyAcceptedSubchunks[2] =
                I32List(originEdgeEquation2Constant) + perLevelState.trivialAccept[2] >= I32List(0);
        }
#if 0
#warning debug code enabled
        triviallyAcceptedSubchunks[0] = Bool32List(false);
        triviallyAcceptedSubchunks[1] = Bool32List(false);
        triviallyAcceptedSubchunks[2] = Bool32List(false);
#endif
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
#if 0
#warning debug code enabled
#else
            if(!passingSubchunks[i])
                continue;
#endif
            if(!needsEdgeEquation0 | triviallyAcceptedSubchunks[0][i])
            {
                if(!needsEdgeEquation1 | triviallyAcceptedSubchunks[1][i])
                {
                    if(!needsEdgeEquation2 | triviallyAcceptedSubchunks[2][i])
                    {
                        runSubchunk<false, false, false>(renderState,
                                                         triangleIndex,
                                                         xOrigin,
                                                         yOrigin,
                                                         originEdgeEquation0Constant,
                                                         originEdgeEquation1Constant,
                                                         originEdgeEquation2Constant,
                                                         perLevelState,
                                                         xPositions,
                                                         yPositions,
                                                         i);
                    }
                    else
                    {
                        runSubchunk<false, false, true>(renderState,
                                                        triangleIndex,
                                                        xOrigin,
                                                        yOrigin,
                                                        originEdgeEquation0Constant,
                                                        originEdgeEquation1Constant,
                                                        originEdgeEquation2Constant,
                                                        perLevelState,
                                                        xPositions,
                                                        yPositions,
                                                        i);
                    }
                }
                else
                {
                    if(!needsEdgeEquation2 | triviallyAcceptedSubchunks[2][i])
                    {
                        runSubchunk<false, true, false>(renderState,
                                                        triangleIndex,
                                                        xOrigin,
                                                        yOrigin,
                                                        originEdgeEquation0Constant,
                                                        originEdgeEquation1Constant,
                                                        originEdgeEquation2Constant,
                                                        perLevelState,
                                                        xPositions,
                                                        yPositions,
                                                        i);
                    }
                    else
                    {
                        runSubchunk<false, true, true>(renderState,
                                                       triangleIndex,
                                                       xOrigin,
                                                       yOrigin,
                                                       originEdgeEquation0Constant,
                                                       originEdgeEquation1Constant,
                                                       originEdgeEquation2Constant,
                                                       perLevelState,
                                                       xPositions,
                                                       yPositions,
                                                       i);
                    }
                }
            }
            else
            {
                if(!needsEdgeEquation1 | triviallyAcceptedSubchunks[1][i])
                {
                    if(!needsEdgeEquation2 | triviallyAcceptedSubchunks[2][i])
                    {
                        runSubchunk<true, false, false>(renderState,
                                                        triangleIndex,
                                                        xOrigin,
                                                        yOrigin,
                                                        originEdgeEquation0Constant,
                                                        originEdgeEquation1Constant,
                                                        originEdgeEquation2Constant,
                                                        perLevelState,
                                                        xPositions,
                                                        yPositions,
                                                        i);
                    }
                    else
                    {
                        runSubchunk<true, false, true>(renderState,
                                                       triangleIndex,
                                                       xOrigin,
                                                       yOrigin,
                                                       originEdgeEquation0Constant,
                                                       originEdgeEquation1Constant,
                                                       originEdgeEquation2Constant,
                                                       perLevelState,
                                                       xPositions,
                                                       yPositions,
                                                       i);
                    }
                }
                else
                {
                    if(!needsEdgeEquation2 | triviallyAcceptedSubchunks[2][i])
                    {
                        runSubchunk<true, true, false>(renderState,
                                                       triangleIndex,
                                                       xOrigin,
                                                       yOrigin,
                                                       originEdgeEquation0Constant,
                                                       originEdgeEquation1Constant,
                                                       originEdgeEquation2Constant,
                                                       perLevelState,
                                                       xPositions,
                                                       yPositions,
                                                       i);
                    }
                    else
                    {
                        runSubchunk<true, true, true>(renderState,
                                                      triangleIndex,
                                                      xOrigin,
                                                      yOrigin,
                                                      originEdgeEquation0Constant,
                                                      originEdgeEquation1Constant,
                                                      originEdgeEquation2Constant,
                                                      perLevelState,
                                                      xPositions,
                                                      yPositions,
                                                      i);
                    }
                }
            }
        }
#warning finish
    }
};

struct Triangle final
{
    Vector4F p1;
    Vector4F p2;
    Vector4F p3;
    Color color;
    Triangle()
    {
    }
    Triangle(Vector4F p1, Vector4F p2, Vector4F p3, Color color)
        : p1(p1), p2(p2), p3(p3), color(color)
    {
    }
};

struct ThreadedTaskRunner final
{
    ThreadedTaskRunner(const ThreadedTaskRunner &) = delete;
    ThreadedTaskRunner &operator=(const ThreadedTaskRunner &) = delete;
    struct Fence final
    {
        std::mutex lock;
        std::condition_variable cond;
        std::size_t scheduledTaskCount;
        void waitForCompletion()
        {
            std::unique_lock<std::mutex> lockIt(lock);
            while(scheduledTaskCount > 0)
            {
                cond.wait(lockIt);
            }
        }
        void addTask()
        {
            std::unique_lock<std::mutex> lockIt(lock);
            scheduledTaskCount++;
        }
        void taskFinished()
        {
            std::unique_lock<std::mutex> lockIt(lock);
            scheduledTaskCount--;
            if(scheduledTaskCount == 0)
                cond.notify_all();
        }
    };
    struct Task
    {
        std::shared_ptr<Fence> fence;
        explicit Task(std::shared_ptr<Fence> fence) : fence(fence)
        {
        }
        virtual ~Task() = default;
        virtual void run() noexcept = 0;
    };
    std::vector<std::thread> threads;
    std::mutex lock;
    std::condition_variable cond;
    bool done = false;
    std::deque<std::shared_ptr<Task>> tasks;
    std::size_t waitingThreadCount = 0;
    void threadFn() noexcept
    {
        std::unique_lock<std::mutex> lockIt(lock);
        while(true)
        {
            if(done)
                break;
            if(tasks.empty())
            {
                waitingThreadCount++;
                cond.wait(lockIt);
                waitingThreadCount--;
                continue;
            }
            auto task = std::move(tasks.front());
            tasks.pop_front();
            lockIt.unlock();
            task->run();
            if(task->fence)
                task->fence->taskFinished();
            lockIt.lock();
        }
    }
    ~ThreadedTaskRunner()
    {
        std::unique_lock<std::mutex> lockIt(lock);
        done = true;
        cond.notify_all();
        lockIt.unlock();
        for(auto &thread : threads)
            thread.join();
    }
    explicit ThreadedTaskRunner(std::size_t threadCount = std::thread::hardware_concurrency())
    {
        threads.resize(threadCount);
        for(auto &thread : threads)
        {
            thread = std::thread([this]()
                                 {
                                     threadFn();
                                 });
        }
    }
    void addTask(std::shared_ptr<Task> task)
    {
        assert(task);
        if(threads.empty())
        {
            task->run();
            return;
        }
        if(task->fence)
            task->fence->addTask();
        std::unique_lock<std::mutex> lockIt(lock);
        tasks.push_back(std::move(task));
        if(waitingThreadCount != 0)
            cond.notify_one();
    }
    std::size_t getParallelism() const noexcept
    {
        return threads.empty() ? 1 : threads.size();
    }
};

template <typename Fn>
void runInThreads(ThreadedTaskRunner &threadedTaskRunner, std::size_t threadCount, Fn fn)
{
    assert(threadCount != 0);
    auto fence = std::make_shared<ThreadedTaskRunner::Fence>();
    for(std::size_t i = 0; i < threadCount; i++)
    {
        struct MyTask final : public ThreadedTaskRunner::Task
        {
            const std::size_t threadIndex;
            Fn fn;
            explicit MyTask(std::shared_ptr<ThreadedTaskRunner::Fence> fence,
                            std::size_t threadIndex,
                            Fn fn)
                : Task(std::move(fence)), threadIndex(threadIndex), fn(std::move(fn))
            {
            }
            virtual void run() noexcept override
            {
                fn(threadIndex);
            }
        };
        threadedTaskRunner.addTask(std::make_shared<MyTask>(fence, i, fn));
    }
    fence->waitForCompletion();
}

void renderTriangles(ColorImage &colorImage,
                     DepthImage &depthImage,
                     const Triangle *const triangles,
                     const std::size_t triangleCount,
                     Matrix4x4 tform,
                     ThreadedTaskRunner &threadedTaskRunner) noexcept
{
    assert(colorImage.getWidth() == depthImage.getWidth()
           && colorImage.getHeight() == depthImage.getHeight());
    if(colorImage.getWidth() == 0 || colorImage.getHeight() == 0 || triangleCount == 0)
        return;
    assert(colorImage.getLayers() == 1 && depthImage.getLayers() == 1);
    std::vector<std::vector<TriangleRenderState>> renderStates;
    std::size_t triangleGroupCount = (triangleCount + ValueListSize - 1) / ValueListSize;
    std::size_t setupThreadCount = triangleGroupCount / 1000;
    if(setupThreadCount == 0)
        setupThreadCount = 1;
    std::size_t maxParallelism =4 * threadedTaskRunner.getParallelism();
    if(setupThreadCount > maxParallelism)
        setupThreadCount = maxParallelism;
    renderStates.resize(setupThreadCount);
    runInThreads(
        threadedTaskRunner,
        setupThreadCount,
        [&](std::size_t threadIndex)
        {
            std::size_t startGroupIndex = threadIndex * (triangleGroupCount / setupThreadCount);
            std::size_t endGroupIndex = (threadIndex + 1) * (triangleGroupCount / setupThreadCount);
            if(endGroupIndex > triangleGroupCount)
                endGroupIndex = triangleGroupCount;
            renderStates[threadIndex].reserve(endGroupIndex - startGroupIndex);
            for(std::size_t groupIndex = startGroupIndex; groupIndex < endGroupIndex; groupIndex++)
            {
                Vector4FList p1, p2, p3;
                TriangleRenderState::Colors colors;
                std::size_t currentTriangleCount = triangleCount - ValueListSize * groupIndex;
                if(currentTriangleCount > ValueListSize)
                    currentTriangleCount = ValueListSize;
                for(std::size_t i = 0; i < currentTriangleCount; i++)
                {
                    p1.x[i] = triangles[i + groupIndex * ValueListSize].p1.x[0];
                    p1.y[i] = triangles[i + groupIndex * ValueListSize].p1.y[0];
                    p1.z[i] = triangles[i + groupIndex * ValueListSize].p1.z[0];
                    p1.w[i] = triangles[i + groupIndex * ValueListSize].p1.w[0];
                    p2.x[i] = triangles[i + groupIndex * ValueListSize].p2.x[0];
                    p2.y[i] = triangles[i + groupIndex * ValueListSize].p2.y[0];
                    p2.z[i] = triangles[i + groupIndex * ValueListSize].p2.z[0];
                    p2.w[i] = triangles[i + groupIndex * ValueListSize].p2.w[0];
                    p3.x[i] = triangles[i + groupIndex * ValueListSize].p3.x[0];
                    p3.y[i] = triangles[i + groupIndex * ValueListSize].p3.y[0];
                    p3.z[i] = triangles[i + groupIndex * ValueListSize].p3.z[0];
                    p3.w[i] = triangles[i + groupIndex * ValueListSize].p3.w[0];
                    colors.colors[i] = triangles[i + groupIndex * ValueListSize].color;
                }
                p1 = tform.apply(p1);
                p2 = tform.apply(p2);
                p3 = tform.apply(p3);
                renderStates[threadIndex].emplace_back(colorImage,
                                                       depthImage,
                                                       p1,
                                                       p2,
                                                       p3,
                                                       colors,
                                                       currentTriangleCount,
                                                       0,
                                                       0,
                                                       colorImage.getWidth(),
                                                       colorImage.getHeight());
                if(!renderStates[threadIndex].back().good)
                    renderStates[threadIndex].pop_back();
            }
        });
    std::size_t chunkXCount = (colorImage.getWidth() + ChunkLevel<MaxChunkLevel>::totalWidth - 1)
                              / ChunkLevel<MaxChunkLevel>::totalWidth;
    std::size_t chunkYCount = (colorImage.getHeight() + ChunkLevel<MaxChunkLevel>::totalHeight - 1)
                              / ChunkLevel<MaxChunkLevel>::totalHeight;
    std::size_t chunkCount = chunkXCount * chunkYCount;
    std::size_t renderThreadCount = triangleCount * chunkCount;
    if(renderThreadCount == 0)
        renderThreadCount = 1;
    if(renderThreadCount > chunkCount)
        renderThreadCount = chunkCount;
    if(renderThreadCount > maxParallelism)
        renderThreadCount = maxParallelism;
    runInThreads(
        threadedTaskRunner,
        renderThreadCount,
        [&](std::size_t threadIndex)
        {
            for(std::size_t chunkIndex = threadIndex; chunkIndex < chunkCount;
                chunkIndex += renderThreadCount)
            {
                std::size_t x = (chunkIndex % chunkXCount) * ChunkLevel<MaxChunkLevel>::totalWidth;
                std::size_t y = (chunkIndex / chunkXCount) * ChunkLevel<MaxChunkLevel>::totalHeight;
                for(auto &renderStateGroup : renderStates)
                {
                    for(auto &renderState : renderStateGroup)
                    {
                        for(std::size_t triangleIndex = 0;
                            triangleIndex < renderState.triangleCount;
                            triangleIndex++)
                        {
                            if(renderState.drawTriangleMask[triangleIndex])
                            {
                                RenderTriangleHelper<MaxChunkLevel,
                                                     true,
                                                     true,
                                                     true,
                                                     false,
                                                     true,
                                                     false,
                                                     true>::
                                    run(renderState,
                                        triangleIndex,
                                        x,
                                        y,
                                        renderState.edgeEquationXSteps[0][triangleIndex] * x
                                            + renderState.edgeEquationYSteps[0][triangleIndex] * y
                                            + renderState.edgeEquationConstants[0][triangleIndex],
                                        renderState.edgeEquationXSteps[1][triangleIndex] * x
                                            + renderState.edgeEquationYSteps[1][triangleIndex] * y
                                            + renderState.edgeEquationConstants[1][triangleIndex],
                                        renderState.edgeEquationXSteps[2][triangleIndex] * x
                                            + renderState.edgeEquationYSteps[2][triangleIndex] * y
                                            + renderState.edgeEquationConstants[2][triangleIndex]);
                            }
                        }
                    }
                }
            }
        });
}

Vector4F getPoint(float u, float v)
{
    u *= 2 * M_PI;
    v *= M_PI;
    return Vector4F(std::sin(u) * std::sin(v), std::cos(v), std::cos(u) * std::sin(v), 1);
}

Vector4F getPointNormal(float u, float v)
{
    u *= 2 * M_PI;
    v *= M_PI;
    return Vector4F(std::sin(u) * std::sin(v), std::cos(v), std::cos(u) * std::sin(v), 0);
}

Triangle getTriangle(std::size_t triangleIndex, std::size_t uCount, std::size_t vCount)
{
    bool isSecondPartOfQuad = triangleIndex % 2;
    triangleIndex /= 2;
    float u0 = static_cast<float>(triangleIndex % uCount) / uCount;
    float v0 = static_cast<float>(triangleIndex / uCount) / vCount;
    float u1 = static_cast<float>(triangleIndex % uCount + 1) / uCount;
    float v1 = static_cast<float>(triangleIndex / uCount + 1) / vCount;
    Triangle retval;
    if(isSecondPartOfQuad)
    {
        retval.p1 = getPoint(u0, v0);
        retval.p2 = getPoint(u1, v0);
        retval.p3 = getPoint(u1, v1);
    }
    else
    {
        retval.p1 = getPoint(u0, v0);
        retval.p2 = getPoint(u1, v1);
        retval.p3 = getPoint(u0, v1);
    }
    Vector4F normal = getPointNormal(0.5f * (u0 + u1), 0.5f * (v0 + v1));
    normal /= Vector4F(normal.abs());
    Vector4F colorF(0.3f, 0.3f, 0.3f, 1);
    if(isSecondPartOfQuad)
        colorF = Vector4F(0.2f, 0.2f, 0.2f, 1);
    struct Light final
    {
        Vector4F direction;
        Vector4F color;
        Light(Vector4F direction, Vector4F color)
            : direction(direction / Vector4F(direction.abs())), color(color)
        {
        }
    };
    Light lights[] = {
        Light(Vector4F(0, 0, 1, 0), Vector4F(1, 0, 0, 0)),
        Light(Vector4F(std::sqrt(0.75f), 0, -0.5f, 0), Vector4F(0, 1, 0, 0)),
        Light(Vector4F(-std::sqrt(0.75f), 1, -0.5f, 0), Vector4F(0, 0, 1, 0)),
    };
    for(Light &light : lights)
    {
        float dot = normal.dot(light.direction)[0];
        if(dot < 0)
            dot = 0;
        float intensity = dot * 0.7f;
        colorF += Vector4F(intensity) * light.color;
    }
    auto colorI32 = Vector4List<std::int32_t, 1>(colorF * Vector4F(0xFF));
    ValueList<std::int32_t, 1> minV(0), maxV(0xFF);
    colorI32.x = select(colorI32.x < minV, minV, colorI32.x);
    colorI32.y = select(colorI32.y < minV, minV, colorI32.y);
    colorI32.z = select(colorI32.z < minV, minV, colorI32.z);
    colorI32.w = select(colorI32.w < minV, minV, colorI32.w);
    colorI32.x = select(colorI32.x > maxV, maxV, colorI32.x);
    colorI32.y = select(colorI32.y > maxV, maxV, colorI32.y);
    colorI32.z = select(colorI32.z > maxV, maxV, colorI32.z);
    colorI32.w = select(colorI32.w > maxV, maxV, colorI32.w);
    retval.color = static_cast<Color>(colorI32);
    return retval;
}

void renderFrame(ColorImage &colorImage,
                 DepthImage &depthImage,
                 ThreadedTaskRunner &threadedTaskRunner)
{
    clearImage(colorImage, 0, {0x80, 0xC0, 0xFF, 0xFF});
    clearImage(depthImage, 0, INFINITY);
    double currentTime = std::chrono::duration_cast<std::chrono::duration<double>>(
                             std::chrono::steady_clock::now().time_since_epoch()).count();
    Matrix4x4 tform;
    tform = Matrix4x4::rotateY(currentTime * M_PI * 2 / 10);
    tform = tform.concat(Matrix4x4::rotateX(currentTime * M_PI * 2 / std::sqrt(2) / 10));
    tform = tform.concat(Matrix4x4::translate(0, 0, -2));
    float scaleX = colorImage.getWidth();
    float scaleY = colorImage.getHeight();
    scaleX /= colorImage.getHeight();
    scaleY /= colorImage.getWidth();
    if(scaleX < 1)
        scaleX = 1;
    if(scaleY < 1)
        scaleY = 1;
    float nearPlane = 0.01f;
    float farPlane = 100.0f;
    tform = tform.concat(Matrix4x4::frustum(-nearPlane * scaleX,
                                            nearPlane * scaleX,
                                            -nearPlane * scaleY,
                                            nearPlane * scaleY,
                                            nearPlane,
                                            farPlane));
    tform = tform.concat(Matrix4x4(colorImage.getWidth() / 2.0f,
                                   0,
                                   0,
                                   colorImage.getWidth() / 2.0f,
                                   0,
                                   colorImage.getHeight() / -2.0f,
                                   0,
                                   colorImage.getHeight() / 2.0f,
                                   0,
                                   0,
                                   0.5f,
                                   0.5f));
    std::size_t uCount = 20;
    std::size_t vCount = 20;
    std::size_t triangleCount = uCount * vCount * 2;
    std::vector<Triangle> triangles;
    triangles.reserve(triangleCount);
    bool reverseTriangles = std::fmod(currentTime, 10) < 2;
    for(std::size_t triangleIndex = 0; triangleIndex < triangleCount; triangleIndex++)
    {
        Vector4F currentP1, currentP2, currentP3;
        triangles.push_back(getTriangle(triangleIndex, uCount, vCount));
        if(reverseTriangles)
        {
            auto temp = triangles.back().p1;
            triangles.back().p1 = triangles.back().p2;
            triangles.back().p2 = temp;
        }
    }
    renderTriangles(
        colorImage, depthImage, triangles.data(), triangles.size(), tform, threadedTaskRunner);
}


int main()
{
    std::size_t initialWidth = 16, initialHeight = 9;
    ColorImage colorImage(initialWidth, initialHeight, 1);
    DepthImage depthImage(initialWidth, initialHeight, 1);
    ThreadedTaskRunner threadedTaskRunner{};
    if(SDL_Init(SDL_INIT_VIDEO) != 0)
    {
        std::cerr << "SDL_Init failed: " << SDL_GetError() << std::endl;
        return 1;
    }
    SDL_Window *window = nullptr;
    SDL_Renderer *renderer = nullptr;
    if(SDL_CreateWindowAndRenderer(
           initialWidth, initialHeight, SDL_WINDOW_RESIZABLE, &window, &renderer) != 0)
    {
        std::cerr << "SDL_CreateWindowAndRenderer failed: " << SDL_GetError() << std::endl;
        SDL_Quit();
        return 1;
    }
    SDL_SetWindowMinimumSize(window, 1, 1);
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
    constexpr auto pixelFormat = SDL_PIXELFORMAT_RGBA8888;
#else
    constexpr auto pixelFormat = SDL_PIXELFORMAT_ABGR8888;
#endif
    SDL_Texture *texture = SDL_CreateTexture(
        renderer, pixelFormat, SDL_TEXTUREACCESS_STREAMING, initialWidth, initialHeight);
    if(!texture)
    {
        std::cerr << "SDL_CreateTexture failed: " << SDL_GetError() << std::endl;
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }
    auto lastFPSReportTime = std::chrono::steady_clock::now();
    std::size_t framesSinceLastFPSReport = 0;
    bool done = false;
    while(!done)
    {
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        std::size_t width = w, height = h;
        if(width != colorImage.getWidth() || height != colorImage.getHeight())
        {
            colorImage = ColorImage();
            depthImage = DepthImage();
            colorImage = ColorImage(width, height, 1);
            depthImage = DepthImage(width, height, 1);
            SDL_DestroyTexture(texture);
            texture = SDL_CreateTexture(
                renderer, pixelFormat, SDL_TEXTUREACCESS_STREAMING, width, height);
            if(!texture)
            {
                std::cerr << "SDL_CreateTexture failed: " << SDL_GetError() << std::endl;
                SDL_DestroyRenderer(renderer);
                SDL_DestroyWindow(window);
                SDL_Quit();
                return 1;
            }
        }
        renderFrame(colorImage, depthImage, threadedTaskRunner);
        framesSinceLastFPSReport++;
        auto currentTime = std::chrono::steady_clock::now();
        if(currentTime - std::chrono::seconds(1) >= lastFPSReportTime)
        {
            float elapsedTime = std::chrono::duration_cast<std::chrono::duration<float>>(
                                    currentTime - lastFPSReportTime).count();
            lastFPSReportTime = currentTime;
            std::ostringstream ss;
            ss << "FPS: " << framesSinceLastFPSReport / elapsedTime;
            framesSinceLastFPSReport = 0;
            std::cout << ss.str() << std::endl;
            SDL_SetWindowTitle(window, ss.str().c_str());
        }
        void *pixels = nullptr;
        int pitch = 0;
        if(SDL_LockTexture(texture, nullptr, &pixels, &pitch) != 0)
        {
            std::cerr << "SDL_LockTexture failed: " << SDL_GetError() << std::endl;
            SDL_DestroyTexture(texture);
            SDL_DestroyRenderer(renderer);
            SDL_DestroyWindow(window);
            SDL_Quit();
            return 1;
        }
        for(std::size_t y = 0; y < height; y++)
        {
            unsigned char *currentPixel = static_cast<unsigned char *>(pixels) + pitch * y;
            for(std::size_t x = 0; x < width; x++)
            {
                auto color = colorImage.getElementUnchecked(x, y, 0);
                *currentPixel++ = color.x[0];
                *currentPixel++ = color.y[0];
                *currentPixel++ = color.z[0];
                *currentPixel++ = color.w[0];
            }
        }
        SDL_UnlockTexture(texture);
        SDL_RenderClear(renderer);
        SDL_RenderCopy(renderer, texture, nullptr, nullptr);
        SDL_RenderPresent(renderer);
        SDL_Event event;
        while(SDL_PollEvent(&event))
        {
            switch(event.type)
            {
            case SDL_QUIT:
                done = true;
                break;
            case SDL_KEYDOWN:
                if(event.key.keysym.sym == SDLK_ESCAPE
                   || (event.key.keysym.sym == SDLK_F4
                       && (event.key.keysym.mod & (KMOD_CTRL | KMOD_SHIFT)) == 0
                       && (event.key.keysym.mod & KMOD_ALT) != 0))
                    done = true;
                break;
            }
        }
    }
    writeImage("out.ppm", colorImage);
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}
