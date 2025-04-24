import os
import subprocess

taps_list = [16, 32, 64]
types_list = ["float"]
type_macro_map = {
    "int": "my_int_t",
    "float": "my_float_t",
    "complex_float": "my_complex_float_t",
    "complex_int": "my_complex_int_t"
}

directives = "scripts/directives.tcl"

base_dir = os.getcwd()
logs_dir = os.path.join(base_dir, "logs")
os.makedirs(logs_dir)

processes = []

for taps in taps_list:
    for data_type in types_list:
        
        type_macro = type_macro_map[data_type]
        flags = f"-DNUM_TAPS={taps} -DTYPE_T={type_macro}"
        proj_name = f"Catapult_{taps}_{data_type}"
        
        # create log for catapult stdout
        log = open(os.path.join(logs_dir, f"{proj_name}.log"), "w")

        # launch catapult
        print(f"Launching Catapult for taps={taps}, type={data_type} ...")
        proc = subprocess.Popen([
            "catapult", "-shell",
            "-eval", f'project set -name {proj_name}',
            "-eval", "solution options defaults",
            "-eval", f'solution options set Input/CompilerFlags "{flags}"',
            "-file", directives
        ], stdout=log, stderr=subprocess.STDOUT)

        processes.append((proc, log))

# wait for processes to complete
for proc, log in processes:
    proc.wait()
    log.close()

print("All Catapult runs completed.")
