##-----------------------------------------------------------------------------------------------
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
## vehicle sources in Los Angeles County, California (fips == 06037). 
## Which city has seen greater changes over time in motor vehicle emissions?
##-----------------------------------------------------------------------------------------------
setwd("H:/2015/coursera/data_science/Exploratory Data Analysis/project2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## reuse the subsetting method from q5 and use the melt-dcast-plot method from q3.
## pseudo code.
##  a. subset sources that are vehicle related in SCC > SCCvehicles. 
##  b. merge the two sets SCCvehicles & NEI > NEIvehicles
##  c. subset locations matching Baltimore or Los Angeles in NEIvehicles > NEI.bla.vehicles
##  d. melt and dcast to produce data format for plotting.
##  e. plot results.
##-----------------------------------------------------------------------------------------------
##  a. subset sources that are vehicle related in SCC > SCCvehicles. 
SCC$EI.Sector.vehicles <- grepl("On-Road", SCC$EI.Sector)
vehiclesSCC <- subset(SCC, EI.Sector.vehicles, select = SCC)
##  b. merge the two sets SCCvehicles & NEI > NEIvehicles
NEIvehicles <- merge(NEI, vehiclesSCC, by.x="SCC", by.y="SCC", all.x = FALSE, all.y = FALSE)
##  c. subset locations matching Baltimore or Los Angeles in NEIvehicles > NEI.location.vehicles
NEI.bla.vehicles <- subset(NEIvehicles, fips == "24510" | fips == "06037")
##  d. melt and dcast to produce data format for plotting.
NEI.bla.vehicles.melt<- melt(NEI.bla.vehicles, id.vars=c("fips", "year"), measure.vars="Emissions")
NEI.bla.year.emissions <- dcast(NEI.bla.vehicles.melt, fips + year ~ variable, sum) 
##  modify data to make it more readable on graph
NEI.bla.year.emissions$fips[NEI.bla.year.emissions$fips=="06037"]<- "Los Angeles County"
NEI.bla.year.emissions$fips[NEI.bla.year.emissions$fips=="24510"]<- "Baltimore City"
##  e. plot results.
qplot(year, Emissions, data=NEI.bla.year.emissions, color = fips, ) + labs(title="Vehicle Emissions : Color by City") + theme_bw() +   geom_line()
##  plot to png file
png("plot6.png")
qplot(year, Emissions, data=NEI.bla.year.emissions, color = fips, ) + labs(title="Vehicle Emissions : Color by City") + theme_bw() +   geom_line()
dev.off()

