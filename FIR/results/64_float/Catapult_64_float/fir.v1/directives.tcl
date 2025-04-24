//  Catapult Ultra Synthesis 2023.1_2/1049935 (Production Release) Sat Jun 10 10:53:51 PDT 2023
//  
//          Copyright (c) Siemens EDA, 1996-2023, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//  
//  Running on Linux ajh9498@hansolo.poly.edu 4.18.0-553.33.1.el8_10.x86_64 x86_64 aol
//  
//  Package information: SIFLIBS v26.1_2.0, HLS_PKGS v26.1_2.0, 
//                       SIF_TOOLKITS v26.1_2.0, SIF_XILINX v26.1_2.0, 
//                       SIF_ALTERA v26.1_2.0, CCS_LIBS v26.1_2.0, 
//                       CDS_PPRO v2022.1_1, CDS_DesigChecker v2023.1_1, 
//                       CDS_OASYS v21.1_3.1, CDS_PSR v22.2_0.9, 
//                       DesignPad v2.78_1.0
//  
solution new -state initial
solution options defaults
solution options set /Input/TargetPlatform x86_64
solution options set /Input/CompilerFlags {-DNUM_TAPS=64 -DTYPE_T=my_float_t}
solution options set /Output/OutputVHDL false
solution options set /Output/RTLSchem false
solution options set /Flows/SCVerify/USE_NCSIM true
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/SCVerify/USE_CCS_BLOCK true
solution file add ./src/fir.cpp -type C++
solution file add ./src/fir.h -type CHEADER -exclude true
solution file add ./src/types.h -type CHEADER -exclude true
solution file add ./src/main.cpp -type C++ -exclude true
directive set -DESIGN_GOAL area
directive set -SPECULATE true
directive set -MERGEABLE true
directive set -REGISTER_THRESHOLD 256
directive set -MEM_MAP_THRESHOLD 32
directive set -LOGIC_OPT false
directive set -FSM_ENCODING none
directive set -FSM_BINARY_ENCODING_THRESHOLD 64
directive set -REG_MAX_FANOUT 0
directive set -NO_X_ASSIGNMENTS true
directive set -SAFE_FSM false
directive set -REGISTER_SHARING_MAX_WIDTH_DIFFERENCE 8
directive set -REGISTER_SHARING_LIMIT 0
directive set -ASSIGN_OVERHEAD 0
directive set -TIMING_CHECKS true
directive set -MUXPATH true
directive set -REALLOC true
directive set -UNROLL no
directive set -IO_MODE super
directive set -CHAN_IO_PROTOCOL use_library
directive set -ARRAY_SIZE 1024
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
directive set -RESET_CLEARS_ALL_REGS use_library
directive set -CLOCK_OVERHEAD 20.000000
directive set -ON_THE_FLY_PROTOTYPING false
directive set -OPT_CONST_MULTS use_library
directive set -CHARACTERIZE_ROM false
directive set -PROTOTYPE_ROM true
directive set -ROM_THRESHOLD 64
directive set -CLUSTER_ADDTREE_IN_WIDTH_THRESHOLD 0
directive set -CLUSTER_ADDTREE_IN_COUNT_THRESHOLD 0
directive set -CLUSTER_OPT_CONSTANT_INPUTS true
directive set -CLUSTER_RTL_SYN false
directive set -CLUSTER_FAST_MODE false
directive set -CLUSTER_TYPE combinational
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set fir -top
go analyze
solution design set fir -top
go compile
solution library add saed32lvt_tt0p78v125c_beh -- -rtlsyntool DesignCompiler -vendor SAED32 -technology {lvt tt0p78v125c}
solution library add saed32lvt_tt0p78v125c_dw_beh
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 1.0 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 0.5 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /fir/core -DESIGN_GOAL latency
directive set /fir/core/SHIFT -UNROLL yes
directive set /fir/core/MAC -UNROLL yes
go architect
go extract
