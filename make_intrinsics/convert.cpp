#include <stdint.h>

template <typename D, typename S, unsigned N>
struct Convert;

#define MAKE_CONVERT3(D, S, N)                                                                    \
    template <>                                                                                   \
    struct Convert<D, S, N> final                                                                 \
    {                                                                                             \
        typedef D DestType;                                                                       \
        typedef S SrcType;                                                                        \
        struct DestArray final                                                                    \
        {                                                                                         \
            DestType value alignas(16)[N];                                                        \
        };                                                                                        \
        struct SrcArray final                                                                     \
        {                                                                                         \
            SrcType value alignas(16)[N];                                                         \
        };                                                                                        \
        typedef DestType DestVector __attribute__((vector_size(sizeof(DestType) * N)));           \
        typedef SrcType SrcVector __attribute__((vector_size(sizeof(SrcType) * N)));              \
        static void run(DestArray &__restrict dest, const SrcArray &__restrict src);              \
    };                                                                                            \
                                                                                                  \
    inline void Convert<D, S, N>::run(DestArray &__restrict dest, const SrcArray &__restrict src) \
    {                                                                                             \
        union                                                                                     \
        {                                                                                         \
            SrcVector srcVector;                                                                  \
            SrcArray srcArray;                                                                    \
        };                                                                                        \
        union                                                                                     \
        {                                                                                         \
            DestVector destVector;                                                                \
            DestArray destArray;                                                                  \
        };                                                                                        \
        srcArray = src;                                                                           \
        destVector = __builtin_convertvector(srcVector, DestVector);                              \
        dest = destArray;                                                                         \
    }                                                                                             \
                                                                                                  \
    extern "C" void convert_##S##_##D##_##N(void *dest, const void *src)                          \
    {                                                                                             \
        return Convert<D, S, N>::run(*reinterpret_cast<Convert<D, S, N>::DestArray *>(dest),      \
                                     *reinterpret_cast<const Convert<D, S, N>::SrcArray *>(src)); \
    }

#define MAKE_CONVERT2(D, S) \
    MAKE_CONVERT3(D, S, 2)  \
    MAKE_CONVERT3(D, S, 4)  \
    MAKE_CONVERT3(D, S, 8)  \
    MAKE_CONVERT3(D, S, 16)

#define MAKE_CONVERT1(D)       \
    MAKE_CONVERT2(D, float)    \
    MAKE_CONVERT2(D, double)   \
    MAKE_CONVERT2(D, uint8_t)  \
    MAKE_CONVERT2(D, uint16_t) \
    MAKE_CONVERT2(D, uint32_t) \
    MAKE_CONVERT2(D, uint64_t) \
    MAKE_CONVERT2(D, int8_t)   \
    MAKE_CONVERT2(D, int16_t)  \
    MAKE_CONVERT2(D, int32_t)  \
    MAKE_CONVERT2(D, int64_t)

MAKE_CONVERT1(float)
MAKE_CONVERT1(double)
MAKE_CONVERT1(uint8_t)
MAKE_CONVERT1(uint16_t)
MAKE_CONVERT1(uint32_t)
MAKE_CONVERT1(uint64_t)
MAKE_CONVERT1(int8_t)
MAKE_CONVERT1(int16_t)
MAKE_CONVERT1(int32_t)
MAKE_CONVERT1(int64_t)
