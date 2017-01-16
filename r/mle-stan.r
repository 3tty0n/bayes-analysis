library(rstan)

d <- read.csv(file='../data/data_example1.csv')
sapporo <- subset(d, prefecture == 1)
sapporo <- transform(sapporo, kakou_jinkou=sapporo$population/500000)
sapporo <- transform(sapporo, kakou_kinyu=sapporo$finance/10000)

data <- list(N=nrow(d), X=d$population/500000, Y=d$finance/10000)
fit <- stan(file='model/mle.stan', data=data, seed=1234)

save.image(file='../output/result.RData')
