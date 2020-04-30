## Setup: set working dir, load libraries, and read in data
setwd("C:/Users/Ellen/Desktop/R_specialization_course/Exploratory Analysis/exdata_data_household_power_consumption")

library(data.table) # For reading in the data fast

bigData <- fread(file="./household_power_consumption.txt", 
                 header=TRUE, 
                 sep=";",
                 na.strings = "?")

# Change Date variable to a date class.
bigData$Date <- as.Date(bigData$Date, format="%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
consumption <- bigData[bigData$Date == "2007-02-01" | bigData$Date == "2007-02-02",]


# Add a column combining date and time into one variable, DateTime.
datetime <- paste(consumption$Date, consumption$Time, sep=" ")
datetime <- as.POSIXct(datetime)
consumption$DateTime <- datetime


# Make the plot as save it as a png.
png(file="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))

plot(Global_active_power ~ DateTime, data=consumption, col="black",
     xlab="", ylab="Global Active Power", type="l")

plot(Voltage ~ DateTime, data=consumption, col="black",
     xlab="datetime", ylab="Voltage", type="l")


plot(Sub_metering_1 ~ DateTime, data=consumption, type="l", xlab="", col="black",
     ylab="Energy sub metering")
lines(Sub_metering_2 ~ DateTime, data=consumption, col="red")
lines(Sub_metering_3 ~ DateTime, data=consumption, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1, bty="n")


plot(Global_reactive_power ~ DateTime, data=consumption, col="black",
     xlab="datetime", type="l")
dev.off()
