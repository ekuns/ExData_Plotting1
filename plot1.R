## plot1: Creates plot 1 for Exploratory Data Analysis project one
## Assumptions: See "Assumptions" in loadTable.R
## Arguments: screen - if not set or if set to FALSE, then the plot will be
##  created in a PNG file.  If set to TRUE, then the plot will be generated in
##  the default graphics device.
## Returns: Nothing useful
plot1 <- function(screen = FALSE) {
  # Read our data into a local variable
  df <- loadTable()

  if (!screen) {
    png(filename = "plot1.png",
        width = 480, height = 480, units = "px", pointsize = 12,
        bg = "transparent",  res = NA, type = c("windows"))
  }

  par(mfrow=c(1,1))
  hist(df$Global_active_power, bg="transparent", col="red",
       main="Global Active Power", xlab="Global Active Power (kilowatts)")

  if (!screen) {
    dev.off()
  }
}
