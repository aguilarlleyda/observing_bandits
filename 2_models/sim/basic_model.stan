
data {
  int<lower=0> numGames;
  int<lower=0> numChoices;
  int<lower=1, upper=2> choice[numGames, numChoices]; // 1->left; 2->right
  int<lower=0> outcome[numGames, numChoices];

}

parameters {
  real alpha_raw; // learning rate
  real<lower=0> temp_raw; // inverse temperature
}

transformed parameters {
  // subject-level parameters
  real<lower=0, upper=1> alpha;
  real<lower=0, upper=5> temp;

  alpha   = Phi_approx(alpha_raw);
  temp = Phi_approx(temp_raw) * 5;
}

model {
  vector[2] ev; // expected value
  real PE;      // prediction error

  // priors
  alpha_raw ~ normal(0,1);
  temp_raw ~ normal(0,1);

  for (g in 1:numGames) {
    // initialize values
    ev = rep_vector(0.5,2);

    for (t in 1:numChoices) {
      // action probabilities
      choice[g,t] ~ categorical_logit(temp * ev);
      // prediction error
      PE = outcome[g, t] - ev[choice[g, t]];
      // value update
      ev[choice[g, t]] += alpha * PE;
    }
  }
}

