library(quantmod)
library(tidyr)

#This is the csv exported from gretl, I used it to check that the data was in fact the same
#Testing <- read.csv("./DATA/gretl_data.csv")

#List of symbols to fetch, my added variables are savingssl and nonrevns 
FRED_symbols <- c("MORTG", "FEDFUNDS", "CPIFABNS", "GDP", "TB3MS", "GS20", "SPCS10RSA", "SAVINGSL", "NONREVNS")

getSymbols.FRED(FRED_symbols, globalenv())


#This takes the many seperate xts objects and throws them in a list to make looping easier
FRED_data <- list(MORTG,FEDFUNDS,CPIFABNS,GDP,TB3MS,GS20,SPCS10RSA,SAVINGSL,NONREVNS)


FRED_data_trimmed <- vector("list",9)

#The xts objects are subsetted to the recommended date range using xts subsetting
for(x in 1:length(FRED_data)){
  FRED_data_trimmed[[x]] <- FRED_data[[x]]["1994/201609"]
}

FRED_combined <- 
  data.frame(cbind(FRED_data_trimmed[[1]],FRED_data_trimmed[[2]],FRED_data_trimmed[[3]],
      FRED_data_trimmed[[4]],FRED_data_trimmed[[5]],FRED_data_trimmed[[6]],
      FRED_data_trimmed[[7]],FRED_data_trimmed[[8]],FRED_data_trimmed[[9]]))

#Fills NA's in GDP with prior values
FRED_final <- fill(FRED_combined,GDP)


write.csv(FRED_final, file = "DATA/fred_data.csv")


