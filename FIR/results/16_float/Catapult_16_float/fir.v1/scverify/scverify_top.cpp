#include <string>
#include <fstream>
#include <iostream>
#include "mc_testbench.h"
#include <mc_reset.h>
#include <mc_transactors.h>
#include <mc_scverify.h>
#include <mc_stall_ctrl.h>
#include <ac_read_env.h>
#include "ccs_ioport_trans_rsc_v1.h"
#include <mc_monitor.h>
#include <mc_simulator_extensions.h>
#include "mc_dut_wrapper.h"
#include "ccs_probes.cpp"
#include <mt19937ar.c>
#ifndef TO_QUOTED_STRING
#define TO_QUOTED_STRING(x) TO_QUOTED_STRING1(x)
#define TO_QUOTED_STRING1(x) #x
#endif
#ifndef TOP_HDL_ENTITY
#define TOP_HDL_ENTITY fir
#endif
// Hold time for the SCVerify testbench to account for the gate delay after downstream synthesis in pico second(s)
// Hold time value is obtained from 'top_gate_constraints.cpp', which is generated at the end of RTL synthesis
#ifdef CCS_DUT_GATE
extern double __scv_hold_time;
extern double __scv_hold_time_RSCID_1;
extern double __scv_hold_time_RSCID_2;
extern double __scv_hold_time_RSCID_3;
extern double __scv_hold_time_RSCID_4;
extern double __scv_hold_time_RSCID_5;
extern double __scv_hold_time_RSCID_6;
#else
double __scv_hold_time = 0.0; // default for non-gate simulation is zero
double __scv_hold_time_RSCID_1 = 0;
double __scv_hold_time_RSCID_2 = 0;
double __scv_hold_time_RSCID_3 = 0;
double __scv_hold_time_RSCID_4 = 0;
double __scv_hold_time_RSCID_5 = 0;
double __scv_hold_time_RSCID_6 = 0;
#endif

