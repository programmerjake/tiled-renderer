/*
 * Copyright (C) 2012-2017 Jacob R. Lifshay
 * This file is part of Voxels.
 *
 * Voxels is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Voxels is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Voxels; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 */
#include "value_list.h"
#include "vector_list.h"
#include "matrix_list.h"
#include "image.h"
#include <iostream>
#include <fstream>
#include <cstdint>
#include <cassert>
#include <string>

using namespace tiled_renderer;

constexpr std::size_t Log2ValueListSize = 2;
constexpr std::size_t ValueListSize = static_cast<std::size_t>(1) << Log2ValueListSize;
typedef ValueList<float, ValueListSize> FloatList;
typedef ValueList<std::int32_t, ValueListSize> I32List;
typedef ValueList<Bool32, ValueListSize> Bool32List;
typedef Vector4List<float, ValueListSize> Vector4FList;
typedef Vector4List<std::int32_t, ValueListSize> Vector4I32List;
typedef Vector3List<float, ValueListSize> Vector3FList;
typedef Image<float> DepthImage;
typedef Vector4List<std::uint8_t, 1> Color;
typedef Image<Color> ColorImage;

template <std::size_t Level>
struct ChunkLevel;

template <>
struct ChunkLevel<0> final
{
    static_assert(Log2ValueListSize > 0, "");
    static constexpr std::size_t width = static_cast<std::size_t>(1) << (Log2ValueListSize + 1) / 2;
    static constexpr std::size_t height = static_cast<std::size_t>(1) << (Log2ValueListSize) / 2;
    static constexpr std::size_t totalWidth = width;
    static constexpr std::size_t totalHeight = height;
    static constexpr std::size_t xStepSize = 1;
    static constexpr std::size_t yStepSize = 1;
    static I32List getXPositions() noexcept
    {
        I32List retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = i % width;
        }
        return retval;
    }
    static I32List getYPositions() noexcept
    {
        I32List retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = i / width;
        }
        return retval;
    }
};

template <std::size_t Level>
struct ChunkLevel final
{
    static constexpr std::size_t width = ChunkLevel<Level - 1>::height;
    static constexpr std::size_t height = ChunkLevel<Level - 1>::width;
    static constexpr std::size_t totalWidth = ChunkLevel<Level - 1>::totalWidth * width;
    static constexpr std::size_t totalHeight = ChunkLevel<Level - 1>::totalHeight * height;
    static constexpr std::size_t xStepSize = ChunkLevel<Level - 1>::totalWidth;
    static constexpr std::size_t yStepSize = ChunkLevel<Level - 1>::totalHeight;
    static I32List getXPositions() noexcept
    {
        I32List retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = (i % width) * xStepSize;
        }
        return retval;
    }
    static I32List getYPositions() noexcept
    {
        I32List retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = (i / width) * yStepSize;
        }
        return retval;
    }
};

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

