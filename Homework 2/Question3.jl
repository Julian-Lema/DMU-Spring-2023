using DMUStudent.HW2
using POMDPs: states, actions
using POMDPTools: ordered_states
using LinearAlgebra
############
# Question 3
############


S = states(grid_world)
A = actions(grid_world)
T = transition_matrices(grid_world)
R = reward_vectors(grid_world)
gamma = 0.95
epsilon = 1e-8
n_max = 1000 # Not used
gym = grid_world # Inputing for measurments

function value_iteration(S,A,T,R,gamma,epsilon,n_max,gym)
    # Value_iteration function for the grid search algorithm
    # Julian Lema 
    #=
    Inputs:
    S - States possible 
    A - Actions possible (left,right,etc.)
    T - Transition Function 
    R - Column Vector of the Rewards
    gamma - Scalar of given discount factor
    epsilon - tolerance for convergence
    n_max = Max iterations if we do not converge under epsilon
    =#
    
    # Initialize everything first
    V = rand(length(states(gym)))
    V_prime = rand(length(states(gym)))
    

    while maximum(abs.(V-V_prime)) > epsilon
        V = V_prime # Switch em'
        Vhold = fill(-Inf,length(S)) # Make -Inf so will be overwritten no matter what

        for i in A # Iterate through action since we working with dicts
            Vhold = max.(Vhold,R[i] + gamma * T[i] * V_prime)
        end
        # Establish max and restart
        V_prime = Vhold
    end

    return V_prime
end

V_prime = value_iteration(S,A,T,R,gamma,epsilon,n_max,gym)

# # You can use the following commented code to display the value. If you are in an environment with multimedia capability (e.g. Jupyter, Pluto, VSCode, Juno), you can display the environment with the following commented code. From the REPL, you can use the ElectronDisplay package.
display(render(grid_world, color= V_prime ))
