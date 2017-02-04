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
#include <cmath>
#include <limits>

namespace tiled_renderer
{
template <std::size_t BitCount>
struct UIntByBitWidth final
{
};

template <>
struct UIntByBitWidth<8> final
{
    typedef std::uint8_t type;
};

template <>
struct UIntByBitWidth<16> final
{
    typedef std::uint16_t type;
};

template <>
struct UIntByBitWidth<32> final
{
    typedef std::uint32_t type;
};

template <>
struct UIntByBitWidth<64> final
{
    typedef std::uint64_t type;
};

template <std::size_t BitCount>
struct SIntByBitWidth final
{
};

template <>
struct SIntByBitWidth<8> final
{
    typedef std::int8_t type;
};

template <>
struct SIntByBitWidth<16> final
{
    typedef std::int16_t type;
};

template <>
struct SIntByBitWidth<32> final
{
    typedef std::int32_t type;
};

template <>
struct SIntByBitWidth<64> final
{
    typedef std::int64_t type;
};

namespace detail
{
struct BoolByBitWidthFromUnderlyingTypeTag final
{
    constexpr explicit BoolByBitWidthFromUnderlyingTypeTag() noexcept
    {
    }
};
}

template <std::size_t BitCount>
struct BoolByBitWidth final
{
    typedef typename SIntByBitWidth<BitCount>::type underlyingType;
    underlyingType value;
    constexpr BoolByBitWidth() noexcept : value()
    {
    }
    constexpr BoolByBitWidth(bool v) noexcept : value(v ? -1 : 0)
    {
    }
    constexpr BoolByBitWidth(underlyingType value,
                             detail::BoolByBitWidthFromUnderlyingTypeTag) noexcept : value(value)
    {
    }
    constexpr operator bool() const noexcept
    {
        return value != 0;
    }
    constexpr BoolByBitWidth operator!() const noexcept
    {
        return BoolByBitWidth(~value, detail::BoolByBitWidthFromUnderlyingTypeTag());
    }
    template <std::size_t BitCount2>
    friend constexpr BoolByBitWidth<BitCount2> operator&(
        const BoolByBitWidth<BitCount2> &a, const BoolByBitWidth<BitCount2> &b) noexcept
    {
        return BoolByBitWidth<BitCount2>(a.value & b.value,
                                         detail::BoolByBitWidthFromUnderlyingTypeTag());
    }
    template <std::size_t BitCount2>
    friend constexpr BoolByBitWidth<BitCount2> operator|(
        const BoolByBitWidth<BitCount2> &a, const BoolByBitWidth<BitCount2> &b) noexcept
    {
        return BoolByBitWidth<BitCount2>(a.value | b.value,
                                         detail::BoolByBitWidthFromUnderlyingTypeTag());
    }
    template <std::size_t BitCount2>
    friend constexpr BoolByBitWidth<BitCount2> operator^(
        const BoolByBitWidth<BitCount2> &a, const BoolByBitWidth<BitCount2> &b) noexcept
    {
        return BoolByBitWidth<BitCount2>(a.value ^ b.value,
                                         detail::BoolByBitWidthFromUnderlyingTypeTag());
    }
    template <std::size_t BitCount2>
    friend void operator&&(const BoolByBitWidth<BitCount2> &a,
                           const BoolByBitWidth<BitCount2> &b) noexcept = delete;
    template <std::size_t BitCount2>
    friend void operator||(const BoolByBitWidth<BitCount2> &a,
                           const BoolByBitWidth<BitCount2> &b) noexcept = delete;
    template <std::size_t BitCount2>
    friend void operator&&(const BoolByBitWidth<BitCount2> &a, bool b) noexcept = delete;
    template <std::size_t BitCount2>
    friend void operator||(const BoolByBitWidth<BitCount2> &a, bool b) noexcept = delete;
    template <std::size_t BitCount2>
    friend void operator&&(bool a, const BoolByBitWidth<BitCount2> &b) noexcept = delete;
    template <std::size_t BitCount2>
    friend void operator||(bool a, const BoolByBitWidth<BitCount2> &b) noexcept = delete;
};

typedef BoolByBitWidth<8> Bool8;
typedef BoolByBitWidth<16> Bool16;
typedef BoolByBitWidth<32> Bool32;
typedef BoolByBitWidth<64> Bool64;

template <typename T>
struct BoolForType;

template <std::size_t BitCount>
struct BoolForType<BoolByBitWidth<BitCount>> final
{
    typedef BoolByBitWidth<BitCount> type;
};

template <>
struct BoolForType<float> final
{
    static_assert(std::numeric_limits<float>::is_iec559 && sizeof(float) == sizeof(std::uint32_t)
                      && alignof(float) == alignof(std::uint32_t),
                  "float type doesn't meet expectations");
    typedef BoolByBitWidth<32> type;
};

template <>
struct BoolForType<double> final
{
    static_assert(std::numeric_limits<double>::is_iec559 && sizeof(double) == sizeof(std::uint64_t)
                      && alignof(double) == alignof(std::uint64_t),
                  "double type doesn't meet expectations");
    typedef BoolByBitWidth<64> type;
};

template <>
struct BoolForType<unsigned char> final
{
    static_assert(std::is_same<unsigned char, std::uint8_t>::value,
                  "unsigned char type doesn't meet expectations");
    typedef BoolByBitWidth<8> type;
};

template <>
struct BoolForType<char> final
{
    static_assert(std::is_same<unsigned char, std::uint8_t>::value,
                  "char type doesn't meet expectations");
    typedef BoolByBitWidth<8> type;
};

template <>
struct BoolForType<signed char> final
{
    static_assert(std::is_same<signed char, std::int8_t>::value,
                  "signed char type doesn't meet expectations");
    typedef BoolByBitWidth<8> type;
};

template <>
struct BoolForType<std::uint16_t> final
{
    typedef BoolByBitWidth<16> type;
};

template <>
struct BoolForType<std::int16_t> final
{
    typedef BoolByBitWidth<16> type;
};

template <>
struct BoolForType<std::uint32_t> final
{
    typedef BoolByBitWidth<32> type;
};

template <>
struct BoolForType<std::int32_t> final
{
    typedef BoolByBitWidth<32> type;
};

template <>
struct BoolForType<std::uint64_t> final
{
    typedef BoolByBitWidth<64> type;
};

template <>
struct BoolForType<std::int64_t> final
{
    typedef BoolByBitWidth<64> type;
};

template <typename T>
struct BoolForType<T *> final
{
    static_assert(sizeof(T *) == sizeof(std::uintptr_t) && alignof(T *) == alignof(std::uintptr_t),
                  "type T * doesn't meet expectations");
    typedef BoolForType<std::uintptr_t> type;
};

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

template <typename T, std::size_t N>
struct ValueListFill;

template <typename To, typename From, std::size_t N>
struct ValueListCast;

template <typename T, std::size_t N>
struct ValueListNeg;

template <typename T, std::size_t N>
struct ValueListLNot;

template <typename T, std::size_t N>
struct ValueListBNot;

template <typename T, std::size_t N>
struct ValueListMul;

template <typename T, std::size_t N>
struct ValueListDiv;

template <typename T, std::size_t N>
struct ValueListRem;

template <typename T, std::size_t N>
struct ValueListAdd;

template <typename T, std::size_t N>
struct ValueListSub;

template <typename T, std::size_t N>
struct ValueListLShift;

template <typename T, std::size_t N>
struct ValueListRShift;

template <typename T, std::size_t N>
struct ValueListAnd;

template <typename T, std::size_t N>
struct ValueListOr;

template <typename T, std::size_t N>
struct ValueListXor;

template <typename T, std::size_t N>
struct ValueListLT;

template <typename T, std::size_t N>
struct ValueListLE;

template <typename T, std::size_t N>
struct ValueListEq;

template <typename T, std::size_t N>
struct ValueListNE;
}

