### Let's merge the data
library(dplyr)
library(tidyr)

# start with given colnames (instead of V1..V561,V1 again,V1)
# for features just the index nr of the feature
# the feature names from features[,2] aren't unique
colnames(features) <- c("id","name")

colnames(X_test)        <- features[,"id"]   # V1..V561 probably would work also
colnames(y_test)        <- c("y")
colnames(subject_test)  <- c("subject")

colnames(X_train)       <- features[,"id"]
colnames(y_train)       <- c("y")
colnames(subject_train) <- c("subject")

### now merge 
# without losing the information for what part in machine learning the data was used
# (probably not necessary for this analysis, but done for principles - and if so do it with factors)
test_df   <- mutate(cbind(X_test,y_test,subject_test),part="test")
train_df  <- mutate(cbind(X_train,y_train,subject_train),part="train")
merged_df <- mutate(bind_rows(test_df,train_df),part=as.factor(part))
### finished merging now having a data frame

### Let's tidy the data up
# in slight contrast to the original job description, 
# first tidy it really up and then work with the data
# that will be better in general,
# and working with colnames as variables is nothing I want to train

# colnames with feature_ids are just variables
# but before gathering them, first keep track of the the observation unit
# here each row is one observation unit
tidy_df <- merged_df %>%
  add_rownames("observation_unit") %>% 
  gather(feature_id,value,-c(y,subject,part,observation_unit)) %>%
  mutate(feature = features[feature_id,"name"]) %>%
  separate(feature,into=c("measurement","func","variables"),sep="-",fill="right")

# Finally a tidy data set,
# let's look at it by
# > arrange(df,observation_unit)
# Source: local data frame [5,777,739 x 9]
#
# observation_unit     y subject   part feature_id       value measurement agg variables
# (chr) (int)   (int) (fctr)     (fctr)       (dbl)       (chr)    (chr)     (chr)
# 1                 1     5       2   test          1  0.25717778    tBodyAcc   mean()         X
# 2                 1     5       2   test          2 -0.02328523    tBodyAcc   mean()         Y
# 3                 1     5       2   test          3 -0.01465376    tBodyAcc   mean()         Z
# 4                 1     5       2   test          4 -0.93840400    tBodyAcc    std()         X
# 5                 1     5       2   test          5 -0.92009078    tBodyAcc    std()         Y
# 6                 1     5       2   test          6 -0.66768331    tBodyAcc    std()         Z
# 7                 1     5       2   test          7 -0.95250112    tBodyAcc    mad()         X
# 8                 1     5       2   test          8 -0.92524867    tBodyAcc    mad()         Y
# 9                 1     5       2   test          9 -0.67430222    tBodyAcc    mad()         Z
# 10                1     5       2   test         10 -0.89408755    tBodyAcc    max()         X
# ..              ...   ...     ...    ...        ...         ...         ...      ...       ...


### Now start to work with the tidy data
# filter for mean|avg
# label activities
# and select in a proper order (ignoring also the feature_id not needed any longer)
tidy_only_mean_std_measurements_df <- tidy_df %>% 
  filter(func == 'mean()' | func == 'std()') %>% 
  rename(activity = y) %>% 
  mutate(activity = as.factor(activities[activity,2])) %>%
  select(subject,activity,observation_unit,measurement,func,variables,value)


### Now create dataframed grouped by activity and subject
avg_value_by_feature_and_activity_and_subject_df <- tidy_only_mean_std_measurements_df %>%
  group_by(measurement,func,variables,activity,subject) %>%
  summarize(mean(value))