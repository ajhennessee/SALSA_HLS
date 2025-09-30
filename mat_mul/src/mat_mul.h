#include "types.h"

#ifndef N
#define N 1024 // Rows of A, Rows of C
#endif

#ifndef M
#define M 4 // Columns of A, Rows of B
#endif

#ifndef P
#define P 8 // Columns of B, Columns of C
#endif

typedef my_float_t type_t;

void matrix_multiply(type_t A[N][M], type_t B[M][P], type_t C[N][P]);
