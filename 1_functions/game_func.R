
delta_game <- function(trialNum, pay1, pay2, ev0 = 0.5, alpha, temp) {
  ##TODO: info-bonus;

  choice = reject = rep(-1,trialNum)
  outcomes = cbind(rbinom(trialNum, 1, pay1),
                   rbinom(trialNum, 1, pay2))
  observed_outcomes = rep(-1, trialNum)
  ev = matrix(ev0, trialNum, 2)


  for (t in 1:trialNum) {

    #update
    if(t>1) {
      ev[t,choice[t-1]] = ev[t-1,choice[t-1]] + pe * alpha
      ev[t,reject[t-1]] = ev[t-1,reject[t-1]]
    }
    #choose
    prob1 = softmax(ev[t,], temp) # probability of choosing bandit 1
    choice[t] = rbinom(1,1, (1-prob1)) +1 # 1-> left; 2->right
    if (choice[t] == 1) reject[t] = 2
    if (choice[t] == 2) reject[t] = 1
    #update (delta)
    observed_outcomes[t] = outcomes[t, choice[t]]
    pe = observed_outcomes[t] - ev[t,choice[t]]

  } # t loop

  out = tibble(
    ev1 = ev[,1],
    ev2 = ev[,2],
    choice = choice,
    outcome = observed_outcomes,
    trial = 1:trialNum)
}


kalman_game<-function(trialNum, pay1, pay2, temp=1, ev0 = 0.5, ev_var0, sigN, sigC){

  choice = reject = rep(-1,trialNum)
  outcomes = cbind(rbinom(trialNum, 1, pay1),
                   rbinom(trialNum, 1, pay2))
  observed_outcomes = rep(-1, trialNum)
  ev = matrix(ev0, trialNum, 2)
  ev_var = matrix(ev_var0, trialNum, 2)

  # update (kalman)
  for (t in 1:trialNum) {

    #update beliefs
    if (t>1) {
      ev[t,] = updated_preds[[1]]
      ev_var[t,] = updated_preds[[2]]
    }
    #choose
    prob1 = softmax(ev[t,], temp) # probability of choosing bandit 1
    choice[t] = rbinom(1,1, (1-prob1)) +1 # 1-> left; 2->right


    if (choice[t] == 1) reject[t] = 2
    if (choice[t] == 2) reject[t] = 1
    observed_outcomes[t] = outcomes[t, choice[t]]

    #fit kalman
    updated_preds = kalman(vals = ev[t,], vars = ev_var[t,],
                           num_chosen = choice[t],
                           reward = observed_outcomes[t],
                           sigma_noise = sigN,
                           sigma_change = sigC)
  } # t-loop

  out = tibble(
    ev1 = ev[,1],
    ev2 = ev[,2],
    ev_var1 = ev_var[,1],
    ev_var2 = ev_var[,2],
    choice = choice,
    outcome = observed_outcomes,
    trial = 1:trialNum)

}
