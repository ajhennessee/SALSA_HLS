#ifndef MATRIX_MUL_H
#define MATRIX_MUL_H

#include "ac_int.h"

#define N 8 // Rows of A, Rows of C
#define M 8 // Columns of A, Rows of B
#define P 8 // Columns of B, Columns of C

typedef ac_int<16, true> int_t;

#pragma hls_design top
void matrix_multiply(int_t A[N][M], int_t B[M][P], int_t C[N][P]);

#endif