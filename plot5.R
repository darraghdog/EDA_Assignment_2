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

### Plot 5
### How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
### Assumption that motor vehicles are represented by the data classed as "ON-ROAD" SCC type

png(file = "plot5.png", width = 480, height = 480)
ggplot(EmissType_Baltimore_yr[EmissType_Baltimore_yr$type=="ON-ROAD",], aes(x=year, y=Emissions, colour=type)) +
	geom_line(linetype="dashed", size = 1) +
	geom_point(shape=22, size=3, fill="white") +
	scale_colour_manual("Emission type",values=c("red")) +
	ylab("Amount of PM2.5 emitted, in tons") +
	ggtitle("Emissions per year, Baltimore") +
	theme(plot.title = element_text(lineheight=10, face="bold", size=16))
dev.off()