## load the data.table and lubridate packages
library( data.table)
library( lubridate)
library( dplyr)
library( readr)

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


## PLOT 2

## open a png device
png( filename = "plot2.png", height = 480, width = 480)

with( data, plot( Global_active_power ~ datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

##close the device
dev.off()
