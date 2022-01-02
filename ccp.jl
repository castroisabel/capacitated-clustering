using JuMP, Gurobi
include("lp-and-fix.jl")

function clustering(w, D, p, W, method = 1)
    m = size(D,1)
    n = size(D,2)
    model = Model(optimizer_with_attributes(Gurobi.Optimizer))
    
    # Decision variables                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    @variable(model, Y[j in 1:n], Bin)
    @variable(model, X[i in 1:m,j in 1:n], Bin)
    
    if method == 2 # LP-and-fix
        init_X = lp_and_fix(w,D,p,W) 
        for i in 1:m
            for j in 1:n            
                if init_X[i,j] == 1
                    fix(X[i,j],1)
                end
            end
        end
    elseif method == 3 # Size reduction
        for i in 1:m
            for j in 1:n            
                if D[i,j] >= 10
                    fix(X[i,j],0)
                end
            end
        end
    end
    
    # Objective function
    @objective(model, Min, sum(D[i,j]*X[i,j] for i in 1:m, j in 1:n))

    # Constraints
    @constraint(model, [i in 1:m], sum(X[i,j] for j in 1:n)==1)
    @constraint(model, sum(Y[j] for j in 1:n) == p)
    @constraint(model, [i in 1:m, j in 1:n], X[i,j]<=Y[j])
    @constraint(model, [j in 1:n], sum(w[i]*X[i,j] for i in 1:m)<=W)

    # Solving the model
    status = optimize!(model)

    zIP = objective_value(model)
    tzIP = MOI.get(model, MOI.SolveTime())

    return(zIP, tzIP)
end 
