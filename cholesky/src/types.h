#include "ac_int.h"
#include "ac_float.h"
#include "ac_complex.h"

/* 16-bit integer */
typedef ac_int<16, true> my_int_t;

/* complex with 16-bit integer components */
typedef ac_complex<my_int_t> my_complex_int_t;

/* 16-bit float */
typedef ac_float<11, 1, 5> my_float_t;

/* complex with 16-bit float components */
struct my_complex_float_t {

    my_float_t real;
    my_float_t imag;

    my_complex_float_t() : real(0), imag(0) {}
    my_complex_float_t(my_float_t r, my_float_t i) : real(r), imag(i) {}

    my_complex_float_t(int r) : real(r), imag(0) {}
    my_complex_float_t(float r) : real(r), imag(0) {}

    // complex addition
    friend my_complex_float_t operator+(const my_complex_float_t &a,
                                        const my_complex_float_t &b) {
        my_float_t r;
        r.add(a.real, b.real);

        my_float_t i;
        i.add(a.imag, b.imag);

        return my_complex_float_t(r, i);
    }

    // complex subtraction
    friend my_complex_float_t operator-(const my_complex_float_t &a,
                                        const my_complex_float_t &b) {
        my_float_t r;
        r.sub(a.real, b.real);

        my_float_t i;
        i.sub(a.imag, b.imag);

        return my_complex_float_t(r, i);
    }

    // complex multiplication (a + ib)(c + id) = (ac - bd) + i(ad + bc)
    friend my_complex_float_t operator*(const my_complex_float_t &a,
                                        const my_complex_float_t &b) {
        my_float_t r;
        r.sub((my_float_t)(a.real * b.real), (my_float_t)(a.imag * b.imag));

        my_float_t i;
        i.add((my_float_t)(a.real * b.imag), (my_float_t)(a.imag * b.real));

        return my_complex_float_t(r, i);
    }
};
