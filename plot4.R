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

### Plot 4
### Question : Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
### Assumption : Coal is represented by any SCC level threes containing coal or lignite in the description.
### Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

NEI_coal_comb <- NEI[grepl("coal", NEI$SCC.Level.Three, ignore.case=TRUE) | grepl("Lignite", NEI$SCC.Level.Three, ignore.case=TRUE),]
SCC_US_coal <- merge(SCC, NEI_coal_comb, by.x="SCC", by.y="SCC", all=FALSE)
SCC_US_coal_yr <- as.data.frame(aggregate( Emissions ~ year, SCC_US_coal, sum ))

png(file = "plot4.png", width = 480, height = 480)
ggplot(SCC_US_coal_yr, aes(x=year, y=Emissions)) +
	geom_line(linetype="dashed", size = 1, col="blue") +
	geom_point(shape=22, size=3, fill="white") +
	ylab("Amount of PM2.5 emitted, in tons") +
	ggtitle("Total coal combustion-related emissions, US") +
	theme(plot.title = element_text(lineheight=10, face="bold", size=16))
dev.off()