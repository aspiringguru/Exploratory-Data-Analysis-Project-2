library(reshape)
library(reshape2)
library(downloader)
library(mgcv)
library(ggplot2) ## needed for qplot
library(lattice)
## set working directory
setwd("G:/2015/coursera/data_science/Exploratory Data Analysis/project2/09-4-15")
## download zip file & unzip
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")
## 
NEI <- readRDS("summarySCC_PM25.rds")
NEI.Baltimore <- subset(NEI, fips == "24510")
unique(NEI.Baltimore$type) ##[1] "POINT"    "NONPOINT" "ON-ROAD"  "NON-ROAD"
NEIMelt.Baltimore <- melt(NEI.Baltimore, id.vars=c("type", "year"), measure.vars= "Emissions")
NEI.Baltimore.year.emissions <- dcast(NEIMelt.Baltimore, type + year ~ variable, sum) 
names(NEI.Baltimore.year.emissions) ## [1] "type"      "year"      "Emissions"
dim(NEI.Baltimore.year.emissions) ## [1] 16  3
NEI.Baltimore.year.emissions
qplot(year, Emissions, data=NEI.Baltimore.year.emissions, color = type, ) + labs(title="Baltimore City : Emissions by type") + theme_bw() +   geom_line()
## now print to png file.
png("plot3.png")
qplot(year, Emissions, data=NEI.Baltimore.year.emissions, color = type, ) + labs(title="Baltimore City : Emissions by type") + theme_bw() +   geom_line()
dev.off()