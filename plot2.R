## Exploratory Data Analysis, Assignment 1, Plot 2

#Libraries
library(dplyr)

#Download
myData <- read.csv2("household_power_consumption.txt", as.is = TRUE)

spare <- myData #debug

#Combined dateTime
myData <- mutate(myData, dateTime = paste(myData$Date, myData$Time, sep = " "))
myData$dateTime <- strptime(myData$dateTime, format = "%d/%m/%Y %H:%M:%S")

#Date as date class
myData$Date <- as.Date(myData$Date, format = "%d/%m/%Y")

#Select time range
myData <- myData[which(myData$Date == "2007-02-01" | myData$Date == "2007-02-02"),]

#convert active power to number
myData$Global_active_power <- as.numeric(myData$Global_active_power)

#Open graphics device
png("plot4.png")

#Plot
plot(as.numeric(myData$dateTime), as.numeric(myData$Global_active_power), type = "l", ylab = "Global Active Power (kilowats)", xlab = "", xaxt = "n") #don't plot x axis
#Create custom xaxis
q <- quantile(as.numeric(myData$dateTime), c(0.0,0.5,1.0))
axis(side = 1, at=c(q[1],q[2],q[3]), labels=c("Thu","Fri","Sat"))

#Close graphics device
dev.off()
