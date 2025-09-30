#include "types.h"

#ifndef Nd
#define Nd 1024 // Rows of A, Rows of C
#endif

#ifndef Md
#define Md 4 // Columns of A, Rows of B
#endif

#ifndef Pd
#define Pd 8 // Columns of B, Columns of C
#endif

typedef my_float_t type_t;

void matrix_multiply(type_t A[Nd][Md], type_t B[Md][Pd], type_t C[Nd][Pd]);
