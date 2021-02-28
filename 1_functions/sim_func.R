#SET PARAMETERS
sim_kalman_sub <-function(pars) {

  for (g in 1:pars$games) {
    game = kalman_game(trialNum = pars$trials,
                      pay1 = pars$p1,
                      pay2 = pars$p2,
                      temp = pars$temp,
                      ev0 = pars$ev0,
                      ev_var0 = pars$ev_var0,
                      sigN = pars$sigN,
                      sigC = pars$sigC)
    game$game = rep(g, nrow(game))
    if (g==1) out = game else out = bind_rows(out, game)
  }
  return (out)
}

sim_delta_sub <-function(pars) {

  for (g in 1:pars$games) {
    game = delta_game(trialNum = pars$trials,
                       pay1 = pars$p1,
                       pay2 = pars$p2,
                       temp = pars$temp,
                       ev0 = pars$ev0,
                       alpha = pars$alpha)
    game$game = rep(g, nrow(game))
    if (g==1) out = game else out = bind_rows(out, game)
  }
  return (out)
}
