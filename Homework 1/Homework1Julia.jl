import DMUStudent.HW1

using Random
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

# # First let's create a function outputs the step
function step(xt , x_tm1)
    mu = 0
    sigma2 = 0.08
    sigma = sqrt(sigma2)
    vt = randn() * sigma + mu
    x_tp1 = 1.5*xt - x_tm1 + vt

    return x_tp1
end

# Iterate ten, twenty step trajectories
sims = 10
steps = 20
history = zeros(sims,steps)
for i in 1:sims
    # Set up initial conditions
    xt = 1
    x_tm1 = xt
    for j in 1:steps
        # Call my previous function 
        history[i,j] = step(xt , x_tm1)

        # Change order of the previous x values
        x_tm1 = xt
        xt = history[i,j]
    end
end
@show history

# Obtain sizes of matrix for plotting
row , col = size(history)
plot(0:col - 1,history[1,:])






#------------- 
# Problem 4
#-------------

# function f(a , bs)
#     # Finding the size of the matrix and initializing a new matrix
#     result = a*bs[1]

#     for i in 2:length(bs)
#         result = max.(result , a*bs[i])
#     end
    
#     @show typeof(result)
#     return result
# end

# # This is how you create the json file to submit
# HW1.evaluate(f, "julian.lemabulliard@colorado.edu")