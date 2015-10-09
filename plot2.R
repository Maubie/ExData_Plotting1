plot2 <- function() {
        ##load libraries
        library (plyr)
        library (dplyr)
        library(data.table)
        library(datasets)
        ## read file and replace ? with NA
        housepower <- read.table("household_power_consumption.txt", header=TRUE, sep=";" , na.strings="?")
        ## convert date & time to POSIXct
        housepower$Time <- with(housepower, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
        housepower <- select(housepower, Time:Sub_metering_3)
        #filter the date range 
        housepower_filtered <- filter(housepower, Time>= as.POSIXct("2007-02-01 00:00:00") & Time<= as.POSIXct("2007-02-02 23:59:59"))
        #create plot
        plot(housepower_filtered$Time, housepower_filtered$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", cex.lab=.75, cex.axis=.75)
        #send to png
        dev.copy(png, file="plot2.png", width=480, height=480, units = "px", pointsize = 8, bg = "white")
        dev.off()
}
