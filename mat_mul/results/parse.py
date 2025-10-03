import os

with open("results.csv", "w") as csv_file:
    
    # header
    csv_file.write("A_dim, B_dim, Type, Latency, Throughput, Area\n")
    
    # walk through directories and find report files
    for (root, dirs, files) in os.walk("."):
        for file in files:
            if file == "rtl.rpt":
                
                rpt_path = os.path.join(root, file)
                
                # extract taps and type from directory name
                A_dim = root.split("/")[1].split("_")[2]
                B_dim = root.split("/")[1].split("_")[3]

                data_type = "_".join(root.split("/")[1].split("_")[4:])
                
                with open(rpt_path, "r") as rpt_file:
                    
                    lines = rpt_file.readlines()
                    for line in lines:
                        
                        # extract latency cycles
                        if "Design Total:" in line:
                            latency_cycles = line.strip().split(":")[1].strip().split()[1]
                            
                        # extract throughput cycles
                        if "Design Total:" in line:
                            throughput_cycles = line.strip().split(":")[1].strip().split()[2]
                            
                        # extract area (post-assignment)
                        if "Total Area Score:" in line:
                            area = line.strip().split(":")[1].strip().split()[-1]
                          
                # write results to csv
                csv_file.write(f"{A_dim}, {B_dim}, {data_type}, {latency_cycles}, {throughput_cycles}, {area}\n")