source setup.tcl
analyze -f verilog fir_core.v
elaborate fir_core
list_libs
list_designs
source fir_core.con
compile_ultra
report_area
report_power
