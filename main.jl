include("ccp.jl")
include("read.jl")


# Solver 
file_name = string(output_path,"results.txt")
results = open(file_name, "w")
println(results,"Solver: 20 x 100")
close(results)

for j=1:num_instances
     zIP, tzIP = clustering(w, D[j], p, W, 1)
     println("Optimal solution: ", zIP)
     println("Computational time (s): ", tzIP)
     
     results = open(file_name, "a")
     println(results,j,"   Optimal solution: ",zIP,"   Computational time (s): ",tzIP)
     close(results)
end


# LP-and-fix
file_name = string(output_path,"lp_and_fix_results.txt")
results = open(file_name, "w")
println(results,"LP-and-fix: 20 x 100")
close(results)

for j=1:num_instances
     zIP, tzIP = clustering(w, D[j], p, W, 2)
     println("Optimal solution: ", zIP)
     println("Computational time (s): ", tzIP)
     
     results = open(file_name, "a")
     println(results,j,"   Optimal solution: ",zIP,"   Computational time (s): ",tzIP)
     close(results)
end


# Size reduction
file_name = string(output_path,"size_reduction_results.txt")
results = open(file_name, "w")
println(results,"Size reduction: 20 x 100")
close(results)

for j=1:num_instances
     zIP, tzIP = clustering(w, D[j], p, W, 3)
     println("Optimal solution: ", zIP)
     println("Computational time (s): ", tzIP)
     
     results = open(file_name, "a")
     println(results,j,"   Optimal solution: ",zIP,"   Computational time (s): ",tzIP)
     close(results)
end