#set working dir
setwd("~/R programming/Exploratory Data Analysis")

#read csv (using read.csv2 as default seperator is ";")
read.csv2("household_power_consumption.txt") -> power_data

#selects relevant data for plot2
power_data[power_data$Date == '1/2/2007' | power_data$Date == '2/2/2007',] -> power_data_relevant

#change Global_active_power from factor to numeric (factor -> character -> numeric)
as.numeric(as.character(power_data_relevant$Global_active_power)) -> power_data_relevant$Global_active_power

#change Sub_metering_1,2,3 from factor to numeric (factor -> character -> numeric)
as.numeric(as.character(power_data_relevant$Sub_metering_1)) -> power_data_relevant$Sub_metering_1
as.numeric(as.character(power_data_relevant$Sub_metering_2)) -> power_data_relevant$Sub_metering_2
as.numeric(as.character(power_data_relevant$Sub_metering_3)) -> power_data_relevant$Sub_metering_3

#change Voltage from factor to numeric
as.numeric(as.character(power_data_relevant$Voltage)) -> power_data_relevant$Voltage

#change reactive power from factor to numeric
as.numeric(as.character(power_data_relevant$Global_reactive_power)) -> power_data_relevant$Global_reactive_power

#paste Date and Time together
power_data_relevant$DateTime = paste(power_data_relevant$Date, power_data_relevant$Time, sep="/")

#convert DateTime using strptime() to POSIXlt
power_data_relevant$DateTime <- strptime(power_data_relevant$DateTime , format="%d/%m/%Y/%H:%M:%S")

#call png
png("plot4.png", width=480, height=480, units="px")

#Plot graph
attach(power_data_relevant)
par(mfrow=c(2,2))

##topleft
plot(DateTime,Global_active_power, type="l", xlab="", ylab="Global Active Power")

##topright
plot(DateTime,Voltage, type="l", xlab="datetime")

##bottomleft
plot(DateTime,Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
points(DateTime,Sub_metering_2, type="l", col="red", xlab="", ylab="Energy sub metering")
points(DateTime,Sub_metering_3, type="l", col="blue", xlab="", ylab="Energy sub metering")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, col=c('black', 'red', 'blue'), bty = "n")

##bottomright
plot(DateTime,Global_reactive_power, xlab="datetime", type="l")

#close png
dev.off()