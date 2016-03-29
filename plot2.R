library(plyr)
library(ggplot2)
#Read data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#set Seed
set.seed(1)

#find total emisions for Baltimore city = 24510
baltimoreNEI <- NEI[NEI$fips=="24510",]
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

#create bar plot to show the trend
barplot(
        aggTotalsBaltimore$Emissions,
        names.arg=aggTotalsBaltimore$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        col= "slateblue",
        main="Total PM2.5 Emissions From All Baltimore City Sources"
)

dev.copy(png, file="plot2.png", width=640, height=640)
dev.off()
cat("Plot2.png has been saved in", getwd())
