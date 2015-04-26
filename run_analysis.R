#########################################
# Project for Getting and Cleaning Data #
#########################################

# This script does the following: 
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.


##################################################################################
# 1. Merges the training and the test sets to create one data set.               #
##################################################################################

# Firstly, it is set as working directory the folder where the source file is.
# The archive with the project data files is downloaded and extracted to a "data"
# folder in this directory. 

setwd("D:/Training/Data Science/JHU Specialization/Getting and cleaning data/Project/GCD Project/GCDProject")
if (!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/data.zip")
unzip("./data/data.zip", exdir = "./data")

# A subdirectory "data/UCI HAR Dataset" has been created containing all the extracted 
# data files as result of the unzip function.

# Let's read the training and testing sets in two data frames called train and test

train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
test <- read.table("data/UCI HAR Dataset/test/X_test.txt")

# Let's take a look at the head of their structures and data

str(train)
# 'data.frame':        7352 obs. of  561 variables:
# $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
# $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
# $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
# $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
# ...

str(test)
# 'data.frame':        2947 obs. of  561 variables:
# $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
# $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
# $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
# $ V4  : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
# $ V5  : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...

head(train, 1)
#          V1          V2         V3         V4         V5         V6         V7         V8
# 1 0.2885845 -0.02029417 -0.1329051 -0.9952786 -0.9831106 -0.9135264 -0.9951121 -0.9831846
#          V9        V10        V11        V12       V13       V14       V15        V16
# 1 -0.923527 -0.9347238 -0.5673781 -0.7444125 0.8529474 0.6858446 0.8142628 -0.9655228
#          V17       V18        V19        V20        V21      V22        V23        V24
# 1 -0.9999446 -0.999863 -0.9946122 -0.9942308 -0.9876139 -0.94322 -0.4077471 -0.6793375
# ...
#         V553       V554       V555       V556       V557        V558       V559      V560
# 1 -0.2986764 -0.7103041 -0.1127543 0.03040037 -0.4647614 -0.01844588 -0.8412468 0.1799406
#          V561
# 1 -0.05862692

head(test, 1)
#          V1          V2          V3        V4         V5         V6         V7         V8
# 1 0.2571778 -0.02328523 -0.01465376 -0.938404 -0.9200908 -0.6676833 -0.9525011 -0.9252487
#           V9        V10        V11       V12       V13       V14       V15        V16
# 1 -0.6743022 -0.8940875 -0.5545772 -0.466223 0.7172085 0.6355024 0.7894967 -0.8777642
#          V17        V18        V19       V20        V21        V22        V23        V24
# 1 -0.9977661 -0.9984138 -0.9343453 -0.975669 -0.9498237 -0.8304778 -0.1680842 -0.3789955
# ...
# V549       V550 V551       V552       V553       V554        V555      V556       V557
# 1 -0.8980215 -0.2348153   -1 0.07164545 -0.3303704 -0.7059739 0.006462403 0.1629198 -0.8258856
# V558       V559     V560       V561
# 1 0.2711515 -0.7200093 0.276801 -0.0579783

# As the headers show, they both consist of 561 numerical variables, named from V1 to
# V561. There is a file called "features.txt" with 561 feature names corresponding to 
# these variables. Let's load this file to rename the columns of our data frames. 

features <- read.csv("data/UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
str(features)
# 'data.frame':        561 obs. of  2 variables:
# $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
# $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...
head(features)
#   V1                V2
# 1  1 tBodyAcc-mean()-X
# 2  2 tBodyAcc-mean()-Y
# 3  3 tBodyAcc-mean()-Z
# 4  4  tBodyAcc-std()-X
# 5  5  tBodyAcc-std()-Y
# 6  6  tBodyAcc-std()-Z
tail(features)
#      V1                                   V2
# 556 556 angle(tBodyAccJerkMean),gravityMean)
# 557 557     angle(tBodyGyroMean,gravityMean)
# 558 558 angle(tBodyGyroJerkMean,gravityMean)
# 559 559                 angle(X,gravityMean)
# 560 560                 angle(Y,gravityMean)
# 561 561                 angle(Z,gravityMean)

# Since the values of V1 and the values are sorted numerically, as well as the numbers
# suffix of variable names V1, V2, ..., V561 in our training and test data frames, we
# can make use of the second dimension features$v2 as a vector to rename the variables
# in our data frames. There is an implicit coercion from factor (feature$V2 values) 
# to character (column name).

colnames(train) <- features$V2
colnames(test)  <- features$V2

# At this point, the columns of train and test data frames are properly labeled.
# Besides these observed features, there are separated files containing the subjects
# and activity labels for each observation, that should be added to our data frames. 

train.subjects   <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
train.activities <- read.table("data/UCI HAR Dataset/train/y_train.txt")
test.subjects    <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
test.activities  <- read.table("data/UCI HAR Dataset/test/y_test.txt")

# Columns subject and activiy are added at the beginning in both data frames

train <- cbind(train.subjects[ , 1], train.activities[ , 1], train)
test  <- cbind(test.subjects[ , 1], test.activities[ , 1], test)
names(train)[1] <- "subject"
names(train)[2] <- "activity"
names(test)[1] <- "subject"
names(test)[2] <- "activity"

# Once added subject and activity to each observation, the data frames are complete
# and can be merged in a new data set. Since observations are indepedent (according 
# to the specification "Each feature vector is a row on the text file"), and the
# training and test groups are disjoint sets coming from a random partition 70%/30%
# of the population, we can just add the training and test observations to perform 
# the merge operation.

dataset <- rbind(train, test)

dim(dataset) 
# [1] 10299   563

# As it was expected, the resulting data set has 7352 + 2947 = 10299 observations
# and 561 + 2 = 563 variables.


##################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each  #
#    measurement.                                                                #
##################################################################################

# According to the file features_info.txt provided in the extracted data files, 
# measurement names of standard deviation and mean include, respectively std() 
# or mean() as part of the name, so we can reduce the dataset to only the subject, 
# activity, and measures containing "mean()" or "std()" in the name

dataset <- cbind(dataset[ , c("subject", "activity")], 
                 dataset[ , grep("mean\\(\\)|std\\(\\)", colnames(dataset))])

dim(dataset)
# [1] 10299    68
# The reduced dataset keeps the number of rows 10299 but the number or variables 
# decreases from 563 to 68, consisting of subjects, activities and measures whose
# name contains mean() or sd()


##################################################################################
# 3. Uses descriptive activity names to name the activities in the data set      #
##################################################################################

# The variable activity is represented by a number in the current dataset
table (dataset$activity)
#    1    2    3    4    5    6 
# 1722 1544 1406 1777 1906 1944 
summary(dataset$activity)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   2.000   4.000   3.625   5.000   6.000 

# This number is an integer between 1 and 6, and its translation is provided in 
# the file extracted as "activity_labels.txt". 

activity.names <- read.table("data/UCI HAR Dataset/activity_labels.txt")
colnames(activity.names) = c("activity", "activityName")

# Since there are no NA's in activity, we can perform an inner join
dataset <- merge(dataset, activity.names, by.x = "activity", by.y = "activity", all = FALSE)

# There are now two variables activity with the number and activityName with the name
# We can leave only an activity name in the activity variable, because we don't need
# a number for an activity (no aggregation operation makes sense for them). 
# We can reassign the variable activity to the names and remove activityName.
dataset$activity <- dataset$activityName
dataset <- dataset[ , !(names(dataset) %in% "activityName")]

dim(dataset)
# [1] 10299    68

table(dataset$activity)
# LAYING            SITTING           STANDING            WALKING WALKING_DOWNSTAIRS 
# 1944               1777               1906               1722               1406 
# WALKING_UPSTAIRS  
# 1544 

# The activity names appear now instead of the previous activity numbers.

head(dataset)
#    activity subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
# 1  WALKING       7         0.3016485      -0.026883636       -0.09579580       -0.3801243
# 2  WALKING       5         0.3433592      -0.003426473       -0.10154465       -0.2011536
# 3  WALKING       6         0.2696745       0.010907280       -0.07494859       -0.3366399
# 4  WALKING      23         0.2681938      -0.012730069       -0.09365263       -0.3836978
# 5  WALKING       7         0.3141912      -0.008695973       -0.12456099       -0.3558778
# 6  WALKING       7         0.2032763      -0.009764083       -0.15139663       -0.4286661
# 
# ...

# After the inner join, "activity" appears as the first variable and "subject as 
# the second. We can swap them again to preserve their original order: 

dataset <- cbind(dataset[ , c("subject", "activity")], 
                 dataset[ , !(names(dataset) %in% c("subject", "activity"))])


##################################################################################
# 4. Appropriately labels the data set with descriptive variable names.          #
##################################################################################

# Let's see the current labels in column names
colnames(dataset)
# [1] "subject"                     "activity"                    "tBodyAcc-mean()-X"          
# [4] "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
# [7] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"            "tGravityAcc-mean()-X"       
# [10] "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
# [13] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"         "tBodyAccJerk-mean()-X"      
# [16] "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
# [19] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"        "tBodyGyro-mean()-X"         
# [22] "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
# [25] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"           "tBodyGyroJerk-mean()-X"     
# [28] "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
# [31] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"       "tBodyAccMag-mean()"         
# [34] "tBodyAccMag-std()"           "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
# [37] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"       "tBodyGyroMag-mean()"        
# [40] "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
# [43] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"           "fBodyAcc-mean()-Z"          
# [46] "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
# [49] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"       "fBodyAccJerk-mean()-Z"      
# [52] "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
# [55] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"          "fBodyGyro-mean()-Z"         
# [58] "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
# [61] "fBodyAccMag-mean()"          "fBodyAccMag-std()"           "fBodyBodyAccJerkMag-mean()" 
# [64] "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
# [67] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 

# The variables for the measurments are difficult to simplify, since they are already 
# composed by some acronyms unable to be ommitted. The right side of the name could 
# be somehow shortened by removing symbols "-", "(", ")" which are not needed since
# we can use capitals in Mean and Std to denote their beginning.

colnames(dataset) <- gsub("mean\\(\\)", "Mean", colnames(dataset))
colnames(dataset) <- gsub("std\\(\\)", "Std", colnames(dataset))
colnames(dataset) <- gsub("-", "", colnames(dataset))

colnames(dataset)
# [1] "subject"                  "activity"                 "tBodyAccMeanX"           
# [4] "tBodyAccMeanY"            "tBodyAccMeanZ"            "tBodyAccStdX"            
# [7] "tBodyAccStdY"             "tBodyAccStdZ"             "tGravityAccMeanX"        
# [10] "tGravityAccMeanY"         "tGravityAccMeanZ"         "tGravityAccStdX"         
# [13] "tGravityAccStdY"          "tGravityAccStdZ"          "tBodyAccJerkMeanX"       
# [16] "tBodyAccJerkMeanY"        "tBodyAccJerkMeanZ"        "tBodyAccJerkStdX"        
# [19] "tBodyAccJerkStdY"         "tBodyAccJerkStdZ"         "tBodyGyroMeanX"          
# [22] "tBodyGyroMeanY"           "tBodyGyroMeanZ"           "tBodyGyroStdX"           
# [25] "tBodyGyroStdY"            "tBodyGyroStdZ"            "tBodyGyroJerkMeanX"      
# [28] "tBodyGyroJerkMeanY"       "tBodyGyroJerkMeanZ"       "tBodyGyroJerkStdX"       
# [31] "tBodyGyroJerkStdY"        "tBodyGyroJerkStdZ"        "tBodyAccMagMean"         
# [34] "tBodyAccMagStd"           "tGravityAccMagMean"       "tGravityAccMagStd"       
# [37] "tBodyAccJerkMagMean"      "tBodyAccJerkMagStd"       "tBodyGyroMagMean"        
# [40] "tBodyGyroMagStd"          "tBodyGyroJerkMagMean"     "tBodyGyroJerkMagStd"     
# [43] "fBodyAccMeanX"            "fBodyAccMeanY"            "fBodyAccMeanZ"           
# [46] "fBodyAccStdX"             "fBodyAccStdY"             "fBodyAccStdZ"            
# [49] "fBodyAccJerkMeanX"        "fBodyAccJerkMeanY"        "fBodyAccJerkMeanZ"       
# [52] "fBodyAccJerkStdX"         "fBodyAccJerkStdY"         "fBodyAccJerkStdZ"        
# [55] "fBodyGyroMeanX"           "fBodyGyroMeanY"           "fBodyGyroMeanZ"          
# [58] "fBodyGyroStdX"            "fBodyGyroStdY"            "fBodyGyroStdZ"           
# [61] "fBodyAccMagMean"          "fBodyAccMagStd"           "fBodyBodyAccJerkMagMean" 
# [64] "fBodyBodyAccJerkMagStd"   "fBodyBodyGyroMagMean"     "fBodyBodyGyroMagStd"     
# [67] "fBodyBodyGyroJerkMagMean" "fBodyBodyGyroJerkMagStd" 

# Now the set of labels has more appropriate names, that are equally descriptive
# but simplified without unnecessary symbols around.


##################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set    #
#    with the average of each variable for each activity and each subject.       #
##################################################################################

# We can make use of dplyr package to simplify this task by using the group_by
# and the summarise_each functions to group and apply the mean for each variable 

library(dplyr)
activity.subject <- group_by(dataset, activity, subject)
tidy.dataset <- summarise_each(activity.subject, funs(mean))

#  Finally the tidy data set is exported to a txt file created with write.table()
#  using row.names=FALSE

write.table(tidy.dataset, "TidyData.txt", row.names = FALSE)
