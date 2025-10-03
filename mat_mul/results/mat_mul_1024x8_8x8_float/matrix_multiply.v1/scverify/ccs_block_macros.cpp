void mc_testbench_capture_IN( ac_ieee_float<binary16> A[1024][8], ac_ieee_float<binary16> B[8][8], ac_ieee_float<binary16> C[1024][8] ) {
  mc_testbench::capture_IN(A, B, C);
}
void mc_testbench_capture_OUT( ac_ieee_float<binary16> A[1024][8], ac_ieee_float<binary16> B[8][8], ac_ieee_float<binary16> C[1024][8] ) {
  mc_testbench::capture_OUT(A, B, C);
}
