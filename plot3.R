## Exploratory Data Analysis, Assignment 1, Plot 3

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

#convert sub-meterings to numeric
myData$Sub_metering_1 <- as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2 <- as.numeric(myData$Sub_metering_2)
myData$Sub_metering_3 <- as.numeric(myData$Sub_metering_3)

#Open graphics device
png("plot4.png")

#Plot
plot(as.numeric(myData$dateTime), as.numeric(myData$Sub_metering_1), type = "l", ylab = "Global Active Power (kilowats)", xlab = "", xaxt = "n") #don't plot x axis
#Plot sub-mertering 2 and 3
lines(as.numeric(myData$dateTime), as.numeric(myData$Sub_metering_2), type = "l", col = "red")
lines(as.numeric(myData$dateTime), as.numeric(myData$Sub_metering_3), type = "l", col = "blue")
#Create custom xaxis
q <- quantile(as.numeric(myData$dateTime), c(0.0,0.5,1.0))
axis(side = 1, at=c(q[1],q[2],q[3]), labels=c("Thu","Fri","Sat"))
#Add legend
legend("topright", legend = names(myData[7:9]), lty=c(1,1), col = c("black","red","blue"))

#Close graphics device
dev.off()
