


Merge the training and the test sets to create one data set.
    Load activity & feature labels, and raw X/y/subject train and test data sets


```r
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
```

    Apply feature labels and names for activity and subject ids


```r
names(X_train) = features
names(X_test) = features
names(y_test) = "Activity"
names(y_train) = "Activity"
names(subject_train) = "Subject"
names(subject_test) = "Subject"
```

    combine test and train data into single data frame


```r
test_data <- cbind(as.data.table(subject_test), y_test, X_test)
train_data <- cbind(as.data.table(subject_train), y_train, X_train)
all_data = rbind(test_data, train_data)
```

Extract only the measurements on the mean and standard deviation for each measurement.
    extract features containing mean and std only


```r
required_features <- grepl("mean|std", features)
```

    keep only subject, activity and required features in all_data


```r
all_data = all_data[,c(TRUE, TRUE, required_features), with=FALSE]
```

Use descriptive activity names to name the activities in the data set
    replace Activity column contents (ids) with the matching labels


```r
all_data <- mutate(all_data, Activity=activity_labels[Activity])
```

Appropriately label the data set with descriptive variable names.
expand various abbreviated feature names for clarity


```r
names(all_data) <- gsub("^t", "Time", names(all_data))
names(all_data) <- gsub("^f", "Frequency", names(all_data))
names(all_data) <- gsub("BodyBody", "Body", names(all_data))
names(all_data) <- gsub("-mean\\(\\)", "Mean", names(all_data))
names(all_data) <- gsub("-std\\(\\)", "StandardDeviation", names(all_data))
names(all_data) <- gsub("-meanFreq\\(\\)", "MeanFrequency", names(all_data))
names(all_data) <- gsub("Acc", "Accelerometer", names(all_data))
names(all_data) <- gsub("Gyro", "Gyroscope", names(all_data))
```

Create a second, independent tidy data set with the average of each variable for 
each activity and each subject.
    turn all_data into long form, keyed by subject and activity


```r
melted <- melt(all_data, id=c("Subject","Activity"))
```

    turn back into wide form, with mean of each variable


```r
tidy <- dcast(melted, Subject+Activity ~ variable, mean)
```

    write the tidy data to a csv file


```r
write.csv(tidy, "./tidy.csv", row.names=FALSE)
```

Tidy Data Description


```r
knitr::kable(names(tidy), caption = "Tidy Data Variables", col.names=c("Variable"))
```



|Variable                                           |
|:--------------------------------------------------|
|Subject                                            |
|Activity                                           |
|TimeBodyAccelerometerMean-X                        |
|TimeBodyAccelerometerMean-Y                        |
|TimeBodyAccelerometerMean-Z                        |
|TimeBodyAccelerometerStandardDeviation-X           |
|TimeBodyAccelerometerStandardDeviation-Y           |
|TimeBodyAccelerometerStandardDeviation-Z           |
|TimeGravityAccelerometerMean-X                     |
|TimeGravityAccelerometerMean-Y                     |
|TimeGravityAccelerometerMean-Z                     |
|TimeGravityAccelerometerStandardDeviation-X        |
|TimeGravityAccelerometerStandardDeviation-Y        |
|TimeGravityAccelerometerStandardDeviation-Z        |
|TimeBodyAccelerometerJerkMean-X                    |
|TimeBodyAccelerometerJerkMean-Y                    |
|TimeBodyAccelerometerJerkMean-Z                    |
|TimeBodyAccelerometerJerkStandardDeviation-X       |
|TimeBodyAccelerometerJerkStandardDeviation-Y       |
|TimeBodyAccelerometerJerkStandardDeviation-Z       |
|TimeBodyGyroscopeMean-X                            |
|TimeBodyGyroscopeMean-Y                            |
|TimeBodyGyroscopeMean-Z                            |
|TimeBodyGyroscopeStandardDeviation-X               |
|TimeBodyGyroscopeStandardDeviation-Y               |
|TimeBodyGyroscopeStandardDeviation-Z               |
|TimeBodyGyroscopeJerkMean-X                        |
|TimeBodyGyroscopeJerkMean-Y                        |
|TimeBodyGyroscopeJerkMean-Z                        |
|TimeBodyGyroscopeJerkStandardDeviation-X           |
|TimeBodyGyroscopeJerkStandardDeviation-Y           |
|TimeBodyGyroscopeJerkStandardDeviation-Z           |
|TimeBodyAccelerometerMagMean                       |
|TimeBodyAccelerometerMagStandardDeviation          |
|TimeGravityAccelerometerMagMean                    |
|TimeGravityAccelerometerMagStandardDeviation       |
|TimeBodyAccelerometerJerkMagMean                   |
|TimeBodyAccelerometerJerkMagStandardDeviation      |
|TimeBodyGyroscopeMagMean                           |
|TimeBodyGyroscopeMagStandardDeviation              |
|TimeBodyGyroscopeJerkMagMean                       |
|TimeBodyGyroscopeJerkMagStandardDeviation          |
|FrequencyBodyAccelerometerMean-X                   |
|FrequencyBodyAccelerometerMean-Y                   |
|FrequencyBodyAccelerometerMean-Z                   |
|FrequencyBodyAccelerometerStandardDeviation-X      |
|FrequencyBodyAccelerometerStandardDeviation-Y      |
|FrequencyBodyAccelerometerStandardDeviation-Z      |
|FrequencyBodyAccelerometerMeanFrequency-X          |
|FrequencyBodyAccelerometerMeanFrequency-Y          |
|FrequencyBodyAccelerometerMeanFrequency-Z          |
|FrequencyBodyAccelerometerJerkMean-X               |
|FrequencyBodyAccelerometerJerkMean-Y               |
|FrequencyBodyAccelerometerJerkMean-Z               |
|FrequencyBodyAccelerometerJerkStandardDeviation-X  |
|FrequencyBodyAccelerometerJerkStandardDeviation-Y  |
|FrequencyBodyAccelerometerJerkStandardDeviation-Z  |
|FrequencyBodyAccelerometerJerkMeanFrequency-X      |
|FrequencyBodyAccelerometerJerkMeanFrequency-Y      |
|FrequencyBodyAccelerometerJerkMeanFrequency-Z      |
|FrequencyBodyGyroscopeMean-X                       |
|FrequencyBodyGyroscopeMean-Y                       |
|FrequencyBodyGyroscopeMean-Z                       |
|FrequencyBodyGyroscopeStandardDeviation-X          |
|FrequencyBodyGyroscopeStandardDeviation-Y          |
|FrequencyBodyGyroscopeStandardDeviation-Z          |
|FrequencyBodyGyroscopeMeanFrequency-X              |
|FrequencyBodyGyroscopeMeanFrequency-Y              |
|FrequencyBodyGyroscopeMeanFrequency-Z              |
|FrequencyBodyAccelerometerMagMean                  |
|FrequencyBodyAccelerometerMagStandardDeviation     |
|FrequencyBodyAccelerometerMagMeanFrequency         |
|FrequencyBodyAccelerometerJerkMagMean              |
|FrequencyBodyAccelerometerJerkMagStandardDeviation |
|FrequencyBodyAccelerometerJerkMagMeanFrequency     |
|FrequencyBodyGyroscopeMagMean                      |
|FrequencyBodyGyroscopeMagStandardDeviation         |
|FrequencyBodyGyroscopeMagMeanFrequency             |
|FrequencyBodyGyroscopeJerkMagMean                  |
|FrequencyBodyGyroscopeJerkMagStandardDeviation     |
|FrequencyBodyGyroscopeJerkMagMeanFrequency         |

