Getting and Cleaning Data Course Project
=========

## get_data.R

get_data.R provides the logic for downloading the raw data from the Internet.

It performs this function in several steps:

1. It checks for the existance of a data subdirectory. It does not change directories as part of execution so this data directory will appear wherever the current directory is.
1. It downloads the data as a zip file.
1. It expands the zip file (also in the data directory). The structure of the zip file causes the data to appear in several sub-directories.

