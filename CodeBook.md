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

   Firstly we need to create a folder with the name __GCDProject__, create inside an empty file *run_analysis.R* that will contain script, and lastly a subfolder *data*. Then, we open the script in R and begin by setting the just created __GCDProject__ as the working directory. Then, we tell R script to download and unzip the archive with the data files into the data folder. A subdirectory __data/UCI HAR Dataset__ will be created containing all the extracted data files.

2. Loading, transforming and merging the observations: 
   
   We need to load the training and test sets in two data frames called __train__ and __test__ from the files "data/UCI HAR Dataset/train/X_train.txt" and "data/UCI HAR Dataset/test/X_test.txt", respectively. They both consist of 561 numerical variables, named from V1 to V561. There is a features file "data/UCI HAR Dataset/features.txt" with 561 feature names corresponding to these variables, that will be loaded into a data frame called __features__. 
   
   Since the values of V1 are sorted in numerical order, as well as the numbers suffix of variable names V1, V2, ..., V561 in our training and test data frames, we will make use of the second variable __features$v2__ vector to rename the variables in our data frames. There is an implicit coercion from factor (feature$V2 values) to character (column name). Once renamed, we will have the same description in the column names in __train__ and __test__ as well as in the variable __features$V2__. 
   
   At this point, the names of the columns of train and test data frames have been initialized from the set of features. Besides these observed features, there are separated files containing the subjects and activity labels for each observation, that should be added to our data frames. So, we will load two new data frames by reading the files "data/UCI HAR Dataset/train/subject_train.txt" and "data/UCI HAR Dataset/train/subject_train.txt" containing the subjects and activity labels for the training set, and similarly other two by reading the files "data/UCI HAR Dataset/test/subject_test.txt" and "data/UCI HAR Dataset/test/y_test.txt" containig the subjects and activity labels for the test data set. Then we will add columns called __subject__ and __activiy__ to both data frames __train__ and __test__ by a column bind followed by renaming the new two columns. 
   
   Once added subject and activity to each observation, the data frames __train__ and __test__ are complete and can be merged in a new data set. Since observations are independent (according to the specification "_Each feature vector is a row on the text file_"), and the training and test groups are disjoint sets coming from a random partition 70%/30% of the population, we will just add the training and test observations to perform the merge operation, by a row binding in R, saving the result in a data frame called __dataset__ containing the merged sets of observations. 
   
3. Extracting only the measurements on the mean and standard deviation for each measurement.
 
 	 According to the file "data/UCI HAR Dataset/features_info.txt" provided in the extracted data files, measurement names of standard deviation and mean include, respectively "std()" or "mean()" as part of the name, so we can reduce the data frame to the subject, activity, and only the measures containing "mean()" or "std()" in the name. A column bind operation will be perfomed to join between two data frames extrated from our current data frame called __dataset__: a first with the variables *subject* and *activity*, and a second data containg only the columns whose name matches the substring "mean()" or the substring "step()", making use of regular expressions to allow the subsetting in one step. 
 				
	 The resulting reduced data frame will overwrite our data frame __dataset__. It will keep the number of rows but the number of variables, consisting of subjects, activities and measures whose	name contains "mean()" or "sd()".

4. Using descriptive activity names to name the activities in the data set.

	 The variable __activity__ is represented by a number in the current data set. This number is an integer, and its translation is provided in the file extracted as "data/UCI HAR Dataset/activity_labels.txt". We will load a data frame called __activity.names__ and initialize the column names as *activity* and *activityName*. The first column *activity* is a number that coordinates with the homologous variable *activity* in our data set, and the second column is a human-readable description for the activity. We will merge __dataset__ and __activity.name__ making use of the merge function in R. If there are no NA's in dataset$activity, we will be able to perform an inner join, otherwise an outer join. 
	 
	 The merged data set will be stored in our data frame __dataset__ overwritting its previous value. There are now two variables __activity__ with the number and __activityName__ with the name. We leave only an activity name because we don't need # a number for an activity (no aggregation operation makes sense for them). 
   For this, we will update the variable __activity__ with the names in __activityName__, and then remove the activityName column. The activity names appear now instead of the previous activity numbers. Once again, the data frame resulting from these transformations will overwrite the existing __dataset___. 
   
   Optionally, we can reorder the columns After the merge operation, __activity__ appears as the first variable and __subject__ as the second. We can swap them again to preserve their original order, but it is not necessary.
   