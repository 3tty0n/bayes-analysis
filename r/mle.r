data <- read.csv(file("input/data_example1_fit.csv"))

likelihood <- function(x) {
    prefecture <- subset(data, prefectures == x)

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

a <- list()
b <- list()
for (x in 1:7) {
    a[[x]] <- likelihood(x)[1]
    b[[x]] <- likelihood(x)[2]
}

png("output/image/mle.png", width=800, height=600)
par(mfrow=c(2, 4))
prefecture_list <- c("札幌市", "仙台市", "東京都", "名古屋市", "京都市", "大阪市", "福岡市")

for (i in 1:7) {
    pre <- subset(data, prefectures == i)
    plot(pre$population, pre$finance)
    title(prefecture_list[[i]])
    abline(b=a[[i]], a=b[[i]], col="blue")
}

dev.off()