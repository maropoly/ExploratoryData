library(plyr)
library(ggplot2)
#Read data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#set Seed
set.seed(1)

#run tapply to merge NEI file and SCC file
PMItotalByYear <- tapply(NEI$Emissions, NEI$year, sum)

plot(names(PMItotalByYear), PMItotalByYear, type = "b",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),col ="green",
     at=c("1999", "2002", "2005", "2008"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))

#create copy of plot graph
par(mar=c(5.1,5.1,4.1,2.1))
dev.copy(png, file="plot1.png", width=720, height=480)
dev.off()