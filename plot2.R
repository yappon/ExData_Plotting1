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

## Step.3 Display
# Set locale to English
Sys.setlocale("LC_TIME", "English")
with(cleanedData, plot(dayTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

## Step.4 Save to png file
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
