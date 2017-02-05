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
    typedef typename UIntByBitWidth<BitCount>::type underlyingUnsignedType;
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
};

template <std::size_t BitCount2>
constexpr BoolByBitWidth<BitCount2> operator&(const BoolByBitWidth<BitCount2> &a,
                                              const BoolByBitWidth<BitCount2> &b) noexcept
{
    return BoolByBitWidth<BitCount2>(a.value & b.value,
                                     detail::BoolByBitWidthFromUnderlyingTypeTag());
}
template <std::size_t BitCount2>
constexpr BoolByBitWidth<BitCount2> operator|(const BoolByBitWidth<BitCount2> &a,
                                              const BoolByBitWidth<BitCount2> &b) noexcept
{
    return BoolByBitWidth<BitCount2>(a.value | b.value,
                                     detail::BoolByBitWidthFromUnderlyingTypeTag());
}
template <std::size_t BitCount2>
constexpr BoolByBitWidth<BitCount2> operator^(const BoolByBitWidth<BitCount2> &a,
                                              const BoolByBitWidth<BitCount2> &b) noexcept
{
    return BoolByBitWidth<BitCount2>(a.value ^ b.value,
                                     detail::BoolByBitWidthFromUnderlyingTypeTag());
}
template <std::size_t BitCount2>
void operator&&(const BoolByBitWidth<BitCount2> &a,
                const BoolByBitWidth<BitCount2> &b) noexcept = delete;
template <std::size_t BitCount2>
void operator||(const BoolByBitWidth<BitCount2> &a,
                const BoolByBitWidth<BitCount2> &b) noexcept = delete;
template <std::size_t BitCount2>
void operator&&(const BoolByBitWidth<BitCount2> &a, bool b) noexcept = delete;
template <std::size_t BitCount2>
void operator||(const BoolByBitWidth<BitCount2> &a, bool b) noexcept = delete;
template <std::size_t BitCount2>
void operator&&(bool a, const BoolByBitWidth<BitCount2> &b) noexcept = delete;
template <std::size_t BitCount2>
void operator||(bool a, const BoolByBitWidth<BitCount2> &b) noexcept = delete;

typedef BoolByBitWidth<8> Bool8;
static_assert(sizeof(Bool8) == sizeof(std::int8_t) && alignof(Bool8) == alignof(std::int8_t),
              "Bool8 doesn't meet requirements");
typedef BoolByBitWidth<16> Bool16;
static_assert(sizeof(Bool16) == sizeof(std::int16_t) && alignof(Bool16) == alignof(std::int16_t),
              "Bool16 doesn't meet requirements");
typedef BoolByBitWidth<32> Bool32;
static_assert(sizeof(Bool32) == sizeof(std::int32_t) && alignof(Bool32) == alignof(std::int32_t),
              "Bool32 doesn't meet requirements");
typedef BoolByBitWidth<64> Bool64;
static_assert(sizeof(Bool64) == sizeof(std::int64_t) && alignof(Bool64) == alignof(std::int64_t),
              "Bool64 doesn't meet requirements");

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

template <typename T, std::size_t N, bool isFloatingPoint = std::is_floating_point<T>::value>
struct ValueListNegHelper
{
    static void run(ValueList<T, N> &retval, const ValueList<T, N> &value) noexcept
    {
        retval = ValueListSub<T, N>(ValueList<T, N>(0), value);
    }
};

template <typename T, std::size_t N>
struct ValueListNegHelper<T, N, true> // isFloatingPoint = true
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
struct ValueListNeg final
{
    static void run(ValueList<T, N> &retval, const ValueList<T, N> &value) noexcept
    {
        ValueListNegHelper<T, N>::run(retval, value);
    }
};

template <typename T, std::size_t N>
struct ValueListLNot final
{
    static void run(ValueList<typename BoolForType<T>::type, N> &retval,
                    const ValueList<T, N> &value) noexcept
    {
        ValueListEq<T, N>::run(retval, value, ValueList<T, N>(0));
    }
};

