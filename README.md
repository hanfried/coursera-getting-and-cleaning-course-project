# coursera-getting-and-cleaning-course-project

This project is the final part of the MOOC from coursera [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome). 
Here, the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) dataset is analyzed, found to download under [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones].

The github account for this project and this README is at [https://github.com/hanfried/coursera-getting-and-cleaning-course-project]. The dataset isn't included to the github project, it is found to download under [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

There are 2 scripts inside:
  - get_and_read_dataset.R
  - run_analysis.R
  
## get_and_read_dataset.R

This script will first check, whether the dataset zip file is already downloaded to the local working directory with the name 'dataset_human_activity_recognition_using_smartphones.zip'. If it isn't it will download it. 

It will also check whether there is a subfolder 'UCI HAR Dataset' in the local working directory. If not, it will unzip the dataset zip file into this in case new created subdir called 'UCI HAR Dataset' (note the whitespace inside). Note also, the script does not test whether the data files are also inside the folder 'UCI HAR Dataset'. If you run into problems, remove this directory and rerun get_and_read_dataset.R

After downloading und unzipping the raw data, the script will read in the files

- X_test.txt,y_test.txt,subject_test.txt 'UCI HAR Dataset'/test folder into X_test,y_test,subject_test
variables 
- X_train.txt,y_train.txt,subject_train.txt 'UCI HAR Dataset'/test folder into X_test,y_test,subject_train variables 
- 'UCI HAR Dataset'/features.txt into variable features
- 'UCI HAR Dataset'/activity_labels.txt into variable activities
  
The script ignores the available 'Inertial Signals' sub folders in test/ and train/ folders.

After running the script, as a test, we should get

    ### Check the dimensions of the readin data
    # just to find out what's going on
    dim(X_test)           # [1] 2947  561
    dim(y_test)           # [1] 2947    1
    dim(subject_test)     # [1] 2947    1
    
    dim(X_train)          # [1] 7352  561
    dim(y_train)          # [1] 7352    1
    dim(subject_train)    # [1] 7352    1

    dim(features)         # [1] 561   2   # 1st column = 1:561, 2nd column is name of feature
    dim(activities)       # [1] 6 2       # 1st column = 1:6, 2nd column is label of activity
    
## run_analysis.R

This script _expects_ to have the variables after running get_and_read_dataset.R in the global environment.

run_analysis does:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script generates the following variables:

- (for internal use) test_df   : dataframes of the combined input X_test,y_test,subject_test
- (for internal use) train_df  : dataframes of the combined input X_train,y_train,subject_train
- (result of step 1) merged_df : merged dataframe of test_df and train_df
- tidy_df : tidied up dataframe
- (result of step 4) tidy_only_mean_std_measurements_df : 
- (result of step 5) avg_value_by_feature_and_activity_and_subject_df 

Look at the [Codebook](https://github.com/hanfried/coursera-getting-and-cleaning-course-project/blob/master/Codebook.md) for more details about.
  