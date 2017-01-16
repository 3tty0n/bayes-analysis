data <- read.csv("output/fit-summary-2.txt", sep="\t")
d <- read.csv("input/data_example1_fit.csv")

a <- list()
b <- list()

for (i in 3:9) {
  a[[i - 2]] <- data$mean[i]
}

for (j in 10:16) {
  b[[j - 9]] <- data$mean[j]
}

png('output/image/fit-2.png', width = 800, height = 600)
par(mfrow=c(2, 4))
prefecture_list <- c("札幌市", "仙台市", "東京都", "名古屋市", "京都市", "大阪市", "福岡市")

for (i in 1:7) {
  pre <- subset(d, prefectures == i)
  plot(pre$population, pre$finance)
  title(prefecture_list[[i]])
  abline(b=a[[i]], a=b[[i]], col="red")
}

dev.off()
