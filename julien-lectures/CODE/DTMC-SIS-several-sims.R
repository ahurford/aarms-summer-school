# Example simulation of a simple SIS model. Run several simulations.
library(markovchain)

# Source a file with a few helpful functions for plotting (nice axes labels, 
# crop figure)
source("functions_useful.R")

# Total population
Pop = 100
# Initial number of infectious
I_0 = 1
# Parameters
gamma = 1/5
R_0 = 1.5
# R0 would be (beta/gamma)*S0, so beta=R0*gamma/S0
beta = R_0*gamma/(Pop-I_0)
# Time step
Delta_t = 1

# Make the transition matrix
T = mat.or.vec(nr = (Pop+1), nc = (Pop+1))
for (row in 2:Pop) {
  I = row-1
  mv_right = gamma*I*Delta_t # Recoveries
  mv_left = beta*I*(Pop-I)*Delta_t # Infections
  T[row,(row-1)] = mv_right
  T[row,(row+1)] = mv_left
}
# Last row only has move left
T[(Pop+1),Pop] = gamma*(Pop)*Delta_t
# Check that we don't have too large values
if (max(rowSums(T))>1) {
  T = T/max(rowSums(T))
}
diag(T) = 1-rowSums(T)

# Create the Markov chain object
mcSIS <- new("markovchain", 
             states = sprintf("I_%d", 0:Pop),
             transitionMatrix = T,
             name = "SIS")

