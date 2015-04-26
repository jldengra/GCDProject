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

   Firstly we need to create a folder with the name __GDProject__, create inside an empty file *run_analysis.R* that will contain script, and lastly a subfolder *data*. Then, we open the script in R and begin by setting the just created __GDProject__ as the working directory. Then, we tell R script to download and unzip the archive with the data files into the data folder. A subdirectory __data/UCI HAR Dataset__ will be created containing all the extracted data files.

2. Loading, transforming and merging the observations: 
   
   We need to load the training and test sets in two data frames called *train* and *test* from the files "data/UCI HAR Dataset/train/X_train.txt" and "data/UCI HAR Dataset/test/X_test.txt", respectively. They both consist of 561 numerical variables, named from V1 to V561. There is a features file "data/UCI HAR Dataset/features.txt" with 561 feature names corresponding to these variables, that will be loaded into a data frame called *features*. 
   
   Since the values of V1 are sorted in numerical order, as well as the numbers suffix of variable names V1, V2, ..., V561 in our training and test data frames, we will make use of the second variable features$v2 vector to rename the variables in our data frames. There is an implicit coercion from factor (feature$V2 values) to character (column name). Once renamed, we will have the same description in the column names in *train* and *test* as well as in the variable features$V2. 
   
   At this point, the names of the columns of train and test data frames have been initialized from the set of features. Besides these observed features, there are separated files containing the subjects and activity labels for each observation, that should be added to our data frames. So, we will load two new data frames by reading the files "data/UCI HAR Dataset/train/subject_train.txt" and "data/UCI HAR Dataset/train/subject_train.txt" containing the subjects and activity labels for the training set, and similarly other two by reading the files "data/UCI HAR Dataset/test/subject_test.txt" and "data/UCI HAR Dataset/test/y_test.txt" containig the subjects and activity labels for the test data set. Then we will add columns called *subject* and *activiy* to both data frames *train* and *test* by a column bind followed by renaming the new two columns. 
   
   Once added subject and activity to each observation, the data frames *train* and *test* are complete and can be merged in a new data set. Since observations are indepedent (according to the specification "Each feature vector is a row on the text file"), and the training and test groups are disjoint sets coming from a random partition 70%/30% of the population, we will just add the training and test observations to perform the merge operation, by a row binding in R, saving the result in a data frame called *dataset* containing the merged sets of observations. 
   