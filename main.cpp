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

using namespace tiled_renderer;

constexpr std::size_t ValueListWidth = 4;
typedef ValueList<float, ValueListWidth> FloatList;
typedef Vector4List<float, ValueListWidth> Vector4FList;
typedef Vector3List<float, ValueListWidth> Vector3FList;
typedef Image<float> DepthImage;
typedef Image<Vector4List<std::uint8_t, 1>> ColorImage;

int main()
{
    volatile float volatileFloat;
    FloatValueList initialList = map<ValueListWidth>([&]()
                                                     {
                                                         return volatileFloat;
                                                     });
    map(
        [&](float v)
        {
            volatileFloat = v;
        },
        fn(initialList));
}
