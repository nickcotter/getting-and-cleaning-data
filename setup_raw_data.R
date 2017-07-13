if(!file.exists("Dataset.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip")
}

if(!file.exists("UCI HAR Dataset")) {
        unzip("Dataset.zip")    
}