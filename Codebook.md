#### Codebook
Generated on 
2017-07-15 14:40:06



#### Process:
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

#### Tidy Data Description:



```r
knitr::kable(variables, caption = "Tidy Data Variables", col.names=c("Variable", "Description"))
```



|Variable                                           |Description                                          |
|:--------------------------------------------------|:----------------------------------------------------|
|Subject                                            |ID of subject                                        |
|Activity                                           |Label for activity                                   |
|TimeBodyAccelerometerMean-X                        |Mean of feature as described in raw data description |
|TimeBodyAccelerometerMean-Y                        |Mean of feature as described in raw data description |
|TimeBodyAccelerometerMean-Z                        |Mean of feature as described in raw data description |
|TimeBodyAccelerometerStandardDeviation-X           |Mean of feature as described in raw data description |
|TimeBodyAccelerometerStandardDeviation-Y           |Mean of feature as described in raw data description |
|TimeBodyAccelerometerStandardDeviation-Z           |Mean of feature as described in raw data description |
|TimeGravityAccelerometerMean-X                     |Mean of feature as described in raw data description |
|TimeGravityAccelerometerMean-Y                     |Mean of feature as described in raw data description |
|TimeGravityAccelerometerMean-Z                     |Mean of feature as described in raw data description |
|TimeGravityAccelerometerStandardDeviation-X        |Mean of feature as described in raw data description |
|TimeGravityAccelerometerStandardDeviation-Y        |Mean of feature as described in raw data description |
|TimeGravityAccelerometerStandardDeviation-Z        |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkMean-X                    |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkMean-Y                    |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkMean-Z                    |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkStandardDeviation-X       |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkStandardDeviation-Y       |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkStandardDeviation-Z       |Mean of feature as described in raw data description |
|TimeBodyGyroscopeMean-X                            |Mean of feature as described in raw data description |
|TimeBodyGyroscopeMean-Y                            |Mean of feature as described in raw data description |
|TimeBodyGyroscopeMean-Z                            |Mean of feature as described in raw data description |
|TimeBodyGyroscopeStandardDeviation-X               |Mean of feature as described in raw data description |
|TimeBodyGyroscopeStandardDeviation-Y               |Mean of feature as described in raw data description |
|TimeBodyGyroscopeStandardDeviation-Z               |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkMean-X                        |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkMean-Y                        |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkMean-Z                        |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkStandardDeviation-X           |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkStandardDeviation-Y           |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkStandardDeviation-Z           |Mean of feature as described in raw data description |
|TimeBodyAccelerometerMagMean                       |Mean of feature as described in raw data description |
|TimeBodyAccelerometerMagStandardDeviation          |Mean of feature as described in raw data description |
|TimeGravityAccelerometerMagMean                    |Mean of feature as described in raw data description |
|TimeGravityAccelerometerMagStandardDeviation       |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkMagMean                   |Mean of feature as described in raw data description |
|TimeBodyAccelerometerJerkMagStandardDeviation      |Mean of feature as described in raw data description |
|TimeBodyGyroscopeMagMean                           |Mean of feature as described in raw data description |
|TimeBodyGyroscopeMagStandardDeviation              |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkMagMean                       |Mean of feature as described in raw data description |
|TimeBodyGyroscopeJerkMagStandardDeviation          |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMean-X                   |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMean-Y                   |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMean-Z                   |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerStandardDeviation-X      |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerStandardDeviation-Y      |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerStandardDeviation-Z      |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMeanFrequency-X          |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMeanFrequency-Y          |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMeanFrequency-Z          |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMean-X               |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMean-Y               |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMean-Z               |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkStandardDeviation-X  |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkStandardDeviation-Y  |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkStandardDeviation-Z  |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMeanFrequency-X      |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMeanFrequency-Y      |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMeanFrequency-Z      |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMean-X                       |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMean-Y                       |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMean-Z                       |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeStandardDeviation-X          |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeStandardDeviation-Y          |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeStandardDeviation-Z          |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMeanFrequency-X              |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMeanFrequency-Y              |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMeanFrequency-Z              |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMagMean                  |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMagStandardDeviation     |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerMagMeanFrequency         |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMagMean              |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMagStandardDeviation |Mean of feature as described in raw data description |
|FrequencyBodyAccelerometerJerkMagMeanFrequency     |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMagMean                      |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMagStandardDeviation         |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeMagMeanFrequency             |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeJerkMagMean                  |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeJerkMagStandardDeviation     |Mean of feature as described in raw data description |
|FrequencyBodyGyroscopeJerkMagMeanFrequency         |Mean of feature as described in raw data description |

#### Session info:


```r
sessionInfo()
```

```
## R version 3.3.3 (2017-03-06)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: macOS Sierra 10.12.5
## 
## locale:
## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.16        bindrcpp_0.2      dplyr_0.7.1       reshape2_1.4.2   
## [5] data.table_1.10.4 lubridate_1.6.0  
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.11     bindr_0.1        magrittr_1.5     R6_2.2.1        
##  [5] rlang_0.1.1      highr_0.6        stringr_1.2.0    httr_1.2.1      
##  [9] plyr_1.8.4       tools_3.3.3      htmltools_0.3.6  rprojroot_1.2   
## [13] yaml_2.1.14      digest_0.6.12    assertthat_0.2.0 tibble_1.3.3    
## [17] crayon_1.3.2     bitops_1.0-6     RCurl_1.95-4.8   testthat_1.0.2  
## [21] glue_1.1.1       evaluate_0.10.1  rmarkdown_1.6    stringi_1.1.5   
## [25] backports_1.1.0  swirl_2.4.3      markdown_0.8     pkgconfig_2.0.1
```

