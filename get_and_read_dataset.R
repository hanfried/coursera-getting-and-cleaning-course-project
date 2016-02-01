### First get the data and unzip in working directory if necessary
# (isn't really analysis, but getting data in a way that is reproducible is also part of it)
dataset_zip_url      <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip';
dataset_zip_filename <- 'dataset_human_activity_recognition_using_smartphones.zip'
dataset_dir          <- 'UCI HAR Dataset'
if (!file.exists(dataset_zip_filename)) {
  download.file(url = dataset_zip_url, destfile = dataset_zip_filename, method = 'wget')
}
if (!file.exists(dataset_dir)) { 
  unzip(dataset_zip_filename) 
}
###


### Now get the raw data from the dataset files into R 
# switch to the dataset dir for the data extraction part
setwd(dataset_dir)                

# first test data
setwd("test")
X_test        <- read.table("X_test.txt")
y_test        <- read.table("y_test.txt")
subject_test  <- read.table("subject_test.txt")
setwd("..")

# second train data
setwd("train")
X_train       <- read.table("X_train.txt")
y_train       <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
setwd("..")

# and meta data information
features      <- read.table("features.txt")
activities    <- read.table("activity_labels.txt")

# I completely ignore so far the available 'Inertial Signals' sub folders in test/ and train/ folders

setwd("..")
###

###