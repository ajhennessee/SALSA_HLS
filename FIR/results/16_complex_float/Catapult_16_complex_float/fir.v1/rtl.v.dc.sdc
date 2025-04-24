# written for flow package DesignCompiler 
set sdc_version 1.7 

set_operating_conditions tt0p78v125c
set_wire_load_model -name ForQA
set_wire_load_mode top
set_load 5.17023 [all_outputs]
## driver/slew constraints on inputs
set data_inputs [list {input_real_m_rsc_dat[*]} {input_real_e_rsc_dat[*]} {input_imag_m_rsc_dat[*]} {input_imag_e_rsc_dat[*]} {taps_real_m_rsc_dat[*]} {taps_real_e_rsc_dat[*]} {taps_imag_m_rsc_dat[*]} {taps_imag_e_rsc_dat[*]}]
set_driving_cell -no_design_rule -library saed32lvt_tt0p78v125c -lib_cell DFFX1_LVT -pin Q $data_inputs
set_units -time ns
# time_factor: 1.0

create_clock -name clk -period 1.0 -waveform { 0.0 0.5 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 1.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_real_m_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_real_m_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_real_e_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_real_e_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_imag_m_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_imag_m_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_imag_e_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_imag_e_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_real_m_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_real_m_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_real_e_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_real_e_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_imag_m_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_imag_m_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_imag_e_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {taps_imag_e_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_real_m_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_real_m_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_real_e_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_real_e_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_imag_m_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_imag_m_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_imag_e_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {return_imag_e_triosy_lz}]

