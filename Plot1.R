setwd("C:\\Users\\jieqian_liu\\ExploratoryDataAnalysis")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

str(NEI)

summary(NEI$Emissions)

#Total emissions by year
emissionsByYear <- aggregate(Emissions~year, data= NEI, FUN = sum)
emissionsByYear$kiloTons<-emissionsByYear$Emissions/1000

# Open device
png(filename='plot1.png', width=480, height=480, units='px')

with(emissionsByYear, 
     plot(year, kiloTons, type= "l", main="PM2.5 Emissions United States" , xlab="Year", ylab= "PM2.5 Emissions (kiloTons)"))

with(emissionsByYear, points(year, kiloTons, pch=19))

dev.off()


