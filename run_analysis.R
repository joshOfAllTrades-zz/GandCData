####
# Constants and paths for use later
srcHost <- "https://d396qusza40orc.cloudfront.net"
srcPath <- "/getdata%2Fprojectfiles%2F"
srcFile <- "UCI%20HAR%20Dataset.zip"
srcUrl <- paste(srcHost, srcPath, srcFile, sep = "")

dataDir <- "data"
file <- "uciDataset.zip"
manualFile <- "UCI HAR Dataset.zip"
destFile <- paste(dataDir, file, sep = "/")

unzipDir <- "UCI HAR Dataset"
rawDataDir <- paste(dataDir, unzipDir, sep = "/")

# Features
featuresFile <- paste(rawDataDir, "features.txt", sep = "/")

# Activity Catalog
activitiesFile <- paste(rawDataDir, "activity_labels.txt", sep = "/")

# Training files
trainDir     <- paste(rawDataDir, "train", sep = "/")
trainSbjFile <- paste(trainDir, "subject_train.txt", sep = "/")
trainXFile   <- paste(trainDir, "X_train.txt", sep = "/")
trainYFile   <- paste(trainDir, "Y_train.txt", sep = "/")

# Testing files
testDir     <- paste(rawDataDir, "test", sep = "/")
testSbjFile <- paste(testDir, "subject_test.txt", sep = "/")
testXFile   <- paste(testDir, "X_test.txt", sep = "/")
testYFile   <- paste(testDir, "Y_test.txt", sep = "/")

# The output file for my resulting tidy data
tidyFile    <- paste(dataDir, "tidy.txt", sep = "/")

####
# Get the raw data

# Make sure the data directory exists; create it if it doesn't. Further, assume
# that we need to download and unpack the data.
if (!file.exists(dataDir)) {
    dir.create(dataDir)
}

# Check to see if the zip file exists where we expect it. If not then look for
# a copy of the file "next to" the script. If not there, then download it.
if (!file.exists(destFile)) {
    if (file.exists(manualFile)) {
        file.copy(manualFile, destFile)
    } else {
        download.file(srcUrl, destfile = destFile)
    }
}

# Finally, unzip the file for further processing.
if (!file.exists(rawDataDir)) {
  unzip(destFile, exdir = dataDir)
}

####
# Read in the relevant data files for further manipulation

# Start with the subject files as these are simple, 1-field wide tables
trainSbj <- read.csv(trainSbjFile, header = FALSE)
testSbj  <- read.csv(testSbjFile, header = FALSE)

# Get the names of the features (variables), and find the ones that contain
# either the word "mean" or "Mean". I'm going to use these columns to determine
# which features to read from the training and testing data.
features <- read.table(featuresFile, sep = " ")
means <- grepl("mean()", features$V2)
stds  <- grepl("std()", features$V2)
keeperFields <- means | stds
fieldNames <- features$V2[keeperFields]

# When reading fixed width fields a negative number means to skip that many
# characters. In our situation all fields are 16 characters wide so I'm
# creating an array of 16 and -16 based on the fields of interest.
fields <- ifelse(keeperFields, 16, -16)

# Read in the training and testing data using our reduced fields. Again,
# instead of reading in the full 561 fields, I'm only reading in those fields
# that have the word "mean" or "Mean" in its feature name.
# ******** Satisfies Step 2 by only reading the mean() and std() fields ********
# 2 Extract only the measurements on the mean and standard deviation for each
#   measurement
trainX   <- read.fwf(trainXFile, fields, header = FALSE)
trainY   <- read.csv(trainYFile, header = FALSE)
testX    <- read.fwf(testXFile, fields, header = FALSE)
testY    <- read.csv(testYFile, header = FALSE)

# Read in the activity catalog
actCat <- read.table(activitiesFile,
                     header = FALSE,
                     sep = " ",
                     colClasses = c("numeric", "character"))

####
# Combine the data into a single, large data frame.

# Time to bind the subjects, activity, and test/train data
# ******** Satisifies Step 1 by merging the training and test sets ********
# 1 Merge the training and the test sets to create one data set
data <- rbind(cbind(testSbj, testY, testX),
              cbind(trainSbj, trainY, trainX))

####
# Do a little labeling of the data

# Convert the activities to factors and provide the levels
# ******** Satisfies Step 3 by providing activity names in the data ********
# 3 Use descriptive activity names to name the activities in the data set
data$Activity <- factor(data$Activity)
levels(data$Activity) <- actCat$V2

# Assign features as the column names
# ******** Satisfies Step 4 by labeling the variables ********
# 4 Appropriately label the data set with descriptive variable names
names(data) <- union(c("Subject", "Activity"), fieldNames)

####
# Create my new tidy data set
library(reshape2)
library(plyr)

# Melt the data frame so I can calculate the averages
dataMelt <- melt(data, id = c("Subject", "Activity"))

# ******** Satisfies Step 5 with a tall, skinny data set ********
# 5 From the data set in step 4, create a second, independent tidy data set
#   with the average of each variable for each activity and each subject
avgs <- ddply(dataMelt,
              c("Subject", "Activity", "variable"),
              summarize, mean = mean(value))

# Save the resulting data for submission
write.table(avgs, file = tidyFile, row.name = FALSE)

