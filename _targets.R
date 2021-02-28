# _targets.R
library(targets)

source("1_functions/choice_func.R")
source("1_functions/learn_func.R")
source("1_functions/game_func.R")
source("1_functions/sim_func.R")
source("1_functions/plot_func.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse"))

list(
  ###  SIMULATION
  #set parameters
  tar_target(
    par_list,
    list(
      trials = 20,
      games = 20,
      p1 = .35,
      p2 = .65,
      ev0 = .5,
      ev_var0 = .25,
      sigN = .25,
      sigC = 0,
      alpha = 0.05,
      temp = 5
    )
  ),
  # simulate single subject (kalman)
  tar_target(
    kalman_sub,
    sim_kalman_sub(pars=par_list)
  ),
  ##these are single game examples
#   tar_target(
#     game_kalman,
#     kalman_game(trialNum = 20, pay1 = .35, pay2 = .65, ev0 = .5, ev_var0 = .25,
#               sigN = .25 ,sigC = 0)
# ),
#   tar_target(
#     game_plot,
#     plot_game(game_kalman)
#   )
  tar_target(
    delta_sub,
    sim_delta_sub(pars=par_list)
  ),
  ## TODO: get summaries
  # plot element
  tar_target(
    sub_plot_kalman,
    plot_games(df=kalman_sub, multiple=T, type='kalman',
               pay1=par_list$p1, pay2=par_list$p2)
  ),
  tar_target(
    sub_plot_delta,
    plot_games(df=delta_sub, multiple=T, type='delta',
               pay1=par_list$p1, pay2=par_list$p2)
  )

)
