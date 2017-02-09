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
#include <iostream>
#include <fstream>
#include <cstdint>
#include <cassert>
#include <string>
#include "SDL.h"

using namespace tiled_renderer;

constexpr std::size_t Log2ValueListSize = 2;
constexpr std::size_t ValueListSize = static_cast<std::size_t>(1) << Log2ValueListSize;
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
                auto previousColor =
                    renderState.colorImage.getElement(xPositions[i], yPositions[i], 0);
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

void getTriangle(std::size_t triangleIndex,
                 std::size_t uCount,
                 std::size_t vCount,
                 Color &color,
                 Vector4F &p1,
                 Vector4F &p2,
                 Vector4F &p3)
{
    bool isSecondPartOfQuad = triangleIndex % 2;
    triangleIndex /= 2;
    float u0 = static_cast<float>(triangleIndex % uCount) / uCount;
    float v0 = static_cast<float>(triangleIndex / uCount) / vCount;
    float u1 = static_cast<float>(triangleIndex % uCount + 1) / uCount;
    float v1 = static_cast<float>(triangleIndex / uCount + 1) / vCount;
    if(isSecondPartOfQuad)
    {
        p1 = getPoint(u0, v0);
        p2 = getPoint(u1, v0);
        p3 = getPoint(u1, v1);
    }
    else
    {
        p1 = getPoint(u0, v0);
        p2 = getPoint(u1, v1);
        p3 = getPoint(u0, v1);
    }
    Vector4F normal = getPointNormal(0.5f * (u0 + u1), 0.5f * (v0 + v1));
    normal /= Vector4F(normal.abs());
    Vector4F colorF(0.3f, 0.3f, 0.3f, 1);
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
        Light(Vector4F(-std::sqrt(0.75f), 0, -0.5f, 0), Vector4F(0, 0, 1, 0)),
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
    color = static_cast<Color>(colorI32);
}

void renderFrame(ColorImage &colorImage, DepthImage &depthImage)
{
    clearImage(colorImage, 0, {0x20, 0x20, 0x20, 0xFF});
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
    std::size_t uCount = 300;
    std::size_t vCount = 200;
    std::size_t triangleCount = uCount * vCount * 2;
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
            Vector4F currentP1, currentP2, currentP3;
            getTriangle(triangleIndex + i,
                        uCount,
                        vCount,
                        colors.colors[i],
                        currentP1,
                        currentP2,
                        currentP3);
            p1.x[i] = currentP1.x[0];
            p1.y[i] = currentP1.y[0];
            p1.z[i] = currentP1.z[0];
            p1.w[i] = currentP1.w[0];
            p2.x[i] = currentP2.x[0];
            p2.y[i] = currentP2.y[0];
            p2.z[i] = currentP2.z[0];
            p2.w[i] = currentP2.w[0];
            p3.x[i] = currentP3.x[0];
            p3.y[i] = currentP3.y[0];
            p3.z[i] = currentP3.z[0];
            p3.w[i] = currentP3.w[0];
        }
        renderTriangles(colorImage,
                        depthImage,
                        tform.apply(p1),
                        tform.apply(p2),
                        tform.apply(p3),
                        colors,
                        triangleRenderCount);
    }
}

int main()
{
    constexpr std::size_t width = 320, height = 240;
    ColorImage colorImage(width, height, 1);
    DepthImage depthImage(width, height, 1);
    if(SDL_Init(SDL_INIT_VIDEO) != 0)
    {
        std::cerr << "SDL_Init failed: " << SDL_GetError() << std::endl;
        return 1;
    }
    SDL_Window *window = nullptr;
    SDL_Renderer *renderer = nullptr;
    if(SDL_CreateWindowAndRenderer(width, height, 0, &window, &renderer) != 0)
    {
        std::cerr << "SDL_CreateWindowAndRenderer failed: " << SDL_GetError() << std::endl;
        SDL_Quit();
        return 1;
    }
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
    constexpr auto pixelFormat = SDL_PIXELFORMAT_RGBA8888;
#else
    constexpr auto pixelFormat = SDL_PIXELFORMAT_ABGR8888;
#endif
    SDL_Texture *texture =
        SDL_CreateTexture(renderer, pixelFormat, SDL_TEXTUREACCESS_STREAMING, width, height);
    if(!texture)
    {
        std::cerr << "SDL_CreateTexture failed: " << SDL_GetError() << std::endl;
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }
    bool done = false;
    while(!done)
    {
        renderFrame(colorImage, depthImage);
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
                    exit(0);
                done = true;
            }
        }
    }
    writeImage("out.ppm", colorImage);
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}
