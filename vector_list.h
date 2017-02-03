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

#ifndef VECTOR_LIST_H_
#define VECTOR_LIST_H_

#include "value_list.h"

namespace tiled_renderer
{
template <typename T, std::size_t N>
struct Vector3List final
{
    ValueList<T, N> x;
    ValueList<T, N> y;
    ValueList<T, N> z;
    Vector3List(const ValueList<T, N> &value) noexcept : x(value), y(value), z(value)
    {
    }
    Vector3List() noexcept : x(), y(), z()
    {
    }
    Vector3List(const ValueList<T, N> &x,
                const ValueList<T, N> &y,
                const ValueList<T, N> &z) noexcept : x(x),
                                                     y(y),
                                                     z(z)
    {
    }
    Vector3List(const Vector3List<T, 1> &v) noexcept : x(v.x), y(v.y), z(v.z)
    {
    }
    const Vector3List &operator+() const noexcept
    {
        return *this;
    }
    const Vector3List &operator+=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator+(rt));
    }
    const Vector3List &operator-=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator-(rt));
    }
    const Vector3List &operator*=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator*(rt));
    }
    const Vector3List &operator/=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator/(rt));
    }
    const Vector3List &operator%=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator%(rt));
    }
    const Vector3List &operator<<=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator<<(rt));
    }
    const Vector3List &operator>>=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator>>(rt));
    }
    const Vector3List &operator&=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator&(rt));
    }
    const Vector3List &operator|=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator|(rt));
    }
    const Vector3List &operator^=(const Vector3List &rt) noexcept
    {
        return this->operator=(this->operator^(rt));
    }
    Vector3List operator-() const noexcept
    {
        return Vector3List(-x, -y, -z);
    }
    Vector3List operator~() const noexcept
    {
        return Vector3List(~x, ~y, ~z);
    }
    Vector3List operator*(const Vector3List &rt) const noexcept
    {
        return Vector3List(x * rt.x, y * rt.y, z * rt.z);
    }
    Vector3List operator/(const Vector3List &rt) const noexcept
    {
        return Vector3List(x / rt.x, y / rt.y, z / rt.z);
    }
    Vector3List operator%(const Vector3List &rt) const noexcept
    {
        return Vector3List(x % rt.x, y % rt.y, z % rt.z);
    }
    Vector3List operator+(const Vector3List &rt) const noexcept
    {
        return Vector3List(x + rt.x, y + rt.y, z + rt.z);
    }
    Vector3List operator-(const Vector3List &rt) const noexcept
    {
        return Vector3List(x - rt.x, y - rt.y, z - rt.z);
    }
    Vector3List operator<<(const Vector3List &rt) const noexcept
    {
        return Vector3List(x << rt.x, y << rt.y, z << rt.z);
    }
    Vector3List operator>>(const Vector3List &rt) const noexcept
    {
        return Vector3List(x >> rt.x, y >> rt.y, z >> rt.z);
    }
    Vector3List operator&(const Vector3List &rt) const noexcept
    {
        return Vector3List(x & rt.x, y & rt.y, z & rt.z);
    }
    Vector3List operator|(const Vector3List &rt) const noexcept
    {
        return Vector3List(x | rt.x, y | rt.y, z | rt.z);
    }
    Vector3List operator^(const Vector3List &rt) const noexcept
    {
        return Vector3List(x ^ rt.x, y ^ rt.y, z ^ rt.z);
    }
    ValueList<bool, N> operator==(const Vector3List &rt) const noexcept
    {
        return (x == rt.x) & (y == rt.y) & (z == rt.z);
    }
    ValueList<bool, N> operator!=(const Vector3List &rt) const noexcept
    {
        return !operator==(rt);
    }
    ValueList<T, N> sum() const noexcept
    {
        return x + y + z;
    }
    ValueList<T, N> dot(const Vector3List &rt) const noexcept
    {
        return operator*(rt).sum();
    }
    Vector3List<T, N> cross(const Vector3List &rt) const noexcept
    {
        return Vector3List(y * rt.z - z * rt.y, z * rt.x - x * rt.z, x * rt.y - y * rt.x);
    }
    ValueList<T, N> absSquared() const noexcept
    {
        return dot(*this);
    }
    ValueList<T, N> abs() const noexcept
    {
        return map(
            [](T v)
            {
                return std::sqrt(v);
            },
            absSquared());
    }
    Vector3List<T, N> normalizeOrZero() const noexcept
    {
        auto r = abs();
        return select(r == 0, 0, operator/(r));
    }
};

