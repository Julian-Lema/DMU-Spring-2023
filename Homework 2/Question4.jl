using DMUStudent.HW2
using POMDPs: states, actions
using POMDPTools: ordered_states
using LinearAlgebra

############
# Question 4
############
# Inputs
 
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
# You can create an mdp object representing the problem with the following:
gym = UnresponsiveACASMDP(7)
S = states(gym)
A = actions(gym)
T = transition_matrices(gym, sparse = true)
R = reward_vectors(gym)
gamma = 0.99
epsilon = 1e-8
n_max = 1000 # Not used

V = value_iteration(S,A,T,R,gamma,epsilon,n_max,gym)

@show HW2.evaluate(V,"julian.lemabulliard@colorado.edu")