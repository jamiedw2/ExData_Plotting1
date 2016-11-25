#Plot 4

plot4 <- function(){
  #Load the data in, selecting only 2007-02-01 and 2007-02-02
  EPCdata <- read.table("household_power_consumption.txt",
                        skip=grep("1/2/2007", readLines("household_power_consumption.txt"))[1]-1,
                        na.strings="?", sep=";", nrows=2880,
                        col.names = colnames(read.table("household_power_consumption.txt",
                                                        sep=";", nrow = 1, header = TRUE)))
  #Create a new column with the combined date and time in the correct format
  EPCdata$DateandTime <- strptime(paste(EPCdata$Date, EPCdata$Time), "%d/%m/%Y %H:%M:%S")
  
  #Set graphing parameters
  par(mfrow=c(2,2))
  
  #Plot...
  with(EPCdata, plot(DateandTime, Global_active_power, type="l",
                     ylab="Global Active Power", xlab=""))
  with(EPCdata, plot(DateandTime, Voltage, type="l",
                     ylab="Voltage", xlab="datetime"))
  with(EPCdata, plot(DateandTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
  with(EPCdata, lines(DateandTime, Sub_metering_2, col="red"))
  with(EPCdata, lines(DateandTime, Sub_metering_3, col="blue"))
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",
         lty=c(1,1,1),col=c("black","red","blue"),cex=0.6)
  with(EPCdata, plot(DateandTime, Global_reactive_power, type="l",
                     ylab="Global_reactive_power", xlab="datetime"))
  
  #...and save to png
  dev.copy(png, file="plot4.png")
  dev.off()
}