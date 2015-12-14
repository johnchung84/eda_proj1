## Code for Plot2

#download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./ehpc.zip",method="curl")
unzip("ehpc.zip")

# Read the data
ehc <- read.table("./household_power_consumption.txt", head=T, sep = ";", na.strings="?")

# Combine Date and Time
ehc$DateTime <- paste(ehc$Date,ehc$Time)

# Convert DateTime
ehc$DateTime <- strptime(ehc$DateTime,"%d/%m/%Y %H:%M:%S")

#Subset data
ehc0702 <- subset(ehc, DateTime >= '2007-02-01 00:00:00' & DateTime <= '2007-02-02 23:59:59')

#Save plot2
png("plot2.png",width=480,height=480)
plot(ehc0702$DateTime,ehc0702$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()