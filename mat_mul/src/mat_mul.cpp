#include "mat_mul.h"

void CCS_BLOCK(matrix_multiply)(type_t A[Nd][Md], type_t B[Md][Pd], type_t C[Nd][Pd]) {
    
    ROW: for (int i = 0; i < Nd; i++) {
        
        COL: for (int j = 0; j < Pd; j++) {
            
            type_t sum = (type_t)0;
            
            MUL: for (int k = 0; k < Md; k++) {
                sum += A[i][k] * B[k][j]; // for my_int_t
                // sum.add(sum, (type_t)(A[i][k] * B[k][j])); // for my_float_t
                // sum = sum + (type_t)(A[i][k] * B[k][j]); // for my_complex_float_t
            }
            
            C[i][j] = sum;
        }
    }
}
