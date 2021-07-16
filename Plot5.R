setwd("C:\\Users\\jieqian_liu\\ExploratoryDataAnalysis")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

EISectorVehicle <- grep("vehicle",SCC$EI.Sector, ignore.case = TRUE)
SCCVehicle<-SCC[EISectorVehicle,]$SCC

vehicleBaltimore <- subset(NEI, SCC %in% SCCVehicle & fips=="24510")

vehicleBaltimoreByYear <- aggregate(Emissions~year, data= vehicleBaltimore, FUN = sum)


# Open device
png(filename='plot5.png', width=480, height=480, units='px')

ggplot(vehicleBaltimoreByYear, aes(year, Emissions)) +
        geom_line() +
        geom_point(size=3) +
        geom_text(aes(label=sprintf("%1.0f", Emissions)), size=3,hjust=.5, vjust=1.5) + 
        labs(x="Years", y="PM2.5 Emissions (Tons)") +
        labs(title="PM2.5 Emissions from motor vehicle in Baltimore City")

dev.off()