constexpr std::size_t MaxTriangleLevel = 2;
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
        I32List edgeEquationXSteps[3];
        I32List edgeEquationYSteps[3];
        I32List edgeEquationConstants[3];
    };
    ColorImage &colorImage;
    DepthImage &depthImage;
    const Vector4FList triangleP1;
    const Vector4FList triangleP2;
    const Vector4FList triangleP3;
    const Colors drawColors;
    const std::size_t triangleCount;
    PerLevelState perLevelStates[ValueListSize][MaxTriangleLevel + 1];
    Bool32List drawTriangleMask;
    I32List edgeEquationConstants[3];
    I32List edgeEquationXSteps[3];
    I32List edgeEquationYSteps[3];
    Bool32List trivialReject;
    Bool32List trivialAccepts[3];
    TriangleRenderState(ColorImage &colorImage,
                        DepthImage &depthImage,
                        Vector4FList triangleP1,
                        Vector4FList triangleP2,
                        Vector4FList triangleP3,
                        Colors drawColors,
                        std::size_t triangleCount) noexcept : colorImage(colorImage),
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
                                                              trivialAccepts{}
    {
    }
    static Bool32List checkEdgeEquationList(const FloatList &constant,
                                            const FloatList &xStep,
                                            const FloatList &yStep,
                                            const FloatList &x,
                                            const FloatList &y) noexcept
    {
        return constant + xStep * x + yStep * y >= 0;
    }
    template <std::size_t Level>
    char fillPerLevelStates(std::size_t triangleIndex) noexcept
    {
        PerLevelState &perLevelState = perLevelStates[triangleIndex][Level];
        for(std::size_t i = 0; i < 3; i++)
        {
            perLevelState.edgeEquationXSteps[i] =
                I32List(edgeEquationXSteps[i][triangleIndex]) * ChunkLevel<Level>::getXPositions();
            perLevelState.edgeEquationYSteps[i] =
                I32List(edgeEquationYSteps[i][triangleIndex]) * ChunkLevel<Level>::getYPositions();
            perLevelState.edgeEquationConstants[i] =
                I32List(edgeEquationConstants[i][triangleIndex])
                + perLevelState.edgeEquationXSteps[i] + perLevelState.edgeEquationYSteps[i];
        }
        return 0;
    }
    template <std::size_t... Levels>
    void fillAllPerLevelStates(std::size_t triangleIndex, const LevelList<Levels...> *) noexcept
    {
        char unused[] = {fillPerLevelStates<Levels>(triangleIndex)...};
        static_cast<void>(unused);
    }
    bool setup() noexcept
    {
        Bool32List triangleCountMask(true);
        for(std::size_t i = triangleCount; i < ValueListSize; i++)
            triangleCountMask[i] = false;
        FloatList divisor =
            (triangleP1.w * triangleP2.x - triangleP2.w * triangleP1.x) * triangleP3.y
            + (triangleP3.w * triangleP1.x - triangleP1.w * triangleP3.x) * triangleP2.y
            + (triangleP2.w * triangleP3.x - triangleP3.w * triangleP2.x) * triangleP1.y;
        drawTriangleMask &= divisor > FloatList(0);
        drawTriangleMask &= triangleCountMask;
        if(!reduce(
               [](Bool32 a, Bool32 b)
               {
                   return a | b;
               },
               drawTriangleMask))
            return false;
        FloatList factor =
            FloatList(static_cast<std::uint64_t>(1) << EdgeEquationFractionalBits) / divisor;
        FloatList triangleP1WFactor = triangleP1.w * factor;
        FloatList triangleP2WFactor = triangleP2.w * factor;
        FloatList triangleP3WFactor = triangleP3.w * factor;
        FloatList edgeEquationConstantsF[3] = {
            (triangleP2.x * triangleP3.y - triangleP3.x * triangleP2.y) * triangleP1WFactor,
            (triangleP3.x * triangleP1.y - triangleP1.x * triangleP3.y) * triangleP2WFactor,
            (triangleP1.x * triangleP2.y - triangleP2.x * triangleP1.y) * triangleP3WFactor,
        };
        FloatList edgeEquationXStepsF[3] = {
            (triangleP2.y * triangleP3.w - triangleP3.y * triangleP2.w) * triangleP1WFactor,
            (triangleP3.y * triangleP1.w - triangleP1.y * triangleP3.w) * triangleP2WFactor,
            (triangleP1.y * triangleP2.w - triangleP2.y * triangleP1.w) * triangleP3WFactor,
        };
        FloatList edgeEquationYStepsF[3] = {
            (triangleP3.x * triangleP2.w - triangleP2.x * triangleP3.w) * triangleP1WFactor,
            (triangleP1.x * triangleP3.w - triangleP3.x * triangleP1.w) * triangleP2WFactor,
            (triangleP2.x * triangleP1.w - triangleP1.x * triangleP2.w) * triangleP3WFactor,
        };
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
                    static_cast<const MakeLevelList<MaxTriangleLevel>::type *>(nullptr));
        return true;
    }
};