template <typename T, std::size_t N>
struct ValueListBNot final
{
    static void run(ValueList<T, N> &retval, const ValueList<T, N> &value) noexcept
    {
        ValueListXor<T, N>::run(retval, value, ValueList<T, N>(static_cast<T>(-1)));
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

template <std::size_t BitCount, std::size_t N>
struct ValueListAnd<BoolByBitWidth<BitCount>, N> final
{
    static void run(ValueList<BoolByBitWidth<BitCount>, N> &retval,
                    const ValueList<BoolByBitWidth<BitCount>, N> &l,
                    const ValueList<BoolByBitWidth<BitCount>, N> &r) noexcept
    {
        typedef typename BoolByBitWidth<BitCount>::underlyingType underlyingType;
        retval = reinterpret<BoolByBitWidth<BitCount>>(reinterpret<underlyingType>(l)
                                                       & reinterpret<underlyingType>(r));
    }
};

template <std::size_t BitCount, std::size_t N>
struct ValueListOr<BoolByBitWidth<BitCount>, N> final
{
    static void run(ValueList<BoolByBitWidth<BitCount>, N> &retval,
                    const ValueList<BoolByBitWidth<BitCount>, N> &l,
                    const ValueList<BoolByBitWidth<BitCount>, N> &r) noexcept
    {
        typedef typename BoolByBitWidth<BitCount>::underlyingType underlyingType;
        retval = reinterpret<BoolByBitWidth<BitCount>>(reinterpret<underlyingType>(l)
                                                       | reinterpret<underlyingType>(r));
    }
};

template <std::size_t BitCount, std::size_t N>
struct ValueListXor<BoolByBitWidth<BitCount>, N> final
{
    static void run(ValueList<BoolByBitWidth<BitCount>, N> &retval,
                    const ValueList<BoolByBitWidth<BitCount>, N> &l,
                    const ValueList<BoolByBitWidth<BitCount>, N> &r) noexcept
    {
        typedef typename BoolByBitWidth<BitCount>::underlyingType underlyingType;
        retval = reinterpret<BoolByBitWidth<BitCount>>(reinterpret<underlyingType>(l)
                                                       ^ reinterpret<underlyingType>(r));
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

namespace detail
{
template <typename T, std::size_t N>
struct ValueListSelect final
{
    static void run(ValueList<T, N> &retval,
                    const ValueList<typename BoolForType<T>::type, N> &condition,
                    const ValueList<T, N> &trueValue,
                    const ValueList<T, N> &falseValue) noexcept
    {
        typedef typename BoolForType<T>::type BoolType;
        typedef typename BoolType::underlyingUnsignedType UIntType;
        retval = reinterpret<T>(
            (reinterpret<UIntType>(condition) & reinterpret<UIntType>(trueValue))
            | (~reinterpret<UIntType>(condition) & reinterpret<UIntType>(falseValue)));
    }
};
}

template <typename T, std::size_t N>
ValueList<T, N> select(const ValueList<typename BoolForType<T>::type, N> &condition,
                       const ValueList<T, N> &trueValue,
                       const ValueList<T, N> &falseValue) noexcept
{
    ValueList<T, N> retval;
    detail::ValueListSelect<T, N>::run(retval, condition, trueValue, falseValue);
    return retval;
}
}

#ifdef __SSE2__
#include <emmintrin.h>
namespace tiled_renderer
{
#define TILED_RENDERER_VALUE_LIST_CAST(                                               \
    DestType, SourceType, DestVector, SourceVector, ElementCount, ConversionFunction) \
    namespace detail                                                                  \
    {                                                                                 \
    template <>                                                                       \
    struct ValueListCast<DestType, SourceType, ElementCount> final                    \
    {                                                                                 \
        static void run(ValueList<DestType, ElementCount> &retval,                    \
                        const ValueList<SourceType, ElementCount> &value) noexcept    \
        {                                                                             \
            union                                                                     \
            {                                                                         \
                DestVector vector;                                                    \
                ValueList<DestType, ElementCount> valueList;                          \
            } dest{};                                                                 \
            union                                                                     \
            {                                                                         \
                SourceVector vector;                                                  \
                ValueList<SourceType, ElementCount> valueList;                        \
            } src{};                                                                  \
            src.valueList = value;                                                    \
            dest.vector = ConversionFunction(src.vector);                             \
            retval = dest.valueList;                                                  \
        }                                                                             \
    };                                                                                \
    }

TILED_RENDERER_VALUE_LIST_CAST(float, double, __m128, __m128d, 2, _mm_cvtpd_ps)
TILED_RENDERER_VALUE_LIST_CAST(double, float, __m128d, __m128, 2, _mm_cvtps_pd)
TILED_RENDERER_VALUE_LIST_CAST(std::int32_t, double, __m128i, __m128d, 2, _mm_cvttpd_epi32)
TILED_RENDERER_VALUE_LIST_CAST(double, std::int32_t, __m128d, __m128i, 2, _mm_cvtepi32_pd)

TILED_RENDERER_VALUE_LIST_CAST(std::int32_t, float, __m128i, __m128, 4, _mm_cvttps_epi32)
TILED_RENDERER_VALUE_LIST_CAST(float, std::int32_t, __m128, __m128i, 4, _mm_cvtepi32_ps)

#undef TILED_RENDERER_VALUE_LIST_CAST

#define TILED_RENDERER_VALUE_LIST_BITWISE_128(Type, ElementCount)        \
    namespace detail                                                     \
    {                                                                    \
    template <>                                                          \
    struct ValueListAnd<Type, ElementCount> final                        \
    {                                                                    \
        static void run(ValueList<Type, ElementCount> &retval,           \
                        const ValueList<Type, ElementCount> &l,          \
                        const ValueList<Type, ElementCount> &r) noexcept \
        {                                                                \
            union U                                                      \
            {                                                            \
                __m128 vector;                                           \
                ValueList<Type, ElementCount> valueList;                 \
            };                                                           \
            U lValue{};                                                  \
            U rValue{};                                                  \
            lValue.valueList = l;                                        \
            rValue.valueList = r;                                        \
            lValue.vector = _mm_and_ps(lValue.vector, rValue.vector);    \
            retval = lValue.valueList;                                   \
        }                                                                \
    };                                                                   \
    template <>                                                          \
    struct ValueListOr<Type, ElementCount> final                         \
    {                                                                    \
        static void run(ValueList<Type, ElementCount> &retval,           \
                        const ValueList<Type, ElementCount> &l,          \
                        const ValueList<Type, ElementCount> &r) noexcept \
        {                                                                \
            union U                                                      \
            {                                                            \
                __m128 vector;                                           \
                ValueList<Type, ElementCount> valueList;                 \
            };                                                           \
            U lValue{};                                                  \
            U rValue{};                                                  \
            lValue.valueList = l;                                        \
            rValue.valueList = r;                                        \
            lValue.vector = _mm_or_ps(lValue.vector, rValue.vector);     \
            retval = lValue.valueList;                                   \
        }                                                                \
    };                                                                   \
    template <>                                                          \
    struct ValueListXor<Type, ElementCount> final                        \
    {                                                                    \
        static void run(ValueList<Type, ElementCount> &retval,           \
                        const ValueList<Type, ElementCount> &l,          \
                        const ValueList<Type, ElementCount> &r) noexcept \
        {                                                                \
            union U                                                      \
            {                                                            \
                __m128 vector;                                           \
                ValueList<Type, ElementCount> valueList;                 \
            };                                                           \
            U lValue{};                                                  \
            U rValue{};                                                  \
            lValue.valueList = l;                                        \
            rValue.valueList = r;                                        \
            lValue.vector = _mm_xor_ps(lValue.vector, rValue.vector);    \
            retval = lValue.valueList;                                   \
        }                                                                \
    };                                                                   \
    }

TILED_RENDERER_VALUE_LIST_BITWISE_128(std::uint8_t, 16)
TILED_RENDERER_VALUE_LIST_BITWISE_128(std::int8_t, 16)
TILED_RENDERER_VALUE_LIST_BITWISE_128(std::uint16_t, 8)
TILED_RENDERER_VALUE_LIST_BITWISE_128(std::int16_t, 8)
TILED_RENDERER_VALUE_LIST_BITWISE_128(std::uint32_t, 4)
TILED_RENDERER_VALUE_LIST_BITWISE_128(std::int32_t, 4)
TILED_RENDERER_VALUE_LIST_BITWISE_128(std::uint64_t, 2)
TILED_RENDERER_VALUE_LIST_BITWISE_128(std::int64_t, 2)

#undef TILED_RENDERER_VALUE_LIST_BITWISE_128

#define TILED_RENDERER_VALUE_LIST_SIGNLESS(Type, ElementCount, AddOp, SubOp) \
    namespace detail                                                         \
    {                                                                        \
    template <>                                                              \
    struct ValueListAdd<Type, ElementCount> final                            \
    {                                                                        \
        static void run(ValueList<Type, ElementCount> &retval,               \
                        const ValueList<Type, ElementCount> &l,              \
                        const ValueList<Type, ElementCount> &r) noexcept     \
        {                                                                    \
            union U                                                          \
            {                                                                \
                __m128i vector;                                              \
                ValueList<Type, ElementCount> valueList;                     \
            };                                                               \
            U lValue{};                                                      \
            U rValue{};                                                      \
            lValue.valueList = l;                                            \
            rValue.valueList = r;                                            \
            lValue.vector = AddOp(lValue.vector, rValue.vector);             \
            retval = lValue.valueList;                                       \
        }                                                                    \
    };                                                                       \
    template <>                                                              \
    struct ValueListSub<Type, ElementCount> final                            \
    {                                                                        \
        static void run(ValueList<Type, ElementCount> &retval,               \
                        const ValueList<Type, ElementCount> &l,              \
                        const ValueList<Type, ElementCount> &r) noexcept     \
        {                                                                    \
            union U                                                          \
            {                                                                \
                __m128i vector;                                              \
                ValueList<Type, ElementCount> valueList;                     \
            };                                                               \
            U lValue{};                                                      \
            U rValue{};                                                      \
            lValue.valueList = l;                                            \
            rValue.valueList = r;                                            \
            lValue.vector = SubOp(lValue.vector, rValue.vector);             \
            retval = lValue.valueList;                                       \
        }                                                                    \
    };                                                                       \
    }

TILED_RENDERER_VALUE_LIST_SIGNLESS(std::uint8_t, 16, _mm_add_epi8, _mm_sub_epi8)
TILED_RENDERER_VALUE_LIST_SIGNLESS(std::int8_t, 16, _mm_add_epi8, _mm_sub_epi8)
TILED_RENDERER_VALUE_LIST_SIGNLESS(std::uint16_t, 8, _mm_add_epi16, _mm_sub_epi16)
TILED_RENDERER_VALUE_LIST_SIGNLESS(std::int16_t, 8, _mm_add_epi16, _mm_sub_epi16)
TILED_RENDERER_VALUE_LIST_SIGNLESS(std::uint32_t, 4, _mm_add_epi32, _mm_sub_epi32)
TILED_RENDERER_VALUE_LIST_SIGNLESS(std::int32_t, 4, _mm_add_epi32, _mm_sub_epi32)
TILED_RENDERER_VALUE_LIST_SIGNLESS(std::uint64_t, 2, _mm_add_epi64, _mm_sub_epi64)
TILED_RENDERER_VALUE_LIST_SIGNLESS(std::int64_t, 2, _mm_add_epi64, _mm_sub_epi64)

#undef TILED_RENDERER_VALUE_LIST_SIGNLESS

#define TILED_RENDERER_VALUE_LIST_FLOATING_POINT(                        \
    Type, ElementCount, VectorType, AddOp, SubOp, MulOp, DivOp)          \
    namespace detail                                                     \
    {                                                                    \
    template <>                                                          \
    struct ValueListAdd<Type, ElementCount> final                        \
    {                                                                    \
        static void run(ValueList<Type, ElementCount> &retval,           \
                        const ValueList<Type, ElementCount> &l,          \
                        const ValueList<Type, ElementCount> &r) noexcept \
        {                                                                \
            union                                                        \
            {                                                            \
                VectorType lVector;                                      \
                ValueList<Type, ElementCount> lValueList{};              \
            };                                                           \
            union                                                        \
            {                                                            \
                VectorType rVector;                                      \
                ValueList<Type, ElementCount> rValueList{};              \
            };                                                           \
            lValueList = l;                                              \
            rValueList = r;                                              \
            lVector = AddOp(lVector, rVector);                           \
            retval = lValueList;                                         \
        }                                                                \
    };                                                                   \
    template <>                                                          \
    struct ValueListSub<Type, ElementCount> final                        \
    {                                                                    \
        static void run(ValueList<Type, ElementCount> &retval,           \
                        const ValueList<Type, ElementCount> &l,          \
                        const ValueList<Type, ElementCount> &r) noexcept \
        {                                                                \
            union                                                        \
            {                                                            \
                VectorType lVector;                                      \
                ValueList<Type, ElementCount> lValueList{};              \
            };                                                           \
            union                                                        \
            {                                                            \
                VectorType rVector;                                      \
                ValueList<Type, ElementCount> rValueList{};              \
            };                                                           \
            lValueList = l;                                              \
            rValueList = r;                                              \
            lVector = SubOp(lVector, rVector);                           \
            retval = lValueList;                                         \
        }                                                                \
    };                                                                   \
    template <>                                                          \
    struct ValueListMul<Type, ElementCount> final                        \
    {                                                                    \
        static void run(ValueList<Type, ElementCount> &retval,           \
                        const ValueList<Type, ElementCount> &l,          \
                        const ValueList<Type, ElementCount> &r) noexcept \
        {                                                                \
            union                                                        \
            {                                                            \
                VectorType lVector;                                      \
                ValueList<Type, ElementCount> lValueList{};              \
            };                                                           \
            union                                                        \
            {                                                            \
                VectorType rVector;                                      \
                ValueList<Type, ElementCount> rValueList{};              \
            };                                                           \
            lValueList = l;                                              \
            rValueList = r;                                              \
            lVector = MulOp(lVector, rVector);                           \
            retval = lValueList;                                         \
        }                                                                \
    };                                                                   \
    template <>                                                          \
    struct ValueListDiv<Type, ElementCount> final                        \
    {                                                                    \
        static void run(ValueList<Type, ElementCount> &retval,           \
                        const ValueList<Type, ElementCount> &l,          \
                        const ValueList<Type, ElementCount> &r) noexcept \
        {                                                                \
            union                                                        \
            {                                                            \
                VectorType lVector;                                      \
                ValueList<Type, ElementCount> lValueList{};              \
            };                                                           \
            union                                                        \
            {                                                            \
                VectorType rVector;                                      \
                ValueList<Type, ElementCount> rValueList{};              \
            };                                                           \
            lValueList = l;                                              \
            rValueList = r;                                              \
            lVector = DivOp(lVector, rVector);                           \
            retval = lValueList;                                         \
        }                                                                \
    };                                                                   \
    }

TILED_RENDERER_VALUE_LIST_FLOATING_POINT(
    float, 4, __m128, _mm_add_ps, _mm_sub_ps, _mm_mul_ps, _mm_div_ps)
TILED_RENDERER_VALUE_LIST_FLOATING_POINT(
    double, 2, __m128d, _mm_add_pd, _mm_sub_pd, _mm_mul_pd, _mm_div_pd)

#undef TILED_RENDERER_VALUE_LIST_FLOATING_POINT

#define TILED_RENDERER_VALUE_LIST_COMPARE(                                      \
    Type, BType, ElementCount, VectorType, BVectorType, LTOp, LEOp, EqOp, NEOp) \
    namespace detail                                                            \
    {                                                                           \
    template <>                                                                 \
    struct ValueListLT<Type, ElementCount> final                                \
    {                                                                           \
        static void run(ValueList<BType, ElementCount> &retval,                 \
                        const ValueList<Type, ElementCount> &l,                 \
                        const ValueList<Type, ElementCount> &r) noexcept        \
        {                                                                       \
            union                                                               \
            {                                                                   \
                VectorType lVector;                                             \
                ValueList<Type, ElementCount> lValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                VectorType rVector;                                             \
                ValueList<Type, ElementCount> rValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                BVectorType dVector;                                            \
                ValueList<BType, ElementCount> dValueList{};                    \
            };                                                                  \
            lValueList = l;                                                     \
            rValueList = r;                                                     \
            dVector = LTOp(lVector, rVector);                                   \
            retval = dValueList;                                                \
        }                                                                       \
    };                                                                          \
    template <>                                                                 \
    struct ValueListLE<Type, ElementCount> final                                \
    {                                                                           \
        static void run(ValueList<BType, ElementCount> &retval,                 \
                        const ValueList<Type, ElementCount> &l,                 \
                        const ValueList<Type, ElementCount> &r) noexcept        \
        {                                                                       \
            union                                                               \
            {                                                                   \
                VectorType lVector;                                             \
                ValueList<Type, ElementCount> lValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                VectorType rVector;                                             \
                ValueList<Type, ElementCount> rValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                BVectorType dVector;                                            \
                ValueList<BType, ElementCount> dValueList{};                    \
            };                                                                  \
            lValueList = l;                                                     \
            rValueList = r;                                                     \
            dVector = LEOp(lVector, rVector);                                   \
            retval = dValueList;                                                \
        }                                                                       \
    };                                                                          \
    template <>                                                                 \
    struct ValueListEq<Type, ElementCount> final                                \
    {                                                                           \
        static void run(ValueList<BType, ElementCount> &retval,                 \
                        const ValueList<Type, ElementCount> &l,                 \
                        const ValueList<Type, ElementCount> &r) noexcept        \
        {                                                                       \
            union                                                               \
            {                                                                   \
                VectorType lVector;                                             \
                ValueList<Type, ElementCount> lValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                VectorType rVector;                                             \
                ValueList<Type, ElementCount> rValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                BVectorType dVector;                                            \
                ValueList<BType, ElementCount> dValueList{};                    \
            };                                                                  \
            lValueList = l;                                                     \
            rValueList = r;                                                     \
            dVector = EqOp(lVector, rVector);                                   \
            retval = dValueList;                                                \
        }                                                                       \
    };                                                                          \
    template <>                                                                 \
    struct ValueListNE<Type, ElementCount> final                                \
    {                                                                           \
        static void run(ValueList<BType, ElementCount> &retval,                 \
                        const ValueList<Type, ElementCount> &l,                 \
                        const ValueList<Type, ElementCount> &r) noexcept        \
        {                                                                       \
            union                                                               \
            {                                                                   \
                VectorType lVector;                                             \
                ValueList<Type, ElementCount> lValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                VectorType rVector;                                             \
                ValueList<Type, ElementCount> rValueList{};                     \
            };                                                                  \
            union                                                               \
            {                                                                   \
                BVectorType dVector;                                            \
                ValueList<BType, ElementCount> dValueList{};                    \
            };                                                                  \
            lValueList = l;                                                     \
            rValueList = r;                                                     \
            dVector = NEOp(lVector, rVector);                                   \
            retval = dValueList;                                                \
        }                                                                       \
    };                                                                          \
    }

TILED_RENDERER_VALUE_LIST_COMPARE(
    float, Bool32, 4, __m128, __m128, _mm_cmplt_ps, _mm_cmple_ps, _mm_cmpeq_ps, _mm_cmpneq_ps)
TILED_RENDERER_VALUE_LIST_COMPARE(
    double, Bool64, 2, __m128d, __m128d, _mm_cmplt_pd, _mm_cmple_pd, _mm_cmpeq_pd, _mm_cmpneq_pd)

#undef TILED_RENDERER_VALUE_LIST_COMPARE
}
#endif

#endif /* VALUE_LIST_H_ */
