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

constexpr std::size_t Log2ValueListSize = 4;
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
constexpr std::size_t EdgeEquationFractionalBits = 16;

struct TriangleRenderState final
{
    struct Colors final
    {
        Color colors[ValueListSize];
    };
    struct PerLevelState final
    {
        I32List edgeEquationXSteps[3];
        I32List edgeEquationYSteps[3];
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
    Bool32List trivialAccept;
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
                                                              trivialAccept(true)
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
        trivialAccept = drawTriangleMask;
        for(std::size_t i = 0; i < 3; i++)
        {
            trivialReject |= !checkEdgeEquationList(edgeEquationConstantsF[i],
                                                    edgeEquationXStepsF[i],
                                                    edgeEquationYStepsF[i],
                                                    edgeEquationTrivialRejectX[i],
                                                    edgeEquationTrivialRejectY[i]);
            trivialAccept &= checkEdgeEquationList(edgeEquationConstantsF[i],
                                                   edgeEquationXStepsF[i],
                                                   edgeEquationYStepsF[i],
                                                   edgeEquationTrivialAcceptX[i],
                                                   edgeEquationTrivialAcceptY[i]);
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
            edgeEquationConstants[i] = static_cast<I32List>(edgeEquationConstantsF[i]);
        for(std::size_t i = 0; i < 3; i++)
            edgeEquationXSteps[i] = static_cast<I32List>(edgeEquationXStepsF[i]);
        for(std::size_t i = 0; i < 3; i++)
            edgeEquationYSteps[i] = static_cast<I32List>(edgeEquationYStepsF[i]);
        for(std::size_t triangleIndex = 0; triangleIndex < triangleCount; triangleIndex++)
            if(drawTriangleMask[triangleIndex] & !trivialAccept[triangleIndex])
                fillAllPerLevelStates(
                    triangleIndex,
                    static_cast<const MakeLevelList<MaxTriangleLevel>::type *>(nullptr));
        return true;
    }
};

template <std::size_t Level,
          bool needsEdgeEquationOne,
          bool needsEdgeEquationTwo,
          bool needsEdgeEquationThree>
struct RenderTriangleHelper;

template <bool needsEdgeEquationOne, bool needsEdgeEquationTwo, bool needsEdgeEquationThree>
struct RenderTriangleHelper<0, needsEdgeEquationOne, needsEdgeEquationTwo, needsEdgeEquationThree>
    final
{
    static constexpr std::size_t Level = 0;
    static void run(const TriangleRenderState &renderState, std::size_t triangleIndex) noexcept
    {
#warning finish
    }
};

template <std::size_t Level,
          bool needsEdgeEquationOne,
          bool needsEdgeEquationTwo,
          bool needsEdgeEquationThree>
struct RenderTriangleHelper final
{
    static void run(const TriangleRenderState &renderState, std::size_t triangleIndex) noexcept
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
            if(renderState.trivialAccept[triangleIndex])
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
            {
#warning finish
            }
        }
    }
}

int main()
{
    ColorImage colorImage(100, 100, 1);
    DepthImage depthImage(100, 100, 1);
    clearImage(colorImage, 0, {0x7FU, 0x40U, 0xC0U, 0});
    clearImage(depthImage, 0, INFINITY);
    renderTriangles(colorImage,
                    depthImage,
                    Vector4FList(0, 0, 1, 1),
                    Vector4FList(100, 0, 1, 1),
                    Vector4FList(50, 100, 1, 1),
                    {},
                    ValueListSize);
    writeImage("out.ppm", colorImage);
}