template <std::size_t Level,
          bool needsEdgeEquation0,
          bool needsEdgeEquation1,
          bool needsEdgeEquation2>
struct RenderTriangleHelper;

template <bool needsEdgeEquation0, bool needsEdgeEquation1, bool needsEdgeEquation2>
struct RenderTriangleHelper<0, needsEdgeEquation0, needsEdgeEquation1, needsEdgeEquation2> final
{
    static constexpr std::size_t Level = 0;
    static void run(const TriangleRenderState &renderState,
                    std::size_t triangleIndex,
                    std::int32_t xOrigin,
                    std::int32_t yOrigin) noexcept
    {
        auto &perLevelState = renderState.perLevelStates[triangleIndex][Level];
        I32List xPositions = I32List(xOrigin) + ChunkLevel<Level>::getXPositions();
        I32List yPositions = I32List(yOrigin) + ChunkLevel<Level>::getYPositions();
        Bool32List passingPixels(true);
        if(needsEdgeEquation0)
            passingPixels &= I32List(xOrigin * renderState.edgeEquationXSteps[0][triangleIndex]
                                     + yOrigin * renderState.edgeEquationYSteps[0][triangleIndex])
                                 + perLevelState.edgeEquationConstants[0]
                             >= I32List(0);
        if(needsEdgeEquation1)
            passingPixels &= I32List(xOrigin * renderState.edgeEquationXSteps[1][triangleIndex]
                                     + yOrigin * renderState.edgeEquationYSteps[1][triangleIndex])
                                 + perLevelState.edgeEquationConstants[1]
                             >= I32List(0);
        if(needsEdgeEquation2)
            passingPixels &= I32List(xOrigin * renderState.edgeEquationXSteps[2][triangleIndex]
                                     + yOrigin * renderState.edgeEquationYSteps[2][triangleIndex])
                                 + perLevelState.edgeEquationConstants[2]
                             >= I32List(0);
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            if(passingPixels[i])
            {
#warning finish
                renderState.colorImage.setElement(
                    xPositions[i], yPositions[i], 0, renderState.drawColors.colors[triangleIndex]);
            }
        }
    }
};

template <std::size_t Level,
          bool needsEdgeEquation0,
          bool needsEdgeEquation1,
          bool needsEdgeEquation2>
struct RenderTriangleHelper final
{
    static void run(const TriangleRenderState &renderState,
                    std::size_t triangleIndex,
                    std::int32_t xOrigin,
                    std::int32_t yOrigin) noexcept
    {
#warning finish
    }
};