class scverify_top : public sc_module
{
public:
  sc_signal<sc_logic>                                                                            rst;
  sc_signal<sc_logic>                                                                            rst_n;
  sc_signal<sc_logic>                                                                            SIG_SC_LOGIC_0;
  sc_signal<sc_logic>                                                                            SIG_SC_LOGIC_1;
  sc_signal<sc_logic>                                                                            TLS_design_is_idle;
  sc_signal<bool>                                                                                TLS_design_is_idle_reg;
  unsigned long                                                                                  d_max_sim_time;
  unsigned long                                                                                  d_deadlock_time;
  bool                                                                                           env_SCVerify_DEADLOCK_DETECTION;
  bool                                                                                           env_SCVerify_DISABLE_EMPTY_INPUTS;
  bool                                                                                           env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  bool                                                                                           env_SCVerify_ENABLE_RESET_TOGGLE;
  float                                                                                          env_SCVerify_RESET_CYCLES;
  unsigned long                                                                                  env_SCVerify_MAX_SIM_TIME;
  int                                                                                            env_SCVerify_AUTOWAIT;
  int                                                                                            env_SCVerify_AUTOWAIT_INPUT_CYCLES;
  int                                                                                            env_SCVerify_AUTOWAIT_OUTPUT_CYCLES;
  bool                                                                                           d_iosync_pause_on_stall;
  bool                                                                                           d_idle_sync_enabled;
  bool                                                                                           d_disable_on_empty;
  sc_clock                                                                                       clk;
  mc_programmable_reset                                                                          rst_driver;
  sc_signal<sc_logic>                                                                            TLS_rst;
  sc_signal<sc_lv<11> >                                                                          TLS_input_m_rsc_dat;
  sc_signal<sc_logic>                                                                            TLS_input_m_triosy_lz;
  sc_signal<sc_lv<5> >                                                                           TLS_input_e_rsc_dat;
  sc_signal<sc_logic>                                                                            TLS_input_e_triosy_lz;
  sc_signal<sc_lv<176> >                                                                         TLS_taps_m_rsc_dat;
  sc_signal<sc_logic>                                                                            TLS_taps_m_triosy_lz;
  sc_signal<sc_lv<80> >                                                                          TLS_taps_e_rsc_dat;
  sc_signal<sc_logic>                                                                            TLS_taps_e_triosy_lz;
  sc_signal<sc_lv<11> >                                                                          TLS_return_m_rsc_dat;
  sc_signal<sc_logic>                                                                            TLS_return_m_triosy_lz;
  sc_signal<sc_lv<5> >                                                                           TLS_return_e_rsc_dat;
  sc_signal<sc_logic>                                                                            TLS_return_e_triosy_lz;
  ccs_DUT_wrapper                                                                                fir_INST;
  ccs_in_trans_rsc_v1<1,11 >                                                                     input_m_rsc_INST;
  ccs_in_trans_rsc_v1<1,5 >                                                                      input_e_rsc_INST;
  ccs_in_trans_rsc_v1<1,176 >                                                                    taps_m_rsc_INST;
  ccs_in_trans_rsc_v1<1,80 >                                                                     taps_e_rsc_INST;
  ccs_out_trans_rsc_v1<1,11 >                                                                    return_m_rsc_INST;
  ccs_out_trans_rsc_v1<1,5 >                                                                     return_e_rsc_INST;
  tlm::tlm_fifo<ac_fixed<11, 1, true, AC_TRN, AC_WRAP > >                                        TLS_in_fifo_input_m;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                    TLS_in_wait_ctrl_fifo_input_m;
  mc_trios_input_monitor                                                                         trios_monitor_input_m_triosy_lz_INST;
  mc_input_transactor<ac_fixed<11, 1, true, AC_TRN, AC_WRAP >,11,true>                           transactor_input_m;
  tlm::tlm_fifo<ac_int<5, true > >                                                               TLS_in_fifo_input_e;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                    TLS_in_wait_ctrl_fifo_input_e;
  mc_trios_input_monitor                                                                         trios_monitor_input_e_triosy_lz_INST;
  mc_input_transactor<ac_int<5, true >,5,true>                                                   transactor_input_e;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_fixed<11, 1, true, AC_TRN, AC_WRAP >,16> >               TLS_in_fifo_taps_m;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                    TLS_in_wait_ctrl_fifo_taps_m;
  mc_trios_input_monitor                                                                         trios_monitor_taps_m_triosy_lz_INST;
  mc_input_transactor<mgc_sysc_ver_array1D<ac_fixed<11, 1, true, AC_TRN, AC_WRAP >,16>,11,true>  transactor_taps_m;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_int<5, true >,16> >                                      TLS_in_fifo_taps_e;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                    TLS_in_wait_ctrl_fifo_taps_e;
  mc_trios_input_monitor                                                                         trios_monitor_taps_e_triosy_lz_INST;
  mc_input_transactor<mgc_sysc_ver_array1D<ac_int<5, true >,16>,5,true>                          transactor_taps_e;
  tlm::tlm_fifo<ac_fixed<11, 1, true, AC_TRN, AC_WRAP > >                                        TLS_out_fifo_return_m;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                    TLS_out_wait_ctrl_fifo_return_m;
  mc_trios_output_monitor                                                                        trios_monitor_return_m_triosy_lz_INST;
  mc_output_transactor<ac_fixed<11, 1, true, AC_TRN, AC_WRAP >,11,true>                          transactor_return_m;
  tlm::tlm_fifo<ac_int<5, true > >                                                               TLS_out_fifo_return_e;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                    TLS_out_wait_ctrl_fifo_return_e;
  mc_trios_output_monitor                                                                        trios_monitor_return_e_triosy_lz_INST;
  mc_output_transactor<ac_int<5, true >,5,true>                                                  transactor_return_e;
  mc_testbench                                                                                   testbench_INST;
  sc_signal<sc_logic>                                                                            catapult_start;
  sc_signal<sc_logic>                                                                            catapult_done;
  sc_signal<sc_logic>                                                                            catapult_ready;
  sc_signal<sc_logic>                                                                            in_sync;
  sc_signal<sc_logic>                                                                            out_sync;
  sc_signal<sc_logic>                                                                            inout_sync;
  sc_signal<unsigned>                                                                            wait_for_init;
  sync_generator                                                                                 sync_generator_INST;
  catapult_monitor                                                                               catapult_monitor_INST;
  ccs_probe_monitor                                                                             *ccs_probe_monitor_INST;
  mc_wait_ctrl                                                                                  *autowait_input_cfg;
  mc_wait_ctrl                                                                                  *autowait_output_cfg;
  sc_event                                                                                       generate_reset_event;
  sc_event                                                                                       deadlock_event;
  sc_signal<sc_logic>                                                                            deadlocked;
  sc_event                                                                                       max_sim_time_event;
  sc_signal<sc_logic>                                                                            TLS_enable_stalls;
  sc_signal<unsigned short>                                                                      TLS_stall_coverage;

