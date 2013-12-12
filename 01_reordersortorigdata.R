##========================
##Homework #6 R Script 1
##========================
  
## Import the Gapminder data
gDat <- read.delim("gapminderDataFiveYear.txt")

## Basic sanity check that the import went smoothly
str(gDat)

## Load the required packages
library(plyr)  #needed for data aggregation tasks
library(ggplot2)  #needed for plots

## Take Oceania out of the data set because it only has two countries
#(snippet <- subset(gDat, continent == "Oceania"))  #just to confirm
hDat <- droplevels(subset(gDat, continent != "Oceania"))
#check out hDat
str(hDat)
head(hDat)
tail(hDat)

## Make and save a couple descriptive plots to file

#Barplot of average life expectancy for each continent
avglifeExp <- ddply(hDat, ~continent, summarize, meanLifeExp = mean(lifeExp))
ggplot(avglifeExp, aes(y = meanLifeExp, x = continent)) + geom_bar() + 
  ggtitle("Mean Life Expectancy By Continent") + ylab("Life Expectancy (Years)") + 
  xlab("Continent")
ggsave("barplot_meanlifeExp.png")

#Lineplot of average life expectancy over time for each continent
avglifeExpTall <- ddply(hDat, ~continent ~ year, summarize, factor = c("Mean"), 
                        LifeExp = c(meanLifeExp = mean(lifeExp)))
ggplot(avglifeExpTall, aes(y = LifeExp, x = year, color = continent)) + geom_line() + 
  ggtitle("Mean Life Expectancy Over Time By Continent") + ylab("Life Expectancy (Years)") + 
  xlab("Year")
ggsave("lineplot_meanlifeExpOverTime.png")

#Barplot of average GDP per capita for each continent
avggdpPercap <- ddply(hDat, ~continent, summarize, meanGDPpercap = mean(gdpPercap))
ggplot(avggdpPercap, aes(y = meanGDPpercap, x = continent)) + geom_bar() + 
  ggtitle("Mean GDP Per Capita By Continent") + ylab("GDP Per Capita ($)") + 
  xlab("Continent")
ggsave("barplot_meanGDPpercap.png")

#Lineplot of average GDP per capita over time for each continent
avggdpPercapTall <- ddply(hDat, ~continent ~ year, summarize, factor = c("Mean"), 
                          GDPpercap = c(meanGDPpercap = mean(gdpPercap)))
ggplot(avggdpPercapTall, aes(y = GDPpercap, x = year, color = continent)) + geom_line() + 
  ggtitle("Mean GDP Per Capita Over Time By Continent") + ylab("GDP Per Capita ($)") + 
  xlab("Year")
ggsave("lineplot_meanGDPpercapOverTime.png")

#Scatterplots illustrating relationship between life expectancy and GDP per capita over time for each continent
ggplot(hDat, aes(x = gdpPercap, y = lifeExp)) + geom_point() + facet_wrap(~ continent) + 
  scale_x_log10() + ggtitle("Life Expectancy vs. GDP Per Capita By Continent") + 
  ylab("Life Expectancy (Years)") + xlab("GDP Per Capita (Log)")
ggsave("scatterplot_lifeExpGDPpercap.png")

## Reorder the continents based on mean life expectancy in ascending order
rDat <- within(hDat, continent <- reorder(continent, lifeExp, mean))

## Sort the actual data
rDat <- arrange(rDat, continent)
#check out rDat
str(rDat)
head(rDat)
tail(rDat)

## Write the reordered Gapminder data to file
write.table(rDat, "gapminderDataReorderedCont.txt", quote = FALSE, sep = "\t", row.names = FALSE)


