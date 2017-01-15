setwd("~/workspace/r-analysis")

data <- read.csv(file("data/data_example1.csv", encoding = "Shift_JIS"))
sapporo <- subset(data, 都道府県 == 1)
sapporo <- transform(sapporo, kakou_jinkou=sapporo$総人口/500000)
sapporo <- transform(sapporo, kakou_kinyu=sapporo$金融保険業人口/10000)

H1 = sum(sapporo$kakou_jinkou^2)
H2 = sum(sapporo$kakou_jinkou)
H3 = H2
H4 = length(sapporo$kakou_jinkou)

v1 = sum(sapporo$kakou_jinkou * sapporo$kakou_kinyu)
v2 = sum(sapporo$kakou_kinyu)

H = matrix(c(H1, H2, H3, H4), 2, 2)
v = matrix(c(v1, v2), 2, 1)

HInv = solve(H)

ans = crossprod(HInv, v)