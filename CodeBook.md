

Code in file run_analysis.R performs the following action respectively

First of all it merges all data sets to create one data set.

Reading files as shown below

Reading trainings tables in data tables:  x_train, y_train and subject_train variables
Reading testing tables in data tables: x_test, y_test, subject_test
Reading feature vector in vector: features
Reading activity labels in table activityLabels

Then it assigns column names from second column of features vector to column names of x_train and x_test as shown in line 14 and 20.

Column names of data table activityLabels are activityId and activityType

Merging all data in one set is performed with rbind function. rbind merges together rows of testing and training tables.

Testing and training tables are each merged with cbind.

Now that we have one merged data (mergedDT table), next step is to extract only the measurements on the mean and standard deviation for each measurement

For this step we read all column names of mergedDT and use grepl function to create vector whcih has ID (subjectID and activityID), mean and standard deviation

Using this vector we extract a dataset from mergedDT which has ID, mean and standard deviation called datasetMeanStd

Then we extract a second independant tidy data set with average of each variable for each activity and each subject.

Finally we wirte tidy data set in a txt file.