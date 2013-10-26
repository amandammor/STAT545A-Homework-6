=======================
Homework #6 R Script 2
=======================

## Import the reordered Gapminder data
rDat <- read.delim("gapminderDataReorderedCont.txt")  
str(rDat)

## Quick check that the new continent order is still in force
head(rDat)
tail(rDat)

## Load packages
library(plyr)
library(ggplot2)

## Linear regression of life expectancy on year within each country. 

#Define earliest year (intercept)
(minYear <- min(rDat$year))

#Fit linear regression
rFit <- lm(lifeExp ~ I(year - minYear), rDat)

summary(rFit)  #display summary stats
coef(rFit)  #display coefficients

#Package into new function
rFun <- function(x) {
  estCoefs <- coef(lm(lifeExp ~ I(year - minYear), x))
  estResidErrors <- summary(lm(lifeExp ~ I(year - minYear), x))$sigma
  estCoefsREs <- c(estCoefs, estResidErrors)
  names(estCoefsREs) <- c("intercept", "slope", "residual error")
  return(estCoefsREs)
}

#Try new function
rFun(rDat)  #it works!

#Place function inside ddply() call
rCoefs <- ddply(rDat, ~country + continent, rFun)
str(rCoefs)
head(rCoefs)
tail(rCoefs)

## Write the estimated coefficients to file

#Arrange the data
rCoefs <- arrange(rCoefs, continent)

#Write to file
write.table(rCoefs, "gapminderDataReorderedContCoefs.txt", quote = FALSE,
            sep = "\t", row.names = FALSE)

## Find the 3 or 4 "worst" and "best" countries for each continent

#Highest intercepts for each continent
(BestIntercepts <- ddply(rCoefs, ~ continent, summarize, highestInt = max(intercept), country = country[which.max(intercept)]))

#Lowest intercepts for each continent
(WorstIntercepts <- ddply(rCoefs, ~ continent, summarize, lowestInt = min(intercept), country = country[which.min(intercept)]))

#Highest and lowest intercepts for each continent
(BestWorstIntercepts <- ddply(rCoefs, ~continent, summarize, highestInt = max(intercept), bestcountry = country[which.max(intercept)], lowestInt = min(intercept), worstcountry = country[which.min(intercept)]))

## Write linear regression info for best and worst countries to file

#Subset with just countries with best and worst intercepts in each continent
(bwDat <- subset(rDat, country == "Mauritius" | country == "Canada" | country == "Israel" | country == "Norway" | 
                   country == "Gambia" | country == "Bolivia" | country == "Afghanistan" | country == "Turkey"))

#Write subset to file
write.table(bwDat, "gapminderDataBestWorst.txt", quote = FALSE,
            sep = "\t", row.names = FALSE)

#Fit linear regression
bwFit <- lm(lifeExp ~ I(year - minYear), bwDat)
summary(bwFit)
coef(bwFit)

#Use new function
rFun(bwDat)  #it works!

#Place function inside ddply() call
bwCoefs <- ddply(bwDat, ~country + continent, rFun)
str(bwCoefs)
head(bwCoefs)
tail(bwCoefs)

#Arrange the data
bwCoefs <- arrange(bwCoefs, continent)

#Write to file
write.table(bwCoefs, "gapminderDataBestWorstCoefs.txt", quote = FALSE,
            sep = "\t", row.names = FALSE)

## Scatterplots displaying life expectancy versus year for countries with best and worst intercepts

#Africa
ggplot(subset(bwDat, continent == "Africa"), aes(y = lifeExp, x = year)) + geom_point() + 
  facet_wrap(~ country) + ggtitle("Best and Worst Countries in Africa") + geom_smooth(method = "lm")
ggsave("BestWorstInterceptsAfrica.png")

#Americas
ggplot(subset(bwDat, continent == "Americas"), aes(y = lifeExp, x = year)) + geom_point() + 
  facet_wrap(~ country) + ggtitle("Best and Worst Countries in Americas") + geom_smooth(method = "lm")
ggsave("BestWorstInterceptsAmericas.png")

#Asia
ggplot(subset(bwDat, continent == "Asia"), aes(y = lifeExp, x = year)) + geom_point() + 
  facet_wrap(~ country) + ggtitle("Best and Worst Countries in Asia") + geom_smooth(method = "lm")
ggsave("BestWorstInterceptsAsia.png")

#Europe
ggplot(subset(bwDat, continent == "Europe"), aes(y = lifeExp, x = year)) + geom_point() + 
  facet_wrap(~ country) + ggtitle("Best and Worst Countries in Europe") + geom_smooth(method = "lm")
ggsave("BestWorstInterceptsEurope.png")
