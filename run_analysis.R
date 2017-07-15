#' #### Codebook
#' Generated on 
{{now()}}


#+ setup, include=FALSE
require("data.table")
require("reshape2")
require("dplyr")
require("knitr")

#' #### Process:

#' #####Merge the training and the test sets to create one data set.#####

#' Load activity & feature labels, and raw X/y/subject train and test data sets
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#' apply feature labels and names for activity and subject ids
names(X_train) = features
names(X_test) = features
names(y_test) = "Activity"
names(y_train) = "Activity"
names(subject_train) = "Subject"
names(subject_test) = "Subject"

#' combine test and train data into single data frame
test_data <- cbind(as.data.table(subject_test), y_test, X_test)
train_data <- cbind(as.data.table(subject_train), y_train, X_train)
all_data = rbind(test_data, train_data)

#' #####Extract only the measurements on the mean and standard deviation for each measurement.#####

#' extract features containing mean and std only
required_features <- grepl("mean|std", features)

#' keep only subject, activity and required features in all_data
all_data = all_data[,c(TRUE, TRUE, required_features), with=FALSE]

#' #####Use descriptive activity names to name the activities in the data set#####

#'     replace Activity column contents (ids) with the matching labels
all_data <- mutate(all_data, Activity=activity_labels[Activity])


#' #####Appropriately label the data set with descriptive variable names.#####

#' expand various abbreviated feature names for clarity
names(all_data) <- gsub("^t", "Time", names(all_data))
names(all_data) <- gsub("^f", "Frequency", names(all_data))
names(all_data) <- gsub("BodyBody", "Body", names(all_data))
names(all_data) <- gsub("-mean\\(\\)", "Mean", names(all_data))
names(all_data) <- gsub("-std\\(\\)", "StandardDeviation", names(all_data))
names(all_data) <- gsub("-meanFreq\\(\\)", "MeanFrequency", names(all_data))
names(all_data) <- gsub("Acc", "Accelerometer", names(all_data))
names(all_data) <- gsub("Gyro", "Gyroscope", names(all_data))


#' #####Create a second, independent tidy data set with the average of each variable for each activity and each subject.#####

#' turn all_data into long form, keyed by subject and activity
melted <- melt(all_data, id=c("Subject","Activity"))

#' turn back into wide form, with mean of each variable
tidy <- dcast(melted, Subject+Activity ~ variable, mean)

#' write the tidy data to a csv file
write.csv(tidy, "./tidy.csv", row.names=FALSE)

#' #### Tidy Data Description:

#+ create variable descriptions, include=FALSE
variables <- as.data.frame(names(tidy), col.names=c("variable")) %>% mutate(description="Mean of feature as described in raw data description")
variables[1,2] <- "ID of subject"
variables[2,2] <- "Label for activity"

#+ Variables
knitr::kable(variables, caption = "Tidy Data Variables", col.names=c("Variable", "Description"))

#' #### Session info:
#+ show-sessionInfo
sessionInfo()
