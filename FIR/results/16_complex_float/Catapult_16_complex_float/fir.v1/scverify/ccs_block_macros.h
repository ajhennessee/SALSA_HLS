// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_fir
#define ccs_intercept_fir_3 \
  fir(my_complex_float_t input, my_complex_float_t taps[16]);\
  extern void mc_testbench_capture_IN( my_complex_float_t input, my_complex_float_t taps[16] );\
  extern void mc_testbench_capture_OUT( my_complex_float_t _retvalue, my_complex_float_t input, my_complex_float_t taps[16] );\
  my_complex_float_t ccs_real_fir(my_complex_float_t input, my_complex_float_t taps[16]);\
  my_complex_float_t fir(my_complex_float_t input, my_complex_float_t taps[16])\
  {\
    static bool ccs_intercept_flag = false;\
    if (!ccs_intercept_flag) {\
      std::cout << "SCVerify intercepting C++ function 'fir' for RTL block 'fir'" << std::endl;\
      ccs_intercept_flag=true;\
    }\
    mc_testbench_wait_for_idle_sync();\
    mc_testbench_capture_IN(input, taps);\
    my_complex_float_t _retvalue = ccs_real_fir(input, taps);\
    mc_testbench_capture_OUT(_retvalue, input, taps);\
    return _retvalue;\
  }\
  my_complex_float_t ccs_real_fir
#else
#define ccs_intercept_fir_3 fir
#endif //CCS_DESIGN_FUNC_fir
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// my_complex_float_t::my_complex_float_t 21 INLINE
#define ccs_intercept_my_complex_float_t_21 my_complex_float_t
#define ccs_intercept_my_complex_float_t_my_complex_float_t_21 my_complex_float_t
// my_complex_float_t::my_complex_float_t 23 INLINE
#define ccs_intercept_my_complex_float_t_23 my_complex_float_t
#define ccs_intercept_my_complex_float_t_my_complex_float_t_23 my_complex_float_t
// my_complex_float_t::my_complex_float_t 24 INLINE
#define ccs_intercept_my_complex_float_t_24 my_complex_float_t
#define ccs_intercept_my_complex_float_t_my_complex_float_t_24 my_complex_float_t
// test 21 INLINE
#define ccs_intercept_test_21 test
