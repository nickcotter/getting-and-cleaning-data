require("data.table")
require("reshape2")

# 1. Merges the training and the test sets to create one data set.

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

training_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")


names(test_set) = features

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

mean_and_std_features <- grepl("mean|std", features)
test_set = test_set[,mean_and_std_features]

# 3. Uses descriptive activity names to name the activities in the data set
# 4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 5. Appropriately labels the data set with descriptive variable names.