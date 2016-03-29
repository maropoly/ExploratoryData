#include ggplot2 library

library(ggplot2)

## read data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

greps2<-unique(grep("mobile", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))  
#found out that i need only need greps2[1:4]
baltimore<-subset(NEI, NEI$fips==24510)     
Gas_Heavy<-subset(SCC, EI.Sector %in% greps2[1])  #Subset SCC by Vehicle Type
Gas_Light<-subset(SCC, EI.Sector %in% greps2[2])
Diesel_Light<-subset(SCC, EI.Sector %in% greps2[3])
Diesel_Heavy<-subset(SCC, EI.Sector %in% greps2[4])

#Subsetting Baltimore by SCC retaining vehicle type 
gasHeavy<-subset(baltimore, SCC %in% Gas_Heavy$SCC)   
gasLight<-subset(baltimore, SCC %in% Gas_Light$SCC)
dieselLight<-subset(baltimore, SCC %in% Diesel_Light$SCC)
dieselHeavy<-subset(baltimore, SCC %in% Diesel_Heavy$SCC)

#Add vehicle type column to NEI 
vehicle1<-data.frame(gasHeavy, vehicle="Gas - Heavy Duty")     
vehicle2<-data.frame(gasLight, vehicle="Gas - Light Duty")
vehicle3<-data.frame(dieselLight, vehicle="Diesel - Light Duty")
vehicle4<-data.frame(dieselHeavy, vehicle="Diesel - Heavy Duty")
totalvehicle<-rbind(vehicle1, vehicle2, vehicle3, vehicle4) 

ggplot(data=totalvehicle, aes(x=year, y=Emissions, fill=vehicle)) +
        geom_bar(stat="identity", position=position_dodge()) +
        ggtitle("Vehicle-Related Emissions in Baltimore 1999-2008")



dev.copy(png, file="plot5.png", width=640, height=640)
dev.off()
cat("Plot5.png has been saved in", getwd())
