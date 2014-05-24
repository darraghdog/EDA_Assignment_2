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


### Plot 1
### Question : Make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

Emiss_yr <- as.data.frame(aggregate( Emissions ~ year, SCC, sum ))

png(file = "plot1.png", width = 480, height = 480)
with(Emiss_yr, plot(year, Emissions, type="o", xlab="", ylab="Amount of PM2.5 emitted, in tons", col="blue", lwd=1))
title(main="Total emissions per year, US", col.main="black", font.main=4)
dev.off()