library(data.table)

data <- fread(file="household_power_consumption.txt", select = c("Date", "Time", "Global_active_power"))

data <- subset(data, as.Date(Date, "%d/%m/%Y") %between% c("2007-02-01", "2007-02-02"))

png(filename="plot2.png")

with(data,plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

dev.off()