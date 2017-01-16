library(rstan)
library(ggmcmc)

load('output/result-bayes-mcmc-2.RData')

write.table(data.frame(summary(fit)$summary),
            file='output/fit-summary-2.txt', sep='\t', quote=FALSE, col.names=NA)

ggmcmc(ggs(fit, inc_warmup=TRUE, stan_include_auxiliar=TRUE),
       file='output/fit-traceplot-2.pdf', plot='traceplot')

ggmcmc(ggs(fit), file='output/fit-ggmcmc-2.pdf')

dev.off()
