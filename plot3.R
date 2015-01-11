## plot3: Creates plot 3 for Exploratory Data Analysis project one
## Assumptions: See "Assumptions" in loadTable.R
## Arguments: screen - if not set or if set to FALSE, then the plot will be
##  created in a PNG file.  If set to TRUE, then the plot will be generated in
##  the default graphics device.
## Returns: Nothing useful
plot3 <- function(screen = FALSE) {
  # Read our data into a local variable
  df <- loadTable()

  if (!screen) {
    png(filename = "plot3.png",
        width = 480, height = 480, units = "px", pointsize = 12,
        bg = "transparent",  res = NA, type = c("windows"))
  }

  par(mfrow=c(1,1))
  plot(df$DateTime, df$Sub_metering_1, bg="transparent",
       main="", xlab="", ylab="Energy sub metering",
       type="n")
  lines(df$DateTime, df$Sub_metering_1, col="black", type="l")
  lines(df$DateTime, df$Sub_metering_2, col="red", type="l")
  lines(df$DateTime, df$Sub_metering_3, col="blue", type="l")
  legend("topright",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col=c("black", "red", "blue"), lty=1)

  if (!screen) {
    dev.off()
  }
}
