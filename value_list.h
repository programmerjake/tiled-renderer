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

#ifndef VALUE_LIST_H_
#define VALUE_LIST_H_

#include <type_traits>
#include <utility>
#include <cstdint>

namespace tiled_renderer
{
template <typename, std::size_t>
struct ValueList;

namespace detail
{
struct FillValueList final
{
    template <typename, std::size_t>
    friend struct ValueList;

private:
    constexpr explicit FillValueList() noexcept
    {
    }
};
}

template <typename T, std::size_t N>
struct ValueList final
{
    static_assert(N != 0, "N can't be 0");
    static_assert((N & (N - 1)) == 0, "N must be a power of 2");
    union
    {
        T arrayValue[N]
#ifndef __CDT_PARSER__
            alignas(sizeof(T) * N)
#endif
                ;
#ifdef __GNUC__
        T vectorValue __attribute__((vector_size(sizeof(T) * N)));
#endif
    };
    ValueList() noexcept : arrayValue{}
    {
    }
    ValueList(T value) noexcept : arrayValue{}
    {
        for(auto &v : arrayValue)
            v = value;
    }
    const T &operator[](std::size_t index) const noexcept
    {
        return arrayValue[index];
    }
    T &operator[](std::size_t index) noexcept
    {
        return arrayValue[index];
    }
    const ValueList &operator+() const noexcept
    {
        return *this;
    }
    const ValueList &operator+=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator+(rt));
    }
    const ValueList &operator-=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator-(rt));
    }
    const ValueList &operator*=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator*(rt));
    }
    const ValueList &operator/=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator/(rt));
    }
    const ValueList &operator%=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator%(rt));
    }
    const ValueList &operator<<=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator<<(rt));
    }
    const ValueList &operator>>=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator>>(rt));
    }
    const ValueList &operator&=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator&(rt));
    }
    const ValueList &operator|=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator|(rt));
    }
    const ValueList &operator^=(const ValueList &rt) noexcept
    {
        return this->operator=(this->operator^(rt));
    }
    template <typename T2>
    explicit operator ValueList<T2, N>() const noexcept
    {
        ValueList<T2, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = static_cast<T2>(arrayValue[i]);
        return retval;
    }
    ValueList operator-() const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = -vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = -arrayValue[i];
#endif
        return retval;
    }
    const ValueList &operator++() noexcept
    {
        for(std::size_t i = 0; i < N; i++)
            ++arrayValue[i];
        return *this;
    }
    ValueList operator++(int) noexcept
    {
        ValueList retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i]++;
        return retval;
    }
    const ValueList &operator--() noexcept
    {
        for(std::size_t i = 0; i < N; i++)
            --arrayValue[i];
        return *this;
    }
    ValueList operator--(int) noexcept
    {
        ValueList retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i]--;
        return retval;
    }
    ValueList<bool, N> operator!() const noexcept
    {
        ValueList<bool, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = !arrayValue[i];
        return retval;
    }
    ValueList operator~() const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = !vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = ~arrayValue[i];
#endif
        return retval;
    }
    ValueList operator*(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue * rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] * rt[i];
#endif
        return retval;
    }
    ValueList operator/(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue / rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] / rt[i];
#endif
        return retval;
    }
    ValueList operator%(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue % rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] % rt[i];
#endif
        return retval;
    }
    ValueList operator+(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue + rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] + rt[i];
#endif
        return retval;
    }
    ValueList operator-(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue - rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] - rt[i];
#endif
        return retval;
    }
    ValueList operator<<(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue << rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] << rt[i];
#endif
        return retval;
    }
    ValueList operator>>(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue >> rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] >> rt[i];
#endif
        return retval;
    }
    ValueList operator&(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue & rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] & rt[i];
#endif
        return retval;
    }
    ValueList operator|(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue | rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] | rt[i];
#endif
        return retval;
    }
    ValueList operator^(const ValueList &rt) const noexcept
    {
        ValueList retval;
#ifdef __GNUC__
        retval.vectorValue = vectorValue ^ rt.vectorValue;
#else
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] ^ rt[i];
#endif
        return retval;
    }
    ValueList<bool, N> operator<(const ValueList &rt) const noexcept
    {
        ValueList<bool, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] < rt[i];
        return retval;
    }
    ValueList<bool, N> operator<=(const ValueList &rt) const noexcept
    {
        ValueList<bool, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] < rt[i];
        return retval;
    }
    ValueList<bool, N> operator>(const ValueList &rt) const noexcept
    {
        ValueList<bool, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] > rt[i];
        return retval;
    }
    ValueList<bool, N> operator>=(const ValueList &rt) const noexcept
    {
        ValueList<bool, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] >= rt[i];
        return retval;
    }
    ValueList<bool, N> operator==(const ValueList &rt) const noexcept
    {
        ValueList<bool, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] == rt[i];
        return retval;
    }
    ValueList<bool, N> operator!=(const ValueList &rt) const noexcept
    {
        ValueList<bool, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = arrayValue[i] != rt[i];
        return retval;
    }
};

