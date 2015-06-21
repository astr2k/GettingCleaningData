## Read training and test datasets
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_data  <- read.table("./UCI HAR Dataset/test/X_test.txt")

## Merge into one dataset
all_data <- rbind(train_data, test_data)

## Subset data to use only mean and standard deviation measurements
## As seen in features.txt these are in the columns as follows (having mean() or std() as part of name):
use_columns <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,
                 162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,
                 270,271,294,295,296,345,346,347,348,349,350,373,374,375,424,425,426,427,428,
                 429,452,453,454,503,504,513,516,517,526,529,530,539,542,543,552)
all_data <- all_data[, use_columns]

## Merge Activity labels of train and test data
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_activity  <- read.table("./UCI HAR Dataset/test/y_test.txt")
activity_labels <- rbind(train_activity, test_activity)

## Use convenient name
names(activity_labels) <- c("ActivityLabel")

## Add activity labels to our data
all_data <- cbind(all_data, activity_labels)

## Read subject values, merge train and test data and add to our dataset
train_subj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subj  <- read.table("./UCI HAR Dataset/test/subject_test.txt")
all_subj <- rbind(train_subj, test_subj)
names(all_subj) <- c("Subject")
all_data <- cbind(all_data, all_subj)


## We are going to use descriptive names for activities, let's match labels to names
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_names) <- c("ActivityLabel","Activity")

## Add names to our data according to labels
all_data <- merge(all_data, activity_names, by.x="ActivityLabel", by.y="ActivityLabel")

## Remove column with activity labels as it is not needed anymore
all_data$ActivityLabel <- NULL

## Label the dataset with descriptive variable names
## Measurements names are taken from features.txt and slightly modified
names(all_data) <- c(
  "tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z","tGravityAcc_mean_X",
  "tGravityAcc_mean_Y","tGravityAcc_mean_Z","tGravityAcc_std_X","tGravityAcc_std_Y","tGravityAcc_std_Z","tBodyAccJerk_mean_X",
  "tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z","tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z","tBodyGyro_mean_X",
  "tBodyGyro_mean_Y","tBodyGyro_mean_Z","tBodyGyro_std_X","tBodyGyro_std_Y","tBodyGyro_std_Z","tBodyGyroJerk_mean_X",
  "tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyGyroJerk_std_X","tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z",
  "tBodyAccMag_mean","tBodyAccMag_std","tGravityAccMag_mean","tGravityAccMag_std","tBodyAccJerkMag_mean","tBodyAccJerkMag_std",
  "tBodyGyroMag_mean","tBodyGyroMag_std","tBodyGyroJerkMag_mean","tBodyGyroJerkMag_std","fBodyAcc_mean_X","fBodyAcc_mean_Y",
  "fBodyAcc_mean_Z","fBodyAcc_std_X","fBodyAcc_std_Y","fBodyAcc_std_Z","fBodyAcc_meanFreq_X","fBodyAcc_meanFreq_Y",
  "fBodyAcc_meanFreq_Z","fBodyAccJerk_mean_X","fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyAccJerk_std_X",
  "fBodyAccJerk_std_Y","fBodyAccJerk_std_Z","fBodyAccJerk_meanFreq_X","fBodyAccJerk_meanFreq_Y","fBodyAccJerk_meanFreq_Z",
  "fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z","fBodyGyro_std_X","fBodyGyro_std_Y","fBodyGyro_std_Z",
  "fBodyGyro_meanFreq_X","fBodyGyro_meanFreq_Y","fBodyGyro_meanFreq_Z","fBodyAccMag_mean","fBodyAccMag_std",
  "fBodyAccMag_meanFreq","fBodyBodyAccJerkMag_mean","fBodyBodyAccJerkMag_std","fBodyBodyAccJerkMag_meanFreq",
  "fBodyBodyGyroMag_mean","fBodyBodyGyroMag_std","fBodyBodyGyroMag_meanFreq","fBodyBodyGyroJerkMag_mean",
  "fBodyBodyGyroJerkMag_std","fBodyBodyGyroJerkMag_meanFreq",
  "Subject", "Activity" )


## Create dataset with the average of each variable for each activity and each subject
result_data <- aggregate(. ~ Subject + Activity, data = all_data, FUN = mean)

## Apply sorting for convenience
result_data <- result_data[ order(result_data[, 1], result_data[, 2]), ]

## Write resulting data to file
write.table(result_data, "./result.txt", row.name=FALSE)
