library(data.table)

data <- fread(file="household_power_consumption.txt", select = c("Date", "Global_active_power"))

data <- subset(data, as.Date(Date, "%d/%m/%Y") %between% c("2007-02-01", "2007-02-02"))

png(filename="plot1.png")

hist(as.double(data$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col = "red")

dev.off()