namespace detail
{
template <std::size_t N, typename Fn, typename ReturnType, typename... FunctionArgs>
struct MapImplementation final
{
    typedef ValueList<ReturnType, N> ValueListReturnType;
    static ValueList<ReturnType, N> run(Fn &&fn,
                                        const ValueList<FunctionArgs, N> &... functionArgs) noexcept
    {
        ValueList<ReturnType, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = std::forward<Fn>(fn)(functionArgs[i]...);
        return retval;
    }
};
template <std::size_t N, typename Fn, typename... FunctionArgs>
struct MapImplementation<N, Fn, void, FunctionArgs...> final
{
    typedef void ValueListReturnType;
    static void run(Fn &&fn, const ValueList<FunctionArgs, N> &... functionArgs) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
            std::forward<Fn>(fn)(functionArgs[i]...);
    }
};
template <std::size_t N, typename Fn, typename ReturnType>
struct MapImplementation2 final
{
    typedef ValueList<ReturnType, N> ValueListReturnType;
    static ValueList<ReturnType, N> run(Fn &&fn) noexcept
    {
        ValueList<ReturnType, N> retval;
        for(std::size_t i = 0; i < N; i++)
            retval[i] = std::forward<Fn>(fn)();
        return retval;
    }
};
template <std::size_t N, typename Fn>
struct MapImplementation2<N, Fn, void> final
{
    typedef void ValueListReturnType;
    static void run(Fn &&fn) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
            std::forward<Fn>(fn)();
    }
};
}

template <std::size_t N, typename Fn, typename... FunctionArgs>
typename detail::
    MapImplementation<N,
                      Fn,
                      typename std::decay<typename std::result_of<Fn(FunctionArgs...)>::type>::type,
                      FunctionArgs...>::ValueListReturnType
    map(Fn &&fn, const ValueList<FunctionArgs, N> &... functionArgs) noexcept
{
    return detail::MapImplementation<N,
                                     Fn,
                                     typename std::decay<
                                         typename std::result_of<Fn(FunctionArgs...)>::type>::type,
                                     FunctionArgs...>::run(std::forward<Fn>(fn), functionArgs...);
}

template <std::size_t N, typename Fn>
typename detail::
    MapImplementation2<N, Fn, typename std::decay<typename std::result_of<Fn()>::type>::type>::
        ValueListReturnType
    map(Fn &&fn) noexcept
{
    return detail::
        MapImplementation2<N, Fn, typename std::decay<typename std::result_of<Fn()>::type>::type>::
            run(std::forward<Fn>(fn));
}

template <typename T, typename Fn>
T reduce(Fn &&fn, const ValueList<T, 1> &input) noexcept
{
    // typecheck fn
    typedef decltype(std::declval<T &>() =
                         std::forward<Fn>(fn)(std::declval<T>(), std::declval<T>())) typecheck;
    return input[std::is_same<typecheck, typecheck>::value ? 0 : 0]; // reduces to 0; so we don't
    // have a warning about
    // typecheck
}

template <typename T, typename Fn, std::size_t N>
T reduce(Fn &&fn, const ValueList<T, N> &input) noexcept
{
    ValueList<T, N / 2> arg1Input;
    ValueList<T, N / 2> arg2Input;
    for(std::size_t i = 0; i < N / 2; i++)
        arg1Input[i] = input[i];
    for(std::size_t i = 0; i < N / 2; i++)
        arg2Input[i] = input[i + N / 2];
    return std::forward<Fn>(fn)(reduce(std::forward<Fn>(fn), arg1Input),
                                reduce(std::forward<Fn>(fn), arg2Input));
}

template <typename T, std::size_t N>
ValueList<T, N> select(const ValueList<bool, N> &condition,
                       const ValueList<T, N> &trueValue,
                       const ValueList<T, N> &falseValue) noexcept
{
    ValueList<T, N> retval;
    for(std::size_t i = 0; i < N; i++)
        retval[i] = (condition[i] ? trueValue[i] : falseValue[i]);
    return retval;
}
}

#endif /* VALUE_LIST_H_ */
