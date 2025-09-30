import os
import subprocess

# N_list = [1024, 1024, 1024, 1024, 1024, 1024]
# M_list = [4,    4,    8,    8,    16,   16]
# P_list = [8,    16,   8,    16,   8,    16]

# N_list = [2, 4, 8]
# M_list = [2, 4, 8]
# P_list = [2, 4, 8]

N_list = [2]
M_list = [2]
P_list = [2]

types_list = ["int"]
type_macro_map = {
    "int": "my_int_t",
    "float": "my_float_t",
    "complex_float": "my_complex_float_t",
    "complex_int": "my_complex_int_t"
}

directives = "scripts/directives.tcl"

base_dir = os.getcwd()
logs_dir = os.path.join(base_dir, "logs")
os.makedirs(logs_dir, exist_ok=True)

processes = []

for N, M, P in zip(N_list, M_list, P_list):
    
    for data_type in types_list:
        
        type_macro = type_macro_map[data_type]
        flags = f"-DNd={N} -DMd={M} -DPd={P} -DTYPE_T={type_macro}"
        proj_name = f"Catapult_{N}x{M}_{M}x{P}_{data_type}"
        
        # create log for catapult stdout
        log = open(os.path.join(logs_dir, f"{proj_name}.log"), "w")

        # launch catapult
        print(f"Launching Catapult for N={N}, M={M}, P={P}, type={data_type} ...")
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