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

#Setting locale to have weekdays in English
mylocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","English")

#Making the plot
plot(hh2$DateTime, hh2$Sub_metering_1
     , type = "l"
     , xlab = ""
     , ylab = "Energy sub metering")
lines(hh2$DateTime, hh2$Sub_metering_2, col = "red")
lines(hh2$DateTime, hh2$Sub_metering_3, col = "blue")
legend("topright"
       , lty=1
       , col = c("black","red","blue")
       , legend = names(hh2)[7:9])

#Saving to .png
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

#Returning locale to the old one
Sys.setlocale("LC_TIME", mylocale)