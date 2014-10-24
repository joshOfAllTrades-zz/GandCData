Getting and Cleaning Data Course Project
=========

## run_analysis.R

This script performs all of the steps necessary to satisfy the requirements of the project. No arguments are required.

### Running the Script

Running the script performs a number of steps more thoroughly described in the [Code Book](CodeBook.md), but at a high level it...

1. Acquires the raw data (see below for details on this process)
1. Reads in the relevant data files
  * features.txt
  * activity_labels.txt
  * subject_train.txt
  * X_train.txt
  * Y_train.txt
  * subject_test.txt
  * X_test.txt
  * Y_test.txt
1. Performs some correlation steps to merge the data into a single data frame.
1. Generates a second data frame which holds the means of the variable's value grouped by both the subject and activity.

### Acquiring the Data

This script performs several steps in order to acquire the data it processes.
1. It looks to see if the `data` directory exists and creates it if it does not.
1. It looks to see if the file `data/uciDataset.zip` exists and continues to the unzipping checks if it does.
1. If the previous step did not find the data, then it looks "next to" the script for the file `UCI HAR Dataset.zip`, copies it to `data/uciDataset.zip`, and continues to the unzippig checks if it does.
1. If the previous step did not find the data, it downloads it from the Internet.