template <typename T, std::size_t N>
struct Vector4List final
{
    ValueList<T, N> x;
    ValueList<T, N> y;
    ValueList<T, N> z;
    ValueList<T, N> w;
    Vector4List(const ValueList<T, N> &value) noexcept : x(value), y(value), z(value), w(value)
    {
    }
    Vector4List() noexcept : x(), y(), z(), w()
    {
    }
    Vector4List(const ValueList<T, N> &x,
                const ValueList<T, N> &y,
                const ValueList<T, N> &z,
                const ValueList<T, N> &w) noexcept : x(x),
                                                     y(y),
                                                     z(z),
                                                     w(w)
    {
    }
    Vector4List(const Vector4List<T, 1> &v) noexcept : x(v.x), y(v.y), z(v.z), w(v.w)
    {
    }
    Vector4List(const Vector3List<T, N> &v, const ValueList<T, N> &w) noexcept : x(v.x),
                                                                                 y(v.y),
                                                                                 z(v.z),
                                                                                 w(w)
    {
    }
    explicit operator Vector3List<T, N>() const noexcept
    {
        return Vector3List<T, N>(x, y, z);
    }
    const Vector4List &operator+() const noexcept
    {
        return *this;
    }
    const Vector4List &operator+=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator+(rt));
    }
    const Vector4List &operator-=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator-(rt));
    }
    const Vector4List &operator*=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator*(rt));
    }
    const Vector4List &operator/=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator/(rt));
    }
    const Vector4List &operator%=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator%(rt));
    }
    const Vector4List &operator<<=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator<<(rt));
    }
    const Vector4List &operator>>=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator>>(rt));
    }
    const Vector4List &operator&=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator&(rt));
    }
    const Vector4List &operator|=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator|(rt));
    }
    const Vector4List &operator^=(const Vector4List &rt) noexcept
    {
        return this->operator=(this->operator^(rt));
    }
    Vector4List operator-() const noexcept
    {
        return Vector4List(-x, -y, -z, -w);
    }
    Vector4List operator~() const noexcept
    {
        return Vector4List(~x, ~y, ~z, ~w);
    }
    Vector4List operator*(const Vector4List &rt) const noexcept
    {
        return Vector4List(x * rt.x, y * rt.y, z * rt.z, w * rt.w);
    }
    Vector4List operator/(const Vector4List &rt) const noexcept
    {
        return Vector4List(x / rt.x, y / rt.y, z / rt.z, w / rt.w);
    }
    Vector4List operator%(const Vector4List &rt) const noexcept
    {
        return Vector4List(x % rt.x, y % rt.y, z % rt.z, w % rt.w);
    }
    Vector4List operator+(const Vector4List &rt) const noexcept
    {
        return Vector4List(x + rt.x, y + rt.y, z + rt.z, w + rt.w);
    }
    Vector4List operator-(const Vector4List &rt) const noexcept
    {
        return Vector4List(x - rt.x, y - rt.y, z - rt.z, w - rt.w);
    }
    Vector4List operator<<(const Vector4List &rt) const noexcept
    {
        return Vector4List(x << rt.x, y << rt.y, z << rt.z, w << rt.w);
    }
    Vector4List operator>>(const Vector4List &rt) const noexcept
    {
        return Vector4List(x >> rt.x, y >> rt.y, z >> rt.z, w >> rt.w);
    }
    Vector4List operator&(const Vector4List &rt) const noexcept
    {
        return Vector4List(x & rt.x, y & rt.y, z & rt.z, w & rt.w);
    }
    Vector4List operator|(const Vector4List &rt) const noexcept
    {
        return Vector4List(x | rt.x, y | rt.y, z | rt.z, w | rt.w);
    }
    Vector4List operator^(const Vector4List &rt) const noexcept
    {
        return Vector4List(x ^ rt.x, y ^ rt.y, z ^ rt.z, w ^ rt.w);
    }
    ValueList<bool, N> operator==(const Vector4List &rt) const noexcept
    {
        return (x == rt.x) & (y == rt.y) & (z == rt.z) & (w == rt.w);
    }
    ValueList<bool, N> operator!=(const Vector4List &rt) const noexcept
    {
        return !operator==(rt);
    }
    ValueList<T, N> sum() const noexcept
    {
        return x + y + z + w;
    }
    ValueList<T, N> dot(const Vector4List &rt) const noexcept
    {
        return operator*(rt).sum();
    }
    ValueList<T, N> absSquared() const noexcept
    {
        return dot(*this);
    }
    ValueList<T, N> abs() const noexcept
    {
        return map(
            [](T v)
            {
                return std::sqrt(v);
            },
            absSquared());
    }
};
}

#endif /* VECTOR_LIST_H_ */
