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
#include <cstring>
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

constexpr std::size_t EdgeEquationFractionalBits = 14;
constexpr std::size_t PositionFractionalBits = 2;
constexpr std::size_t WFractionalBits = 9;

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
        float intPositionScale = static_cast<std::uint64_t>(1) << PositionFractionalBits;
        float intWScale = static_cast<std::uint64_t>(1) << WFractionalBits;
        I32List intPX[3] = {
            static_cast<I32List>(triangleP1.x * FloatList(intPositionScale)),
            static_cast<I32List>(triangleP2.x * FloatList(intPositionScale)),
            static_cast<I32List>(triangleP3.x * FloatList(intPositionScale)),
        };
        I32List intPY[3] = {
            static_cast<I32List>(triangleP1.y * FloatList(intPositionScale)),
            static_cast<I32List>(triangleP2.y * FloatList(intPositionScale)),
            static_cast<I32List>(triangleP3.y * FloatList(intPositionScale)),
        };
        I32List intPW[3] = {
            static_cast<I32List>(triangleP1.w * FloatList(intWScale)),
            static_cast<I32List>(triangleP2.w * FloatList(intWScale)),
            static_cast<I32List>(triangleP3.w * FloatList(intWScale)),
        };
        FloatList signedArea = static_cast<FloatList>(intPW[0] * intPX[1] - intPW[1] * intPX[0])
                                   * static_cast<FloatList>(intPY[2])
                               + static_cast<FloatList>(intPW[2] * intPX[0] - intPW[0] * intPX[2])
                                     * static_cast<FloatList>(intPY[1])
                               + static_cast<FloatList>(intPW[1] * intPX[2] - intPW[2] * intPX[1])
                                     * static_cast<FloatList>(intPY[0]);
        drawTriangleMask &= signedArea > FloatList(0);
        drawTriangleMask &= triangleCountMask;
        if(!reduce(
               [](Bool32 a, Bool32 b)
               {
                   return a | b;
               },
               drawTriangleMask))
            return false;
        for(std::size_t i = 0; i < 3; i++)
        {
            static_assert(WFractionalBits >= PositionFractionalBits, "");
            edgeEquationConstants[i] =
                (intPX[(i + 1) % 3] * intPY[(i + 2) % 3] - intPX[(i + 2) % 3] * intPY[(i + 1) % 3])
                << I32List(WFractionalBits - PositionFractionalBits);
            edgeEquationXSteps[i] =
                intPY[(i + 1) % 3] * intPW[(i + 2) % 3] - intPY[(i + 2) % 3] * intPW[(i + 1) % 3];
            edgeEquationYSteps[i] =
                intPX[(i + 2) % 3] * intPW[(i + 1) % 3] - intPX[(i + 1) % 3] * intPW[(i + 2) % 3];
            edgeEquationConstants[i] =
                select(signedArea < 0, edgeEquationConstants[i], -edgeEquationConstants[i]);
            edgeEquationXSteps[i] =
                select(signedArea < 0, edgeEquationXSteps[i], -edgeEquationXSteps[i]);
            edgeEquationYSteps[i] =
                select(signedArea < 0, edgeEquationYSteps[i], -edgeEquationYSteps[i]);

            // handle top-left fill rule
            Bool32List isNonTopEdge = (edgeEquationXSteps[i] != 0) | (edgeEquationYSteps[i] <= 0);
            Bool32List isNonLeftEdge = edgeEquationXSteps[i] <= 0;
            edgeEquationConstants[i] += reinterpret<std::int32_t>(isNonTopEdge & isNonLeftEdge);
        }
        I32List edgeEquationTrivialRejectX[3] = {};
        I32List edgeEquationTrivialRejectY[3] = {};
        for(std::size_t i = 0; i < 3; i++)
        {
            edgeEquationTrivialRejectX[i] =
                select(edgeEquationXSteps[i] > 0, I32List(colorImage.getWidth() - 1), I32List(0));
            edgeEquationTrivialRejectY[i] =
                select(edgeEquationYSteps[i] > 0, I32List(colorImage.getHeight() - 1), I32List(0));
        }
        Bool32List trivialReject(false);
        for(std::size_t i = 0; i < 3; i++)
        {
            trivialReject |= !checkEdgeEquationList(edgeEquationConstants[i],
                                                    edgeEquationXSteps[i],
                                                    edgeEquationYSteps[i],
                                                    edgeEquationTrivialRejectX[i],
                                                    edgeEquationTrivialRejectY[i]);
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
        for(std::size_t triangleIndex = 0; triangleIndex < triangleCount; triangleIndex++)
            if(drawTriangleMask[triangleIndex])
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
    struct Task;
    struct Fence final
    {
        std::mutex lock;
        std::condition_variable cond;
        std::size_t scheduledTaskCount;
        std::unique_ptr<std::vector<std::shared_ptr<Task>>> waitingTasks;
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
        bool tryAddWaitingTask(std::shared_ptr<Task> &&waitingTask)
        {
            std::unique_lock<std::mutex> lockIt(lock);
            if(scheduledTaskCount > 0)
            {
                if(!waitingTasks)
                    waitingTasks.reset(new std::vector<std::shared_ptr<Task>>);
                waitingTasks->push_back(std::move(waitingTask));
                return true;
            }
            return false;
        }
        bool tryAddWaitingTask(const std::shared_ptr<Task> &waitingTask)
        {
            std::unique_lock<std::mutex> lockIt(lock);
            if(scheduledTaskCount > 0)
            {
                if(!waitingTasks)
                    waitingTasks.reset(new std::vector<std::shared_ptr<Task>>);
                waitingTasks->push_back(waitingTask);
                return true;
            }
            return false;
        }
        std::unique_ptr<std::vector<std::shared_ptr<Task>>> signalTaskFinishedAndGetWaitingTasks()
        {
            std::unique_lock<std::mutex> lockIt(lock);
            scheduledTaskCount--;
            if(scheduledTaskCount == 0)
            {
                cond.notify_all();
                return std::move(waitingTasks);
            }
            return std::unique_ptr<std::vector<std::shared_ptr<Task>>>();
        }
    };
    struct Task
    {
        std::shared_ptr<Fence> signalFence;
        std::shared_ptr<Fence> waitFence;
        explicit Task(std::shared_ptr<Fence> signalFence, std::shared_ptr<Fence> waitFence)
            : signalFence(std::move(signalFence)), waitFence(std::move(waitFence))
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
    void runTasks(std::unique_lock<std::mutex> &lockIt) noexcept
    {
        while(true)
        {
            if(tasks.empty())
                return;
            auto task = std::move(tasks.front());
            tasks.pop_front();
            lockIt.unlock();
            task->run();
            std::unique_ptr<std::vector<std::shared_ptr<Task>>> newTasks;
            if(task->signalFence)
            {
                newTasks = task->signalFence->signalTaskFinishedAndGetWaitingTasks();
            }
            lockIt.lock();
            if(newTasks)
            {
                for(auto &i : *newTasks)
                {
                    addNonwaitingTask(std::move(i), lockIt);
                }
            }
        }
    }
    void threadFn() noexcept
    {
        std::unique_lock<std::mutex> lockIt(lock);
        while(true)
        {
            if(done)
                break;
            runTasks(lockIt);
            waitingThreadCount++;
            cond.wait(lockIt);
            waitingThreadCount--;
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
    void addNonwaitingTask(std::shared_ptr<Task> task, std::unique_lock<std::mutex> &lockIt)
    {
        tasks.push_back(std::move(task));
        if(waitingThreadCount != 0)
            cond.notify_one();
    }
    void addTask(std::shared_ptr<Task> task)
    {
        assert(task);
        if(task->signalFence)
            task->signalFence->addTask();
        if(task->waitFence)
        {
            auto waitFence = task->waitFence;
            if(waitFence->tryAddWaitingTask(std::move(task)))
                return;
        }
        std::unique_lock<std::mutex> lockIt(lock);
        addNonwaitingTask(std::move(task), lockIt);
        if(threads.empty())
            runTasks(lockIt);
    }
    std::size_t getParallelism() const noexcept
    {
        return threads.empty() ? 1 : threads.size();
    }
};

template <typename Fn>
void runInThreads(ThreadedTaskRunner &threadedTaskRunner,
                  std::shared_ptr<ThreadedTaskRunner::Fence> signalFence,
                  std::shared_ptr<ThreadedTaskRunner::Fence> waitFence,
                  std::size_t threadCount,
                  Fn fn)
{
    assert(threadCount != 0);
    for(std::size_t i = 0; i < threadCount; i++)
    {
        struct MyTask final : public ThreadedTaskRunner::Task
        {
            const std::size_t threadIndex;
            Fn fn;
            explicit MyTask(std::shared_ptr<ThreadedTaskRunner::Fence> signalFence,
                            std::shared_ptr<ThreadedTaskRunner::Fence> waitFence,
                            std::size_t threadIndex,
                            Fn fn)
                : Task(std::move(signalFence), std::move(waitFence)),
                  threadIndex(threadIndex),
                  fn(std::move(fn))
            {
            }
            virtual void run() noexcept override
            {
                fn(threadIndex);
            }
        };
        threadedTaskRunner.addTask(std::make_shared<MyTask>(signalFence, waitFence, i, fn));
    }
}

void renderTriangles(ColorImage &colorImage,
                     DepthImage &depthImage,
                     const Triangle *const triangles,
                     const std::size_t triangleCount,
                     Matrix4x4 tform,
                     ThreadedTaskRunner &threadedTaskRunner,
                     std::shared_ptr<ThreadedTaskRunner::Fence> signalFence,
                     std::shared_ptr<ThreadedTaskRunner::Fence> waitFence) noexcept
{
    assert(colorImage.getWidth() == depthImage.getWidth()
           && colorImage.getHeight() == depthImage.getHeight());
    if(colorImage.getWidth() == 0 || colorImage.getHeight() == 0 || triangleCount == 0)
    {
        runInThreads(threadedTaskRunner,
                     signalFence,
                     waitFence,
                     1,
                     [](std::size_t)
                     {
                     }); // connect the fences
        return;
    }
    assert(colorImage.getLayers() == 1 && depthImage.getLayers() == 1);
    struct State final
    {
        std::vector<std::vector<TriangleRenderState>> renderStates;
        std::size_t triangleGroupCount;
        std::size_t setupThreadCount;
        std::size_t maxParallelism;
        std::size_t renderThreadCount;
    };
    const auto state = std::make_shared<State>();
    state->triangleGroupCount = (triangleCount + ValueListSize - 1) / ValueListSize;
    state->setupThreadCount = state->triangleGroupCount / 1000;
    if(state->setupThreadCount == 0)
        state->setupThreadCount = 1;
    state->maxParallelism = 4 * threadedTaskRunner.getParallelism();
    if(state->setupThreadCount > state->maxParallelism)
        state->setupThreadCount = state->maxParallelism;
    state->renderStates.resize(state->setupThreadCount);
    const auto setupToRenderFence = std::make_shared<ThreadedTaskRunner::Fence>();
    runInThreads(
        threadedTaskRunner,
        setupToRenderFence,
        waitFence,
        state->setupThreadCount,
        [state, triangleCount, triangles, tform, &colorImage, &depthImage](std::size_t threadIndex)
        {
            std::size_t startGroupIndex =
                threadIndex * (state->triangleGroupCount / state->setupThreadCount);
            std::size_t endGroupIndex =
                (threadIndex + 1) * (state->triangleGroupCount / state->setupThreadCount);
            if(endGroupIndex > state->triangleGroupCount)
                endGroupIndex = state->triangleGroupCount;
            state->renderStates[threadIndex].reserve(endGroupIndex - startGroupIndex);
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
                state->renderStates[threadIndex].emplace_back(colorImage,
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
                if(!state->renderStates[threadIndex].back().good)
                    state->renderStates[threadIndex].pop_back();
            }
        });
    const std::size_t chunkXCount = (colorImage.getWidth() + ChunkLevel<MaxChunkLevel>::totalWidth
                                     - 1) / ChunkLevel<MaxChunkLevel>::totalWidth;
    const std::size_t chunkYCount = (colorImage.getHeight() + ChunkLevel<MaxChunkLevel>::totalHeight
                                     - 1) / ChunkLevel<MaxChunkLevel>::totalHeight;
    const std::size_t chunkCount = chunkXCount * chunkYCount;
    state->renderThreadCount = triangleCount * chunkCount;
    if(state->renderThreadCount == 0)
        state->renderThreadCount = 1;
    if(state->renderThreadCount > chunkCount)
        state->renderThreadCount = chunkCount;
    if(state->renderThreadCount > state->maxParallelism)
        state->renderThreadCount = state->maxParallelism;
    runInThreads(
        threadedTaskRunner,
        signalFence,
        setupToRenderFence,
        state->renderThreadCount,
        [state, chunkCount, chunkXCount](std::size_t threadIndex)
        {
            for(std::size_t chunkIndex = threadIndex; chunkIndex < chunkCount;
                chunkIndex += state->renderThreadCount)
            {
                std::size_t x = (chunkIndex % chunkXCount) * ChunkLevel<MaxChunkLevel>::totalWidth;
                std::size_t y = (chunkIndex / chunkXCount) * ChunkLevel<MaxChunkLevel>::totalHeight;
                for(auto &renderStateGroup : state->renderStates)
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

#if 0
constexpr bool renderWithViewerInside = false;
#else
constexpr bool renderWithViewerInside = true;
#endif

std::vector<Triangle> getTriangles()
{
    std::vector<Triangle> triangles;
    std::size_t uCount = 20;
    std::size_t vCount = 10;
    std::size_t triangleCount = uCount * vCount * 2;
    triangles.reserve(triangleCount);
    for(std::size_t triangleIndex = 0; triangleIndex < triangleCount; triangleIndex++)
    {
        triangles.push_back(getTriangle(triangleIndex, uCount, vCount));
        if(renderWithViewerInside)
            std::swap(triangles.back().p1, triangles.back().p2);
    }
    return triangles;
}

void renderFrame(ColorImage &colorImage,
                 DepthImage &depthImage,
                 ThreadedTaskRunner &threadedTaskRunner,
                 const std::vector<Triangle> &triangles,
                 std::shared_ptr<ThreadedTaskRunner::Fence> signalFence,
                 std::shared_ptr<ThreadedTaskRunner::Fence> waitFence)
{
    struct FillColorTask final : public ThreadedTaskRunner::Task
    {
        Color color;
        std::size_t threadIndex;
        std::size_t threadCount;
        ColorImage &colorImage;
        FillColorTask(std::shared_ptr<ThreadedTaskRunner::Fence> signalFence,
                      std::shared_ptr<ThreadedTaskRunner::Fence> waitFence,
                      Color color,
                      std::size_t threadIndex,
                      std::size_t threadCount,
                      ColorImage &colorImage)
            : Task(std::move(signalFence), std::move(waitFence)),
              color(color),
              threadIndex(threadIndex),
              threadCount(threadCount),
              colorImage(colorImage)
        {
        }
        virtual void run() noexcept
        {
#if 1
            colorImage.fillPart(color, threadIndex, threadCount);
#endif
        }
    };
    struct FillDepthTask final : public ThreadedTaskRunner::Task
    {
        float depth;
        std::size_t threadIndex;
        std::size_t threadCount;
        DepthImage &depthImage;
        FillDepthTask(std::shared_ptr<ThreadedTaskRunner::Fence> signalFence,
                      std::shared_ptr<ThreadedTaskRunner::Fence> waitFence,
                      float depth,
                      std::size_t threadIndex,
                      std::size_t threadCount,
                      DepthImage &depthImage)
            : Task(std::move(signalFence), std::move(waitFence)),
              depth(depth),
              threadIndex(threadIndex),
              threadCount(threadCount),
              depthImage(depthImage)
        {
        }
        virtual void run() noexcept
        {
#if 1
            depthImage.fillPart(depth, threadIndex, threadCount);
#endif
        }
    };
    auto clearToDrawFence = std::make_shared<ThreadedTaskRunner::Fence>();
    for(std::size_t i = 0; i < threadedTaskRunner.getParallelism(); i++)
        threadedTaskRunner.addTask(
            std::make_shared<FillColorTask>(clearToDrawFence,
                                            waitFence,
                                            Color{0x80, 0xC0, 0xFF, 0xFF},
                                            i,
                                            threadedTaskRunner.getParallelism(),
                                            colorImage));
    for(std::size_t i = 0; i < threadedTaskRunner.getParallelism(); i++)
        threadedTaskRunner.addTask(
            std::make_shared<FillDepthTask>(clearToDrawFence,
                                            waitFence,
                                            INFINITY,
                                            i,
                                            threadedTaskRunner.getParallelism(),
                                            depthImage));
    double currentTime = std::chrono::duration_cast<std::chrono::duration<double>>(
                             std::chrono::steady_clock::now().time_since_epoch()).count();
    Matrix4x4 tform;
    tform = Matrix4x4::rotateY(currentTime * M_PI * 2 / 10);
    tform = tform.concat(Matrix4x4::rotateX(currentTime * M_PI * 2 / std::sqrt(2) / 10));
    tform = tform.concat(Matrix4x4::translate(0, 0, renderWithViewerInside ? 0 : 2));
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
    renderTriangles(colorImage,
                    depthImage,
                    triangles.data(),
                    triangles.size(),
                    tform,
                    threadedTaskRunner,
                    signalFence,
                    clearToDrawFence);
}

enum class PixelFormat
{
    RGBA,
    ABGR,
    RGBX,
    XBGR,
    ARGB,
    BGRA,
    XRGB,
    BGRX,
    RGB,
    BGR,
};

std::pair<PixelFormat, Uint32> pickPixelFormat(SDL_Renderer *renderer) noexcept
{
    SDL_RendererInfo rendererInfo{};
    if(0 == SDL_GetRendererInfo(renderer, &rendererInfo))
    {
        for(std::size_t i = 0; i < rendererInfo.num_texture_formats; i++)
        {
            switch(rendererInfo.texture_formats[i])
            {
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
            case SDL_PIXELFORMAT_ABGR8888:
                return {PixelFormat::RGBA, SDL_PIXELFORMAT_ABGR8888};
            case SDL_PIXELFORMAT_BGRA8888:
                return {PixelFormat::ARGB, SDL_PIXELFORMAT_BGRA8888};
            case SDL_PIXELFORMAT_ARGB8888:
                return {PixelFormat::BGRA, SDL_PIXELFORMAT_ARGB8888};
            case SDL_PIXELFORMAT_RGBA8888:
                return {PixelFormat::ABGR, SDL_PIXELFORMAT_RGBA8888};
            // case SDL_PIXELFORMAT_XBGR8888:
            //     return {PixelFormat::RGBX, SDL_PIXELFORMAT_XBGR8888};
            case SDL_PIXELFORMAT_BGRX8888:
                return {PixelFormat::XRGB, SDL_PIXELFORMAT_BGRX8888};
            // case SDL_PIXELFORMAT_XRGB8888:
            //     return {PixelFormat::BGRX, SDL_PIXELFORMAT_XRGB8888};
            case SDL_PIXELFORMAT_RGBX8888:
                return {PixelFormat::XBGR, SDL_PIXELFORMAT_RGBX8888};
            case SDL_PIXELFORMAT_RGB888:
                return {PixelFormat::BGR, SDL_PIXELFORMAT_RGB888};
            case SDL_PIXELFORMAT_BGR888:
                return {PixelFormat::RGB, SDL_PIXELFORMAT_BGR888};
#else
            case SDL_PIXELFORMAT_RGBA8888:
                return {PixelFormat::RGBA, SDL_PIXELFORMAT_RGBA8888};
            case SDL_PIXELFORMAT_ARGB8888:
                return {PixelFormat::ARGB, SDL_PIXELFORMAT_ARGB8888};
            case SDL_PIXELFORMAT_BGRA8888:
                return {PixelFormat::BGRA, SDL_PIXELFORMAT_BGRA8888};
            case SDL_PIXELFORMAT_ABGR8888:
                return {PixelFormat::ABGR, SDL_PIXELFORMAT_ABGR8888};
            case SDL_PIXELFORMAT_RGBX8888:
                return {PixelFormat::RGBX, SDL_PIXELFORMAT_RGBX8888};
            // case SDL_PIXELFORMAT_XRGB8888:
            //     return {PixelFormat::XRGB, SDL_PIXELFORMAT_XRGB8888};
            case SDL_PIXELFORMAT_BGRX8888:
                return {PixelFormat::BGRX, SDL_PIXELFORMAT_BGRX8888};
            // case SDL_PIXELFORMAT_XBGR8888:
            //     return {PixelFormat::XBGR, SDL_PIXELFORMAT_XBGR8888};
            case SDL_PIXELFORMAT_BGR888:
                return {PixelFormat::BGR, SDL_PIXELFORMAT_BGR888};
            case SDL_PIXELFORMAT_RGB888:
                return {PixelFormat::RGB, SDL_PIXELFORMAT_RGB888};
#endif
            default:
                continue;
            }
        }
    }
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
    return {PixelFormat::RGBA, SDL_PIXELFORMAT_ABGR8888};
#else
    return {PixelFormat::RGBA, SDL_PIXELFORMAT_RGBA8888};
#endif
}

int main()
{
    std::size_t initialWidth = 1366, initialHeight = 700;
    ColorImage colorImage(initialWidth, initialHeight, 1);
    DepthImage depthImage(initialWidth, initialHeight, 1);
    const std::vector<Triangle> triangles = getTriangles();
#if 0
#warning in debug mode
    ThreadedTaskRunner threadedTaskRunner{0};
#else
    ThreadedTaskRunner threadedTaskRunner{};
#endif
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
    auto pixelFormat = pickPixelFormat(renderer);
    SDL_Texture *texture = SDL_CreateTexture(renderer,
                                             std::get<1>(pixelFormat),
                                             SDL_TEXTUREACCESS_STREAMING,
                                             initialWidth,
                                             initialHeight);
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
                renderer, std::get<1>(pixelFormat), SDL_TEXTUREACCESS_STREAMING, width, height);
            if(!texture)
            {
                std::cerr << "SDL_CreateTexture failed: " << SDL_GetError() << std::endl;
                SDL_DestroyRenderer(renderer);
                SDL_DestroyWindow(window);
                SDL_Quit();
                return 1;
            }
        }
        auto frameRenderedFence = std::make_shared<ThreadedTaskRunner::Fence>();
        renderFrame(
            colorImage, depthImage, threadedTaskRunner, triangles, frameRenderedFence, nullptr);
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
#if 0
#define NO_COPY
#endif
#ifndef NO_COPY
        if(SDL_LockTexture(texture, nullptr, &pixels, &pitch) != 0)
        {
            std::cerr << "SDL_LockTexture failed: " << SDL_GetError() << std::endl;
            SDL_DestroyTexture(texture);
            SDL_DestroyRenderer(renderer);
            SDL_DestroyWindow(window);
            SDL_Quit();
            return 1;
        }
#endif
        struct CopyLineTask final : public ThreadedTaskRunner::Task
        {
            std::size_t height;
            std::size_t width;
            unsigned char *pixels;
            std::size_t pitch;
            std::size_t threadIndex;
            std::size_t threadCount;
            ColorImage &colorImage;
            PixelFormat outputPixelFormat;
            CopyLineTask(std::shared_ptr<ThreadedTaskRunner::Fence> signalFence,
                         std::shared_ptr<ThreadedTaskRunner::Fence> waitFence,
                         std::size_t height,
                         std::size_t width,
                         unsigned char *pixels,
                         std::size_t pitch,
                         std::size_t threadIndex,
                         std::size_t threadCount,
                         ColorImage &colorImage,
                         PixelFormat outputPixelFormat)
                : Task(std::move(signalFence), std::move(waitFence)),
                  height(height),
                  width(width),
                  pixels(pixels),
                  pitch(pitch),
                  threadIndex(threadIndex),
                  threadCount(threadCount),
                  colorImage(colorImage),
                  outputPixelFormat(outputPixelFormat)
            {
            }
            virtual void run() noexcept
            {
#ifndef NO_COPY
                std::size_t startY = threadIndex * height / threadCount;
                std::size_t endY = (threadIndex + 1) * height / threadCount;
                for(std::size_t y = startY; y < endY; y++)
                {
                    unsigned char *currentPixel = static_cast<unsigned char *>(pixels) + pitch * y;
                    switch(outputPixelFormat)
                    {
#define WRITE_LINE_IN_FORMAT4(fmt, first, second, third, fourth)  \
    case PixelFormat::fmt:                                        \
        for(std::size_t x = 0, i = 0; x < width; x++)             \
        {                                                         \
            auto color = colorImage.getElementUnchecked(x, y, 0); \
            *currentPixel++ = color.first[0];                     \
            *currentPixel++ = color.second[0];                    \
            *currentPixel++ = color.third[0];                     \
            *currentPixel++ = color.fourth[0];                    \
        }                                                         \
        break;
#define WRITE_LINE_IN_FORMAT3(fmt, first, second, third)          \
    case PixelFormat::fmt:                                        \
        for(std::size_t x = 0, i = 0; x < width; x++)             \
        {                                                         \
            auto color = colorImage.getElementUnchecked(x, y, 0); \
            *currentPixel++ = color.first[0];                     \
            *currentPixel++ = color.second[0];                    \
            *currentPixel++ = color.third[0];                     \
        }                                                         \
        break;
                        WRITE_LINE_IN_FORMAT4(RGBA, x, y, z, w)
                        WRITE_LINE_IN_FORMAT4(ARGB, w, x, y, z)
                        WRITE_LINE_IN_FORMAT4(BGRA, z, y, x, w)
                        WRITE_LINE_IN_FORMAT4(ABGR, w, z, y, x)
                        WRITE_LINE_IN_FORMAT4(RGBX, x, y, z, w)
                        WRITE_LINE_IN_FORMAT4(XRGB, w, x, y, z)
                        WRITE_LINE_IN_FORMAT4(BGRX, z, y, x, w)
                        WRITE_LINE_IN_FORMAT4(XBGR, w, z, y, x)
                        WRITE_LINE_IN_FORMAT3(RGB, x, y, z)
                        WRITE_LINE_IN_FORMAT3(BGR, z, y, x)
#undef WRITE_LINE_IN_FORMAT4
#undef WRITE_LINE_IN_FORMAT3
                    }
                }
#endif
            }
        };
        std::size_t copyLineThreadCount = height;
        if(copyLineThreadCount > threadedTaskRunner.getParallelism())
            copyLineThreadCount = threadedTaskRunner.getParallelism();
        if(copyLineThreadCount == 0)
            copyLineThreadCount = 1;
        auto copyLinesFence = std::make_shared<ThreadedTaskRunner::Fence>();
        for(std::size_t i = 0; i < copyLineThreadCount; i++)
            threadedTaskRunner.addTask(
                std::make_shared<CopyLineTask>(copyLinesFence,
                                               frameRenderedFence,
                                               height,
                                               width,
                                               static_cast<unsigned char *>(pixels),
                                               pitch,
                                               i,
                                               copyLineThreadCount,
                                               colorImage,
                                               std::get<0>(pixelFormat)));
        copyLinesFence->waitForCompletion();
#ifndef NO_COPY
        SDL_UnlockTexture(texture);
        SDL_RenderClear(renderer);
        SDL_RenderCopy(renderer, texture, nullptr, nullptr);
        SDL_RenderPresent(renderer);
#else
#undef NO_COPY
#endif
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
