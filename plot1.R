#Getting the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("data")){dir.create("data")}
download.file(fileUrl, "./data/Dataset.zip")
unzip("./data/Dataset.zip", exdir = "./data")
hh <- read.csv2("./data/household_power_consumption.txt", stringsAsFactors = FALSE)
hh[hh == "?" | hh == ""] <- NA
hh2 <- subset(hh, Date == "1/2/2007" | Date == "2/2/2007")
hh2$DateTime <- paste(hh2$Date, hh2$Time)
hh2$DateTime <- strptime(hh2$DateTime, format = "%d/%m/%Y %H:%M:%S")

#Making the plot
hist(as.numeric(hh2$Global_active_power)
     , main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)"
     , col = "red")

#Saving to .png
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()