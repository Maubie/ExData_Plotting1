plot1 <- function() {
        ##load libraries
        library (plyr)
        library (dplyr)
        library(data.table)
        library(chron)
        ## read file and replace ? with NA
        housepower <- read.table("household_power_consumption.txt", header=TRUE, sep=";" , na.strings="?")
        ## convert date & time
        housepower$Date <- as.Date(housepower$Date, format="%d/%m/%Y")
        housepower$Time <- chron(times=housepower$Time)
        #filter the date range 
        housepower_filtered <- filter(housepower, Date>= as.Date("2007-02-01") & Date<= as.Date("2007-02-02"))
        #create plot
        hist(housepower_filtered$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
        #send to png
        dev.copy(png, file="plot1.png", width=480, height=480, units = "px", pointsize = 12, bg = "white")
        dev.off()
}
