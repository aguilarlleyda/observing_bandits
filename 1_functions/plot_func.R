plot_games <- function (df, type = 'kalman', multiple, pay1, pay2, games_in=list()) {

  # df: output of a sim function (dataframe)
  # type: either 'kalman' or 'delta'
  # multiple: whether plot multiple games  (bool)
  # pay1, pay2: bandit mean payouts
  # games_in: subset of games to plot (numeric list)

  #selecting a subset of games
  if (length(games_in)>0) df <- df %>% filter(game %in% game)

  p = ggplot(df) +
    aes(x = trial, y = ev1) +
    geom_line(size = 1L, colour = "#0c4c8a") +
    geom_line(aes(y = ev2), size = 1L, colour = "orange") +
    geom_hline(yintercept = pay1, color = "#0c4c8a", linetype = 'dashed', alpha = .5) +
    geom_hline(yintercept = pay2, color = "orange", linetype = 'dashed', alpha = .5) +
    geom_point(aes(y=outcome, color=as.factor(choice))) +
    scale_color_manual(values = c("#0c4c8a", 'orange')) +
    labs(y = 'Expected Reward', colour = 'Bandit') +
    theme_classic()

  if (type == 'kalman') {
    p = p +
      geom_ribbon(aes(ymin=ev1-ev_var1, ymax=ev1+ev_var1),fill='#0c4c8a', alpha=.3) +
      geom_ribbon(aes(ymin=ev2-ev_var2, ymax=ev2+ev_var2),fill='orange', alpha=.3)
  }

  if (multiple==T) {
    p = p +
      facet_wrap(~game)
  }
  p
}
