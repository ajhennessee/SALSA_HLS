import os

with open("results.csv", "w") as csv_file:
    
    # header
    csv_file.write("Taps, Type, Latency, Area\n")
    
    # walk through directories and find report files
    for (root, dirs, files) in os.walk("."):
        for file in files:
            if file == "rtl.rpt":
                
                rpt_path = os.path.join(root, file)
    
                # extract taps and type from directory name
                taps = root.split("/")[1].split("_")[0]
                data_type = "_".join(root.split("/")[1].split("_")[1:])
                
                with open(rpt_path, "r") as rpt_file:
                    
                    lines = rpt_file.readlines()
                    for line in lines:
                        
                        # extract latency cycles
                        if "Design Total:" in line:
                            latency_cycles = line.strip().split(":")[1].strip().split()[1]
                            
                        # extract area (post-assignment)
                        if "Total Area Score:" in line:
                            area = line.strip().split(":")[1].strip().split()[-1]
                    
                # write results to csv
                csv_file.write(f"{taps}, {data_type}, {latency_cycles}, {area}\n")