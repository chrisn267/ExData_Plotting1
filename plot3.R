##  Run this script in its entirety to produce plot3 for EDA Assignment Week1 ##
##  It assumes that 'household_power_consumption.txt' is in the same folder   ##

# link to download data directly if needed (keep commented out if already in working directory)
# download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method = "curl")
# unzip("household_power_consumption.zip")

# read data in from .txt file, reduce the date range to 1&2 Feb 2007,  
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
hpc <- hpc[(hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007"), ]

# ensure all columns are in required class/format
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, format = "%H:%M:%S")
hpc$Time <- hpc$Time - difftime(hpc$Time[1], hpc$Date[1], units = "secs")
hpc$Time[(hpc$Date == "2007-02-02")] <- hpc$Time[(hpc$Date == "2007-02-02")] + (1 * 24 * 60 * 60)
hpc[,3:9] <- lapply(hpc[,3:9], as.numeric)

# plot a line chart with the required characteristics
plot(hpc$Time,
     hpc$Sub_metering_1,
     type = "l",
     lty = 1,
     xlab = "",
     ylab = "Energy sub metering")

lines(hpc$Time,
      hpc$Sub_metering_2,
      lty = 1,
      col = "red")

lines(hpc$Time,
      hpc$Sub_metering_3,
      lty = 1,
      col = "blue")

legend("topright", legend = names(hpc[,7:9]), col = c("black", "red", "blue"), lty = c(1,1,1)) 

# copy over to png file
dev.copy(png, file = "plot3.png")
dev.off()
