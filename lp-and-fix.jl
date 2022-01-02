using JuMP

function lp_and_fix(w,D,p,W)
    m = size(D,1)
    n = size(D,2)
    model = Model(optimizer_with_attributes(Gurobi.Optimizer))
    
    # Decision variables
    @variable(model, X[i in 1:m,j in 1:n], lower_bound = 0)
    @variable(model, Y[j in 1:n], lower_bound = 0)

    # Objective function
    @objective(model, Min, sum(D[i,j]*X[i,j] for i in 1:m, j in 1:n))

    # Constraints
    @constraint(model, [i in 1:m], sum(X[i,j] for j in 1:n)==1)
    @constraint(model, sum(Y[j] for j in 1:n) == p)
    @constraint(model, [i in 1:m, j in 1:n], X[i,j]<=Y[j])
    @constraint(model, [j in 1:n], sum(w[i]*X[i,j] for i in 1:m)<=W)

    # Solving the model
    status = optimize!(model)
    x_val = value.(X)
    
    return x_val
end