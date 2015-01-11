## loadTable:  Loads and returns the desired subset of data as a data.frame.
##    This function ensures:
##    a) The data folder exists.  All data (raw and otherwise) is
##       stored in a "data" folder to make it easy to tell GIT to
##       ignore it all.
##    b) The raw data file exists.  If it does not, the ZIP is
##       fetched and unzipped to acquire it.
##    c) The subsetted file exists.  If not, the raw data file is
##       loaded as a data.frame.  Appropriate data types are ensured.
##       The data.frame is then subsetted and saved.
## Assumptions: Assumes the current working directory is set appropriately.  The
##    working directory doesn't have to be any particular place, but if the
##    "data" folder doesn't exist relative to the current working directory,
##    then it will be created and populated.
## Arguments: None
## Returns:   The desired subset of data as a data.frame
loadTable <- function() {
  # Make sure our data folder exists
  if (!file.exists("data")) {
    message("Making data folder")
    dir.create("data")
  }

  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  rawFile <- "data/household_power_consumption.txt"
  subsetFile <- "data/household_power_subset.rds"

  # Ensure that we have a copy of the raw data file
  if (!file.exists(rawFile)) {
    # Note: the "method" depends on the OS.  For example, if you run this on a
    # Mac, you may need method="curl" for it to work, but this option doesn't
    # work on windows (out of the box).  method="internal" works on Windows.
    message("Downloading from URL...")
    download.file(fileUrl, destfile="data/household_power.zip", method="internal")

    message("Unzipping...")
    unzip("data/household_power.zip", exdir="data")
  }

  if (!file.exists(subsetFile)) {
    message("Subsetting...")
    # Over-estimate of number of rows for efficiency (better than underestimate)
    numberrows <- 2100000
    t <- read.table("data/household_power_consumption.txt", sep=";", na.strings=c("?"),
                    header=TRUE, nrows=numberrows,
                    colClasses=c("character", "character", "numeric", "numeric",
                                 "numeric", "numeric", "numeric", "numeric", "numeric"))
    t$DateTime <- strptime(paste(t$Date, t$Time), format="%d/%m/%Y %H:%M:%S")
    t$Date <- as.Date(t$Date, "%d/%m/%Y")
    t <- t[-2] # Get rid of Time column
    # Return only the subset of dates we care about
    t <- subset(t, t$Date == "2007-02-01" | t$Date == "2007-02-02")

    saveRDS(t, file=subsetFile)
  } else {
    message("Loading cached subsetted file")
  }

  # Load and return our subset of the data
  readRDS(subsetFile)
}
