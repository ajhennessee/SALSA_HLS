#include "mat_mul.h"
#include <iostream>

int main() {
    int_t A[N][M];
    int_t B[M][P];
    int_t C[N][P];

    // Initialize A and B with example values
    for (int i = 0; i < N; ++i)
        for (int j = 0; j < M; ++j)
            A[i][j] = i + j + 1; // Example: increasing values

    for (int i = 0; i < M; ++i)
        for (int j = 0; j < P; ++j)
            B[i][j] = (i == j) ? 1 : 0; // Identity matrix

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