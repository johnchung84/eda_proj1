## Code for Plot3

#download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./ehpc.zip",method="curl")
unzip("ehpc.zip")

# Read the data
ehc <- read.table("./household_power_consumption.txt", head=T, sep = ";", na.strings="?")

# Combine Date and Time
ehc$DateTime <- paste(ehc$Date,ehc$Time)

# Convert DateTime
ehc$DateTime <- strptime(ehc$DateTime,"%d/%m/%Y %H:%M:%S")

# Subset data
ehc0702 <- subset(ehc, DateTime >= '2007-02-01 00:00:00' & DateTime <= '2007-02-02 23:59:59')

# Modify dataset
ehcsub1 <- ehc0702
ehcsub2 <- ehc0702
ehcsub3 <- ehc0702

ehcsub1$Sub_metering_2 <- ehcsub1$Sub_metering_3 <- NULL
ehcsub2$Sub_metering_1 <- ehcsub2$Sub_metering_3 <- NULL
ehcsub3$Sub_metering_1 <- ehcsub3$Sub_metering_2 <- NULL
ehcsub1$SubType <- "Sub_metering_1"
ehcsub2$SubType <- "Sub_metering_2"
ehcsub3$SubType <- "Sub_metering_3"

install.packages("reshape")
library(reshape)
ehcsub1 <- rename(ehcsub1, c(Sub_metering_1="Sub_metering"))
ehcsub2 <- rename(ehcsub2, c(Sub_metering_2="Sub_metering"))
ehcsub3 <- rename(ehcsub3, c(Sub_metering_3="Sub_metering"))

ehcsub <- rbind(ehcsub1,ehcsub2,ehcsub3)


#Save plot3
png("plot3.png",width=480,height=480)
with(ehcsub, plot(DateTime, Sub_metering, type="p", pch=".", xlab="",ylab="Energy sub metering"))
with(subset(ehcsub, SubType == "Sub_metering_1"), lines(DateTime, Sub_metering, col = "black"))
with(subset(ehcsub, SubType == "Sub_metering_2"), lines(DateTime, Sub_metering, col = "red"))
with(subset(ehcsub, SubType == "Sub_metering_3"), lines(DateTime, Sub_metering, col = "blue"))
legend("topright", pch="_", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()