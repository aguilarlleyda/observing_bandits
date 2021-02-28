kalman <- function(vals, vars, num_chosen, reward, sigma_noise, sigma_change) {
  # vars: variances vector
  # num_chosen: number of chosen bandit (1 or 2)

  # set the Kalman gain for unchosen options
  kt <- rep(0,2)
  # set the Kalman gain for the chosen option
  kt[num_chosen] <- (vars[num_chosen] +
                       sigma_change)/(vars[num_chosen] +
                                        sigma_change + sigma_noise)
  #print (kt)
  # compute the posterior means
  vals_out <- vals + kt*(reward - vals)
  # compute posterior variances
  vars_out <- (1-kt)*(vars + sigma_change)

  out = list(vals_out, vars_out)
  return(out)
}

