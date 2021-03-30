
genConfChecks <- function(numGames=20) {
  numGames = 20
  mats = matrix(NA, 0,5) # subject output matrix
  #difs = 0
  for (g in 1:(numGames/4)) {
    difs <- 0
    print (g)
    while (min(difs)<2) {
      # set initially equally-spaced samples & randomize
      mat = cbind(c(1:4), sample(5:8), sample(9:12), sample(13:16), sample(17:20))
      # check if any subsequent trials were sampled in a game
      difs = apply(mat, 1, diff)
      #if not, add game
      if (min(difs>1)) mats = rbind(mats, mat)
    }
    #sanity check
    if (min(apply(mats, 1, diff)) < 2) {
      bad_cords = which(mats==1, arr.ind=T)
      mes = paste('2 subseqent trials in game', g, 'row',bad_cords[1,1], 'column', bad_cords[1,2])
      stop(mes)
    }
  }
  return (mats)
}

checkConfMat <-function(confMat) {
  if (min(apply(mats, 1, diff)) < 2) {
    bad_cords = which(mats==1, arr.ind=T)
    mes = paste('2 subseqent trials in game', g, 'row',bad_cords[1,1], 'column', bad_cords[1,2])
  }
  else {
    mes = 'Everything is fine!'
  }

  return (mes)
}
