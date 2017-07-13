require("data.table")
require("reshape2")

#Merges the training and the test sets to create one data set.

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

mean_and_std_features <- grepl("mean|std", features)

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

X_test = X_test[,mean_and_std_features]

#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Appropriately labels the data set with descriptive variable names.