## testHarness:  Tests the four plotting functions, verifying that they are
## able to both plot to the screen (without creating PNG files) and plot to a
## PNG file (without plotting to the screen).  The default behavior of each
## plot function is to plot to a PNG file.
## Argument: clean - if equal to (or coerces to) TRUE, the whole "data" folder
## will be deleted before any plot function is called to prove that the code to
## download, unzip, and subset the data works.  If equal to "subset" then only
## the pre-subsetted file will be deleted (if it exists).
## Returns: FALSE if something detectably went wrong.  TRUE otherwise.
testHarness <- function(clean = TRUE) {
  pass = TRUE

  if (clean == TRUE && file.exists("data")) {
    message("Removing the whole data folder")
    unlink("data", recursive = TRUE, force = TRUE)
  }

  subsetFile <- "data/household_power_subset.rds"
  if (clean == "subset" && file.exists(subsetFile)) {
    message("Removing the subset file")
    unlink(subsetFile)
  }

  plots <- c("plot1.png", "plot2.png", "plot3.png", "plot4.png")

  for (f in plots) {
    if (file.exists(f)) {
      message(paste("Removing old plot file", f))
      unlink(f)
    }
  }

  message("\nTesting screen plotting...")
  plot1(screen = TRUE)
  invisible(readline(prompt = "press ENTER before plot 2: "))
  plot2(screen = TRUE)
  invisible(readline(prompt = "press ENTER before plot 3: "))
  plot3(screen = TRUE)
  invisible(readline(prompt = "press ENTER before plot 4: "))
  plot4(screen = TRUE)

  if (any(file.exists(plots))) {
    pass = FALSE
    for (f in plots) {
      if (file.exists(f)) {
        message(paste("*** Plot file", f, "unexpectedly exists ***"))
      }
    }
  }

  # For some reason, if we don't readline AFTER graphics.off() then it doesn't
  # visibly take effect until after the four PNG files are created.  To make it
  # unambiguous that the screen plotting is gone before we create PNGs, do the
  # one more readline.
  invisible(readline(prompt = "press ENTER before closing graphics window: "))
  graphics.off()
  invisible(readline(prompt = "press ENTER before PNG plotting: "))

  message("\nTesting PNG file plotting...")
  plot1()
  plot2()
  plot3()
  plot4()

  for (f in plots) {
    if (!file.exists(f)) {
      pass = FALSE
      message(paste("*** Plot file", f, "does not exist ***"))
    }
  }

  message("\nTest complete")
  pass
}
