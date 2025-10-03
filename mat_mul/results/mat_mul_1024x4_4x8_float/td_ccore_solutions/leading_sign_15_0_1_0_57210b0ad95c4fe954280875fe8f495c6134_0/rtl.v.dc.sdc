# written for flow package DesignCompiler 
set sdc_version 1.7 

set_operating_conditions tt0p78v125c
set_wire_load_model -name ForQA
set_wire_load_mode top
set_load 5.17023 [all_outputs]
## driver/slew constraints on inputs
set data_inputs [list {mantissa[*]}]
set_driving_cell -no_design_rule -library saed32lvt_tt0p78v125c -lib_cell DFFX1_LVT -pin Q $data_inputs
set_units -time ns
# time_factor: 1.0

create_clock -name virtual_io_clk -period 1.0
## IO TIMING CONSTRAINTS
set_max_delay 1.0 -from [all_inputs] -to [all_outputs]
set_input_delay 0.0 -clock virtual_io_clk [get_ports {mantissa[*]}]
set_output_delay 0.0 -clock virtual_io_clk [get_ports {all_same}]
set_output_delay 0.0 -clock virtual_io_clk [get_ports {rtn[*]}]