  void read_env();
  void TLS_rst_method();
  void max_sim_time_notify();
  void start_of_simulation();
  void setup_autowait();
  void inform_autowait();
  void setup_debug();
  void debug(const char* varname, int flags, int count);
  void generate_reset();
  void install_observe_foreign_signals();
  void deadlock_watch();
  void deadlock_notify();

  // Constructor
  SC_HAS_PROCESS(scverify_top);
  scverify_top(const sc_module_name& name)
    : rst("rst")
    , rst_n("rst_n")
    , SIG_SC_LOGIC_0("SIG_SC_LOGIC_0")
    , SIG_SC_LOGIC_1("SIG_SC_LOGIC_1")
    , TLS_design_is_idle("TLS_design_is_idle")
    , TLS_design_is_idle_reg("TLS_design_is_idle_reg")
    , CCS_CLK_CTOR(clk, "clk", 1, SC_NS, 0.5, 0, SC_NS, false)
    , rst_driver("rst_driver", ac_env::read_float("SCVerify_RESET_CYCLES",2.0)*1.000000, false)
    , TLS_rst("TLS_rst")
    , TLS_input_m_rsc_dat("TLS_input_m_rsc_dat")
    , TLS_input_m_triosy_lz("TLS_input_m_triosy_lz")
    , TLS_input_e_rsc_dat("TLS_input_e_rsc_dat")
    , TLS_input_e_triosy_lz("TLS_input_e_triosy_lz")
    , TLS_taps_m_rsc_dat("TLS_taps_m_rsc_dat")
    , TLS_taps_m_triosy_lz("TLS_taps_m_triosy_lz")
    , TLS_taps_e_rsc_dat("TLS_taps_e_rsc_dat")
    , TLS_taps_e_triosy_lz("TLS_taps_e_triosy_lz")
    , TLS_return_m_rsc_dat("TLS_return_m_rsc_dat")
    , TLS_return_m_triosy_lz("TLS_return_m_triosy_lz")
    , TLS_return_e_rsc_dat("TLS_return_e_rsc_dat")
    , TLS_return_e_triosy_lz("TLS_return_e_triosy_lz")
    , fir_INST("rtl", TO_QUOTED_STRING(TOP_HDL_ENTITY))
    , input_m_rsc_INST("input_m_rsc", true)
    , input_e_rsc_INST("input_e_rsc", true)
    , taps_m_rsc_INST("taps_m_rsc", true)
    , taps_e_rsc_INST("taps_e_rsc", true)
    , return_m_rsc_INST("return_m_rsc", true)
    , return_e_rsc_INST("return_e_rsc", true)
    , TLS_in_fifo_input_m("TLS_in_fifo_input_m", -1)
    , TLS_in_wait_ctrl_fifo_input_m("TLS_in_wait_ctrl_fifo_input_m", -1)
    , trios_monitor_input_m_triosy_lz_INST("trios_monitor_input_m_triosy_lz_INST")
    , transactor_input_m("transactor_input_m", 0, 11, 0, d_disable_on_empty)
    , TLS_in_fifo_input_e("TLS_in_fifo_input_e", -1)
    , TLS_in_wait_ctrl_fifo_input_e("TLS_in_wait_ctrl_fifo_input_e", -1)
    , trios_monitor_input_e_triosy_lz_INST("trios_monitor_input_e_triosy_lz_INST")
    , transactor_input_e("transactor_input_e", 0, 5, 0, d_disable_on_empty)
    , TLS_in_fifo_taps_m("TLS_in_fifo_taps_m", -1)
    , TLS_in_wait_ctrl_fifo_taps_m("TLS_in_wait_ctrl_fifo_taps_m", -1)
    , trios_monitor_taps_m_triosy_lz_INST("trios_monitor_taps_m_triosy_lz_INST")
    , transactor_taps_m("transactor_taps_m", 0, 176, 0, d_disable_on_empty)
    , TLS_in_fifo_taps_e("TLS_in_fifo_taps_e", -1)
    , TLS_in_wait_ctrl_fifo_taps_e("TLS_in_wait_ctrl_fifo_taps_e", -1)
    , trios_monitor_taps_e_triosy_lz_INST("trios_monitor_taps_e_triosy_lz_INST")
    , transactor_taps_e("transactor_taps_e", 0, 80, 0, d_disable_on_empty)
    , TLS_out_fifo_return_m("TLS_out_fifo_return_m", -1)
    , TLS_out_wait_ctrl_fifo_return_m("TLS_out_wait_ctrl_fifo_return_m", -1)
    , trios_monitor_return_m_triosy_lz_INST("trios_monitor_return_m_triosy_lz_INST")
    , transactor_return_m("transactor_return_m", 0, 11, 0)
    , TLS_out_fifo_return_e("TLS_out_fifo_return_e", -1)
    , TLS_out_wait_ctrl_fifo_return_e("TLS_out_wait_ctrl_fifo_return_e", -1)
    , trios_monitor_return_e_triosy_lz_INST("trios_monitor_return_e_triosy_lz_INST")
    , transactor_return_e("transactor_return_e", 0, 5, 0)
    , testbench_INST("user_tb")
    , catapult_start("catapult_start")
    , catapult_done("catapult_done")
    , catapult_ready("catapult_ready")
    , in_sync("in_sync")
    , out_sync("out_sync")
    , inout_sync("inout_sync")
    , wait_for_init("wait_for_init")
    , sync_generator_INST("sync_generator", true, false, false, false, 67, 67, 0)
    , catapult_monitor_INST("Monitor", clk, true, 67LL, 67LL)
    , ccs_probe_monitor_INST(NULL)
    , autowait_input_cfg(NULL)
    , autowait_output_cfg(NULL)
    , deadlocked("deadlocked")
  {
    read_env();

    rst_driver.reset_out(TLS_rst);

    fir_INST.clk(clk);
    fir_INST.rst(TLS_rst);
    fir_INST.input_m_rsc_dat(TLS_input_m_rsc_dat);
    fir_INST.input_m_triosy_lz(TLS_input_m_triosy_lz);
    fir_INST.input_e_rsc_dat(TLS_input_e_rsc_dat);
    fir_INST.input_e_triosy_lz(TLS_input_e_triosy_lz);
    fir_INST.taps_m_rsc_dat(TLS_taps_m_rsc_dat);
    fir_INST.taps_m_triosy_lz(TLS_taps_m_triosy_lz);
    fir_INST.taps_e_rsc_dat(TLS_taps_e_rsc_dat);
    fir_INST.taps_e_triosy_lz(TLS_taps_e_triosy_lz);
    fir_INST.return_m_rsc_dat(TLS_return_m_rsc_dat);
    fir_INST.return_m_triosy_lz(TLS_return_m_triosy_lz);
    fir_INST.return_e_rsc_dat(TLS_return_e_rsc_dat);
    fir_INST.return_e_triosy_lz(TLS_return_e_triosy_lz);

    input_m_rsc_INST.dat(TLS_input_m_rsc_dat);
    input_m_rsc_INST.clk(clk);
    input_m_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_1)));

    input_e_rsc_INST.dat(TLS_input_e_rsc_dat);
    input_e_rsc_INST.clk(clk);
    input_e_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_2)));

    taps_m_rsc_INST.dat(TLS_taps_m_rsc_dat);
    taps_m_rsc_INST.clk(clk);
    taps_m_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_3)));

    taps_e_rsc_INST.dat(TLS_taps_e_rsc_dat);
    taps_e_rsc_INST.clk(clk);
    taps_e_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_4)));

    return_m_rsc_INST.dat(TLS_return_m_rsc_dat);
    return_m_rsc_INST.clk(clk);
    return_m_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_5)));

    return_e_rsc_INST.dat(TLS_return_e_rsc_dat);
    return_e_rsc_INST.clk(clk);
    return_e_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_6)));

    trios_monitor_input_m_triosy_lz_INST.trios(TLS_input_m_triosy_lz);
    trios_monitor_input_m_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_input_m.in_fifo(TLS_in_fifo_input_m);
    transactor_input_m.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_input_m);
    transactor_input_m.set_disable_on_empty(d_disable_on_empty);
    transactor_input_m.bind_clk(clk, true, rst);
    transactor_input_m.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_input_m.register_block(&input_m_rsc_INST, input_m_rsc_INST.basename(), TLS_input_m_triosy_lz, 0, 0, 1);

    trios_monitor_input_e_triosy_lz_INST.trios(TLS_input_e_triosy_lz);
    trios_monitor_input_e_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_input_e.in_fifo(TLS_in_fifo_input_e);
    transactor_input_e.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_input_e);
    transactor_input_e.set_disable_on_empty(d_disable_on_empty);
    transactor_input_e.bind_clk(clk, true, rst);
    transactor_input_e.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_input_e.register_block(&input_e_rsc_INST, input_e_rsc_INST.basename(), TLS_input_e_triosy_lz, 0, 0, 1);

    trios_monitor_taps_m_triosy_lz_INST.trios(TLS_taps_m_triosy_lz);
    trios_monitor_taps_m_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_taps_m.in_fifo(TLS_in_fifo_taps_m);
    transactor_taps_m.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_taps_m);
    transactor_taps_m.set_disable_on_empty(d_disable_on_empty);
    transactor_taps_m.bind_clk(clk, true, rst);
    transactor_taps_m.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_taps_m.register_block(&taps_m_rsc_INST, taps_m_rsc_INST.basename(), TLS_taps_m_triosy_lz, 0, 0, 1);

    trios_monitor_taps_e_triosy_lz_INST.trios(TLS_taps_e_triosy_lz);
    trios_monitor_taps_e_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_taps_e.in_fifo(TLS_in_fifo_taps_e);
    transactor_taps_e.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_taps_e);
    transactor_taps_e.set_disable_on_empty(d_disable_on_empty);
    transactor_taps_e.bind_clk(clk, true, rst);
    transactor_taps_e.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_taps_e.register_block(&taps_e_rsc_INST, taps_e_rsc_INST.basename(), TLS_taps_e_triosy_lz, 0, 0, 1);

    trios_monitor_return_m_triosy_lz_INST.trios(TLS_return_m_triosy_lz);
    trios_monitor_return_m_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_return_m.out_fifo(TLS_out_fifo_return_m);
    transactor_return_m.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_return_m);
    transactor_return_m.bind_clk(clk, true, rst);
    transactor_return_m.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_return_m.register_block(&return_m_rsc_INST, return_m_rsc_INST.basename(), TLS_return_m_triosy_lz, 0, 0, 1);

    trios_monitor_return_e_triosy_lz_INST.trios(TLS_return_e_triosy_lz);
    trios_monitor_return_e_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_return_e.out_fifo(TLS_out_fifo_return_e);
    transactor_return_e.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_return_e);
    transactor_return_e.bind_clk(clk, true, rst);
    transactor_return_e.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_return_e.register_block(&return_e_rsc_INST, return_e_rsc_INST.basename(), TLS_return_e_triosy_lz, 0, 0, 1);

    testbench_INST.clk(clk);
    testbench_INST.ccs_input_m(TLS_in_fifo_input_m);
    testbench_INST.ccs_wait_ctrl_input_m(TLS_in_wait_ctrl_fifo_input_m);
    testbench_INST.ccs_input_e(TLS_in_fifo_input_e);
    testbench_INST.ccs_wait_ctrl_input_e(TLS_in_wait_ctrl_fifo_input_e);
    testbench_INST.ccs_taps_m(TLS_in_fifo_taps_m);
    testbench_INST.ccs_wait_ctrl_taps_m(TLS_in_wait_ctrl_fifo_taps_m);
    testbench_INST.ccs_taps_e(TLS_in_fifo_taps_e);
    testbench_INST.ccs_wait_ctrl_taps_e(TLS_in_wait_ctrl_fifo_taps_e);
    testbench_INST.ccs_return_m(TLS_out_fifo_return_m);
    testbench_INST.ccs_wait_ctrl_return_m(TLS_out_wait_ctrl_fifo_return_m);
    testbench_INST.ccs_return_e(TLS_out_fifo_return_e);
    testbench_INST.ccs_wait_ctrl_return_e(TLS_out_wait_ctrl_fifo_return_e);
    testbench_INST.design_is_idle(TLS_design_is_idle_reg);
    testbench_INST.enable_stalls(TLS_enable_stalls);
    testbench_INST.stall_coverage(TLS_stall_coverage);

    sync_generator_INST.clk(clk);
    sync_generator_INST.rst(rst);
    sync_generator_INST.in_sync(in_sync);
    sync_generator_INST.out_sync(out_sync);
    sync_generator_INST.inout_sync(inout_sync);
    sync_generator_INST.wait_for_init(wait_for_init);
    sync_generator_INST.catapult_start(catapult_start);
    sync_generator_INST.catapult_ready(catapult_ready);
    sync_generator_INST.catapult_done(catapult_done);

    catapult_monitor_INST.rst(rst);


    SC_METHOD(TLS_rst_method);
      sensitive_pos << TLS_rst;
      dont_initialize();

    SC_METHOD(max_sim_time_notify);
      sensitive << max_sim_time_event;
      dont_initialize();

    SC_METHOD(inform_autowait);
      sensitive << testbench_INST.testbench_aw_event;
      dont_initialize();

    SC_METHOD(generate_reset);
      sensitive << generate_reset_event;
      sensitive << testbench_INST.reset_request_event;

    SC_METHOD(deadlock_watch);
      sensitive << clk;
      dont_initialize();

    SC_METHOD(deadlock_notify);
      sensitive << deadlock_event;
      dont_initialize();


    #if defined(CCS_SCVERIFY) && defined(CCS_DUT_RTL) && !defined(CCS_DUT_SYSC) && !defined(CCS_SYSC) && !defined(CCS_DUT_POWER)
    ccs_probe_monitor_INST = new ccs_probe_monitor("ccs_probe_monitor");
    ccs_probe_monitor_INST->clk(clk);
    ccs_probe_monitor_INST->rst(rst);
    #endif
    SIG_SC_LOGIC_0.write(SC_LOGIC_0);
    SIG_SC_LOGIC_1.write(SC_LOGIC_1);
    mt19937_init_genrand(19650218UL);
    install_observe_foreign_signals();
    deadlocked.write(SC_LOGIC_0);
    TLS_design_is_idle.write(SC_LOGIC_0);
  }
};
void scverify_top::read_env() {
  env_SCVerify_DEADLOCK_DETECTION = ac_env::read_bool("SCVerify_DEADLOCK_DETECTION",false);
  env_SCVerify_DISABLE_EMPTY_INPUTS = ac_env::read_bool("SCVerify_DISABLE_EMPTY_INPUTS",false);
  env_SCVerify_IDLE_SYNCHRONIZATION_MODE = ac_env::read_bool("SCVerify_IDLE_SYNCHRONIZATION_MODE",false);
  env_SCVerify_ENABLE_RESET_TOGGLE = ac_env::read_bool("SCVerify_ENABLE_RESET_TOGGLE",false);
  env_SCVerify_RESET_CYCLES = ac_env::read_float("SCVerify_RESET_CYCLES",2.0);
  env_SCVerify_MAX_SIM_TIME = ac_env::read_int("SCVerify_MAX_SIM_TIME",0);
  env_SCVerify_AUTOWAIT = ac_env::read_int("SCVerify_AUTOWAIT",/*default to 0 (no automatic I/O stalling)*/ 0);
  env_SCVerify_AUTOWAIT_INPUT_CYCLES = ac_env::read_int("SCVerify_AUTOWAIT_INPUT_CYCLES",/*original hardcoded default*/ 5);
  env_SCVerify_AUTOWAIT_OUTPUT_CYCLES = ac_env::read_int("SCVerify_AUTOWAIT_OUTPUT_CYCLES",/*original hardcoded default*/ 5);
  d_iosync_pause_on_stall = ac_env::read_bool("SCVerify_IOSYNC_PAUSE_ON_STALL",false);
  d_idle_sync_enabled = env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  d_disable_on_empty = env_SCVerify_DISABLE_EMPTY_INPUTS || env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  float longest_clk_per = 1.000000;
  unsigned long latency_est = 66;
  unsigned long trcnt = 1;
  if (env_SCVerify_ENABLE_RESET_TOGGLE) { trcnt = ceil(env_SCVerify_RESET_CYCLES+0.5)*3; }
  unsigned long wait_for_cycles = latency_est * 9 + trcnt;
  unsigned long wait_time = ceil(longest_clk_per) * wait_for_cycles;
  d_deadlock_time = wait_time;
  d_max_sim_time = env_SCVerify_MAX_SIM_TIME;
  if ((d_max_sim_time > 0) && (wait_time > d_max_sim_time)) {
    d_max_sim_time = wait_time;
    std::ostringstream msg;
    msg << "Maximum simulation time extended to meet calculated value of " << d_max_sim_time << " ns";
    SC_REPORT_WARNING("System", msg.str().c_str());
  }
}

