library(reshape)
library(reshape2)
library(downloader)
library(mgcv)
## set working directory
setwd("G:/2015/coursera/data_science/Exploratory Data Analysis/project2/09-4-15")
## download zip file & unzip
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")
## 
NEI <- readRDS("summarySCC_PM25.rds")
NEI.Baltimore <- subset(NEI, fips == "24510")
dim(NEI.Baltimore)  ## [1] 2096    6
names(NEI.Baltimore)
NEIMelt.Baltimore <- melt(NEI.Baltimore, id.vars=c("fips", "SCC", "Pollutant", "type", "year"), measure.vars="Emissions")
NEI.Baltimore.year.emissions <- dcast(NEIMelt.Baltimore, year ~ variable, sum)
NEI.Baltimore.year.emissions
barplot(NEI.Baltimore.year.emissions$Emissions, names = NEI.Baltimore.year.emissions$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission in Baltimore City, Maryland, from all sources")
png("plot2.png")
barplot(NEI.Baltimore.year.emissions$Emissions, names = NEI.Baltimore.year.emissions$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission in Baltimore City, Maryland, from all sources")
dev.off()
