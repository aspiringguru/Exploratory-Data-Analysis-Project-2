## code for Plot1.R
library(reshape)
library(reshape2)
library(downloader)
library(mgcv)
## set working directory
setwd("G:/2015/coursera/data_science/Exploratory Data Analysis/project2/09-4-15")
## download zip file & unzip
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")
NEI <- readRDS("summarySCC_PM25.rds")
NEIMelt <- melt(NEI, id=c("fips", "SCC", "Pollutant", "type", "year"), measure.vars="Emissions")
NEI.year.emissions <- dcast(NEIMelt, year ~ variable, sum)
## NEI.year.emissions
##  year Emissions
## 1 1999   7332967
## 2 2002   5635780
## 3 2005   5454703
## 4 2008   3464206

---------------------------------------------------------------------
## not using this plot since wrong plot type.
## with(NEI.year.emissions, plot(year, Emissions)) ## would prefer barplot, but only histogram?
## title(main = "Total PM2.5 emission from all sources")
---------------------------------------------------------------------
library(reshape)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
NEIMelt <- melt(NEI, id=c("fips", "SCC", "Pollutant", "type", "year"), measure.vars="Emissions")
NEI.year.emissions <- dcast(NEIMelt, year ~ variable, sum)
barplot(NEI.year.emissions$Emissions, names = NEI.year.emissions$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission from all sources")
## now plot to file
png("plot1.png")
barplot(NEI.year.emissions$Emissions, names = NEI.year.emissions$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission from all sources")
dev.off()
