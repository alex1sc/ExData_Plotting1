library(data.table)
library(dplyr)

hpc <- fread( input = "./household_power_consumption.txt", 
               na.strings = "?")

hpcGAP <- fread( input = "household_power_consumption.txt", 
               na.strings = "?",
               sep = ";",
               stringsAsFactors = TRUE,
               select = c( "Date", 
                           "Time",
                           "Global_active_power"))

hpc1 <- hpcGAP %>%  
  filter( strptime( Date, "%d/%m/%Y") == "2007-02-01" | 
            strptime( Date, "%d/%m/%Y") == "2007-02-02")

timeLocale <- Sys.getlocale( category = "LC_TIME") ## LC_TIME=fr_FR.UTF-8
Sys.setlocale( category = "LC_TIME", "en_US.UTF-8")

hpc2 <- cbind( hpc1, time = strptime( paste( hpc1$Date, hpc1$Time), 
                                      format = "%d/%m/%Y %H:%M:%S"))

plot( hpc2$time,
      hpc1$Global_active_power,
      type = "l", 
      xlab = "",
      ylab = "Global Active Power (kilowatts)")

dev.copy( "plot2.png", 
          device = png, 
          width = 480, 
          height = 480, 
          units = "px" )

dev.off( which = dev.cur())
Sys.setlocale( category = "LC_TIME", timeLocale)
rm( hpc, hpc1, hpc2, hpcGAP, timeLocale)
