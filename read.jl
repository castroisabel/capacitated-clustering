using DelimitedFiles

function read_processing_times(cont, input_path)
    processing_time_instance = string(input_path,"p", cont, ".txt")
    p = readdlm(processing_time_instance, Int)
    return(p)
end

num_instances = 10
input_path = ("/home/isabecl/ccp/instances/")
output_path = ("/home/isabecl/ccp/")

m = 20
n = 100
w = [rand(1:5) for i=1:m] # weight vector
p = 6 # amount of facilities
W = 15 # cluster capacity

D = Array{Int64,2}[]
for i = 1:num_instances
     push!(D, read_processing_times(i, input_path))
end 