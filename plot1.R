## load the necessary packages
library( dplyr)
library( readr)
library( data.table)
library( lubridate)

##read the csv file 
dt <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?" , stringsAsFactors = FALSE, comment.char = "", quote = '\"')

##tiding the data

##adding a separate 'datetime' column to the data set      
dtime <- paste( dt$Date, dt$Time)
dtime1 <- dmy_hms( dtime)
dt <- mutate( dt, datetime = dtime1)
dt1 <- subset( dt,  year(datetime ) == 2007 & month( datetime) == 2 & (day( datetime) == 1 | day(datetime) == 2) )
data <- dt1

##converting the requiered columns from "character" to "numeric" class
data[, 3:9 ] <- sapply( data[ ,3:9] , as.numeric)

## PLOT 1

##open a png device
png( filename = "plot1.png", height = 480, width = 480)
hist( data$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

#close the device
dev.off()
