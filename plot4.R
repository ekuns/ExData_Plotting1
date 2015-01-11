## plot4: Creates plot 4 for Exploratory Data Analysis project one
## Assumptions: See "Assumptions" in loadTable.R
## Arguments: screen - if not set or if set to FALSE, then the plot will be
##  created in a PNG file.  If set to TRUE, then the plot will be generated in
##  the default graphics device.
## Returns: Nothing useful
plot4 <- function(screen = FALSE) {
  # Read our data into a local variable
  df <- loadTable()

  if (!screen) {
    png(filename = "plot4.png",
        width = 480, height = 480, units = "px", pointsize = 12,
        bg = "transparent",  res = NA, type = c("windows"))
  }

  par(mfrow=c(2,2))
  par(mar=c(5,4,3,2)+0.1)

  plot(df$DateTime, df$Global_active_power, bg="transparent", col="black",
       main="", xlab="", ylab="Global Active Power",
       type="l")

  plot(df$DateTime, df$Voltage, bg="transparent", col="black",
       main="", xlab="datetime", ylab="Voltage", type="l")

  plot(df$DateTime, df$Sub_metering_1, bg="transparent",
       main="", xlab="", ylab="Energy sub metering",
       type="n")
  lines(df$DateTime, df$Sub_metering_1, col="black", type="l")
  lines(df$DateTime, df$Sub_metering_2, col="red", type="l")
  lines(df$DateTime, df$Sub_metering_3, col="blue", type="l")
  legend("topright", bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col=c("black", "red", "blue"), lty=1)

  plot(df$DateTime, df$Global_reactive_power, bg="transparent", col="black",
       main="", xlab="datetime", ylab="Global_reactive_power", type="l")

  if (!screen) {
    dev.off()
  }
}
