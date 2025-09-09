// #include "types.h"
#include <stdio.h>

#ifndef N
#define N 3
#endif

#ifndef TYPE_T
#define TYPE_T int
#endif
typedef TYPE_T type_t;

void cholesky(type_t A[N][N], type_t L[N][N], type_t D[N][N]);
