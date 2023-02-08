import DMUStudent.HW1

using Random
using Distributions
using Plots
#-------------
# Testing
#-------------

# x = randn(10,10)
# y = 1:10
# plot(y , x[1,:])

#------------- 
# Problem 3
#-------------
# See https://github.com/zsunberg/CU-DMU-Materials/blob/master/notebooks/030-Stochastic-Processes.ipynb for code that simulates a stochastic process.

# First let's create a function outputs the step
function step(xt , x_tm1)
    mu = 0
    sigma2 = 0.04
    sigma = sqrt(sigma2)
    # vt = randn() * sigma + mu
    x_tp1 = 1.5*xt - x_tm1 + rand(Normal(mu,sigma))

    return x_tp1
end

# Function to be called to create history
function simulate(step; n_steps = 20 , xt = 1.0, xtm1 = 1.0)
    # Pre allocate the first two given variables
    history = [xtm1 , xt]

    for _ in 1:n_steps
        
        # Store the first variables as above to xtm1 and xt
        # Step to the next number and store this to history
        # On next step these new numbers will be interchanged with xt and xtm1

        xtm1 , xt = history[end-1:end]
        xtp1 = step(xt,xtm1)
        push!(history,xtp1)

    end
    # Return history 
    return history
end


# Iterate ten, twenty step trajectories
sims = 10
steps = 20
store = zeros(22,sims)
for i in 1:sims
    store[:,i] = simulate(step)
end
storeplot = store[2:end,:];

row , col = size(store)
output = plot(0:row-2, storeplot , legend =:outertopright)
title!(output, "Trajectories")
xlabel!(output, "Step (time)")
xlims!(output,0,20)
ylabel!(output, "X value")
png(output,"HW3Num3")




#------------- 
# Problem 4
#-------------

function f(a , bs)
    # Finding the size of the matrix and initializing a new matrix
    result = a*bs[1]

    for i in 2:length(bs)
        result = max.(result , a*bs[i])
    end
    
    @show typeof(result)
    return result
end

# # This is how you create the json file to submit
HW1.evaluate(f, "julian.lemabulliard@colorado.edu")