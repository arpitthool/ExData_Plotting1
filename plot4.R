## load the necessary packages
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
## PLOT 4

##open a png device
png( filename = "plot4.png", height = 480, width = 480)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
        plot(Global_active_power ~ datetime, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(Voltage ~ datetime, type = "l", ylab = "Voltage", xlab = "datetime")
        plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2 ~ datetime, col = 'Red')
        lines(Sub_metering_3 ~ datetime, col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ datetime, type = "l", 
             ylab = "Global_rective_power", xlab = "datetime")
})
## close the device
dev.off()
