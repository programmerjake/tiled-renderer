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

#ifndef MATRIX_LIST_H_
#define MATRIX_LIST_H_

#include "value_list.h"
#include "vector_list.h"

namespace tiled_renderer
{
template <std::size_t N>
struct Matrix4x4List final
{
    ValueList<float, N> elements[4][4];
    ValueList<float, N>(&operator[](std::size_t index) noexcept)[4]
    {
        return elements[index];
    }
    const ValueList<float, N>(&operator[](std::size_t index) const noexcept)[4]
    {
        return elements[index];
    }
    Matrix4x4List(const ValueList<float, N> &x00,
                  const ValueList<float, N> &x10,
                  const ValueList<float, N> &x20,
                  const ValueList<float, N> &x30,
                  const ValueList<float, N> &x01,
                  const ValueList<float, N> &x11,
                  const ValueList<float, N> &x21,
                  const ValueList<float, N> &x31,
                  const ValueList<float, N> &x02,
                  const ValueList<float, N> &x12,
                  const ValueList<float, N> &x22,
                  const ValueList<float, N> &x32,
                  const ValueList<float, N> &x03,
                  const ValueList<float, N> &x13,
                  const ValueList<float, N> &x23,
                  const ValueList<float, N> &x33) noexcept : elements{
                                                                 {x00, x01, x02, x03},
                                                                 {x10, x11, x12, x13},
                                                                 {x20, x21, x22, x23},
                                                                 {x30, x31, x32, x33},
                                                             }
    {
    }
    Matrix4x4List(const ValueList<float, N> &x00,
                  const ValueList<float, N> &x10,
                  const ValueList<float, N> &x20,
                  const ValueList<float, N> &x30,
                  const ValueList<float, N> &x01,
                  const ValueList<float, N> &x11,
                  const ValueList<float, N> &x21,
                  const ValueList<float, N> &x31,
                  const ValueList<float, N> &x02,
                  const ValueList<float, N> &x12,
                  const ValueList<float, N> &x22,
                  const ValueList<float, N> &x32) noexcept
        : elements{
              {x00, x01, x02, ValueList<float, N>(0)},
              {x10, x11, x12, ValueList<float, N>(0)},
              {x20, x21, x22, ValueList<float, N>(0)},
              {x30, x31, x32, ValueList<float, N>(1)},
          }
    {
    }
    Matrix4x4List() noexcept : elements{
                                   {ValueList<float, N>(1),
                                    ValueList<float, N>(0),
                                    ValueList<float, N>(0),
                                    ValueList<float, N>(0)},
                                   {ValueList<float, N>(0),
                                    ValueList<float, N>(1),
                                    ValueList<float, N>(0),
                                    ValueList<float, N>(0)},
                                   {ValueList<float, N>(0),
                                    ValueList<float, N>(0),
                                    ValueList<float, N>(1),
                                    ValueList<float, N>(0)},
                                   {ValueList<float, N>(0),
                                    ValueList<float, N>(0),
                                    ValueList<float, N>(0),
                                    ValueList<float, N>(1)},
                               }
    {
    }
    static Matrix4x4List identity() noexcept
    {
        return Matrix4x4List();
    }
    static Matrix4x4List rotate(const Vector3List<float, N> &axis, double angle) noexcept
    {
        auto axisv = axis.normalizeOrZero();
        auto c = static_cast<float>(std::cos(angle));
        auto s = static_cast<float>(std::sin(angle));
        auto v = 1 - c; // Versine
        auto xx = axisv.x * axisv.x;
        auto xy = axisv.x * axisv.y;
        auto xz = axisv.x * axisv.z;
        auto yy = axisv.y * axisv.y;
        auto yz = axisv.y * axisv.z;
        auto zz = axisv.z * axisv.z;
        return Matrix4x4List(xx + (1 - xx) * c,
                             xy * v - axisv.z * s,
                             xz * v + axisv.y * s,
                             0,
                             xy * v + axisv.z * s,
                             yy + (1 - yy) * c,
                             yz * v - axisv.x * s,
                             0,
                             xz * v - axisv.y * s,
                             yz * v + axisv.x * s,
                             zz + (1 - zz) * c,
                             0);
    }
    static Matrix4x4List rotateX(double angle) noexcept
    {
        auto c = static_cast<float>(std::cos(angle));
        auto s = static_cast<float>(std::sin(angle));
        return Matrix4x4List(1, 0, 0, 0, 0, c, -s, 0, 0, s, c, 0);
    }
    static Matrix4x4List rotateY(double angle) noexcept
    {
        auto c = static_cast<float>(std::cos(angle));
        auto s = static_cast<float>(std::sin(angle));
        return Matrix4x4List(c, 0, s, 0, 0, 1, 0, 0, -s, 0, c, 0);
    }
    static Matrix4x4List rotateZ(double angle) noexcept
    {
        auto c = static_cast<float>(std::cos(angle));
        auto s = static_cast<float>(std::sin(angle));
        return Matrix4x4List(c, -s, 0, 0, s, c, 0, 0, 0, 0, 1, 0);
    }
    static Matrix4x4List translate(const Vector3List<float, N> &position) noexcept
    {
        return Matrix4x4List(1, 0, 0, position.x, 0, 1, 0, position.y, 0, 0, 1, position.z);
    }
    static Matrix4x4List translate(float x, float y, float z) noexcept
    {
        return Matrix4x4List(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, z);
    }
    static Matrix4x4List scale(float x, float y, float z) noexcept
    {
        return Matrix4x4List(x, 0, 0, 0, 0, y, 0, 0, 0, 0, z, 0);
    }
    static Matrix4x4List scale(const Vector3List<float, N> &s) noexcept
    {
        return Matrix4x4List(s.x, 0, 0, 0, 0, s.y, 0, 0, 0, 0, s.z, 0);
    }
    static Matrix4x4List scale(float s) noexcept
    {
        return Matrix4x4List(s, 0, 0, 0, 0, s, 0, 0, 0, 0, s, 0);
    }
    static Matrix4x4List frustum(
        float left, float right, float bottom, float top, float front, float back) noexcept
    {
        return Matrix4x4List(2 * front / (right - left),
                             0,
                             (right + left) / (right - left),
                             0,
                             0,
                             2 * front / (top - bottom),
                             (top + bottom) / (top - bottom),
                             0,
                             0,
                             0,
                             (back + front) / (front - back),
                             2 * front * back / (front - back),
                             0,
                             0,
                             -1,
                             0);
    }
    static Matrix4x4List inverseTransposeFrustum(
        float left, float right, float bottom, float top, float front, float back) noexcept
    {
        return Matrix4x4List((right - left) / (2 * front),
                             0,
                             0,
                             0,
                             0,
                             (top - bottom) / (2 * front),
                             0,
                             0,
                             0,
                             0,
                             0,
                             (front - back) / (2 * front * back),
                             (left + right) / (2 * front),
                             (bottom + top) / (2 * front),
                             -1,
                             (back + front) / (2 * front * back));
    }
    static Matrix4x4List ortho(
        float left, float right, float bottom, float top, float front, float back) noexcept
    {
        return Matrix4x4List(-2 / (left - right),
                             0,
                             0,
                             (right + left) / (left - right),

                             0,
                             -2 / (bottom - top),
                             0,
                             (top + bottom) / (bottom - top),

                             0,
                             0,
                             2 / (front - back),
                             (back + front) / (front - back));
    }
    static Matrix4x4List inverseTransposeOrtho(
        float left, float right, float bottom, float top, float front, float back) noexcept
    {
        return Matrix4x4List((right - left) * 0.5f,
                             0,
                             0,
                             0,

                             0,
                             (top - bottom) * 0.5f,
                             0,
                             0,

                             0,
                             0,
                             (front - back) * 0.5f,
                             0,

                             (left + right) * 0.5f,
                             (bottom + top) * 0.5f,
                             (front + back) * -0.5f,
                             1);
    }
    ValueList<float, N> determinant() const noexcept
    {
        return elements[0][3] * elements[1][2] * elements[2][1] * elements[3][0]
               - elements[0][2] * elements[1][3] * elements[2][1] * elements[3][0]
               - elements[0][3] * elements[1][1] * elements[2][2] * elements[3][0]
               + elements[0][1] * elements[1][3] * elements[2][2] * elements[3][0]
               + elements[0][2] * elements[1][1] * elements[2][3] * elements[3][0]
               - elements[0][1] * elements[1][2] * elements[2][3] * elements[3][0]
               - elements[0][3] * elements[1][2] * elements[2][0] * elements[3][1]
               + elements[0][2] * elements[1][3] * elements[2][0] * elements[3][1]
               + elements[0][3] * elements[1][0] * elements[2][2] * elements[3][1]
               - elements[0][0] * elements[1][3] * elements[2][2] * elements[3][1]
               - elements[0][2] * elements[1][0] * elements[2][3] * elements[3][1]
               + elements[0][0] * elements[1][2] * elements[2][3] * elements[3][1]
               + elements[0][3] * elements[1][1] * elements[2][0] * elements[3][2]
               - elements[0][1] * elements[1][3] * elements[2][0] * elements[3][2]
               - elements[0][3] * elements[1][0] * elements[2][1] * elements[3][2]
               + elements[0][0] * elements[1][3] * elements[2][1] * elements[3][2]
               + elements[0][1] * elements[1][0] * elements[2][3] * elements[3][2]
               - elements[0][0] * elements[1][1] * elements[2][3] * elements[3][2]
               - elements[0][2] * elements[1][1] * elements[2][0] * elements[3][3]
               + elements[0][1] * elements[1][2] * elements[2][0] * elements[3][3]
               + elements[0][2] * elements[1][0] * elements[2][1] * elements[3][3]
               - elements[0][0] * elements[1][2] * elements[2][1] * elements[3][3]
               - elements[0][1] * elements[1][0] * elements[2][2] * elements[3][3]
               + elements[0][0] * elements[1][1] * elements[2][2] * elements[3][3];
    }
    Matrix4x4List concat(const Matrix4x4List &rt) const noexcept
    {
        return Matrix4x4List(
            /* elements[0][0] */ elements[0][0] * rt[0][0] + elements[0][1] * rt[1][0]
                + elements[0][2] * rt[2][0]
                + elements[0][3] * rt[3][0],
            /* elements[1][0] */ elements[1][0] * rt[0][0] + elements[1][1] * rt[1][0]
                + elements[1][2] * rt[2][0]
                + elements[1][3] * rt[3][0],
            /* elements[2][0] */ elements[2][0] * rt[0][0] + elements[2][1] * rt[1][0]
                + elements[2][2] * rt[2][0]
                + elements[2][3] * rt[3][0],
            /* elements[3][0] */ elements[3][0] * rt[0][0] + elements[3][1] * rt[1][0]
                + elements[3][2] * rt[2][0]
                + elements[3][3] * rt[3][0],
            /* elements[0][1] */ elements[0][0] * rt[0][1] + elements[0][1] * rt[1][1]
                + elements[0][2] * rt[2][1]
                + elements[0][3] * rt[3][1],
            /* elements[1][1] */ elements[1][0] * rt[0][1] + elements[1][1] * rt[1][1]
                + elements[1][2] * rt[2][1]
                + elements[1][3] * rt[3][1],
            /* elements[2][1] */ elements[2][0] * rt[0][1] + elements[2][1] * rt[1][1]
                + elements[2][2] * rt[2][1]
                + elements[2][3] * rt[3][1],
            /* elements[3][1] */ elements[3][0] * rt[0][1] + elements[3][1] * rt[1][1]
                + elements[3][2] * rt[2][1]
                + elements[3][3] * rt[3][1],
            /* elements[0][2] */ elements[0][0] * rt[0][2] + elements[0][1] * rt[1][2]
                + elements[0][2] * rt[2][2]
                + elements[0][3] * rt[3][2],
            /* elements[1][2] */ elements[1][0] * rt[0][2] + elements[1][1] * rt[1][2]
                + elements[1][2] * rt[2][2]
                + elements[1][3] * rt[3][2],
            /* elements[2][2] */ elements[2][0] * rt[0][2] + elements[2][1] * rt[1][2]
                + elements[2][2] * rt[2][2]
                + elements[2][3] * rt[3][2],
            /* elements[3][2] */ elements[3][0] * rt[0][2] + elements[3][1] * rt[1][2]
                + elements[3][2] * rt[2][2]
                + elements[3][3] * rt[3][2],
            /* elements[0][3] */ elements[0][0] * rt[0][3] + elements[0][1] * rt[1][3]
                + elements[0][2] * rt[2][3]
                + elements[0][3] * rt[3][3],
            /* elements[1][3] */ elements[1][0] * rt[0][3] + elements[1][1] * rt[1][3]
                + elements[1][2] * rt[2][3]
                + elements[1][3] * rt[3][3],
            /* elements[2][3] */ elements[2][0] * rt[0][3] + elements[2][1] * rt[1][3]
                + elements[2][2] * rt[2][3]
                + elements[2][3] * rt[3][3],
            /* elements[3][3] */ elements[3][0] * rt[0][3] + elements[3][1] * rt[1][3]
                + elements[3][2] * rt[2][3]
                + elements[3][3] * rt[3][3]);
    }
    Vector4List<float, N> apply(const Vector4List<float, N> &v) const noexcept
    {
        return Vector4List<float, N>(
            v.x * elements[0][0] + v.y * elements[1][0] + v.z * elements[2][0]
                + v.w * elements[3][0],
            v.x * elements[0][1] + v.y * elements[1][1] + v.z * elements[2][1]
                + v.w * elements[3][1],
            v.x * elements[0][2] + v.y * elements[1][2] + v.z * elements[2][2]
                + v.w * elements[3][2],
            v.x * elements[0][3] + v.y * elements[1][3] + v.z * elements[2][3]
                + v.w * elements[3][3]);
    }
};
}

#endif /* MATRIX_LIST_H_ */
