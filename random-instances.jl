function processing_times_generator(m, n, cont, output_path)
    instance = string(output_path,"p", cont, ".txt")
    processing_times = open(instance, "w")

    for i in 1:m
        for j in 1:n
            r = rand(1:50)
            print(processing_times, r, "   ")
        end
        print(processing_times,"\n")
    end
    close(processing_times)
end

# Generating the instances
println("The generator begins...")
output_path = ("/home/isabecl/ccp/instances/")

m =  20
n = 100
num_instances = 10

for j = 1:num_instances
    processing_times_generator(m, n, j, output_path)
end

println("The test instances were successful generated!")