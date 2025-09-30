# solution options defaults
options set Output/OutputVHDL false
options set Output/RTLSchem false
options set Input/TargetPlatform x86_64

solution options set /Flows/SCVerify/USE_CCS_BLOCK true
flow package option set /SCVerify/USE_NCSIM true
flow package option set /SCVerify/USE_VCS true
flow package require /SCVerify

# set compiler flags
# set COMPILER_FLAGS "options set Input/CompilerFlags {-DNUM_TAPS=$NUM_TAPS}"
# eval $COMPILER_FLAGS

# add source files
# solution file add <tb_file>.cpp -type C++ -exclude true
# solution file add <dut_file>.cpp -type C++
solution file add src/outer_product.cpp -type C++
solution file add src/outer_product.h -type C++ -exclude true
solution file add src/types.h -type C++ -exclude true
solution file add src/main.cpp -type C++ -exclude true

# adjust this as needed, can be -mapped, -inline, -ccore, -top, -block
# solution design set <top_module> -top
solution design set outer_product -top

go new

go compile

solution library remove *
solution library add saed32lvt_tt0p78v125c_beh -- -rtlsyntool DesignCompiler -vendor SAED32 -technology {lvt tt0p78v125c}
solution library add saed32lvt_tt0p78v125c_dw_beh

# solution library remove *
# solution library add nangate-45nm_beh -file {$MGC_HOME/pkgs/siflibs/nangate/nangate-45nm_beh.lib} -- -rtlsyntool OasysRTL
# solution library add ram_nangate-45nm-dualport_beh
# solution library add ram_nangate-45nm-separate_beh
# solution library add ram_nangate-45nm-singleport_beh

go libraries

directive set -CLOCKS {clk {-CLOCK_PERIOD 1 -CLOCK_EDGE rising}}
# FIXME: for FIR, need at least 1.5ns for the clock period to avoid timing violations, max delay is 1.42 ns for complex_float
# -CLOCK_HIGH_TIME 0.5 -CLOCK_OFFSET 0.000000 -CLOCK_UNCERTAINTY 0.0 -RESET_KIND sync -RESET_SYNC_NAME rst -RESET_SYNC_ACTIVE high -RESET_ASYNC_NAME arst_n -RESET_ASYNC_ACTIVE low -ENABLE_NAME {} -ENABLE_ACTIVE high}}

go assembly

# # define architecture / optimizations
# directive set /fir/core -DESIGN_GOAL Latency
# # directive set /test/core/for -PIPELINE_INIT_INTERVAL 1
# directive set /fir/core/SHIFT -UNROLL yes
# directive set /fir/core/MAC -UNROLL yes

# # schedule
# go allocate

# # generate RTL
# go extract

# project save
