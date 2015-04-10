##-----------------------------------------------------------------------------------------------
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
## Upload a PNG file containing your plot addressing this question.
##-----------------------------------------------------------------------------------------------
library(reshape)
library(reshape2)
library(downloader)
library(mgcv)
library(ggplot2) ## needed for qplot
library(lattice)
## set working directory
setwd("G:/2015/coursera/data_science/Exploratory Data Analysis/project2/09-4-15/")
## download zip file & unzip
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")
##
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## pseudocode : 
##  a. subset sources that are vehicle related in SCC > SCCvehicles. 
##  b. merge the two sets SCCvehicles & NEI > NEIvehicles
##  c. subset locations matching Baltimore city in NEIvehicles > NEI.Baltimore.vehicles
##  d. melt and dcast to produce data format for plotting.
##  e. plot results.
##-----------------------------------------------------------------------------------------------
##
##  a. subset sources that are vehicle related in SCC > SCCvehicles. 
## visual examination of data
## unique(SCC$EI.Sector)
## four categories of "On-Road" vehicles were identified. Non road and agricultural equipment are excluded.
SCC$EI.Sector.vehicles <- grepl("On-Road", SCC$EI.Sector)
sum(SCC$EI.Sector.vehicles) ##[1] 1138
## ie: 1138 rows containing data for "On-Road" vehicles were identified.
vehiclesSCC <- subset(SCC, EI.Sector.vehicles, select = SCC)
## dim(vehiclesSCC)  ## [1] 1138    1

NEIvehicles <- merge(NEI, vehiclesSCC, by.x="SCC", by.y="SCC", all.x = FALSE, all.y = FALSE)
##NEIcoal <- merge(NEI, coalSCC, by.x="SCC", by.y="SCC", all.x = FALSE, all.y = FALSE)

## quick comparison of data before/after merging.
dim(NEIvehicles) ## [1] 3183602       6
dim(NEI) ##[1] 6497651       6
dim(vehiclesSCC) ##[1] 1138    1
dim(SCC) ##[1] 11717    16
##
## quick checking of NEI & NEIcoal incomplete rows (has na values)
## NEIvehicles[!complete.cases(NEIvehicles),]
##[1] SCC       fips      Pollutant Emissions type      year     
##<0 rows> (or 0-length row.names)
## this is good, no na values in data.
## vehiclesSCC[!complete.cases(vehiclesSCC)]
## data frame with 0 columns and 1138 rows
## subset locations matching Baltimore city in NEI > NEIbaltimore (fips == "24510")
## reuse code from Q2.
NEI.Baltimore.vehicles <- subset(NEIvehicles, fips == "24510")
## dim(NEI.Baltimore.vehicles) ## [1] 1119    6
## length(unique(NEI.Baltimore.vehicles$SCC)) ##[1] 418
##  melt and dcast to produce data format for plotting.
NEI.Baltimore.vehicles.melt<- melt(NEI.Baltimore.vehicles, id=c("fips", "SCC", "Pollutant", "type", "year"), measure.vars="Emissions")
Baltimore.vehicles.year <- dcast(NEI.Baltimore.vehicles.melt, year ~ variable, sum)
##
## dim(Baltimore.vehicles.year) ## [1] 4 2
##  e. plot results.
barplot(Baltimore.vehicles.year$Emissions, names = Baltimore.vehicles.year$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission from vehicle sources in Baltimore.")
## print to .png file
png("plot5.png")
barplot(Baltimore.vehicles.year$Emissions, names = Baltimore.vehicles.year$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission from vehicle sources in Baltimore.")
dev.off()

