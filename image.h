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

#ifndef IMAGE_H_
#define IMAGE_H_

#include "value_list.h"
#include "vector_list.h"
#include <memory>
#include <new>
#include <type_traits>

namespace tiled_renderer
{
template <typename T>
class Image final
{
private:
    struct DeleteArray final
    {
        void operator()(T *elements) const noexcept
        {
            delete[] elements;
        }
    };

private:
    std::size_t width, height, layers;
    std::shared_ptr<T> elements;
    std::size_t getIndex(std::size_t x, std::size_t y, std::size_t layer) const noexcept
    {
        return x + width * (y + height * layer);
    }

public:
    constexpr Image() noexcept : width(0), height(0), layers(0), elements(nullptr)
    {
    }
    explicit Image(std::size_t width, std::size_t height, std::size_t layers)
        : width(width), height(height), layers(layers), elements()
    {
        if(width != 0 && height != 0 && layers != 0)
        {
            std::size_t elementCount = width * height * layers;
            if(elementCount / width / height != layers) // if the multiplication overflowed
                throw std::bad_alloc();
            elements = std::shared_ptr<T>(new T[elementCount](), DeleteArray());
        }
    }
    explicit operator bool() const noexcept
    {
        return elements != nullptr;
    }
    std::size_t getWidth() const noexcept
    {
        return width;
    }
    std::size_t getHeight() const noexcept
    {
        return height;
    }
    std::size_t getLayers() const noexcept
    {
        return layers;
    }
    void setElementUnchecked(std::size_t x, std::size_t y, std::size_t layer, const T &v) noexcept
    {
        elements.get()[getIndex(x, y, layer)] = v;
    }
    void setElementUnchecked(std::size_t x, std::size_t y, std::size_t layer, T &&v) noexcept
    {
        elements.get()[getIndex(x, y, layer)] = std::move(v);
    }
    void setElement(std::size_t x, std::size_t y, std::size_t layer, T &&v) noexcept
    {
        if(x < width && y < height && layer < layers)
            setElementUnchecked(x, y, layer, std::move(v));
    }
    void setElement(std::size_t x, std::size_t y, std::size_t layer, const T &v) noexcept
    {
        if(x < width && y < height && layer < layers)
            setElementUnchecked(x, y, layer, v);
    }
    const T &getElementUnchecked(std::size_t x, std::size_t y, std::size_t layer) const noexcept
    {
        return elements.get()[getIndex(x, y, layer)];
    }
    T getElement(std::size_t x, std::size_t y, std::size_t layer) const noexcept
    {
        if(x < width && y < height && layer < layers)
            return getElementUnchecked(x, y, layer);
        return T();
    }
};
}

#endif /* IMAGE_H_ */