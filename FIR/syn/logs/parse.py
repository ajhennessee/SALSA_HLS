import os

with open("results.csv", "w") as csv_file:
    
    csv_file.write("Taps, Type, Area, Power\n")

    for (root, dirs, files) in os.walk("."):
        for file in files:
            if file.endswith(".log"):
                
                taps = file.split("_")[1]
                data_type = file.split("_")[2].split(".")[0]
                
                with open(file, "r") as log_file:
                    
                    lines = log_file.readlines()
                    
                    for line in lines:
                        
                        if line.startswith("Total cell area:"):
                            area = line.strip().split(":")[1].strip()
                            
                        if line.endswith("uW\n"):
                            power = line.strip().split()[-2]
                            
                csv_file.write(f"{taps}, {data_type}, {area}, {power}\n")
            