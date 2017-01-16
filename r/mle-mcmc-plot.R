summary <- read.csv("output/fit-summary-2.txt", sep="\t")
d <- read.csv("input/data_example1_fit.csv")

a_sum <- list()
b_sum <- list()

a_lik <- list()
b_lik <- list()


likelihood <- function(x) {
  prefecture <- subset(d, prefectures == x)
  
  H1 = sum(prefecture$population^2)
  H2 = sum(prefecture$population)
  H3 = H2
  H4 = length(prefecture$population)
  
  v1 = sum(prefecture$population * prefecture$finance)
  v2 = sum(prefecture$finance)
  
  H = matrix(c(H1, H2, H3, H4), 2, 2)
  v = matrix(c(v1, v2), 2, 1)
  
  HInv = solve(H)
  
  crossprod(HInv, v)
}

for (x in 1:7) {
  a_lik[[x]] <- likelihood(x)[1]
  b_lik[[x]] <- likelihood(x)[2]
}

for (i in 3:9) {
  a_sum[[i - 2]] <- summary$mean[i]
}

for (j in 10:16) {
  b_sum[[j - 9]] <- summary$mean[j]
}

png("output/image/mle-mcmc-2.png", width=800, height=600)
par(mfrow=c(2, 4))
prefecture_list <- c("札幌市", "仙台市", "東京都", "名古屋市", "京都市", "大阪市", "福岡市")

for (i in 1:7) {
  pre <- subset(d, prefectures == i)
  plot(pre$population, pre$finance)
  title(prefecture_list[[i]])
  abline(b=a_lik[[i]], a=b_lik[[i]], col="blue")
  abline(b=a_sum[[i]], a=b_sum[[i]], col="red")
}

dev.off()
