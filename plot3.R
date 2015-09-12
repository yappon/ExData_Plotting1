## Step.1 Loading the file and extract subset 
# The data file path
filename <- "./data/household_power_consumption.txt"
# Loading all rows of file 
rawdata <- read.table(file = filename, header = TRUE, sep = ";", as.is = TRUE)
# Extract interested part from the data
subsetData <- subset(rawdata, rawdata$Date %in% c("1/2/2007","2/2/2007"))
# Remove rawdata (to save memory space used for 2.8mm rows)
remove(rawdata)

## Step.2 Data cleaning
# Create POSIXlt vector from Data and Time column
daytime <- strptime(paste(subsetData$Date, subsetData$Time),format = "%d/%m/%Y %H:%M:%S")
# Column bind
cleanedData <- cbind(subsetData, dayTime = daytime)
# Transform Data Type
cleanedData <- transform(cleanedData, Global_active_power = as.numeric(Global_active_power))
cleanedData <- transform(cleanedData, Global_reactive_power = as.numeric(Global_reactive_power))
cleanedData <- transform(cleanedData, Voltage = as.numeric(Voltage))
cleanedData <- transform(cleanedData, Global_intensity = as.numeric(Global_intensity))
cleanedData <- transform(cleanedData, Sub_metering_1 = as.numeric(Sub_metering_1))
cleanedData <- transform(cleanedData, Sub_metering_2 = as.numeric(Sub_metering_2))
cleanedData <- transform(cleanedData, Sub_metering_3 = as.numeric(Sub_metering_3))
# Remove intermediate data
remove(subsetData)

## Step.3 Display & Save to png file
# Set output device to png file
png("plot3.png")
# Set locale to English
Sys.setlocale("LC_TIME", "English")
# Plotting
with(cleanedData, plot(dayTime, Sub_metering_1, type = "n", ylab = "Energy sub metering"))
with(cleanedData, points(dayTime, Sub_metering_1, type = "l"))
with(cleanedData, points(dayTime, Sub_metering_2, type = "l", col = "red"))
with(cleanedData, points(dayTime, Sub_metering_3, type = "l", col = "blue"))
# Legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), lwd = c(1,1,1), col = c("black","red","blue"))
# Off device
dev.off()