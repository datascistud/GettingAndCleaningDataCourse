#!/usr/bin/env Rscript

if (!file.exists("rawdata.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", method="curl", destfile="rawdata.zip")
}
unzip("rawdata.zip")
