solution options defaults
options set Output/OutputVHDL false
options set Output/RTLSchem false
options set Input/TargetPlatform x86_64

solution options set /Flows/SCVerify/USE_CCS_BLOCK true
flow package option set /SCVerify/USE_NCSIM true
flow package option set /SCVerify/USE_VCS true
flow package require /SCVerify

# set what flags you want
# set COMPILER_FLAGS "options set Input/CompilerFlags {-D<VARIABLE_NAME>=$<TARGET_ENV_VARIABLE>}"
# eval $COMPILER_FLAGS

# add the files you want
# solution file add <tb_file>.cpp -type C++ -exclude true
# solution file add <dut_file>.cpp -type C++
solution file add src/mat_mul.cpp -type C++
solution file add src/mat_mul.h -type C++

# adjust this as needed, can be -mapped, -inline, -ccore, -top, -block
# solution design set <top_module> -top
solution design set matrix_multiply -top

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
# -CLOCK_HIGH_TIME 0.5 -CLOCK_OFFSET 0.000000 -CLOCK_UNCERTAINTY 0.0 -RESET_KIND sync -RESET_SYNC_NAME rst -RESET_SYNC_ACTIVE high -RESET_ASYNC_NAME arst_n -RESET_ASYNC_ACTIVE low -ENABLE_NAME {} -ENABLE_ACTIVE high}}

### 1 MAC ###
go assembly
directive set /matrix_multiply/core -DESIGN_GOAL Latency
# directive set /top/core/for -PIPELINE_INIT_INTERVAL 1
# directive set /fir/core/SHIFT -UNROLL yes
# go allocate

# ### 2 MAC ###
# go assembly
# directive set /fir/core/MAC -UNROLL 2
# go allocate

# ### 4 MAC ###
# go assembly
# directive set /fir/core/MAC -UNROLL 4
# go allocate

# ### 8 MAC ###
# go assembly
# directive set /fir/core/MAC -UNROLL 8
# go allocate

# ### 16 MAC ###
# go assembly
# directive set /fir/core/MAC -UNROLL yes
# go allocate
