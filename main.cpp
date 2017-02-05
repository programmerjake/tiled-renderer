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
template <std::size_t Level>
struct ChunkLevel;

template <>
struct ChunkLevel<0> final
{
    static_assert(Log2ValueListSize > 0, "");
    constexpr std::size_t width = static_cast<std::size_t>(1) << (Log2ValueListSize + 1) / 2;
    constexpr std::size_t height = static_cast<std::size_t>(1) << (Log2ValueListSize) / 2;
    constexpr std::size_t totalWidth = width;
    constexpr std::size_t totalHeight = height;
    constexpr std::size_t xStepSize = 1;
    constexpr std::size_t yStepSize = 1;
};

template <std::size_t Level>
struct ChunkLevel final
{
    constexpr std::size_t width = ChunkLevel<Level - 1>::height;
    constexpr std::size_t height = ChunkLevel<Level - 1>::width;
    constexpr std::size_t totalWidth = ChunkLevel<Level - 1>::totalWidth * width;
    constexpr std::size_t totalHeight = ChunkLevel<Level - 1>::totalHeight * height;
    constexpr std::size_t xStepSize = ChunkLevel<Level - 1>::totalWidth;
    constexpr std::size_t yStepSize = ChunkLevel<Level - 1>::totalHeight;
};

typedef ValueList<float, ValueListSize> FloatList;
typedef ValueList<std::int32_t, ValueListSize> I32List;
typedef Vector4List<float, ValueListSize> Vector4FList;
typedef Vector4List<std::int32_t, ValueListSize> Vector4I32List;
typedef Vector3List<float, ValueListSize> Vector3FList;
typedef Image<float> DepthImage;
typedef Vector4List<std::uint8_t, 1> Color;
typedef Image<Color> ColorImage;

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
        I32List edgeEquationConstants[3];
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
    ValueList<Bool32, ValueListSize> drawTriangleMask;
    I32List edgeEquationConstants[3];
    I32List edgeEquationXSteps[3];
    I32List edgeEquationYSteps[3];
    TriangleRenderState(ColorImage &colorImage,
                        DepthImage &depthImage,
                        Vector4FList triangleP1,
                        Vector4FList triangleP2,
                        Vector4FList triangleP3,
                        Colors drawColors,
                        std::size_t triangleCount)
        : colorImage(colorImage),
          depthImage(depthImage),
          triangleP1(triangleP1),
          triangleP2(triangleP2),
          triangleP3(triangleP3),
          drawColors(drawColors),
          triangleCount(triangleCount),
          perLevelStates{},
          drawTriangleMask(true)
    {
    }
    bool setup()
    {
        FloatList divisor =
            (triangleP1.w * triangleP2.x - triangleP2.w * triangleP1.x) * triangleP3.y
            + (triangleP3.w * triangleP1.x - triangleP1.w * triangleP3.x) * triangleP2.y
            + (triangleP2.w * triangleP3.x - triangleP3.w * triangleP2.x) * triangleP1.y;
        drawTriangleMask &= divisor != FloatList(0);
        if(!reduce(
               [](Bool32 a, Bool32 b)
               {
                   return a | b;
               },
               drawTriangleMask))
            return false;
        FloatList factor = FloatList(static_cast<std::uint64_t>(1) << EdgeEquationFractionalBits) / divisor;
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
#error finish
    }
};

template <std::size_t Level,
          bool needsEdgeEquationOne,
          bool needsEdgeEquationTwo,
          bool needsEdgeEquationThree>
void renderTriangleHelper(const TriangleRenderState &renderState, std::size_t triangleIndex)
{
}

void renderTriangles(ColorImage &colorImage,
                     DepthImage &depthImage,
                     Vector4FList triangleP1,
                     Vector4FList triangleP2,
                     Vector4FList triangleP3,
                     Color drawColor,
                     std::size_t triangleCount)
{
    TriangleRenderState renderState(
        colorImage, depthImage, triangleP1, triangleP2, triangleP3, drawColor, triangleCount);
    if(!renderState.setup())
        return;
    for(std::size_t triangleIndex = 0; triangleIndex < triangleCount; triangleIndex++)
    {
        if(renderState.drawTriangleMask[triangleIndex])
        {
#warning finish
        }
    }
}

int main()
{
    ColorImage colorImage(640, 480, 1);
    DepthImage depthImage(640, 480, 1);
    clearImage(colorImage, 0, {0x7FU, 0x40U, 0xC0U, 0});
    clearImage(depthImage, 0, INFINITY);
    renderTriangles writeImage("out.ppm", colorImage);
}
