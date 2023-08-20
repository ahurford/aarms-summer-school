# Example simulation of a simple SIS model. Run several simulations.
library(markovchain)

# Source a file with a few helpful functions for plotting (nice axes labels, 
# crop figure)
source("functions_useful.R")

# Number of simulations to run
nb_sims = 100
# Final time
t_f = 100

# Total population
Pop = 100
# Initial number of infectious
I_0 = 1
# Parameters
gamma = 1/5
R_0 = 2.5
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

# Store the results in a list called SIMS
SIMS = list()
# Run nb_sims samples of the Markov chain
for (s in 1:nb_sims) {
  SIMS[[s]] <- markovchainSequence(n = t_f, 
                                   markovchain = mcSIS, 
                                   t0 = "I_1")
  # We need to do a bit of editing: states come out named, not numbered, so we
  # change this
  SIMS[[s]] <- as.numeric(gsub("I_", "", SIMS[[s]]))
}

# To compute temporal means, we need to convert the result into a table with
# time as rows and sims as columns
RESULTS = mat.or.vec(nr = t_f, nc = nb_sims)
for (s in 1:nb_sims) {
  RESULTS[,s] = SIMS[[s]]
}

# Find max of all sims for plotting
max_I = max(RESULTS)
# Find mean for each row
mean_I = apply(RESULTS, 1, mean)

# Now do the plot
for (s in 1:nb_sims) {
  if (s == 1) {
    plot(x = 1:t_f,
         y = RESULTS[,s],
         type = "l", lwd = 0.5, 
         ylim = c(0, max_I),
         col = ifelse(RESULTS[t_f, s] == 0, "dodgerblue4", "firebrick4"),
         xlab = "Time (days)", ylab = "Prevalence")
  } else {
    lines(x = 1:t_f,
          y = SIMS[[s]],
          type = "l", lwd = 0.5,
          col = ifelse(RESULTS[t_f, s] == 0, "dodgerblue4", "firebrick4"))
  }
}
lines(x = 1:t_f, y = mean_I, lwd = 2)