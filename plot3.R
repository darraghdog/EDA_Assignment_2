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


### Plot 3
### Question : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
### which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 

EmissType_Baltimore_yr <- as.data.frame(aggregate( Emissions ~ year + type, SCC[SCC$fips=="24510",], sum ))

png(file = "plot3.png", width = 480, height = 480)
ggplot(EmissType_Baltimore_yr, aes(x=year, y=Emissions, colour=type)) +
	geom_line(linetype="dashed", size = 1) +
	geom_point(shape=22, size=3, fill="white") +
	ylab("Amount of PM2.5 emitted, in tons") +
	ggtitle("Total Emissions types per year, Baltimore") +
	theme(plot.title = element_text(lineheight=10, face="bold", size=16))
dev.off()