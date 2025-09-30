#include "mat_mul.h"

void matrix_multiply(type_t A[N][M], type_t B[M][P], type_t C[N][P]) {
    
    ROW: for (int i = 0; i < N; i++) {
        
        COL: for (int j = 0; j < P; j++) {
            
            type_t sum = (type_t)0;
            
            MUL: for (int k = 0; k < M; k++) {
                // sum += A[i][k] * B[k][j]; // for my_int_t
                sum.add(sum, (type_t)(A[i][k] * B[k][j])); // for my_float_t
                // sum = sum + (type_t)(A[i][k] * B[k][j]); // for my_complex_float_t
            }
            
            C[i][j] = sum;
        }
    }
}