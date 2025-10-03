#include "types.h"
#include <mc_scverify.h>

#ifndef Nd
#define Nd 1024 // Rows of A
#endif

#ifndef Md
#define Md 4 // Columns of A, Rows of B
#endif

// typedef my_complex_float_t type_t;
typedef my_int_t type_t;

void CCS_BLOCK(matrix_vector_multiply)(type_t A[Nd][Md], type_t B[Md], type_t C[Nd]);
