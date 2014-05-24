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

### Plot 2
### Question : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

Emiss_Baltimore_yr <- as.data.frame(aggregate( Emissions ~ year, SCC[SCC$fips=="24510",], sum ))

png(file = "plot2.png", width = 480, height = 480)
with(Emiss_Baltimore_yr, plot(year, Emissions, type="o", xlab="", ylab="Amount of PM2.5 emitted, in tons", col="blue", lwd=1))
title(main="Total emissions per year, Baltimore", col.main="black", font.main=4)
dev.off()