## Exploratory Data Analysis, Assignment 1, Plot 1

#Libraries
library(dplyr)

#Download
myData <- read.csv2("household_power_consumption.txt", as.is = TRUE)
spare <- myData

#Clean
myData$Date <- as.Date(myData$Date, format = "%d/%m/%Y")
myData <- myData[which(myData$Date == "2007-02-01" | myData$Date == "2007-02-02"),]
myData$Global_active_power <- as.numeric(myData$Global_active_power)

#Open graphics device
png("plot4.png")

#Plot
hist(myData$Global_active_power, include.lowest = TRUE, right = FALSE, main = "Global Active Power", col = "red", ylab = "Frequnecy", xlab = "Global Active Power (kilowats)")

#Close graphics device
dev.off()