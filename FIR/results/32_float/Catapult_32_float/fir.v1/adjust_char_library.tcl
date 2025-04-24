# This Catapult LB script has been generated to expand the characterization range(es)
# of components of the Catapult base library(ies) to fit the current design
# 
# Running this script is optional but using the updated library should result in improved correlation.
# 
# Run this script in Catapult LB with the base library loaded or uncomment the "library load" command(s)
#library load /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/saed/saed32lvt_tt0p78v125c_beh.lib
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_mul_pipe/PARAMETERS/n_inreg -- -CHAR_RANGE {0 to 0, 2}
#library load /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/saed/saed32lvt_tt0p78v125c_dw_beh.lib
library set /LIBS/saed32lvt_tt0p78v125c_dw_beh/MODS/ccs_dw_mult_pipe/PARAMETERS/has_rst_a -- -CHAR_RANGE {0, 1 to 1}
library set /LIBS/saed32lvt_tt0p78v125c_dw_beh/MODS/ccs_dw_add/PARAMETERS/width -- -CHAR_RANGE {2, 4 to 4, 8 to 8, 16 to 16, 32 to 32, 64 to 64}
library set /LIBS/saed32lvt_tt0p78v125c_dw_beh/MODS/ccs_dw_addsub/PARAMETERS/width -- -CHAR_RANGE {2, 4 to 4, 8 to 8, 16 to 16, 32 to 32, 64 to 64}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_shift_bl/PARAMETERS/width_s -- -CHAR_RANGE {1 to 1, 3 to 6 by 1, 7}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_add/PARAMETERS/width_z -- -CHAR_RANGE {2, 3 to 3, 5 to 25, 33 to 33, 65 to 65}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_reg_pos/PARAMETERS/has_enable -- -CHAR_RANGE {0 to 0, 1}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_reg_pos/PARAMETERS/enable_on -- -CHAR_RANGE {0 to 0, 1}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_mux1hot/PARAMETERS/ctrlw -- -CHAR_RANGE {1, 2 to 2, 4 to 32}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_mux1hot/PARAMETERS/ctrlw -- -CHAR_RANGE {2 to 2, 4 to 32, 68}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_or/PARAMETERS/ninps -- -CHAR_RANGE {2 to 2, 4 to 32, 36}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_add/PARAMETERS/width_b -- -CHAR_RANGE {1, 2 to 2, 4 to 24, 32 to 32, 64 to 64}
library set /LIBS/saed32lvt_tt0p78v125c_beh/MODS/mgc_add_msb/PARAMETERS/width_b -- -CHAR_RANGE {1, 2 to 2, 4 to 24, 32 to 32, 64 to 64}
# The "library characterize" command below requires that: 
#   1. characterization directory set in the library exists and write accessible;
#   2. paths to technology libraries are set to correct locations;
#   3. the downstream tool used to characterize the library is available;
library characterize
