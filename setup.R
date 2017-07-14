# set up required libraries and data

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

if(!file.exists("Dataset.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip")
}

if(!file.exists("UCI HAR Dataset")) {
        unzip("Dataset.zip")    
}

