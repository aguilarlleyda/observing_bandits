softmax <- function(vals, temperature) {
  #vals: vector [2] with estimates for the two options
  p1 <- exp(vals[1]*temperature)
  p2 <- exp(vals[2]*temperature)
  prob <- p1/sum(p1,p2)
  return(prob)
}

softmax2 <- function(vals, temperature) {
  #vals: vector [2] with estimates for the two options
  diff = vals[2]-vals[1]
  prob <- 1/(1+exp(diff/temperature))
  return(prob)
}


