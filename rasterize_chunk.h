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

#ifndef RASTERIZE_CHUNK_H_
#define RASTERIZE_CHUNK_H_

#include "value_list.h"

namespace tiled_renderer
{
constexpr std::size_t MaxChunkLevel = 3;

template <std::size_t Level>
struct ChunkLevel;

template <>
struct ChunkLevel<0> final
{
    static_assert(Log2ValueListSize > 0, "");
    static constexpr std::size_t subchunkWidth = static_cast<std::size_t>(1)
                                                 << (Log2ValueListSize + 1) / 2;
    static constexpr std::size_t subchunkHeight = static_cast<std::size_t>(1)
                                                  << (Log2ValueListSize) / 2;
    static constexpr std::size_t totalWidth = subchunkWidth;
    static constexpr std::size_t totalHeight = subchunkHeight;
    static constexpr std::size_t xStepSize = 1;
    static constexpr std::size_t yStepSize = 1;
    static ValueList<std::int32_t, ValueListSize> getXPositions() noexcept
    {
        ValueList<std::int32_t, ValueListSize> retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = i % subchunkWidth;
        }
        return retval;
    }
    static ValueList<std::int32_t, ValueListSize> getYPositions() noexcept
    {
        ValueList<std::int32_t, ValueListSize> retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = i / subchunkWidth;
        }
        return retval;
    }
};

template <std::size_t Level>
struct ChunkLevel final
{
    static constexpr std::size_t subchunkWidth = ChunkLevel<Level - 1>::subchunkHeight;
    static constexpr std::size_t subchunkHeight = ChunkLevel<Level - 1>::subchunkWidth;
    static constexpr std::size_t totalWidth = ChunkLevel<Level - 1>::totalWidth * subchunkWidth;
    static constexpr std::size_t totalHeight = ChunkLevel<Level - 1>::totalHeight * subchunkHeight;
    static constexpr std::size_t xStepSize = ChunkLevel<Level - 1>::totalWidth;
    static constexpr std::size_t yStepSize = ChunkLevel<Level - 1>::totalHeight;
    static ValueList<std::int32_t, ValueListSize> getXPositions() noexcept
    {
        ValueList<std::int32_t, ValueListSize> retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = (i % subchunkWidth) * xStepSize;
        }
        return retval;
    }
    static ValueList<std::int32_t, ValueListSize> getYPositions() noexcept
    {
        ValueList<std::int32_t, ValueListSize> retval{};
        for(std::size_t i = 0; i < ValueListSize; i++)
        {
            retval[i] = (i / subchunkWidth) * yStepSize;
        }
        return retval;
    }
};
}

#endif /* RASTERIZE_CHUNK_H_ */
