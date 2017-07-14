require("data.table")
require("reshape2")
require("dplyr")

# 1. Merges the training and the test sets to create one data set.

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# feature data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

names(X_train) = features
names(X_test) = features

# activity data
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

names(y_test) = "Activity"
names(y_train) = "Activity"

# subjects
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(subject_train) = "Subject"
names(subject_test) = "Subject"


test_data <- cbind(as.data.table(subject_test), y_test, X_test)
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

all_data = rbind(test_data, train_data)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

required_features <- grepl("mean|std", features)
all_data = all_data[,c(TRUE, TRUE, required_features), with=FALSE]

# 3. Uses descriptive activity names to name the activities in the data set

all_data <- mutate(all_data, Activity=activity_labels[Activity])


# 4. Appropriately labels the data set with descriptive variable names.

names(all_data) <- gsub("^t", "Time", names(all_data))
names(all_data) <- gsub("^f", "Frequency", names(all_data))
names(all_data) <- gsub("BodyBody", "Body", names(all_data))
names(all_data) <- gsub("-mean\\(\\)", "Mean", names(all_data))
names(all_data) <- gsub("-std\\(\\)", "StandardDeviation", names(all_data))
names(all_data) <- gsub("-meanFreq\\(\\)", "MeanFrequency", names(all_data))
names(all_data) <- gsub("Acc", "Accelerometer", names(all_data))
names(all_data) <- gsub("Gyro", "Gyroscope", names(all_data))


# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

melted <- melt(all_data, id=c("Subject","Activity"))
tidy <- dcast(melted, Subject+Activity ~ variable, mean)
write.csv(tidy, "./tidy.csv", row.names=FALSE)
