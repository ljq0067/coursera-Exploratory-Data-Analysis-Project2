setwd("C:\\Users\\jieqian_liu\\ExploratoryDataAnalysis")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Across the United States, how have emissions from coal combustion-related sources changed 
#from 1999-2008?

EISectorCoal <- grep("coal",SCC$EI.Sector, ignore.case = TRUE)
SCCCoal<-SCC[EISectorCoal,]$SCC

emissionsCoal<- subset(NEI, SCC %in% SCCCoal)

emissionsCoalByYear <- aggregate(Emissions~year, data= emissionsCoal, FUN = sum)
emissionsCoalByYear$kiloTons<- emissionsCoalByYear$Emissions/1000

# Open device
png(filename='plot4.png', width=480, height=480, units='px')

ggplot(emissionsCoalByYear, aes(year, kiloTons)) +
        geom_line() +
        geom_point(size=3) +
        geom_text(aes(label=sprintf("%1.2f", kiloTons)), size=3,hjust=.5, vjust=1.5) + 
        labs(x="Years", y="PM2.5 Emissions(kiloTons)") +
        labs(title="PM2.5 Emissions from Coal in the United States")

dev.off()
        

