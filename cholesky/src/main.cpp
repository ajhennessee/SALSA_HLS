#include "cholesky.h"

int main(void) {

    /* A is the symmetric, positive-definite matrix */
    /* that we want to decompose */
    type_t A[N][N] = {{4, 12, -16}, 
                    {12, 37, -43}, 
                    {-16, -43, 98}
                };
    
    /* L is the lower triangular matrix */
    type_t L[N][N] = {0, 0, 0, 
                    0, 0, 0, 
                    0, 0, 0};

    /* D is the diagonal matrix */
    type_t D[N][N] = {0, 0, 0, 
                    0, 0, 0, 
                    0, 0, 0};

    cholesky(A, L, D);

    printf("L:\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%d ", L[i][j]);
        }
        printf("\n");
    }
    printf("D:\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%d ", D[i][j]);
        }
        printf("\n");
    }

    return 0;
}
