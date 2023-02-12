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
max_iterations = 300
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
        if norm(V_new - V,Inf) < epsilon #Infinity norm
            break
        end

        V = V_new
    end

    return V[1], i
end

ValueIteration(T, R, discount, epsilon, max_iterations)


############
# Question 3
############


S = states(grid_world)
A = actions(grid_world)
T = transition_matrices(grid_world)
R = reward_vectors(grid_world)
gamma = 0.95
epsilon = 1e-10
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
    n_max = Max iterations if we do not converge under epsilon (Not Used)
    gym - this in inputting the environment into the function so we can call states on it
    =#
    
    # Initialize everything first
    V = rand(length(states(gym)))
    V_prime = rand(length(states(gym)))
    

    while maximum(abs.(V-V_prime)) > epsilon
        V = V_prime # Switch em'
        Vhold = fill(-Inf,length(S)) # Make -Inf so will be overwritten no matter what

        for i in A # Iterate through action since we working with dicts
            Vhold = max.(Vhold,R[i] + gamma * T[i] * V_prime) # Find max of iterations
        end
        # Establish max and restart
        V_prime = Vhold # Store max and repeat if needed
    end

    return V_prime # Output optimal policy
end

V_prime = value_iteration(S,A,T,R,gamma,epsilon,n_max,gym)
# # You can use the following commented code to display the value. If you are in an environment with multimedia capability (e.g. Jupyter, Pluto, VSCode, Juno), you can display the environment with the following commented code. From the REPL, you can use the ElectronDisplay package.
display(render(grid_world, color= V_prime ))

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
gym = UnresponsiveACASMDP(15)
S = states(gym)
A = actions(gym)
T = transition_matrices(gym, sparse = true)
R = reward_vectors(gym)
gamma = 0.99
epsilon = 1e-8
n_max = 1000 # Not used

V = value_iteration(S,A,T,R,gamma,epsilon,n_max,gym)

@show HW2.evaluate(V,"julian.lemabulliard@colorado.edu")