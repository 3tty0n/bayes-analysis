library('ggplot2')

d <- read.csv('input/data_example2.csv')
X <- d$under15man / d$population
K <- 47
d <- transform(d, ratio=X)

variance <- function(x) var(x) * (length(x) - 1) / length(x)

m0 <- mean(X)
s0 <- sqrt(variance(X))

print(m0)
print(s0)

Y <- c()
for (k in 1:K) {
  p <- subset(d, d$number == k)
  ratio.sum <- sum(p$ratio)
  Y <- append(Y, c(ratio.sum))
}
plot(abs(Y), main = "Y")

M <- mean(Y)
S <- sqrt(variance(Y))
Z <- list()
for (k in 1:K) {
  Z <- append(Z, (Y[k] - M)/S)
}
Z <- unlist(Z)
plot(abs(Z), main = "Z")
hist(Z, col="#993435")

result <- list()
for (k in 1:K) {
  if (abs(Z[k]) > 2.58) {
    result <- append(result, c(k, Z[k]))
  }
}

print(result)