Getting and Cleaning Data Course Project
========

## Code Book

### Source Data

The source data is from Spanish researchers attempting to identify volunteer's activities based on the sensor readings from a Samsung Galaxy S II smartphone on the volunteers' waists. The researchers observed the volunteers while the volunteers performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING). The researchers then processed the sensor data through various methods as described in the README.txt included within the source ZIP file. The researchers partitioned the data into two sets: a training set with 70% of the volunteers and testing set with the remaining 30%.

The ZIP file containing the source data was acquired from [Coursera](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

### Processing

The [Read Me](README.md) gives a high-level overview of the `run_analysis.R` script. A more thorough explination follows. The `run_analysis.R` script is the main and only script required to process the source data into the required tidy data set. The script performs the following steps to produce the tidy data set:

1. Defines a number of "constants" for use in later steps.
1. Downloads the source ZIP file if it has not previously been downloaded.
1. Unzips the contents of the ZIP file.
1. Reads in the subject files.
  * `subject_train.txt`
  * `subject_test.txt`
1. Reads in the feature labels (`features.txt`).
1. Determines which features represent calculations of mean and standard deviation values by looking for feature names with the strings "mean()" and "std()".
1. Reads in the testing and training "X" data utilizing the previously determined interesting features to read a subset of the features and reduce the amount of data loaded from disk (**thus satisfying assignment requirement #2**).
  * `X_train.txt`
  * `X_test.txt`
1. Reads in the testing and training "Y" data (observed activies).
  * `Y_train.txt`
  * `Y_test.txt`
1. Reads in the activity mapping (1 = walking, 2 = walking upstairs, etc) (`activity_labels.txt`).
1. Combines the subjects, observed activities, and selected feature data into a single data frame (**thus satisfying assignment requirment #1**).
1. Utilizing the activity mapping, gives the observed activities meaningful labels (**thus satisfying assignment requirement #3**).
1. Utilizing the feature labels, names the retained variables in the data set (**thus satisfying assignment requirement #4**).
1. Using the reshape2 library, melts the wide data to a tall data set.
1. Using the plyr library, calculates the mean for each variable for each subject and activity (**thus satisfying assignment requirement #5**). 
1. Writes the resulting tidy data set to the data directory as the file `tidy.txt`.

### Data Dictionary
There are four fields in the tidy data set produced by the script.

#### Subject
The subject field denotes to which participant the data belongs. The subjects are numbered from 1 to 30.

#### Activity
The activities were scored by human observers of the volunteers. In the original data the activities were provided in numeric form, however in the produced data set the activities are textual. There are six possible values for this field.
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

#### variable
The variable field identifies which feature is captured in a given row. These names are taken directly from the original data and their meanings are identical to the meanings provided there.

#### mean
The mean was calculated for each variable for each activity for each subject. In other words the data was grouped by subject and activity and the mean of the variable values was calculated. It is this mean that populates this field.
