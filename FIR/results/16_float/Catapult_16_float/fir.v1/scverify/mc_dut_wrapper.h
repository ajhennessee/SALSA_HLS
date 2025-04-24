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
  sc_in<sc_lv<11> > input_m_rsc_dat;
  sc_out<sc_logic> input_m_triosy_lz;
  sc_in<sc_lv<5> > input_e_rsc_dat;
  sc_out<sc_logic> input_e_triosy_lz;
  sc_in<sc_lv<176> > taps_m_rsc_dat;
  sc_out<sc_logic> taps_m_triosy_lz;
  sc_in<sc_lv<80> > taps_e_rsc_dat;
  sc_out<sc_logic> taps_e_triosy_lz;
  sc_out<sc_lv<11> > return_m_rsc_dat;
  sc_out<sc_logic> return_m_triosy_lz;
  sc_out<sc_lv<5> > return_e_rsc_dat;
  sc_out<sc_logic> return_e_triosy_lz;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    input_m_rsc_dat("input_m_rsc_dat"), 
    input_m_triosy_lz("input_m_triosy_lz"), 
    input_e_rsc_dat("input_e_rsc_dat"), 
    input_e_triosy_lz("input_e_triosy_lz"), 
    taps_m_rsc_dat("taps_m_rsc_dat"), 
    taps_m_triosy_lz("taps_m_triosy_lz"), 
    taps_e_rsc_dat("taps_e_rsc_dat"), 
    taps_e_triosy_lz("taps_e_triosy_lz"), 
    return_m_rsc_dat("return_m_rsc_dat"), 
    return_m_triosy_lz("return_m_triosy_lz"), 
    return_e_rsc_dat("return_e_rsc_dat"), 
    return_e_triosy_lz("return_e_triosy_lz")
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


