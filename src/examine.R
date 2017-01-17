d <- read.csv('input/data_example2.csv')
X <- d$under15.man / d$population
K <- 47
d <- transform(d, ratio=X)

variance <- function(x) var(x)*(length(x)-1)/length(x)

m0 <- mean(X)
s0 <- sqrt(variance(X))

Y <- c()
for (k in 1:K) {
  p <- subset(d, d$number == k)
  ratio.sum <- sum(p$ratio)
  Y <- append(Y, c(ratio.sum))
}

M <- mean(Y)
S <- sqrt(variance(Y))
Z <- list()
for (k in 1:K) {
  Z <- append(Z, (Y[k] - M)/S)
}

result <- list()
for (k in 1:K) {
  if (abs(unlist(Z)[k]) > 2.58) {
    result <- append(result, c(k, Z[k]))
  }
}

print(result)