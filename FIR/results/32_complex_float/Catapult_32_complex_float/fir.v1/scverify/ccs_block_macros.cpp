void mc_testbench_capture_IN( my_complex_float_t input, my_complex_float_t taps[32] ) {
  mc_testbench::capture_IN(input, taps);
}
void mc_testbench_capture_OUT( my_complex_float_t _retvalue, my_complex_float_t input, my_complex_float_t taps[32] ) {
  mc_testbench::capture_OUT(_retvalue, input, taps);
}
