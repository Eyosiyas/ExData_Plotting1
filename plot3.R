#create file connection for text file
textConn <- file("household_power_consumption.txt", "r")
#read first row to get the column names and the initial date for which first data was recorded
Consump <- read.table(textConn, header = TRUE, sep=";", nrows = 1);
#calculate time difference to skip to the data recorded on 2007-02-01
skipto <- as.integer(difftime(strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"),strptime(paste(Consump$Date,Consump$Time),"%d/%m/%Y %H:%M:%S"),units = "mins"))
#calculate the time difference in minutes to get the number of records to import
numrows <- as.integer(difftime(strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"),strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"),units = "mins"))
#import data. Note that we skipped 2 behind and one more than the number of rows calculated to get the correct data
Consump <- read.table(textConn, sep=";", col.names = colnames(Consump), skip = skipto-2, nrows = numrows+1)
# create the png file to store plot, plot data and close file
png(file = "plot3.png")
x<-strptime(paste(Consump$Date,Consump$Time),"%d/%m/%Y %H:%M:%S")
with(Consump,plot(x, Sub_metering_1, type="l", xlab="", ylab="Energy sub setting"))
with(Consump,lines(x, Sub_metering_2, col="red"))
with(Consump,lines(x, Sub_metering_3, col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),col=c("black","red","blue"))
dev.off()