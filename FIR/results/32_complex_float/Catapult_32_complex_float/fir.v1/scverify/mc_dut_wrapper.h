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
    ccs_design::HDL::fir ccs_DUT_wrapper;

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
  sc_in<sc_lv<11> > input_real_m_rsc_dat;
  sc_out<sc_logic> input_real_m_triosy_lz;
  sc_in<sc_lv<5> > input_real_e_rsc_dat;
  sc_out<sc_logic> input_real_e_triosy_lz;
  sc_in<sc_lv<11> > input_imag_m_rsc_dat;
  sc_out<sc_logic> input_imag_m_triosy_lz;
  sc_in<sc_lv<5> > input_imag_e_rsc_dat;
  sc_out<sc_logic> input_imag_e_triosy_lz;
  sc_in<sc_lv<352> > taps_real_m_rsc_dat;
  sc_out<sc_logic> taps_real_m_triosy_lz;
  sc_in<sc_lv<160> > taps_real_e_rsc_dat;
  sc_out<sc_logic> taps_real_e_triosy_lz;
  sc_in<sc_lv<352> > taps_imag_m_rsc_dat;
  sc_out<sc_logic> taps_imag_m_triosy_lz;
  sc_in<sc_lv<160> > taps_imag_e_rsc_dat;
  sc_out<sc_logic> taps_imag_e_triosy_lz;
  sc_out<sc_lv<11> > return_real_m_rsc_dat;
  sc_out<sc_logic> return_real_m_triosy_lz;
  sc_out<sc_lv<5> > return_real_e_rsc_dat;
  sc_out<sc_logic> return_real_e_triosy_lz;
  sc_out<sc_lv<11> > return_imag_m_rsc_dat;
  sc_out<sc_logic> return_imag_m_triosy_lz;
  sc_out<sc_lv<5> > return_imag_e_rsc_dat;
  sc_out<sc_logic> return_imag_e_triosy_lz;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    input_real_m_rsc_dat("input_real_m_rsc_dat"), 
    input_real_m_triosy_lz("input_real_m_triosy_lz"), 
    input_real_e_rsc_dat("input_real_e_rsc_dat"), 
    input_real_e_triosy_lz("input_real_e_triosy_lz"), 
    input_imag_m_rsc_dat("input_imag_m_rsc_dat"), 
    input_imag_m_triosy_lz("input_imag_m_triosy_lz"), 
    input_imag_e_rsc_dat("input_imag_e_rsc_dat"), 
    input_imag_e_triosy_lz("input_imag_e_triosy_lz"), 
    taps_real_m_rsc_dat("taps_real_m_rsc_dat"), 
    taps_real_m_triosy_lz("taps_real_m_triosy_lz"), 
    taps_real_e_rsc_dat("taps_real_e_rsc_dat"), 
    taps_real_e_triosy_lz("taps_real_e_triosy_lz"), 
    taps_imag_m_rsc_dat("taps_imag_m_rsc_dat"), 
    taps_imag_m_triosy_lz("taps_imag_m_triosy_lz"), 
    taps_imag_e_rsc_dat("taps_imag_e_rsc_dat"), 
    taps_imag_e_triosy_lz("taps_imag_e_triosy_lz"), 
    return_real_m_rsc_dat("return_real_m_rsc_dat"), 
    return_real_m_triosy_lz("return_real_m_triosy_lz"), 
    return_real_e_rsc_dat("return_real_e_rsc_dat"), 
    return_real_e_triosy_lz("return_real_e_triosy_lz"), 
    return_imag_m_rsc_dat("return_imag_m_rsc_dat"), 
    return_imag_m_triosy_lz("return_imag_m_triosy_lz"), 
    return_imag_e_rsc_dat("return_imag_e_rsc_dat"), 
    return_imag_e_triosy_lz("return_imag_e_triosy_lz")
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


