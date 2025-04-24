void mc_testbench_capture_IN( ac_float<11, 1, 5, AC_TRN> input, ac_float<11, 1, 5, AC_TRN> taps[64] ) {
  mc_testbench::capture_IN(input, taps);
}
void mc_testbench_capture_OUT( ac_float<11, 1, 5, AC_TRN> _retvalue, ac_float<11, 1, 5, AC_TRN> input, ac_float<11, 1, 5, AC_TRN> taps[64] ) {
  mc_testbench::capture_OUT(_retvalue, input, taps);
}
