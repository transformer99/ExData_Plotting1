url1 <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url1,"./hpc.zip", method="curl")
unzip("./hpc.zip")


dat <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header=F, sep=';')
colnames(dat) <- names(read.table('household_power_consumption.txt', header=TRUE, sep=';', nrows=1))
datetime <- paste(dat$Date, dat$Time)
datetime_fixed <- strptime(datetime, format= "%d/ %m/ %Y %H:%M:%S")

png(file = "plot4.png",width=480, height=480)
par(mfcol = c(2,2))
par("mar"=c(5.1,4.1,4.1,1.4))
with ({
  plot(datetime_fixed, dat$Global_active_power, type = "l",xlab = "", ylab = "Global Active Power")
  plot(datetime_fixed,dat$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
  lines(datetime_fixed,dat$Sub_metering_2,type = "l", col = "red")
  lines(datetime_fixed,dat$Sub_metering_3,type = "l", col = "blue")
  legend("topright", col = c("black", "red", "blue"),bty="n", lty= "solid", cex=0.9, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime_fixed, dat$Voltage, type = "l",xlab = "datetime", ylab = "Voltage")
  plot(datetime_fixed, dat$Global_reactive_power, type ='l', xlab ="datetime", ylab="Global_reactive_power")
})
dev.off()
