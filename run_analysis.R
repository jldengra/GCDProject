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
# 
# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

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


#  Finally the tidy data set is exported to a txt file created with write.table() using
#  row.names=FALSE