# Codebook of Coursera's Getting and Cleaning Course Project

## Raw Data

/Human+Activity+Recognition+Using+Smartphones) dataset is analyzed, found under [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones].
The raw data file taken as input here is to [download at](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The github account for this project and this README is at [https://github.com/hanfried/coursera-getting-and-cleaning-course-project]. The dataset isn't included to the github project, it is found to download under [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]


## Scripts

The data is downloaded, unzipped and read by the script [get_and_read_dataset.R](https://github.com/hanfried/coursera-getting-and-cleaning-course-project/blob/master/get_and_read_dataset.R).
The analysis is done with [runAnalysis.R](https://github.com/hanfried/coursera-getting-and-cleaning-course-project/blob/master/run_analysis.R)

Look at [README.md](https://github.com/hanfried/coursera-getting-and-cleaning-course-project/blob/master/README.md) for details.

## Output data

run_analysis results in the variables 

- tidy_df : tidied up dataframe
- (result of step 4) tidy_only_mean_std_measurements_df : 
- (result of step 5) avg_value_by_feature_and_activity_and_subject_df 


### tidy_df

is a dataframe looking like:

    Source: local data frame [5,777,739 x 9]

       observation_unit     y subject   part feature_id     value measurement   func variables
                  (chr) (int)   (int) (fctr)     (fctr)     (dbl)       (chr)  (chr)     (chr)
    1                 1     5       2   test          1 0.2571778    tBodyAcc mean()         X
    2                 2     5       2   test          1 0.2860267    tBodyAcc mean()         X
    3                 3     5       2   test          1 0.2754848    tBodyAcc mean()         X
    4                 4     5       2   test          1 0.2702982    tBodyAcc mean()         X
    5                 5     5       2   test          1 0.2748330    tBodyAcc mean()         X
    6                 6     5       2   test          1 0.2792199    tBodyAcc mean()         X
    7                 7     5       2   test          1 0.2797459    tBodyAcc mean()         X
    8                 8     5       2   test          1 0.2746005    tBodyAcc mean()         X
    9                 9     5       2   test          1 0.2725287    tBodyAcc mean()         X
    10               10     5       2   test          1 0.2757457    tBodyAcc mean()         X
    ..              ...   ...     ...    ...        ...       ...         ...    ...       ...

Columns are:

* observation_unit: In the raw data there are 561 observed features for each test/training data unit found in 561 columns. Each row of this observation has got by runAnalysis an own nr identififying it. So in tidy_df, you find for each observation unit 561 rows (with the same observation_unit nr).
* y: Ist a nr indicating the activity seen by the subject.  
     In the variable features, the meaning of the nr are coded.
     
.     

    V1                 V2
    1  1            WALKING
    2  2   WALKING_UPSTAIRS
    3  3 WALKING_DOWNSTAIRS
    4  4            SITTING
    5  5           STANDING
    6  6             LAYING

* subject: nr of the subject observed
* part: factor variable ("test","training") 
        whether the observation data was used in test or trainings data
* feature_id: nr of the feature, coded in the variable features
              in the raw data, each feature was just one of 561 columns in X_test or X_train,
              the 1st column has nr 1, ..., last columns had nr 561, has nr 561

head(features)

    id              name
    1  1 tBodyAcc-mean()-X
    2  2 tBodyAcc-mean()-Y
    3  3 tBodyAcc-mean()-Z
    4  4  tBodyAcc-std()-X
    5  5  tBodyAcc-std()-Y
    6  6  tBodyAcc-std()-Z
    
  * value: measured value of the feature,
           is a normalized dbl range [-1.0,1.0]
  * measurement: string, is 1st part (split by '-') of feature name indicating what is measured
  * func:        string, is 2nd part (split by '-') of feature name indicating how is aggregated
  * variables:   string, is 3rd part (split by '-') of feature name indicating above what variables in the raw data is aggregated
                 note: can be NA
                
                

### tidy_only_mean_std_measurements_df 

    Source: local data frame [679,734 x 7]
    
       subject activity observation_unit measurement   func variables     value
         (int)   (fctr)            (chr)       (chr)  (chr)     (chr)     (dbl)
    1        2 STANDING                1    tBodyAcc mean()         X 0.2571778
    2        2 STANDING                2    tBodyAcc mean()         X 0.2860267
    3        2 STANDING                3    tBodyAcc mean()         X 0.2754848
    4        2 STANDING                4    tBodyAcc mean()         X 0.2702982
    5        2 STANDING                5    tBodyAcc mean()         X 0.2748330
    6        2 STANDING                6    tBodyAcc mean()         X 0.2792199
    7        2 STANDING                7    tBodyAcc mean()         X 0.2797459
    8        2 STANDING                8    tBodyAcc mean()         X 0.2746005
    9        2 STANDING                9    tBodyAcc mean()         X 0.2725287
    10       2 STANDING               10    tBodyAcc mean()         X 0.2757457
    ..     ...      ...              ...         ...    ...       ...       ...

Variables have same description as in tidy_df
with the exception that activity_nr has been replaced by activity name (factor variable), look at table at description of tidy_df for activity_labels. Also, feature_ids have not been selected for this dataframe.

Note, the data is filtered (in contrast to tidy_df) to only have func either 'mean()' oder 'std()' as given in the project description. 

tidy_only_mean_std_measurements_df is the result after Step 4 of project description.

### avg_value_by_feature_and_activity_and_subject_df                 

    Source: local data frame [11,880 x 6]
    Groups: measurement, func, variables, activity [?]
    
       measurement   func variables activity subject mean(value)
             (chr)  (chr)     (chr)   (fctr)   (int)       (dbl)
    1     fBodyAcc mean()         X   LAYING       1  -0.9390991
    2     fBodyAcc mean()         X   LAYING       2  -0.9767251
    3     fBodyAcc mean()         X   LAYING       3  -0.9806656
    4     fBodyAcc mean()         X   LAYING       4  -0.9588021
    5     fBodyAcc mean()         X   LAYING       5  -0.9687417
    6     fBodyAcc mean()         X   LAYING       6  -0.9391143
    7     fBodyAcc mean()         X   LAYING       7  -0.9534242
    8     fBodyAcc mean()         X   LAYING       8  -0.9535386
    9     fBodyAcc mean()         X   LAYING       9  -0.9468655
    10    fBodyAcc mean()         X   LAYING      10  -0.9691842
    ..         ...    ...       ...      ...     ...         ...
    
Variable description same as above.
Dataset is grouped by

* measurement,func,variables: they are indicating the variable measured (as the original feature was gathered out)
* activity
* subject

avg_value_by_feature_and_activity_and_subject_df is the result after Step 5 of project description