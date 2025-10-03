// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_matrix_multiply
#define ccs_intercept_matrix_multiply_3 \
  matrix_multiply(ac_ieee_float<binary16> A[1024][16], ac_ieee_float<binary16> B[16][8], ac_ieee_float<binary16> C[1024][8]);\
  extern void mc_testbench_capture_IN( ac_ieee_float<binary16> A[1024][16], ac_ieee_float<binary16> B[16][8], ac_ieee_float<binary16> C[1024][8] );\
  extern void mc_testbench_capture_OUT( ac_ieee_float<binary16> A[1024][16], ac_ieee_float<binary16> B[16][8], ac_ieee_float<binary16> C[1024][8] );\
  void ccs_real_matrix_multiply(ac_ieee_float<binary16> A[1024][16], ac_ieee_float<binary16> B[16][8], ac_ieee_float<binary16> C[1024][8]);\
  void matrix_multiply(ac_ieee_float<binary16> A[1024][16], ac_ieee_float<binary16> B[16][8], ac_ieee_float<binary16> C[1024][8])\
  {\
    static bool ccs_intercept_flag = false;\
    if (!ccs_intercept_flag) {\
      std::cout << "SCVerify intercepting C++ function 'matrix_multiply' for RTL block 'matrix_multiply'" << std::endl;\
      ccs_intercept_flag=true;\
    }\
    mc_testbench_wait_for_idle_sync();\
    mc_testbench_capture_IN(A, B, C);\
    ccs_real_matrix_multiply(A, B, C);\
    mc_testbench_capture_OUT(A, B, C);\
  }\
  void ccs_real_matrix_multiply
#else
#define ccs_intercept_matrix_multiply_3 matrix_multiply
#endif //CCS_DESIGN_FUNC_matrix_multiply
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// my_complex_float_t::my_complex_float_t 23 INLINE
#define ccs_intercept_my_complex_float_t_23 my_complex_float_t
#define ccs_intercept_my_complex_float_t_my_complex_float_t_23 my_complex_float_t
// my_complex_float_t::my_complex_float_t 25 INLINE
#define ccs_intercept_my_complex_float_t_25 my_complex_float_t
#define ccs_intercept_my_complex_float_t_my_complex_float_t_25 my_complex_float_t
// my_complex_float_t::my_complex_float_t 26 INLINE
#define ccs_intercept_my_complex_float_t_26 my_complex_float_t
#define ccs_intercept_my_complex_float_t_my_complex_float_t_26 my_complex_float_t
