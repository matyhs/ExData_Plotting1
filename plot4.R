library(data.table)

data <- fread(file="household_power_consumption.txt", select = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

data <- subset(data, as.Date(Date, "%d/%m/%Y") %between% c("2007-02-01", "2007-02-02"))

png(filename="plot4.png")

par(mfrow = c(2,2))

#plot (1,1)

with(data,plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Global_active_power, type="l", xlab="", ylab="Global Active Power"))

#plot (1,2)

with(data,plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Voltage, type="l", xlab="datetime", ylab="Voltage"))

#plot (2,1)

merge_data <- rbind(data.table(Date = paste(data$Date, data$Time), Sub_metering = as.numeric(data$Sub_metering_1), Sub_metering_type=1), 
                    data.table(Date = paste(data$Date, data$Time), Sub_metering = as.numeric(data$Sub_metering_2), Sub_metering_type=2))

merge_data <- rbind(merge_data,
                    data.table(Date = paste(data$Date, data$Time), Sub_metering = as.numeric(data$Sub_metering_3), Sub_metering_type=3))

with(merge_data, plot(strptime(Date, "%d/%m/%Y %H:%M:%S"),Sub_metering, type="n", xlab="", ylab="Energy sub metering"))
with(subset(merge_data,Sub_metering_type==1), lines(strptime(Date, "%d/%m/%Y %H:%M:%S"),Sub_metering, col="Black"))
with(subset(merge_data,Sub_metering_type==2), lines(strptime(Date, "%d/%m/%Y %H:%M:%S"),Sub_metering, col="Red"))
with(subset(merge_data,Sub_metering_type==3), lines(strptime(Date, "%d/%m/%Y %H:%M:%S"),Sub_metering, col="Blue"))

legend("topright", lty=1, col=c("Black", "Red", "Blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")

#plot (2,2)

with(data,plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Global_reactive_power, type="l", xlab="datetime"))

dev.off()

