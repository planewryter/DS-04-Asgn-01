## DS-04-Assignment-01-02.R
## DS-04 Exploratory Data Analysis
## Course Project

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
# working_directory <- "/Users/Rick/Dropbox/Data-Science/Coursera/DS-04-EDA/"
working_directory <- "/Users/rickwrites/Dropbox/Data-Science/Coursera/DS-04-EDA/"

setwd(working_directory) ## Make it so, Number One (set the Working Directory to the best path)

getwd()

# Load the Selected Electric Power Consumption dataset from Step 01
source_dataset <- "./HPC_result.csv"
dt <- fread(source_dataset,header=TRUE)

# Coerce the dates to be POSIXct Dates
# 2007-02-01 and 2007-02-02

dt$Date.formatted <- ymd(dt$Date.formatted)

# Generate plot1.png as per instructions

hist(as.numeric(dt$Global_active_power),col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Copy Histogram to PNG

dev.copy(png,'plot1.png')

dev.off()
