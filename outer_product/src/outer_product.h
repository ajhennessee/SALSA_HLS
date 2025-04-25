#include "types.h"
#include "mc_scverify.h"

#ifndef TYPE_T
#define TYPE_T my_int_t
#endif
typedef TYPE_T type_t;

#ifndef M
#define M 4
#endif

#ifndef N
#define N 4
#endif

void CCS_BLOCK(outer_product)(type_t A[M], type_t B[N], type_t C[M][N]);
