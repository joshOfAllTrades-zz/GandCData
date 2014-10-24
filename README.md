Getting and Cleaning Data Course Project
=========

## run_analysis.R

This script performs all of the steps necessary to satisfy the requirements of the project. No arguments are required. Running the script performs a number of steps more thoroughly described in the [Code Book](CodeBook.md), but at a high level it...

1. Downloads the raw data from the Internet (if it has not already done so)
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

