#include "mat_vec.h"

void CCS_BLOCK(matrix_vector_multiply)(type_t A[Nd][Md], type_t B[Md], type_t C[Nd]) {

    ROW: for (int i = 0; i < Nd; i++) {
        
        type_t sum = (type_t)0;
        
        MUL: for (int j = 0; j < Md; j++) {
            sum += A[i][j] * B[j]; // for my_int_t
            // sum.add(sum, (type_t)(A[i][j] * B[j])); // for my_float_t
            // sum = sum + (type_t)(A[i][j] * B[j]); // for my_complex_float_t
        }
        
        C[i] = sum;
    }
}
