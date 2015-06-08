## plot4.R

## DS-04-Assignment-01-03.R
## DS-04 Exploratory Data Analysis
## Energy by Metering

rm(list=ls())
cat('\014')

packageR <- function(pkg)
{
     if (!require(pkg,character.only = TRUE))
     {
          install.packages(pkg,dep=TRUE)
          if(!require(pkg,character.only = TRUE)) {
               stop("Package not found")
          } else {
               library(pkg,character.only=TRUE)
          }
     }
}

packageR("rmarkdown")
packageR("data.table")
packageR("dplyr")
packageR("stringr")
packageR("timeDate")
# packageR("timeSeries")
packageR("lubridate")
# packageR("zoo")
# packageR("xts")
# packageR("xtsExtra") //Incompatiable with R3.2.0
# packageR("quantmod")
# packageR("RMySQL")
# packageR("sqldf")

# Set path to best Working Directory for this project
getwd()

# To facilitate multi-device development, set up a 'path_to_data' for both my Desktop and MacBook Air
# working_directory <- "/Users/Rick/Dropbox/Data-Science/Coursera/DS-04-EDA/DS-04-Asgn-01/"
working_directory <- "/Users/rickwrites/Dropbox/Data-Science/Coursera/DS-04-EDA/DS-04-Asgn-01/"

setwd(working_directory) ## Make it so, Number One (set the Working Directory to the best path)

getwd()

# Load the Selected Electric Power Consumption dataset from Step 01
source_dataset <- "./HPC_result.csv"
dt <- fread(source_dataset,header=TRUE)

# Coerce the dates to be POSIXct Dates
# 2007-02-01 and 2007-02-02

dt$Date.formatted <- ymd(dt$Date.formatted)
tz(dt$Date.formatted) <- "America/Los_Angeles"
dt$Time.formatted <- hms(dt$Time)
dt$DateTime.formatted <- dt$Date.formatted + dt$Time.formatted

# Coerce Sub_meterine_1 to be numeric
dt$Sub_metering_1 <- as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2 <- as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3 <- as.numeric(dt$Sub_metering_3)

# Generate 4 Plots in 2x2 Array

par(mfrow = c(2,2), mar = c(4,4,4,1), oma = c(0,0,0,0), cex=.4)
with(dt, {
     plot(dt$DateTime.formatted,dt$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
     axis(1,at=c(5,6,7),labels=c("Thu","Fri","Sat"), tck=-.05)
     plot(dt$DateTime.formatted,as.numeric(dt$Voltage), type = "l", ylab="Voltage", xlab="datetime")
     plot(dt$DateTime.formatted,dt$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
     par(mar=c(5,4,4,3))
     lines(dt$DateTime.formatted,dt$Sub_metering_2,col="red",lwd=2.5)
     lines(dt$DateTime.formatted,dt$Sub_metering_3,col="blue",lwd=2.5) # adds a line for defense expenditures 
     legend("topright", col = c("black","red","blue"), lty = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), inset = .05)
     axis(1,at=c(5,6,7),labels=c("Thu","Fri","Sat"), tck=-.05)
     plot(dt$DateTime.formatted,as.numeric(dt$Global_reactive_power), type = "l", ylab = "Global_reactive_power", xlab="datetime")
})

# Copy Image to PNG

dev.copy(png,'plot4.png')

dev.off()
