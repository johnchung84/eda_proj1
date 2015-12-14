## Code for Plot1

#download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./ehpc.zip",method="curl")
unzip("ehpc.zip")

# Read the data
ehc <- read.table("./household_power_consumption.txt", head=T, sep = ";", na.strings="?")

# Convert Date
ehc$Date <- as.Date(ehc$Date,"%d/%m/%Y")

#Subset data
ehc0702 <- subset(ehc, Date == '2007-02-01' | Date == '2007-02-02')

#Save plot1
png("plot1.png",width=480,height=480)
hist(ehc0702$Global_active_power, xlab="Global Active Power(kilowatts)", main="Global Active Power", col="red")
dev.off()