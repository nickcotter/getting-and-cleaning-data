# Getting and Cleaning Data Course Project


This is the repository for my work on the Coursera Data Science [Getting And Cleaning Data](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project) course project. This is to take some raw accelerometer data for wearable devices and write a script that performs the following actions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How To Run The Analysis ##


#### Prepare The Environment ####

Source the R script [setup.R](setup.R). This will prepare the R environment with the required libraries and download the raw data. The required libraries are:

        data.table
        reshape2
        dplyr
        knitr (for codebook)

#### Create The Tidy Data ####

Source the R scripts [run_analysis.R](run_analysis.R). This will produce a file called tidy.csv


#### Codebook ####

The [Codebook](Codebook.md) was created using [knitr](https://yihui.name/knitr/) from the script [run_analysis.R](run_analysis.R). To generate it run the R script [make_codebook.R](make_codebook.R). This will produce the tidy data and the Codebook.






