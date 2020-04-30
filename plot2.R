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
png(file="plot2.png", width=480, height=480, units="px")
with(consumption, plot(Global_active_power ~ DateTime,
                       type="l",
                       ylab="Global Active Power (kilowatts)",
                       xlab=""))
dev.off()
