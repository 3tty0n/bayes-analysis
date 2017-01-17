summary <- read.csv("output/fit-summary.txt", sep="\t")
d <- read.csv("input/data_example1_fit.csv")

a.summary <- list()
b.summary <- list()

a.likelihood <- list()
b.likelihood <- list()


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
  a.likelihood[[x]] <- likelihood(x)[1]
  b.likelihood[[x]] <- likelihood(x)[2]
}

for (i in 3:9) {
  a.summary[[i - 2]] <- summary$mean[i]
}

for (j in 10:16) {
  b.summary[[j - 9]] <- summary$mean[j]
}

png("output/image/mle-mcmc.png", width=800, height=600)
par(mfrow=c(2, 4))
prefecture_list <- c("札幌市", "仙台市", "東京都", "名古屋市", "京都市", "大阪市", "福岡市")

for (i in 1:7) {
  pre <- subset(d, prefectures == i)
  pop.max <- max(pre$population)
  fin.max <- max(pre$finance)
  plot(pre$population, pre$finance,
       xlab="人口総数",
       ylab="金融保険業人口", 
       xlim=c(0.0, pop.max),
       ylim=c(0.0, fin.max))
  title(prefecture_list[[i]])
  abline(b=a.likelihood[[i]], a=b.likelihood[[i]], col="red")
  abline(b=a.summary[[i]], a=b.summary[[i]], col="blue")
  legend("topleft",
         legend=c("最尤推定", "階層ベイズ法"),
         lty=c(1, 1),
         col=c("red", "blue")
  )
}

png('output/image/mle-bar.png')
par(mfrow=c(2, 2))
barplot(unlist(a.summary), names.arg = c(1:7), col = "blue", main = "a(k) by Bayes")
barplot(unlist(b.summary), names.arg = c(1:7), col = "blue", main = "b(k) by Bayes")
barplot(unlist(a.likelihood), names.arg = c(1:7), col = "orange", main = "a(k) by ML")
barplot(unlist(b.likelihood), names.arg = c(1:7), col = "orange", main = "b(k) by ML")


dev.off()
