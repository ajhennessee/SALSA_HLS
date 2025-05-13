import os
import shutil
import subprocess

top = "fir"

directives_script = "directives.tcl"
clean_script = "./clean.tcsh"

results_dir = "../results"
rtl_dir = "setup/rtl"
logs_dir = "logs"

taps_list = [16, 32, 64]
types_list = ["float", "complex_float"]

for taps in taps_list:
    for data_type in types_list:
        
        # locate rtl
        rtl_path = os.path.join(
            results_dir,
            f"{taps}_{data_type}",
            f"Catapult_{taps}_{data_type}",
            f"{top}.v1",
            "concat_rtl.v"
        )

        if os.path.exists(rtl_path):
            
            temp_rtl = os.path.join(rtl_dir, "fir_core.v")
            shutil.copy(rtl_path, temp_rtl)

            log_path = os.path.join(logs_dir, f"DC_{taps}_{data_type}.log")

            # run synthesis
            print(f"Running DC for FIR design with {taps} taps and {data_type} data type...")
            
            with open(log_path, "w") as log_file:
                subprocess.run(["dcnxt_shell", "-topo", "-f", directives_script], cwd="setup", stdout=log_file, stderr=subprocess.STDOUT)
            
            subprocess.run(clean_script, shell=True)