void scverify_top::TLS_rst_method() {
  std::ostringstream msg;
  msg << "TLS_rst active @ " << sc_time_stamp();
  SC_REPORT_INFO("HW reset", msg.str().c_str());
  input_m_rsc_INST.clear();
  input_e_rsc_INST.clear();
  taps_m_rsc_INST.clear();
  taps_e_rsc_INST.clear();
  return_m_rsc_INST.clear();
  return_e_rsc_INST.clear();
}

void scverify_top::max_sim_time_notify() {
  testbench_INST.set_failed(true);
  testbench_INST.check_results();
  SC_REPORT_ERROR("System", "Specified maximum simulation time reached");
  sc_stop();
}

void scverify_top::start_of_simulation() {
  setup_autowait();
  if (d_max_sim_time>0) max_sim_time_event.notify(d_max_sim_time,SC_NS);
}

void scverify_top::setup_autowait() {
  autowait_input_cfg = new mc_wait_ctrl(0, 1, env_SCVerify_AUTOWAIT_INPUT_CYCLES, mc_wait_ctrl::RANDOM, mc_wait_ctrl::INITIAL, 0, false);
  autowait_output_cfg = new mc_wait_ctrl(0, 1, env_SCVerify_AUTOWAIT_OUTPUT_CYCLES, mc_wait_ctrl::RANDOM, mc_wait_ctrl::INITIAL, 0, false);
  transactor_input_m.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_input_m.configure_autowait(autowait_input_cfg);
  transactor_input_e.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_input_e.configure_autowait(autowait_input_cfg);
  transactor_taps_m.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_taps_m.configure_autowait(autowait_input_cfg);
  transactor_taps_e.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_taps_e.configure_autowait(autowait_input_cfg);
  transactor_return_m.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_return_m.configure_autowait(autowait_output_cfg);
  transactor_return_e.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_return_e.configure_autowait(autowait_output_cfg);
}

