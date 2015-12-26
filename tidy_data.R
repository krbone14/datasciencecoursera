## 1. Merges the training and the test sets to create one data set.

x_data<-rbind(read.table("train/X_train.txt"),read.table("test/X_test.txt"))
y_data<-rbind(read.table("train/y_train.txt"),read.table("test/y_test.txt"))
subject_data<-rbind(read.table("train/subject_train.txt"),read.table("test/subject_test.txt"))

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]

## 3.Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt")
y_data[, 1] <- activity_labels[y_data[, 1], 2]
names(y_data) <- "activity"


##  4.Appropriately labels the data set with descriptive variable names.

names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)


## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
