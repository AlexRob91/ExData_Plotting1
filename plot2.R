#set working dir
setwd("~/R programming/Exploratory Data Analysis")

#read csv (using read.csv2 as default seperator is ";")
read.csv2("household_power_consumption.txt") -> power_data

#selects relevant data for plot2
power_data[power_data$Date == '1/2/2007' | power_data$Date == '2/2/2007',] -> power_data_relevant

#change Global_active_power from factor to numeric (factor -> character -> numeric)
as.numeric(as.character(power_data_relevant$Global_active_power)) -> power_data_relevant$Global_active_power

#paste Date and Time together
power_data_relevant$DateTime = paste(power_data_relevant$Date, power_data_relevant$Time, sep="/")

#convert DateTime using strptime() to POSIXlt
power_data_relevant$DateTime <- strptime(power_data_relevant$DateTime , format="%d/%m/%Y/%H:%M:%S")

#call png
png("plot2.png", width=480, height=480, units="px")

#Plot graph
attach(power_data_relevant)
plot(DateTime,Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#close png
dev.off()