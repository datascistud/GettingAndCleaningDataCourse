GettingAndCleaningDataCourse
============================

The script `run_analysis.R` performs data cleaning and transformation on the Human Activity Recognition Using Smartphones Data Set of the UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) as the Getting and Cleaning Data Coursera course project.

The script `run_analysis.R` expects the data set to be in the working copy, unzipped. Another script, `get_data.R` can be used to fetch the data set and unzip it as preparation. Then `run_analysis.R` itself will combine the training and test data sets, exclude all the measurement variables except the means and standard deviations and merge them with the subject and activity IDs (activity IDs are replaced with the human readable labels). As a second step the average of the mean and standard deviations are calculated for each subject-activity pair. The resulting data frame contains the averages for one such pair in each row, various measurement variables are stored in the various columns. Rows are named by the subject-activity pair (there are 30x6 = 180 such pairs), columns are named by the measurement variable names (there are 66 measurement variables).

The script is a standalone, it should be run from the OS shell, it's usage: `run_analysis.R [<tidy output csv> [<intermediary output csv]]`.
If run without any arguments, `run_analysis.R` will print out the result data set of the second step. If an argument is provided, the script will write the data set in CSV format to a file specified by the argument instead. If a second argument is also specified, the intermediary data set created after the first step is written to the file specified by the second argument, also in CSV format.

Activity labels are fetched from `activity_labels.txt`, contained in the original data set, feature variables represented in the columns are named using `features.txt`, also contained in the original data set.
