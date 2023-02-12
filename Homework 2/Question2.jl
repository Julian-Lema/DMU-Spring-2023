using DMUStudent.HW2
using POMDPs: states, actions
using POMDPTools: ordered_states
using LinearAlgebra

##############
# Question 2 
##############


# Create a state and an action matrix
# First row = State | Second Row = Action (1 = roll , 0 = reset)
Q = [1 2 3; 1 0 0]

# Create a transition Matrixs
T = [0 0.5 0.5; 1 0 0 ; 1 0 0]

# Reward Matrix 
R = [0 ; 2 ; -1] # Reward given in order of what actions we would take at each step

# Conditions for value_iteration function 
discount = 0.95
epsilon = 1e-10
max_iterations = 500
function ValueIteration(T, R, gamma, epsilon, n_max)
    # Julian Lema 
    #=
    Inputs;
    T - Transition Function 
    R - Column Vector of the Rewards
    gamma - Scalar of given discount factor
    epsilon - tolerance for convergence
    n_max = Max iterations if we do not converge under epsilon
    =#
    V = zeros(size(R, 1))
    i = 0 # Iteration

    # Repeat until convergence or maximum iterations are reached
    while i < n_max
        i = i + 1 # Update counter
        V_new = R + gamma * T * V

        # Check for convergence
        if norm(V_new - V, Inf) < epsilon #Infinity norm
            break
        end

        V = V_new
    end

    return V, i
end
ValueIteration(T, R, discount, epsilon, max_iterations)
