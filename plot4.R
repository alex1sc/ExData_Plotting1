library(data.table)
library(dplyr)

timeLocale <- Sys.getlocale( category = "LC_TIME") ## LC_TIME=fr_FR.UTF-8
Sys.setlocale( category = "LC_TIME", "en_US.UTF-8")

hpc <- fread( input = "./household_power_consumption.txt", 
              na.strings = "?",
              sep = ";",
              stringsAsFactors = TRUE) %>%  

       filter( strptime( Date, "%d/%m/%Y") == "2007-02-01" | 
               strptime( Date, "%d/%m/%Y") == "2007-02-02")
 
hpc <- cbind( hpc, 
              datetime = strptime( paste( hpc$Date, 
                                          hpc$Time), 
                                   format = "%d/%m/%Y %H:%M:%S"))

par( mfcol = c( 2, 2), 
     bg = "transparent")

with( hpc, {

## plot [1,1]
      plot( datetime, 
            Global_active_power,
            type = "l", 
            xlab = "",
            ylab = "Global Active Power")

## plot [2,1]
      plot( datetime,
            Sub_metering_1,
            ylim = c( 0, 40),
            type = "l", 
            xlab = "",
            ylab = "Energy sub metering",
            col = "black")

      par( new = TRUE)

      plot( datetime,
            Sub_metering_2,
            ylim = c( 0, 40),
            type = "l", 
            xlab = "",
            ylab = "Energy sub metering",
            col = "red")

      par( new = TRUE)

      plot( datetime,
            Sub_metering_3,
            ylim = c( 0, 40),
            type = "l", 
            xlab = "",
            ylab = "Energy sub metering",
            col = "blue")

      legend( "topright", 
              pch = "―", 
              box.lwd = 0,
              col = c( "black", "red", "blue"), 
              legend = c( "Sub_metering_1", 
                          "Sub_metering_2", 
                          "Sub_metering_3"))

      par( new = FALSE)

## plot [1,2]
      plot( datetime, Voltage, type = "l")
      
## plot [2,2] 
      plot( datetime, Global_reactive_power, type = "l")})

# copy the frame to png
dev.copy( "plot4.png", 
          device = png, 
          width = 480, 
          height = 480, 
          units = "px")

dev.off( which = dev.cur())
Sys.setlocale( category = "LC_TIME", timeLocale)
rm( hpc, timeLocale)

