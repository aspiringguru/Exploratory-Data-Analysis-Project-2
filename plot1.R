NEI <- readRDS("summarySCC_PM25.rds")
NEIMelt <- melt(NEI, id=c("fips", "CSS", "Pullutant", "type", "year"), measure.vars="Emissions")
NEI.year.emissions <- dcast(NEIMelt, year ~ variable, sum)
png("plot1.png")
barplot(NEI.year.emissions$Emissions, names = NEI.year.emissions$year,
  xlab = "Year", ylab = "Emissions (PM2.5)",
  main = "Total PM2.5 emission from all sources")
dev.off()