void renderTriangles(ColorImage &colorImage,
                     DepthImage &depthImage,
                     Vector4FList triangleP1,
                     Vector4FList triangleP2,
                     Vector4FList triangleP3,
                     TriangleRenderState::Colors drawColors,
                     std::size_t triangleCount) noexcept
{
    assert(triangleCount <= ValueListSize);
    assert(colorImage.getWidth() == depthImage.getWidth()
           && colorImage.getHeight() == depthImage.getHeight());
    if(colorImage.getWidth() == 0 || colorImage.getHeight() == 0)
        return;
    assert(colorImage.getLayers() == 1 && depthImage.getLayers() == 1);
    TriangleRenderState renderState(
        colorImage, depthImage, triangleP1, triangleP2, triangleP3, drawColors, triangleCount);
    if(!renderState.setup())
        return;
    for(std::size_t triangleIndex = 0; triangleIndex < triangleCount; triangleIndex++)
    {
        if(renderState.drawTriangleMask[triangleIndex])
        {
#if 0
            if(renderState.trivialAccepts[0][triangleIndex]
               & renderState.trivialAccepts[1][triangleIndex]
               & renderState.trivialAccepts[2][triangleIndex])
            {
                for(std::size_t y = 0; y < colorImage.getHeight(); y += ChunkLevel<0>::height)
                {
                    if(y + ChunkLevel<0>::height <= colorImage.getHeight())
                    {
                        for(std::size_t x = 0; x < colorImage.getWidth(); x += ChunkLevel<0>::width)
                        {
                            if(x + ChunkLevel<0>::width <= colorImage.getWidth())
                            {
#warning finish
                            }
                            else
                            {
#warning finish
                            }
                        }
                    }
                    else
                    {
                        for(std::size_t x = 0; x < colorImage.getWidth(); x += ChunkLevel<0>::width)
                        {
                            if(x + ChunkLevel<0>::width <= colorImage.getWidth())
                            {
#warning finish
                            }
                            else
                            {
#warning finish
                            }
                        }
                    }
                }
            }
            else
#endif
            {
                for(std::size_t y = 0; y < colorImage.getHeight(); y += ChunkLevel<0>::height)
                {
                    for(std::size_t x = 0; x < colorImage.getWidth(); x += ChunkLevel<0>::width)
                    {
                        RenderTriangleHelper<0, true, true, true>::run(
                            renderState, triangleIndex, x, y);
                    }
                }
#warning finish
            }
        }
    }
}

void getTriangle(std::size_t triangleIndex,
                 Color &color,
                 float &x1,
                 float &y1,
                 float &z1,
                 float &w1,
                 float &x2,
                 float &y2,
                 float &z2,
                 float &w2,
                 float &x3,
                 float &y3,
                 float &z3,
                 float &w3)
{
    if(triangleIndex & 1)
    {
        color = Color(0xFF, 0, 0, 0xFF);
        x1 = 10 + triangleIndex * 100;
        y1 = 10;
        z1 = 1;
        w1 = 1;

        x2 = 210 + triangleIndex * 100;
        y2 = 10;
        z2 = 1;
        w2 = 1;

        x3 = 110 + triangleIndex * 100;
        y3 = 110;
        z3 = 1;
        w3 = 1;
    }
    else
    {
        color = Color(0, 0, 0xFF, 0xFF);
        x1 = 110 + triangleIndex * 100;
        y1 = 10;
        z1 = 1;
        w1 = 1;

        x2 = 210 + triangleIndex * 100;
        y2 = 110;
        z2 = 1;
        w2 = 1;

        x3 = 10 + triangleIndex * 100;
        y3 = 110;
        z3 = 1;
        w3 = 1;
    }
    w1 += 0.001f * x1;
    w2 += 0.001f * x2;
    w3 += 0.001f * x3;
}

int main()
{
    ColorImage colorImage(1280, 720, 1);
    DepthImage depthImage(1280, 720, 1);
    clearImage(colorImage, 0, {0, 0xFF, 0, 0xFF});
    clearImage(depthImage, 0, INFINITY);
    std::size_t triangleCount = 10;
    for(std::size_t triangleIndex = 0; triangleIndex < triangleCount;
        triangleIndex += ValueListSize)
    {
        TriangleRenderState::Colors colors;
        Vector4FList p1, p2, p3;
        std::size_t triangleRenderCount = triangleCount - triangleIndex;
        if(triangleRenderCount > ValueListSize)
            triangleRenderCount = ValueListSize;
        for(std::size_t i = 0; i < triangleRenderCount; i++)
        {
            getTriangle(triangleIndex + i,
                        colors.colors[i],
                        p1.x[i],
                        p1.y[i],
                        p1.z[i],
                        p1.w[i],
                        p2.x[i],
                        p2.y[i],
                        p2.z[i],
                        p2.w[i],
                        p3.x[i],
                        p3.y[i],
                        p3.z[i],
                        p3.w[i]);
        }
        renderTriangles(colorImage, depthImage, p1, p2, p3, colors, triangleRenderCount);
    }
    writeImage("out.ppm", colorImage);
}
