#include ggplot2 library

library(ggplot2)

## read data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")



# The first thing i need to do is Subset coal combustion related NEI data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

plot4 <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="sienna3",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(plot4)
#copy png into folder 
dev.copy(png, file="plot4.png", width=640, height=640)
dev.off()
cat("Plot4.png has been saved in", getwd())
