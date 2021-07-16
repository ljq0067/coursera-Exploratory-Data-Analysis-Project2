setwd("C:\\Users\\jieqian_liu\\ExploratoryDataAnalysis")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
#sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

EISectorVehicle <- grep("vehicle",SCC$EI.Sector, ignore.case = TRUE)
SCCVehicle<-SCC[EISectorVehicle,]$SCC

vehicleEmissions <- subset(NEI, SCC %in% SCCVehicle & fips %in% c("24510","06037"))

vehicleEmissionsByYear <- aggregate(Emissions~year + fips, data= vehicleEmissions, FUN = sum)

# Open device
png(filename='plot6.png', width=480, height=480, units='px')

ggplot(vehicleEmissionsByYear, aes(year, Emissions, color=fips)) +
        geom_line() +
        geom_point(size=3) +
        geom_text(aes(label=sprintf("%1.0f", Emissions)), size=3,hjust=.5, vjust=1.5) + 
        labs(x="Years", y="PM2.5 Emissions (Tons)") +
        labs(title="PM2.5 Emissions from motor vehicle in Baltimore City vs L.A. County") +
        scale_color_discrete("Cities", breaks=c("06037","24510"), labels = c("L.A. County", "Baltimore"))

dev.off()


