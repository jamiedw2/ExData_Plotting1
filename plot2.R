#Plot 2

plot2 <- function(){
  #Load the data in, selecting only 2007-02-01 and 2007-02-02
  EPCdata <- read.table("household_power_consumption.txt",
                        skip=grep("1/2/2007", readLines("household_power_consumption.txt"))[1]-1,
                        na.strings="?", sep=";", nrows=2880,
                        col.names = colnames(read.table("household_power_consumption.txt",
                                                        sep=";", nrow = 1, header = TRUE)))
  #Create a new column with the combined date and time in the correct format
  EPCdata$DateandTime <- strptime(paste(EPCdata$Date, EPCdata$Time), "%d/%m/%Y %H:%M:%S")
  
  #Plot...
  with(EPCdata, plot(DateandTime, Global_active_power, type="l",
                     ylab="Global Active Power (kilowatts)", xlab=""))
  
  #...and save to png
  dev.copy(png, file="plot2.png")
  dev.off()
}