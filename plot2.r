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
