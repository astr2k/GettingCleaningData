### run_analysis.R script documentation

The script does the following:


#### Merges the training and the test sets to create one data set.

Function `read.table()` is used to load train and test data and then the data is combined using `rbind()`.


#### Extracts only the measurements on the mean and standard deviation for each measurement. 

Using standard subset operation to use only mean and standard deviation measurements.
As seen in features.txt these are in the columns that have "mean()" or "std()" as part of name.


#### Uses descriptive activity names to name the activities in the data set

Matching labels to names is based on activity_labels.txt. Actual operation is done using `merge()` function.


#### Appropriately labels the data set with descriptive variable names. 

Descriptive measurements names are taken from features.txt. Using `names()` to set new values.


#### Creates independent tidy data set with the average of each variable for each activity and each subject.

Using standard `aggregate()` function, the result is then sorted using `order()`.


#### Writes resulting data set to file each subject.

Done with `write.table()` using row.name=FALSE, the name of the output file is result.txt.
