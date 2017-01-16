library(rstan)

d <- read.csv(file='../data/data_example1.csv')
sapporo <- subset(d, 都道府県 == 1)
sapporo <- transform(sapporo, kakou_jinkou=sapporo$総人口/500000)
sapporo <- transform(sapporo, kakou_kinyu=sapporo$金融保険業人口/10000)

data <- list(N=nrow(d), X=d$総人口/500000, Y=d$金融保険業人口/10000)
fit <- stan(file='model/mle.stan', data=data, seed=1234)

save.image(file='../output/result.RData')
