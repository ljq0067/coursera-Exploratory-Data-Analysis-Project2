library(ggplot2)

setwd("C:\\Users\\jieqian_liu\\ExploratoryDataAnalysis")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

str(NEI)

summary(NEI$Emissions)

baltimore <- NEI[NEI$fips == "24510",]

#Total emissions by year and type
emissionsByYear <- aggregate(Emissions~year + type, data= baltimore, FUN = sum)

# Open device
png(filename='plot3.png', width=480, height=480, units='px')


g<-ggplot(emissionsByYear, aes(year, Emissions, color=type)) +
        geom_line() +
        geom_point() +
        geom_text(aes(label=sprintf("%1.0f", Emissions)), size=3,hjust=.5, vjust=1.2) +
        labs(x="Year", y="PM2.5 Emissions (Tons)") +
        labs(title="PM2.5 Emissions Baltimore City") 

print(g)

dev.off() 
