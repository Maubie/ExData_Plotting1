plot4 <- function() {
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
        #set par for 2x2
        par(mfrow=c(2,2))
        #first plot
        plot(housepower_filtered$Time, housepower_filtered$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", cex.lab=.75, cex.axis=.75)
        #second plot
        plot(housepower_filtered$Time, housepower_filtered$Voltage, type="l", ylab="Voltage", xlab="datetime", cex.lab=.75, cex.axis=.75)
        # third plot
        plot_colors = c("black", "red", "blue")
        plot(housepower_filtered$Time, housepower_filtered$Sub_metering_1, type="l", col=plot_colors[1], ann=FALSE, cex.axis=.75)
        lines(housepower_filtered$Time, housepower_filtered$Sub_metering_2, type = "l", col=plot_colors[2])
        lines(housepower_filtered$Time, housepower_filtered$Sub_metering_3, type = "l", col=plot_colors[3])
        title(ylab="Energy sub metering", xlab="", cex.lab=.75)
        legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), cex=.75)
        #fourth plot
        plot(housepower_filtered$Time, housepower_filtered$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", cex.lab=.75, cex.axis=.75)
        #send to png
        dev.copy(png, file="plot4.png", width=480, height=480, units = "px", pointsize = 8, bg = "white")
        dev.off()
}