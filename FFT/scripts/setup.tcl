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
directive set -I$env(MGC_HOME)/shared/include

# add the files you want
# solution file add <tb_file>.cpp -type C++ -exclude true
# solution file add <dut_file>.cpp -type C++
solution file add src/fft_fixed.cpp -type C++
solution file add src/fft_fixed.h -type C++
solution file add src/utils.cpp -type C++
solution file add src/utils.h -type C++
solution file add dat/cos_qtable.txt -type C++ -exclude true
solution file add dat/sin_qtable.txt -type C++ -exclude true

# solution file add fft_fixed_test.cpp -type C++ -tb true -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"

# adjust this as needed, can be -mapped, -inline, -ccore, -top, -block
# solution design set <top_module> -top
solution design set fft_fixed -top

go new

go compile
# solution library remove *
# solution library add nangate-45nm_beh -file {$MGC_HOME/pkgs/siflibs/nangate/nangate-45nm_beh.lib} -- -rtlsyntool OasysRTL
# solution library add ram_nangate-45nm-dualport_beh
# solution library add ram_nangate-45nm-separate_beh
# solution library add ram_nangate-45nm-singleport_beh