## This is code for plotting plot4 in png format

#The file is downloaded from the site in working directory
#The file is in a zip format so it is unzipped in the same directory

powerconsumption<-unzip("exdata_data_household_power_consumption.zip")

# The file name is stored in the variable powerconsumption
# powerconsumption (not executed)
# [1] "./household_power_consumption.txt" 

# the file is read into a data frame DF

DF<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

# The data frame is read into a data table DT

library(data.table)
DT<-data.table(DF)

# Subset of DT is extracted for dates "1/2/2007" and "2/2/2007" into another Data Table DT2

DT2<-subset(DT,Date=="1/2/2007"|Date=="2/2/2007")

# A new column "datetime" is added by concatenating Date and Time fields 
# and converting to Calandar representation of Date and Time

DT2[,datetime:=strptime(paste(DT2$Date,DT2$Time),"%d/%m/%Y %H:%M:%S")]

## Above steps are common for all the plots
## -----------------------------------------------------------------------

# Open png file of high and width 480 pixels each

png(filename="./plot4.png",width=480,height=480,units="px")

# Set two column and two rows for plotting

par(mfcol=c(2,2))

# First plot (1,1)

with(DT2,plot(datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

# Second plot (2,1)
with(DT2,plot(datetime,Sub_metering_1,type="l",col="grey",ylab="Energy sub metering",xlab=""))
lines(DT2$datetime,DT2$Sub_metering_2,col="red")
lines(DT2$datetime,DT2$Sub_metering_3,col="blue")
legend("topright",pch="-",col=c("grey","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Third plot (1,2)

with(DT2,plot(datetime,Voltage,type="l",ylab="Voltage",xlab=""))

# Fourth plot (2,2)

with(DT2,plot(datetime,Global_reactive_power,type="l"))

# Close png device

dev.off()

## Required plots are plotted in the png file in working directory