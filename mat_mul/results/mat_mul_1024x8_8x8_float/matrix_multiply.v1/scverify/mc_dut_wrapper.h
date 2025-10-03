// mc_dut_wrapper.h
#ifndef INCLUDED_CCS_DUT_WRAPPER_H
#define INCLUDED_CCS_DUT_WRAPPER_H

#ifndef SC_USE_STD_STRING
#define SC_USE_STD_STRING
#endif

#include <systemc.h>
#include <mc_simulator_extensions.h>

#ifdef CCS_SYSC
namespace HDL {
#endif
#if defined(CCS_DUT_SYSC)
// alias ccs_DUT_wrapper to namespace enclosure of either cycle or RTL SystemC netlist
namespace
    ccs_design {
#if defined(CCS_DUT_CYCLE)
#include "cycle.cxx"
#else
#if defined(CCS_DUT_RTL)
#include "rtl.cxx"
#endif
#endif
}
typedef
    ccs_design::HDL::matrix_multiply ccs_DUT_wrapper;

#else

// Create a foreign module wrapper around the HDL
#ifdef VCS_SYSTEMC
// VCS support - ccs_DUT_wrapper is derived from VCS-generated SystemC wrapper around HDL code
class ccs_DUT_wrapper : public TOP_HDL_ENTITY
{
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  : TOP_HDL_ENTITY(nm)
  {
  // elaborate_foreign_module(hdl_name);
  }

