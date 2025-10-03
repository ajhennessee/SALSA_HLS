#include "mat_vec.h"
#include <iostream>

int main() {
    type_t A[Nd][Md];
    type_t B[Md];
    type_t C[Nd];

    // Initialize A and B with example values
    for (int i = 0; i < Nd; i++) {
        for (int j = 0; j < Md; j++) {
            A[i][j] = i + j + (type_t)1; // Example: increasing values
        }
    }

    for (int i = 0; i < Md; i++) {
        B[i] = (type_t)1; // Example: all ones
    }

    matrix_vector_multiply(A, B, C);

    std::cout << "Result vector C = A * B:\n";
    for (int i = 0; i < Nd; i++) {
        std::cout << C[i] << "\n";
    }

    return 0;
}