template <typename To, typename From, std::size_t N>
ValueList<To, N> reinterpret(const ValueList<From, N> &v) noexcept;

template <typename T, std::size_t N>
struct ValueList final
{
    static_assert(N != 0, "N can't be 0");
    static_assert((N & (N - 1)) == 0, "N must be a power of 2");
    T arrayValue[N]
#ifndef __CDT_PARSER__
        alignas(sizeof(T) * N)
#endif
            ;
    ValueList() noexcept : arrayValue{}
    {
    }
    ValueList(T value) noexcept : arrayValue{}
    {
        detail::ValueListFill<T, N>::run(*this, value);
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
        detail::ValueListCast<T2, T, N>::run(retval, *this);
        return retval;
    }
    ValueList operator-() const noexcept
    {
        ValueList retval;
        detail::ValueListNeg<T, N>::run(retval, *this);
        return retval;
    }
    const ValueList &operator++() noexcept
    {
        operator+=(ValueList(1));
        return *this;
    }
    ValueList operator++(int) noexcept
    {
        ValueList retval = *this;
        operator++();
        return retval;
    }
    const ValueList &operator--() noexcept
    {
        operator-=(ValueList(1));
        return *this;
    }
    ValueList operator--(int) noexcept
    {
        ValueList retval = *this;
        operator--();
        return retval;
    }
    ValueList<typename BoolForType<T>::type, N> operator!() const noexcept
    {
        ValueList<typename BoolForType<T>::type, N> retval;
        detail::ValueListLNot<T, N>::run(retval, *this);
        return retval;
    }
    ValueList operator~() const noexcept
    {
        ValueList retval;
        detail::ValueListBNot<T, N>::run(retval, *this);
        return retval;
    }
    ValueList operator*(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListMul<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator/(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListDiv<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator%(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListRem<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator+(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListAdd<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator-(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListSub<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator<<(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListLShift<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator>>(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListRShift<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator&(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListAnd<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator|(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListOr<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList operator^(const ValueList &rt) const noexcept
    {
        ValueList retval;
        detail::ValueListXor<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList<typename BoolForType<T>::type, N> operator<(const ValueList &rt) const noexcept
    {
        ValueList<typename BoolForType<T>::type, N> retval;
        detail::ValueListLT<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList<typename BoolForType<T>::type, N> operator<=(const ValueList &rt) const noexcept
    {
        ValueList<typename BoolForType<T>::type, N> retval;
        detail::ValueListLE<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList<typename BoolForType<T>::type, N> operator>(const ValueList &rt) const noexcept
    {
        ValueList<typename BoolForType<T>::type, N> retval;
        detail::ValueListLT<T, N>::run(retval, rt, *this);
        return retval;
    }
    ValueList<typename BoolForType<T>::type, N> operator>=(const ValueList &rt) const noexcept
    {
        ValueList<typename BoolForType<T>::type, N> retval;
        detail::ValueListLE<T, N>::run(retval, rt, *this);
        return retval;
    }
    ValueList<typename BoolForType<T>::type, N> operator==(const ValueList &rt) const noexcept
    {
        ValueList<typename BoolForType<T>::type, N> retval;
        detail::ValueListEq<T, N>::run(retval, *this, rt);
        return retval;
    }
    ValueList<typename BoolForType<T>::type, N> operator!=(const ValueList &rt) const noexcept
    {
        ValueList<typename BoolForType<T>::type, N> retval;
        detail::ValueListNE<T, N>::run(retval, *this, rt);
        return retval;
    }
};

namespace detail
{
template <typename T, std::size_t N>
struct ValueListFill final
{
    static void run(ValueList<T, N> &retval, T value) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = value;
        }
    }
};

template <typename To, typename From, std::size_t N>
struct ValueListCast final
{
    static void run(ValueList<To, N> &retval, const ValueList<From, N> &value) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = static_cast<To>(value[i]);
        }
    }
};

template <typename T, std::size_t N>
struct ValueListNeg final
{
    static void run(ValueList<T, N> &retval, const ValueList<T, N> &value) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = -value[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListLNot final
{
    static void run(ValueList<typename BoolForType<T>::type, N> &retval,
                    const ValueList<T, N> &value) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = !value[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListBNot final
{
    static void run(ValueList<T, N> &retval, const ValueList<T, N> &value) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = ~value[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListMul final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] * r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListDiv final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] / r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListRem final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] % r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListAdd final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] + r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListSub final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] - r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListLShift final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] << r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListRShift final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] >> r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListAnd final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] & r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListOr final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] | r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListXor final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] ^ r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListLT final
{
    static void run(ValueList<typename BoolForType<T>::type, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] < r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListLE final
{
    static void run(ValueList<typename BoolForType<T>::type, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] <= r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListEq final
{
    static void run(ValueList<typename BoolForType<T>::type, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] == r[i];
        }
    }
};

template <typename T, std::size_t N>
struct ValueListNE final
{
    static void run(ValueList<typename BoolForType<T>::type, N> &retval,
                    const ValueList<T, N> &l,
                    const ValueList<T, N> &r) noexcept
    {
        for(std::size_t i = 0; i < N; i++)
        {
            retval[i] = l[i] != r[i];
        }
    }
};

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

template <typename To, typename From, std::size_t N>
ValueList<To, N> reinterpret(const ValueList<From, N> &v) noexcept
{
    static_assert(sizeof(From) == sizeof(To) && alignof(From) == alignof(To)
                      && std::is_same<typename BoolForType<From>::type,
                                      typename BoolForType<To>::type>::value,
                  "invalid reinterpret types");
    union
    {
        ValueList<To, N> retval;
        ValueList<From, N> source;
    } u;
    u.source = v;
    return u.retval;
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
