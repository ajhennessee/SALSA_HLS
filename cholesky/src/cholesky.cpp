#include "cholesky.h"

void cholesky(type_t A[N][N], type_t L[N][N], type_t D[N][N]) {
    
    for (int i = 0; i < N; i++) {

        for (int j = 0; j <= i; j++) {

            type_t sum = 0;
            for (int k = 0; k < j; k++) {
                // sum.add(sum, L[i][k] * L[j][k] * D[k][k]);
                sum += L[i][k] * L[j][k] * D[k][k];
            }

            if (i == j) { // diagonal element
                L[i][j] = 1;
                // D[i][j].sub(A[i][i], sum);
                D[i][j] = A[i][i] - sum;
            }
            
            else { // off-diagonal element
                type_t numer;
                // numer.sub(A[i][j], sum);
                numer = A[i][j] - sum;
                L[i][j] = (type_t) numer / D[j][j];
            }
        }
    }
}