  ~ccs_DUT_wrapper() {}
};

#else
// non VCS simulators - ccs_DUT_wrapper is derived from mc_foreign_module (adding 2nd ctor arg)
class ccs_DUT_wrapper: public mc_foreign_module
{
public:
  // Interface Ports
  sc_in<bool> clk;
  sc_in<sc_logic> rst;
  sc_out<sc_lv<10> > A_d_rsc_0_0_radr;
  sc_out<sc_logic> A_d_rsc_0_0_re;
  sc_in<sc_lv<16> > A_d_rsc_0_0_q;
  sc_out<sc_logic> A_d_tri_0_0_osy_lz;
  sc_out<sc_lv<10> > A_d_rsc_0_1_radr;
  sc_out<sc_logic> A_d_rsc_0_1_re;
  sc_in<sc_lv<16> > A_d_rsc_0_1_q;
  sc_out<sc_logic> A_d_tri_0_1_osy_lz;
  sc_out<sc_lv<10> > A_d_rsc_0_2_radr;
  sc_out<sc_logic> A_d_rsc_0_2_re;
  sc_in<sc_lv<16> > A_d_rsc_0_2_q;
  sc_out<sc_logic> A_d_tri_0_2_osy_lz;
  sc_out<sc_lv<10> > A_d_rsc_0_3_radr;
  sc_out<sc_logic> A_d_rsc_0_3_re;
  sc_in<sc_lv<16> > A_d_rsc_0_3_q;
  sc_out<sc_logic> A_d_tri_0_3_osy_lz;
  sc_out<sc_lv<10> > A_d_rsc_0_4_radr;
  sc_out<sc_logic> A_d_rsc_0_4_re;
  sc_in<sc_lv<16> > A_d_rsc_0_4_q;
  sc_out<sc_logic> A_d_tri_0_4_osy_lz;
  sc_out<sc_lv<10> > A_d_rsc_0_5_radr;
  sc_out<sc_logic> A_d_rsc_0_5_re;
  sc_in<sc_lv<16> > A_d_rsc_0_5_q;
  sc_out<sc_logic> A_d_tri_0_5_osy_lz;
  sc_out<sc_lv<10> > A_d_rsc_0_6_radr;
  sc_out<sc_logic> A_d_rsc_0_6_re;
  sc_in<sc_lv<16> > A_d_rsc_0_6_q;
  sc_out<sc_logic> A_d_tri_0_6_osy_lz;
  sc_out<sc_lv<10> > A_d_rsc_0_7_radr;
  sc_out<sc_logic> A_d_rsc_0_7_re;
  sc_in<sc_lv<16> > A_d_rsc_0_7_q;
  sc_out<sc_logic> A_d_tri_0_7_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_0_0_radr;
  sc_out<sc_logic> B_d_rsc_0_0_re;
  sc_in<sc_lv<16> > B_d_rsc_0_0_q;
  sc_out<sc_logic> B_d_tri_0_0_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_1_0_radr;
  sc_out<sc_logic> B_d_rsc_1_0_re;
  sc_in<sc_lv<16> > B_d_rsc_1_0_q;
  sc_out<sc_logic> B_d_tri_1_0_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_2_0_radr;
  sc_out<sc_logic> B_d_rsc_2_0_re;
  sc_in<sc_lv<16> > B_d_rsc_2_0_q;
  sc_out<sc_logic> B_d_tri_2_0_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_3_0_radr;
  sc_out<sc_logic> B_d_rsc_3_0_re;
  sc_in<sc_lv<16> > B_d_rsc_3_0_q;
  sc_out<sc_logic> B_d_tri_3_0_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_4_0_radr;
  sc_out<sc_logic> B_d_rsc_4_0_re;
  sc_in<sc_lv<16> > B_d_rsc_4_0_q;
  sc_out<sc_logic> B_d_tri_4_0_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_5_0_radr;
  sc_out<sc_logic> B_d_rsc_5_0_re;
  sc_in<sc_lv<16> > B_d_rsc_5_0_q;
  sc_out<sc_logic> B_d_tri_5_0_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_6_0_radr;
  sc_out<sc_logic> B_d_rsc_6_0_re;
  sc_in<sc_lv<16> > B_d_rsc_6_0_q;
  sc_out<sc_logic> B_d_tri_6_0_osy_lz;
  sc_out<sc_lv<3> > B_d_rsc_7_0_radr;
  sc_out<sc_logic> B_d_rsc_7_0_re;
  sc_in<sc_lv<16> > B_d_rsc_7_0_q;
  sc_out<sc_logic> B_d_tri_7_0_osy_lz;
  sc_out<sc_lv<13> > C_d_rsc_wadr;
  sc_out<sc_lv<16> > C_d_rsc_d;
  sc_out<sc_logic> C_d_rsc_we;
  sc_out<sc_logic> C_d_triosy_lz;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    A_d_rsc_0_0_radr("A_d_rsc_0_0_radr"), 
    A_d_rsc_0_0_re("A_d_rsc_0_0_re"), 
    A_d_rsc_0_0_q("A_d_rsc_0_0_q"), 
    A_d_tri_0_0_osy_lz("A_d_tri_0_0_osy_lz"), 
    A_d_rsc_0_1_radr("A_d_rsc_0_1_radr"), 
    A_d_rsc_0_1_re("A_d_rsc_0_1_re"), 
    A_d_rsc_0_1_q("A_d_rsc_0_1_q"), 
    A_d_tri_0_1_osy_lz("A_d_tri_0_1_osy_lz"), 
    A_d_rsc_0_2_radr("A_d_rsc_0_2_radr"), 
    A_d_rsc_0_2_re("A_d_rsc_0_2_re"), 
    A_d_rsc_0_2_q("A_d_rsc_0_2_q"), 
    A_d_tri_0_2_osy_lz("A_d_tri_0_2_osy_lz"), 
    A_d_rsc_0_3_radr("A_d_rsc_0_3_radr"), 
    A_d_rsc_0_3_re("A_d_rsc_0_3_re"), 
    A_d_rsc_0_3_q("A_d_rsc_0_3_q"), 
    A_d_tri_0_3_osy_lz("A_d_tri_0_3_osy_lz"), 
    A_d_rsc_0_4_radr("A_d_rsc_0_4_radr"), 
    A_d_rsc_0_4_re("A_d_rsc_0_4_re"), 
    A_d_rsc_0_4_q("A_d_rsc_0_4_q"), 
    A_d_tri_0_4_osy_lz("A_d_tri_0_4_osy_lz"), 
    A_d_rsc_0_5_radr("A_d_rsc_0_5_radr"), 
    A_d_rsc_0_5_re("A_d_rsc_0_5_re"), 
    A_d_rsc_0_5_q("A_d_rsc_0_5_q"), 
    A_d_tri_0_5_osy_lz("A_d_tri_0_5_osy_lz"), 
    A_d_rsc_0_6_radr("A_d_rsc_0_6_radr"), 
    A_d_rsc_0_6_re("A_d_rsc_0_6_re"), 
    A_d_rsc_0_6_q("A_d_rsc_0_6_q"), 
    A_d_tri_0_6_osy_lz("A_d_tri_0_6_osy_lz"), 
    A_d_rsc_0_7_radr("A_d_rsc_0_7_radr"), 
    A_d_rsc_0_7_re("A_d_rsc_0_7_re"), 
    A_d_rsc_0_7_q("A_d_rsc_0_7_q"), 
    A_d_tri_0_7_osy_lz("A_d_tri_0_7_osy_lz"), 
    B_d_rsc_0_0_radr("B_d_rsc_0_0_radr"), 
    B_d_rsc_0_0_re("B_d_rsc_0_0_re"), 
    B_d_rsc_0_0_q("B_d_rsc_0_0_q"), 
    B_d_tri_0_0_osy_lz("B_d_tri_0_0_osy_lz"), 
    B_d_rsc_1_0_radr("B_d_rsc_1_0_radr"), 
    B_d_rsc_1_0_re("B_d_rsc_1_0_re"), 
    B_d_rsc_1_0_q("B_d_rsc_1_0_q"), 
    B_d_tri_1_0_osy_lz("B_d_tri_1_0_osy_lz"), 
    B_d_rsc_2_0_radr("B_d_rsc_2_0_radr"), 
    B_d_rsc_2_0_re("B_d_rsc_2_0_re"), 
    B_d_rsc_2_0_q("B_d_rsc_2_0_q"), 
    B_d_tri_2_0_osy_lz("B_d_tri_2_0_osy_lz"), 
    B_d_rsc_3_0_radr("B_d_rsc_3_0_radr"), 
    B_d_rsc_3_0_re("B_d_rsc_3_0_re"), 
    B_d_rsc_3_0_q("B_d_rsc_3_0_q"), 
    B_d_tri_3_0_osy_lz("B_d_tri_3_0_osy_lz"), 
    B_d_rsc_4_0_radr("B_d_rsc_4_0_radr"), 
    B_d_rsc_4_0_re("B_d_rsc_4_0_re"), 
    B_d_rsc_4_0_q("B_d_rsc_4_0_q"), 
    B_d_tri_4_0_osy_lz("B_d_tri_4_0_osy_lz"), 
    B_d_rsc_5_0_radr("B_d_rsc_5_0_radr"), 
    B_d_rsc_5_0_re("B_d_rsc_5_0_re"), 
    B_d_rsc_5_0_q("B_d_rsc_5_0_q"), 
    B_d_tri_5_0_osy_lz("B_d_tri_5_0_osy_lz"), 
    B_d_rsc_6_0_radr("B_d_rsc_6_0_radr"), 
    B_d_rsc_6_0_re("B_d_rsc_6_0_re"), 
    B_d_rsc_6_0_q("B_d_rsc_6_0_q"), 
    B_d_tri_6_0_osy_lz("B_d_tri_6_0_osy_lz"), 
    B_d_rsc_7_0_radr("B_d_rsc_7_0_radr"), 
    B_d_rsc_7_0_re("B_d_rsc_7_0_re"), 
    B_d_rsc_7_0_q("B_d_rsc_7_0_q"), 
    B_d_tri_7_0_osy_lz("B_d_tri_7_0_osy_lz"), 
    C_d_rsc_wadr("C_d_rsc_wadr"), 
    C_d_rsc_d("C_d_rsc_d"), 
    C_d_rsc_we("C_d_rsc_we"), 
    C_d_triosy_lz("C_d_triosy_lz")
  {
    elaborate_foreign_module(hdl_name);
  }

  ~ccs_DUT_wrapper() {}
};
#endif

#endif

#ifdef CCS_SYSC
} // end namespace HDL
#endif
#endif


