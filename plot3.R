## Prabir Maiti

## Goals for this project###

##1.Loading the data
##2.Making plots. 

# @ first set the file path and working directory here
## setwd("C:\DataScience\4-ExploratoryDataAnalysis\WorkingDirectory")
workingDirectory<-getwd()
	
# @ all folder names #
baseDataFolder <- 'Household_Power_Consumption_Data'

# @ download all data files and unzip those #
if (!file.exists(baseDataFolder)) {
	dir.create(file.path(workingDirectory, baseDataFolder), showWarnings = FALSE)

	fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
	tmpFile = paste(workingDirectory, "/", baseDataFolder, "/Household_Power_Consumption_Data.zip", sep="")
	setInternet2(TRUE)
	download.file(fileUrl, destfile=tmpFile)
	unzip(tmpFile)
}

filePath <- paste(workingDirectory, "/", baseDataFolder, "/household_power_consumption.txt", sep="")

# @read the files #
powerData <- read.csv2(filePath, header = TRUE, sep = ";", stringsAsFactors=FALSE, dec=".") 

# @convert the date
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")

# @read selected  power #
dfSelectedPower <- powerData[(powerData$Date=="2007-02-01") | (powerData$Date=="2007-02-02"),]

# @convert the required columns into numeric columns
dfSelectedPower$Global_active_power <- as.numeric(as.character(dfSelectedPower$Global_active_power))

dfSelectedPower <- transform(dfSelectedPower, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

dfSelectedPower$Sub_metering_1 <- as.numeric(as.character(dfSelectedPower$Sub_metering_1))
dfSelectedPower$Sub_metering_2 <- as.numeric(as.character(dfSelectedPower$Sub_metering_2))
dfSelectedPower$Sub_metering_3 <- as.numeric(as.character(dfSelectedPower$Sub_metering_3))

# @create a plot function and save a .png
plot3 <- function() {
	png("plot3.png", width=480, height=480)
	plot(dfSelectedPower$timestamp,dfSelectedPower$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	lines(dfSelectedPower$timestamp,dfSelectedPower$Sub_metering_2,col="red")
	lines(dfSelectedPower$timestamp,dfSelectedPower$Sub_metering_3,col="blue")
	legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
	dev.off()
	cat("plot3.png has been saved in", getwd())
}
plot3()