void scverify_top::inform_autowait() {
  bool waited = false;
  waited |= (transactor_input_m.atleast_one_autowait(0) > 0);
  waited |= (transactor_input_e.atleast_one_autowait(0) > 0);
  waited |= (transactor_taps_m.atleast_one_autowait(0) > 0);
  waited |= (transactor_taps_e.atleast_one_autowait(0) > 0);
  waited |= (transactor_return_m.atleast_one_autowait(1) > 0);
  waited |= (transactor_return_e.atleast_one_autowait(1) > 0);
  if (waited)
    SC_REPORT_INFO(name(), "At least one AUTOWAIT was applied during simulation.");
}

void scverify_top::setup_debug() {
#ifdef MC_DEFAULT_TRANSACTOR_LOG
  static int transactor_input_m_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_input_e_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_taps_m_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_taps_e_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_return_m_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_return_e_flags = MC_DEFAULT_TRANSACTOR_LOG;
#else
  static int transactor_input_m_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_input_e_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_taps_m_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_taps_e_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_return_m_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_return_e_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
#endif
  static int transactor_input_m_count = -1;
  static int transactor_input_e_count = -1;
  static int transactor_taps_m_count = -1;
  static int transactor_taps_e_count = -1;
  static int transactor_return_m_count = -1;
  static int transactor_return_e_count = -1;

  // At the breakpoint, modify the local variables
  // above to turn on/off different levels of transaction
  // logging for each variable. Available flags are:
  //   MC_TRANSACTOR_EMPTY       - log empty FIFOs (on by default)
  //   MC_TRANSACTOR_UNDERFLOW   - log FIFOs that run empty and then are loaded again (off)
  //   MC_TRANSACTOR_READ        - log all read events
  //   MC_TRANSACTOR_WRITE       - log all write events
  //   MC_TRANSACTOR_LOAD        - log all FIFO load events
  //   MC_TRANSACTOR_DUMP        - log all FIFO dump events
  //   MC_TRANSACTOR_STREAMCNT   - log all streamed port index counter events
  //   MC_TRANSACTOR_WAIT        - log user specified handshake waits
  //   MC_TRANSACTOR_SIZE        - log input FIFO size updates

  std::ifstream debug_cmds;
  debug_cmds.open("scverify.cmd",std::fstream::in);
  if (debug_cmds.is_open()) {
    std::cout << "Reading SCVerify debug commands from file 'scverify.cmd'" << std::endl;
    std::string line;
    while (getline(debug_cmds,line)) {
      std::size_t pos1 = line.find(" ");
      if (pos1 == std::string::npos) continue;
      std::size_t pos2 = line.find(" ", pos1+1);
      std::string varname = line.substr(0,pos1);
      std::string flags = line.substr(pos1+1,pos2-pos1-1);
      std::string count = line.substr(pos2+1);
      debug(varname.c_str(),std::atoi(flags.c_str()),std::atoi(count.c_str()));
    }
    debug_cmds.close();
  } else {
    debug("transactor_input_m",transactor_input_m_flags,transactor_input_m_count);
    debug("transactor_input_e",transactor_input_e_flags,transactor_input_e_count);
    debug("transactor_taps_m",transactor_taps_m_flags,transactor_taps_m_count);
    debug("transactor_taps_e",transactor_taps_e_flags,transactor_taps_e_count);
    debug("transactor_return_m",transactor_return_m_flags,transactor_return_m_count);
    debug("transactor_return_e",transactor_return_e_flags,transactor_return_e_count);
  }
}

