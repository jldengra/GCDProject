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
# the archive with the project data files is downloaded and extracted
# to a "data" folder in the directory where the source file. 

setwd("D:/Training/Data Science/JHU Specialization/Getting and cleaning data/Project/GCD Project/GCDProject")
if (!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/data.zip")
unzip("./data/data.zip", exdir = "./data")

# A subdirectory data/UCI HAR Dataset" has been created containing all the extracted 
# data files.

# 1. Merge the training and the test sets to create one data set.



Reading test and train data
trainTable <- read.table("UCIHARDataset/train/X_train.txt")
testTable <- read.table("UCIHARDataset/test/X_test.txt")

#  Finally the tidy data set is exported to a txt file created with write.table() using
#  row.names=FALSE