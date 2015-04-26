Getting and Cleaning Data Project
=================================
Study design and code book

Study design 
------------

The data come from a study called Human Activity Recognition Using Smartphones, and have beeen collected from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The data have been collected by annotations taken from video-recorded experiments. The data set and attribute basic information is available in the web site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

A more detailed description is available in the names file: 

http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

The data files for the project are provided in the following archive:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Code book 
---------

This study has been included step by step in the run_analysis.R script, which tries to compilate everything neccesary to reproduce the experiment and analysis.

1. Configuring location and data files: A folder was created with the name __GDProject__, including the files README.md, CodeBook.md and run_analysis.R and a subfolder called "data". The working directory has been set to the the path of the folder __GDProject__. The archive containing the data has been dowloaded and unzipped from the R script into the data folder, and a subdirectory "data/UCI HAR Dataset" has been created containing all the extracted 
data files as result. 

2. The training and testing sets are loaded in two data frames called *train* and *test* from the files "data/UCI HAR Dataset/train/X_train.txt" and "data/UCI HAR Dataset/test/X_test.txt", respectively. They both consist of 561 numerical variables, named from V1 to V561. There is a file called "features.txt" with 561 feature names corresponding to these variables. The features file "data/UCI HAR Dataset/features.txt" is loaded into a data frame called *features*. Since the values of V1 and the values are sorted numerically, as well as the numbers suffix of variable names V1, V2, ..., V561 in our training and test data frames, we rename the variables in our data frames making use of the second dimension features$v2 as a vector. There is an implicit coercion from factor (feature$V2 values) 
 to character (column name).