void scverify_top::debug(const char* varname, int flags, int count) {
  sc_module *xlator_p = 0;
  sc_attr_base *debug_attr_p = 0;
  if (strcmp(varname,"transactor_input_m") == 0)
    xlator_p = &transactor_input_m;
  if (strcmp(varname,"transactor_input_e") == 0)
    xlator_p = &transactor_input_e;
  if (strcmp(varname,"transactor_taps_m") == 0)
    xlator_p = &transactor_taps_m;
  if (strcmp(varname,"transactor_taps_e") == 0)
    xlator_p = &transactor_taps_e;
  if (strcmp(varname,"transactor_return_m") == 0)
    xlator_p = &transactor_return_m;
  if (strcmp(varname,"transactor_return_e") == 0)
    xlator_p = &transactor_return_e;
  if (xlator_p) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_EVENT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_EVENT",flags);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = flags;
  }

  if (count>=0) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_COUNT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_COUNT",count);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = count;
  }
}

// Process: SC_METHOD generate_reset
void scverify_top::generate_reset() {
  static bool activate_reset = true;
  static bool toggle_hw_reset = env_SCVerify_ENABLE_RESET_TOGGLE;
  if (activate_reset || sc_time_stamp() == SC_ZERO_TIME) {
    setup_debug();
    activate_reset = false;
    rst.write(SC_LOGIC_1);
    rst_driver.reset_driver();
    generate_reset_event.notify(env_SCVerify_RESET_CYCLES*1.000000, SC_NS);
  } else {
    if (toggle_hw_reset) {
      toggle_hw_reset = false;
      generate_reset_event.notify(env_SCVerify_RESET_CYCLES*1.000000, SC_NS);
    } else {
      transactor_input_m.reset_streams();
      transactor_input_e.reset_streams();
      transactor_taps_m.reset_streams();
      transactor_taps_e.reset_streams();
      transactor_return_m.reset_streams();
      transactor_return_e.reset_streams();
      rst.write(SC_LOGIC_0);
    }
    activate_reset = true;
  }
}

void scverify_top::install_observe_foreign_signals() {
#if !defined(CCS_DUT_SYSC)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#endif
#endif
}

void scverify_top::deadlock_watch() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  deadlocked.write(SC_LOGIC_0);
#endif
#endif
#endif
}

void scverify_top::deadlock_notify() {
  if (deadlocked.read() == SC_LOGIC_1) {
    testbench_INST.check_results();
    SC_REPORT_ERROR("System", "Simulation deadlock detected");
    sc_stop();
  }
}

#if defined(MC_SIMULATOR_OSCI) || defined(MC_SIMULATOR_VCS)
int sc_main(int argc, char *argv[]) {
  sc_report_handler::set_actions("/IEEE_Std_1666/deprecated", SC_DO_NOTHING);
  scverify_top scverify_top("scverify_top");
  sc_start();
  return scverify_top.testbench_INST.failed();
}
#else
MC_MODULE_EXPORT(scverify_top);
#endif
