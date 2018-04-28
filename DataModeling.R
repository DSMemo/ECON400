options(scipen = 999)

fred <- read.csv("./DATA/fred_data.csv")
fred_dateless <- fred[-1]

model_a <- lm(MORTG ~ ., data = fred_dateless)

summary(model_a)
