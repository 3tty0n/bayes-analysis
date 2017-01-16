data {
  int N;
  int K;
  real X[N];
  real Y[N];
  int<lower=1, upper=K> PRE[N];
}

parameters {
  real a0;
  real b0;
  real a[K];
  real b[K];
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

model {
  for (k in 1:K) {
    a[k] ~ normal(a0, s_a);
    b[k] ~ normal(b0, s_b);
  }

  for (n in 1:N) {
    Y[n] ~ normal(b[PRE[n]] + a[PRE[n]] * X[n], s_Y);
  }
}

