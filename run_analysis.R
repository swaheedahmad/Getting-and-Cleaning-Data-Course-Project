
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
             , destfile = "data.zip")
unzip(zipfile="data.zip")



# Reading trainings and testing tables:

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
features <- read.table('UCI HAR Dataset/features.txt')
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
activityLabels = read.table('UCI HAR Dataset/activity_labels.txt')
colnames(activityLabels) <- c('activityId','activityType')


# Merging:
mergedDT <- rbind(cbind(y_train, subject_train, x_train), cbind(y_test, subject_test, x_test))

#Extracting only the measurements on the mean and standard deviation for each measurement

meanStdVector <- (grepl("activityId" , colnames(mergedDT)) | 
                   grepl("subjectId" , colnames(mergedDT)) | 
                   grepl("mean.." , colnames(mergedDT)) | 
                   grepl("std.." , colnames(mergedDT)) )
datasetMeanStd <- mergedDT[,meanStdVector==TRUE]

##Using descriptive activity names to name the activities in the data set:
##Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
datasetDescActNames <- merge(datasetMeanStd, activityLabels, by='activityId', all.x=TRUE)
datasetTidy <- aggregate(. ~subjectId + activityId, datasetDescActNames, mean)
datasetTidy <- datasetTidy[order(datasetTidy$subjectId, datasetTidy$activityId),]
write.table(datasetTidy, "datasetTidy.txt", row.name=FALSE)

