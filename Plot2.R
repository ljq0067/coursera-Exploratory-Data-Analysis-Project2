setwd("C:\\Users\\jieqian_liu\\ExploratoryDataAnalysis")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

str(NEI)

summary(NEI$Emissions)

baltimore <- NEI[NEI$fips == "24510",]

#Total emissions by year
emissionsByYear <- aggregate(Emissions~year, data= baltimore, FUN = sum)

# Open device
png(filename='plot2.png', width=480, height=480, units='px')

with(emissionsByYear, 
     plot(year, Emissions, type= "l", main="PM2.5 Emissions Baltimore City" , xlab="Year", ylab= "PM2.5 Emissions (Tons)"))

with(emissionsByYear, points(year, Tons, pch=19))

dev.off()

