#include "outer_product.h"
#include <iostream>

CCS_MAIN(int argc, char *argv[]) {
    
    type_t A[M];
    type_t B[N];
    type_t C[M][N];

    for (int i = 0; i < M; ++i)
            A[i] = i + 1;

    for (int i = 0; i < N; ++i)
            B[i] = i + 1;

    outer_product(A, B, C);

    // std::cout << "Result of outer product:" << std::endl;
    // for (int i = 0; i < M; ++i) {
    //     for (int j = 0; j < N; ++j) {
    //         std::cout << C[i][j] << " ";
    //     }
    //     std::cout << std::endl;
    // }

    CCS_RETURN(0);
}
