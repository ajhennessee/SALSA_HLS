#include "mat_mul.h"

void matrix_multiply(int_t A[N][M], int_t B[M][P], int_t C[N][P]) {
    
    ROW: for (int i = 0; i < N; i++) {
        
        COL: for (int j = 0; j < P; j++) {
            
            int_t sum = 0;
            
            MUL: for (int k = 0; k < M; k++) {
                sum += A[i][k] * B[k][j];
            }
            
            C[i][j] = sum;
        }
    }
}