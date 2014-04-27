#!/usr/bin/env Rscript

base_directory <- 'UCI HAR Dataset'

# load feature names
names <- read.csv(file.path(base_directory, 'features.txt'), header = FALSE, sep='', colClasses=c('integer','character'))

# load activity names
activity_labels <- read.csv(file.path(base_directory, 'activity_labels.txt'), header = FALSE, sep='', colClasses=c('integer','character'))

# load training data (name columns with feature names) and activity as the addition column 'activity' and subject as the additional column 'subject'
train <- read.csv(file.path(base_directory, 'train', 'X_train.txt'), header = FALSE, sep='')
names(train) <- names[[2]]
train_activity <- read.csv(file.path(base_directory, 'train', 'y_train.txt'), header = FALSE, sep='')
train$activity <- factor(train_activity[[1]], levels=activity_labels[[1]], labels=activity_labels[[2]])
train_subject <- read.csv(file.path(base_directory, 'train', 'subject_train.txt'), header = FALSE, sep='', colClasses=c('integer'))
train$subject <- factor(train_subject[[1]], levels=1:30)

# load test data (name columns with feature names) and activity as the addition column 'activity' and subject as the additional column 'subject'
test <- read.csv(file.path(base_directory, 'test', 'X_test.txt'), header = FALSE, sep='')
names(test) <- names[[2]]
test_activity <- read.csv(file.path(base_directory, 'test', 'y_test.txt'), header = FALSE, sep='')
test$activity <- factor(test_activity[[1]], levels=activity_labels[[1]], labels=activity_labels[[2]])
test_subject <- read.csv(file.path(base_directory, 'test', 'subject_test.txt'), header = FALSE, sep='', colClasses=c('integer'))
test$subject <- factor(test_subject[[1]], levels=1:30)

# merge training and test data
data <- rbind(train, test)

# extract the measurements on the mean and standard deviation

selected_cols <- c(
 'activity',
 'subject',
 'tBodyAcc-mean()-X',
 'tBodyAcc-mean()-Y',
 'tBodyAcc-mean()-Z',
 'tBodyAcc-std()-X',
 'tBodyAcc-std()-Y',
 'tBodyAcc-std()-Z',
 'tGravityAcc-mean()-X',
 'tGravityAcc-mean()-Y',
 'tGravityAcc-mean()-Z',
 'tGravityAcc-std()-X',
 'tGravityAcc-std()-Y',
 'tGravityAcc-std()-Z',
 'tBodyAccJerk-mean()-X',
 'tBodyAccJerk-mean()-Y',
 'tBodyAccJerk-mean()-Z',
 'tBodyAccJerk-std()-X',
 'tBodyAccJerk-std()-Y',
 'tBodyAccJerk-std()-Z',
 'tBodyGyro-mean()-X',
 'tBodyGyro-mean()-Y',
 'tBodyGyro-mean()-Z',
 'tBodyGyro-std()-X',
 'tBodyGyro-std()-Y',
 'tBodyGyro-std()-Z',
 'tBodyGyroJerk-mean()-X',
 'tBodyGyroJerk-mean()-Y',
 'tBodyGyroJerk-mean()-Z',
 'tBodyGyroJerk-std()-X',
 'tBodyGyroJerk-std()-Y',
 'tBodyGyroJerk-std()-Z',
 'tBodyAccMag-mean()',
 'tBodyAccMag-std()',
 'tGravityAccMag-mean()',
 'tGravityAccMag-std()',
 'tBodyAccJerkMag-mean()',
 'tBodyAccJerkMag-std()',
 'tBodyGyroMag-mean()',
 'tBodyGyroMag-std()',
 'tBodyGyroJerkMag-mean()',
 'tBodyGyroJerkMag-std()',
 'fBodyAcc-mean()-X',
 'fBodyAcc-mean()-Y',
 'fBodyAcc-mean()-Z',
 'fBodyAcc-std()-X',
 'fBodyAcc-std()-Y',
 'fBodyAcc-std()-Z',
 'fBodyAccJerk-mean()-X',
 'fBodyAccJerk-mean()-Y',
 'fBodyAccJerk-mean()-Z',
 'fBodyAccJerk-std()-X',
 'fBodyAccJerk-std()-Y',
 'fBodyAccJerk-std()-Z',
 'fBodyGyro-mean()-X',
 'fBodyGyro-mean()-Y',
 'fBodyGyro-mean()-Z',
 'fBodyGyro-std()-X',
 'fBodyGyro-std()-Y',
 'fBodyGyro-std()-Z',
 'fBodyAccMag-mean()',
 'fBodyAccMag-std()',
 'fBodyBodyAccJerkMag-mean()',
 'fBodyBodyAccJerkMag-std()',
 'fBodyBodyGyroMag-mean()',
 'fBodyBodyGyroMag-std()',
 'fBodyBodyGyroJerkMag-mean()',
 'fBodyBodyGyroJerkMag-std()'
  )

data <- data[, selected_cols]

# create second, independent tidy data set with the average of each variable for each activity and each subject

selected_cols <- selected_cols[-(1:2)]

tidy <- data.frame()
for (col in selected_cols) {
  tidy <- cbind(tidy, numeric())
  colnames(tidy)[ncol(tidy)] <- col
}

names <- names(tidy)
for (activity in levels(data[['activity']])) {
  for (subject in levels(data[['subject']])) {
    tidy <- rbind(tidy, sapply(data[data$activity == activity & data$subject == subject, selected_cols], mean))
    row.names(tidy)[nrow(tidy)] <- paste(activity, subject, sep = '.')
  }
}
names(tidy) <- names


args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  tidy
} else {
  write.table(tidy, file=args[1], sep=',', quote=FALSE, col.names=NA)

  if (length(args) > 1) {
      write.table(data, file=args[2], sep=',', quote=FALSE, col.names=NA)
  }
}
