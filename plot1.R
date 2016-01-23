#set working dir
setwd("~/R programming/Exploratory Data Analysis")

#read csv (using read.csv2 as default seperator is ";")
read.csv2("household_power_consumption.txt") -> power_data

#selects relevant data for plot1
power_data[power_data$Date == '1/2/2007' | power_data$Date == '2/2/2007',] -> power_data_relevant

#change Global_active_power from factor to numeric
as.numeric(as.character(power_data_relevant$Global_active_power)) -> power_data_relevant$Global_active_power

#call png
png("plot1.png", width=480, height=480, units="px")

#histogram 
hist(power_data_relevant$Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")

#close png
dev.off()
