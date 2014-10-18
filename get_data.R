# The purpose of this script is to acquire the raw data for this project. The
# data is available as a zip file. It needs to be downloaded and unzipped
# before any cleaning my begin.

# Let's define some "constants"
srcHost <- "https://d396qusza40orc.cloudfront.net"
srcPath <- "/getdata%2Fprojectfiles%2F"
srcFile <- "UCI%20HAR%20Dataset.zip"
srcUrl <- paste(srcHost, srcPath, srcFile, sep = "")

dataDir <- "data"
file <- "uciDataset.zip"
destFile <- paste(dataDir, file, sep = "/")

# Make sure the data directory exists; create it if it doesn't
if (!file.exists(dataDir)) {
  dir.create(dataDir)
}

# Download the zip file
download.file(srcUrl, destfile = destFile)

# Unpack the zip file
unzip(destFile, exdir = dataDir)

