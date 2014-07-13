url1 <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url1,"./hpc.zip", method="curl")
unzip("./hpc.zip")


dat <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header=F, sep=';')
colnames(dat) <- names(read.table('household_power_consumption.txt', header=TRUE, sep=';', nrows=1))
datetime <- paste(dat$Date, dat$Time)
datetime_fixed <- strptime(datetime, format= "%d/ %m/ %Y %H:%M:%S")

png(file = "plot2.png",width=480, height=480)
plot(datetime_fixed, dat$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
