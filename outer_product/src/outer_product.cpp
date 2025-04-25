#include "outer_product.h"

void CCS_BLOCK(outer_product)(type_t A[M], type_t B[N], type_t C[M][N]) {
    
    VEC_A: for (int i = 0; i < M; i++) {
        
        VEC_B: for (int j = 0; j < N; j++) {
            
            C[i][j] = A[i]* B[j];

        }
    }
}