#include "mat_mul.h"
#include <iostream>

int main() {
    type_t A[N][M];
    type_t B[M][P];
    type_t C[N][P];

    // Initialize A and B with example values
    for (int i = 0; i < N; ++i)
        for (int j = 0; j < M; ++j)
            A[i][j] = i + j + (type_t)1; // Example: increasing values

    for (int i = 0; i < M; ++i)
        for (int j = 0; j < P; ++j)
            B[i][j] = (i == j) ? (type_t)1 : (type_t)0; // Identity matrix

    matrix_multiply(A, B, C);

    std::cout << "Result matrix C = A * B:\n";
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < P; j++) {
            std::cout << C[i][j] << "\t";
        }
        std::cout << "\n";
    }

    return 0;
}