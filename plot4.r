##-----------------------------------------------------------------------------------------------
##Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
##-----------------------------------------------------------------------------------------------
setwd("H:/2015/coursera/data_science/Exploratory Data Analysis/project2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##length(unique(SCC$Short.Name))  ## [1] 11238
## pseudocode - select SCC$Short.Name with "Coal" or "coal" in name, plot sum of emissions for each year.
## 
SCC$coal <- grepl("[Cc]oal", SCC$Short.Name)
coalSCC <- subset(SCC, coal, select = SCC)
## now select rows from NEI where NEI$SCC is in coalSCC.
NEIcoal <- merge(NEI, coalSCC, by.x="SCC", by.y="SCC", all.x = FALSE, all.y = FALSE)
## quick comparison of data before/after merging.
dim(NEIcoal) ##[1] 53400     6
dim(NEI) ##[1] 6497651       6
dim(coalSCC) ##[1] 239   1
dim(SCC) ##[1] 11717    16
## quick comparison of NEI & NEIcoal incomplete rows (has na values)
NEIcoal[!complete.cases(NEIcoal),]
##  [1] SCC       fips      Pollutant Emissions type      year     
##  <0 rows> (or 0-length row.names)
coalSCC[!complete.cases(coalSCC)]
## data frame with 0 columns and 239 rows
## reusing method from Q1.
NEIcoalMelt <- melt(NEIcoal, id=c("fips", "SCC", "Pollutant", "type", "year"), measure.vars="Emissions")
NEIcoal.year.emissions <- dcast(NEIcoalMelt, year ~ variable, sum)
## now plot, reuse plot method from Q1 and adjust title
## should probably make this a variable 
barplot(NEIcoal.year.emissions$Emissions, names = NEIcoal.year.emissions$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission from coal sources")
## now print plot to file
png("plot4.png")
barplot(NEIcoal.year.emissions$Emissions, names = NEIcoal.year.emissions$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission from coal sources")
dev.off()
