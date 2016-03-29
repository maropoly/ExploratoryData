library(ggplot2)

#Read data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#set Seed
set.seed(1)

plot3 <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(plot3)

dev.copy(png, file="plot3.png", width=640, height=640)
dev.off()
cat("Plot3.png has been saved in", getwd())
