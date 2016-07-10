library(data.table)
library(dplyr)

hpc3 <- fread( input = "./household_power_consumption.txt", 
                 na.strings = "?",
                 sep = ";",
                 stringsAsFactors = TRUE) %>%  
        filter( strptime( Date, "%d/%m/%Y") == "2007-02-01" | 
                strptime( Date, "%d/%m/%Y") == "2007-02-02")

hpc3 <- cbind( hpc3, datetime = strptime( paste( hpc3$Date, 
                                                 hpc3$Time), 
                                          format = "%d/%m/%Y %H:%M:%S"))

timeLocale <- Sys.getlocale( category = "LC_TIME") ## LC_TIME=fr_FR.UTF-8
Sys.setlocale( category = "LC_TIME", "en_US.UTF-8")

plot( hpc3$datetime,
      hpc3$Sub_metering_1,
      ylim = c( 0, 40),
      type = "l", 
      xlab = "",
      ylab = "Energy sub metering",
      col = "black")

par( new = TRUE)

plot( hpc3$datetime,
      hpc3$Sub_metering_2,
      ylim = c( 0, 40),
      type = "l", 
      xlab = "",
      ylab = "Energy sub metering",
      col = "red")

par( new = TRUE)
      
plot( hpc3$datetime,
      hpc3$Sub_metering_3,
      ylim = c( 0, 40),
      type = "l", 
      xlab = "",
      ylab = "Energy sub metering",
      col = "blue")

legend( "topright", 
        pch = "―", 
        col = c( "black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

par( new = FALSE)

dev.copy( "plot3.png", 
          device = png, 
          width = 480, 
          height = 480, 
          units = "px" )

dev.off( which = dev.cur())
Sys.setlocale( category = "LC_TIME", timeLocale)
rm( hpc3, timeLocale)

