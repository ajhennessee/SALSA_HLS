# tcl script to set catapult directives for matrix multiplication kernel

logfile close

set combinations {
    {1024 4 8}
    {1024 4 16}
    {1024 8 8}
    {1024 8 16}
    {1024 16 8}
    {1024 16 16}
}

set types_list {
    # int
    float
    # complex_int
    # complex_float
}

dict set type_macro_map   int            my_int_t
dict set type_macro_map   float          my_float_t
dict set type_macro_map   complex_int    my_complex_int_t
dict set type_macro_map   complex_float  my_complex_float_t

foreach combo $combinations {

    set N [lindex $combo 0]
    set M [lindex $combo 1]
    set P [lindex $combo 2]

    # puts $N
    # puts $M
    # puts $P

    foreach type $types_list {
        # puts $type

        set type_macro [dict get $type_macro_map $type]
        # puts $type_macro

        set compiler_flags "-DNd=${N} -DMd=${M} -DPd=${P} -DTYPE_T=${type_macro}"
        # puts $compiler_flags
        
        set project_name "mat_mul_${N}x${M}_${M}x${P}_${type}"
        # puts $project_name

        # puts "Launching Catapult for N=${N}, M=${M}, P=${P}, type=${type} ..."

        ##########################
        ### CATAPULT COMMMANDS ###
        ##########################

        logfile open "${project_name}.log"

        project new -name $project_name

        solution options defaults
        options set Output/OutputVHDL false
        options set Output/RTLSchem false
        options set Input/TargetPlatform x86_64

        solution options set /Flows/SCVerify/USE_CCS_BLOCK true
        flow package option set /SCVerify/USE_NCSIM true
        flow package option set /SCVerify/USE_VCS true
        flow package require /SCVerify

        # set compiler flags
        solution options set Input/CompilerFlags $compiler_flags

        # add design files
        solution file add src/mat_mul.cpp -type C++
        solution file add src/mat_mul.h -type C++ -exclude true
        solution file add src/types.h -type C++ -exclude true
        solution file add src/main.cpp -type C++ -exclude true

        # set top module
        solution design set matrix_multiply -top

        go new

        go compile

        # set libraries
        solution library remove *
        solution library add saed32lvt_tt0p78v125c_beh -- -rtlsyntool DesignCompiler -vendor SAED32 -technology {lvt tt0p78v125c}
        solution library add saed32lvt_tt0p78v125c_dw_beh
        solution library add ccs_sample_mem

        go libraries

        # set clock
        directive set -CLOCKS {clk {-CLOCK_PERIOD 1 -CLOCK_EDGE rising}}

        go assembly

        # set architecture / optimizations
        directive set /matrix_multiply/core -DESIGN_GOAL latency
        directive set /matrix_multiply/core/MUL -UNROLL yes
        directive set /matrix_multiply/A.d:rsc -INTERLEAVE $M
        directive set /matrix_multiply/B.d:rsc -BLOCK_SIZE $P
        directive set /matrix_multiply/core/ROW -PIPELINE_INIT_INTERVAL 1

        go architect

        go allocate

        # extract RTL
        go extract

        # save and close project
        project save

        logfile close

        project close
    }
}
