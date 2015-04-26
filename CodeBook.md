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

This analysis has been included stepwise in the run_analysis.R script, which tries to compile everything neccesary to reproduce the experiment.
This code book details these steps as well as provides a description for the variables and data sets that take part in the process. 
These are the instructions: 

1. Configuring location and data files: 

Firstly we need to create a folder with the name __GDProject__, and create inside the file run_analysis.R script in which we will be writting the script, and lastly a subfolder *data*. Then, we open the script in R and begin by setting the just created __GDProject__ as the working directory. Then, we tell R to download and unzip the archive with the data files into the data folder. A subdirectory __data/UCI HAR Dataset__ will be created containing all the extracted 
data files.

2. The training and testing sets are loaded in two data frames called *train* and *test* from the files "data/UCI HAR Dataset/train/X_train.txt" and "data/UCI HAR Dataset/test/X_test.txt", respectively. They both consist of 561 numerical variables, named from V1 to V561. There is a file called "features.txt" with 561 feature names corresponding to these variables. The features file "data/UCI HAR Dataset/features.txt" is loaded into a data frame called *features*. Since the values of V1 and the values are sorted numerically, as well as the numbers suffix of variable names V1, V2, ..., V561 in our training and test data frames, we rename the variables in our data frames making use of the second dimension features$v2 as a vector. There is an implicit coercion from factor (feature$V2 values) 
 to character (column name).