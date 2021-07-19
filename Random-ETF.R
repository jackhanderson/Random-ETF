library(quantmod)
library(rrapply)
library(stringr)
library(ggplot2)


#Maximum number of companies in each ETF. Usually averages to ~3/4 of the maximum
number_of_companies <- 100

term_length <- 1384

trial_data <- list()
trial_returns <- vector()
trial_volatility <- vector()
trial_size <- vector()
trial_sharpe <- vector()


setwd()
all_companies <- read.csv("symbols.csv")
all_companies <- subset(all_companies, Market.Cap!=0)
all_companies <- subset(all_companies, (Sector!='Finance') | (Industry!='Business Services'))
all_companies <- all_companies['Symbol']
all_companies <- as.vector(all_companies[,1])
all_companies <- trimws(all_companies)


spy <- data.frame(getSymbols('SPY', from='2016-01-01', to='2021-07-01', auto.assign=F))
spy_daily_price <- as.vector(spy[,6])
spy_tickers <- read.csv("constituents.csv")

spy_daily_return <- diff(log(spy_daily_price))
target_return <- 255*sum(spy_daily_return)/term_length
spy_daily_volatility <- sd(spy_daily_return)
target_volatility <- sqrt(255)*spy_daily_volatility
target_sharpe <- (target_return - .0144)/target_volatility




for(z in 1:100){
  
  
  
  tickers <- vector()
  
  company_data <- list()
  
  
  tickers<- sample(all_companies,number_of_companies)
  

  
  for (i in 1:number_of_companies){
    company_data[[i]] <- data.frame(getSymbols(tickers[i], from='2016-01-01', to='2021-07-01', auto.assign=F))
    company_data[[i]] <- na.omit(company_data[[i]])
  }
  
  
  
  for (i in 1:length(company_data)){
    if(nrow(company_data[[i]]) < term_length){
      company_data[[i]] <- list(NULL)
    }
  }
  
  
  company_data <- rrapply(company_data, condition = Negate(is.null), how = 'prune')
  
  
  initial <- vector()
  final <- vector()
  
  
  for (i in 1:length(company_data)){
    initial <- c(initial, company_data[[i]][1,6])
    final <- c(final, company_data[[i]][term_length,6])
  }
  
  
  daily_price <- vector()
  
  for (i in 1:term_length){
    sum <- 0
    for (j in 1:length(company_data)){
      sum <- sum + company_data[[j]][i,6]
    }
    daily_price <- c(daily_price, sum)
  }
  
  daily_return <- diff(log(daily_price))
  daily_volatility <- sd(daily_return)
  

  
  trial_data[[length(trial_data) + 1]] <- company_data
  trial_returns <- c(trial_returns, as.numeric(255*sum(daily_return)/term_length))
  trial_volatility <- c(trial_volatility, as.numeric(sqrt(255)*daily_volatility))
  trial_size <- c(trial_size, length(company_data))
  
  
}
 

for(i in 1:length(trial_returns)){
  trial_sharpe <- c(trial_sharpe, (trial_returns[i]-.0144)/trial_volatility[i])
}


winning_returns <- which(trial_returns >= target_return)
winning_sharpe <- which(trial_sharpe >= target_sharpe)

max_return <- max(trial_returns)
max_sharpe <- max(trial_sharpe)
max_volatility <- max(trial_volatility)

min_return <- min(trial_returns)
min_volatility <- min(trial_volatility)

max_return_index <- which(trial_returns == max_return)
max_sharpe_index <- which(trial_sharpe == max_sharpe)
min_volatility_index <- which(trial_volatility == min_volatility)



##Below code is used to analyze the winning ETF
# tickers_75 <- vector()
# 
# 
# 
# daily_price_75 <- vector()
# 
# for (i in 1:term_length){
#   sum <- 0
#   for (j in 1:73){
#     sum <- sum + trial_data[[75]][[j]][i,6]
#   }
#   daily_price_75 <- c(daily_price_75, sum)
# }
# daily_return_75 <- diff(log(daily_price_75))
# 
# 
##Plotting Results of W winning ETF vs SPY
# 
# y1 <- cumprod(1+daily_return_75)-1
# data <- data.frame(x,y1)
# y2 <- cumprod(1+spy_daily_return)-1
# data <- cbind(data,y2)
# date <- as.Date(rownames(head(trial_data[[75]][[1]],-11)))
# data <- cbind(data, date)
# 
# 
# 
# 
# ggplot(data, aes(x=date)) +
#   geom_line(aes(y=y1), color="black") +
#   geom_line(aes(y=y2), color="darkred") +
#   xlab("Date") +
#   ylab("Cumulative Return") +
#   theme(legend.position="left")
# 
#
##Finding individual returns for tickers inside of winning ETF
# individual_total_return <- vector()
# for(i in 1:length(trial_data[[75]])){
#   individual_total_return <- c(individual_total_return, log(trial_data[[75]][[i]][nrow(trial_data[[75]][[i]]),6]/trial_data[[75]][[i]][1,6]))
# }

