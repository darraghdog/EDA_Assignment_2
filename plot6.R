######################################################################
#                                                                #####
# A study of Fine particulate matter (PM2.5) emissions in the US #####
# Data source : EPA releases its database on emissions of PM2.5. #####
#                                                                #####
######################################################################

library(ggplot2)
library(plyr)
library(quantmod)

filepath_SCC <- "~/R/exdata-data-NEI_data/summarySCC_PM25.rds"
filepath_NEI <- "~/R/exdata-data-NEI_data/Source_Classification_Code.rds"

NEI <- readRDS(filepath_NEI)
SCC <- readRDS(filepath_SCC)

### Plot 6
### Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California. 
### Which city has seen greater changes over time in motor vehicle emissions?
### Assumption that percentage changes have been shown over time instead of actual values.


em_city <- as.data.frame(aggregate( Emissions ~ year + type + fips, SCC[(SCC$fips=="24510" | SCC$fips=="06037") & SCC$type=="ON-ROAD",], sum ))
for(i in unique(em_city$fips)) {
	print(i)
	em_city$PercentChg[em_city$fips==i] <- 100 * (em_city$Emissions[em_city$fips==i] - em_city$Emissions[em_city$year=="1999"& em_city$fips==i]) / em_city$Emissions[em_city$year=="1999"& em_city$fips==i]
}

png(file = "plot6.png", width = 480, height = 480)
ggplot(em_city, aes(x=year, y=PercentChg, colour=fips)) +
	geom_line(linetype="dashed", size = 1) +
	geom_point(shape=22, size=3, fill="white") +
	scale_colour_manual("US County",values=c("red", "blue"), label=c("Los Angeles County,\nCalifornia\n", "Baltimore City,\nMaryland\n")) + 
	ylab("% change in amount of PM2.5 emitted") +
	ggtitle("Change motor vehicles emissions per year (%)") +
	theme(plot.title = element_text(lineheight=10, face="bold", size=16)) 
dev.off()