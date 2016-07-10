library(data.table)
library(dplyr)

hpcGAP <- fread( input = "./household_power_consumption.txt", 
               na.strings = "?",
               sep = ";",
               stringsAsFactors = TRUE,
               select = c( "Date", 
                           "Time",
                           "Global_active_power"))

hpc1 <- hpcGAP %>%  
  filter( strptime( Date, "%d/%m/%Y") == "2007-02-01" | 
            strptime( Date, "%d/%m/%Y") == "2007-02-02")

hist( hpc1$Global_active_power, 
      freq = TRUE, 
      main = "Global Active Power", 
      xlab = "Global Active Power (kilowatts)", 
      col = "red")

dev.copy( "plot1.png", 
          device = png, 
          width = 480, 
          height = 480, 
          units = "px" )

dev.off()
rm( hpcGAP, hpc1)
