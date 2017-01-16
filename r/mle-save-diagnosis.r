library(rstan)
library(ggmcmc)

load('../output/result.RData')

write.table(data.frame(summary(fit)$summary),
            file='../output/fit-summary.txt', sep='\t', quote=FALSE, col.names=NA)

ggmcmc(ggs(fit, inc_warmup=TRUE, stan_include_auxiliar=TRUE),
       file='../output/fit-traceplot.pdf', plot='traceplot')

ggmcmc(ggs(fit), file='../output/fit-ggmcmc.pdf')
