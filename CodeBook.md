Getting and Cleaning Data Project
=================================
_Study design and code book._

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
 				
	 The resulting reduced data frame will overwrite our data frame __dataset__. It will keep the number of rows but the number of variables will decrease, consisting of subjects, activities and the subset of measures whose name contains "mean()" or "sd()".

4. Using descriptive activity names to name the activities in the data set.

	 The variable __activity__ is represented by a number in the current data set. This number is an integer, and its translation is provided in the file extracted as "data/UCI HAR Dataset/activity_labels.txt". We will load a data frame called __activity.names__ and initialize the column names as *activity* and *activityName*. The first column *activity* is a number that coordinates with the homologous variable *activity* in our data set, and the second column is a human-readable description for the activity. We will merge __dataset__ and __activity.name__ making use of the merge function in R. If there are no NA's in dataset$activity, we will be able to perform an inner join, otherwise an outer join. 
	 
	 The merged data set will be stored in our data frame __dataset__ overwritting its previous value. There are now two variables __activity__ with the number and __activityName__ with the name. We leave only an activity name because we don't need # a number for an activity (no aggregation operation makes sense for them). 
   For this, we will update the variable __activity__ with the names in __activityName__, and then remove the activityName column. The activity names appear now instead of the previous activity numbers. Once again, the data frame resulting from these transformations will overwrite the existing __dataset__. 
   
   Optionally, we can reorder the columns After the merge operation, __activity__ appears as the first variable and __subject__ as the second. We can swap them again using column binding to preserve their original order, but it is not necessary.
   
5. Appropriately label the data set with descriptive variable names.
 
   There are two ways to improve the variable names: one is minimizing their length by removing unnecessary symbols, and another is by changing some parts to improve their readability. 
 		
 	 The variables for the measurements are difficult to shorten, since they are already composed by some acronyms unable to be ommitted. The right side of the name could be somehow shortened by removing symbols "-", "(", ")" which are not needed since we can use capitals in Mean and Std to denote their beginning. So we will delete all the ocurrences of the symbols "-", "(", ")", by replacing "mean()" by "Mean", "std()" by "Std" and "-" by "". Thus we simplify the names getting them without unnecessary symbols around and leave means and standards deviation better delimited beginning with a capital.
 		
 	 Regarding some of acronyms that cannot be ommitted as "t" at the beginning for time, or "f" at the beginning for frequency, they are not easily interpretable, so it is convenient to replace them by a longer string as "Time" or "Frequency" to be more descriptive. The same occurs with the abbreviations "Mag", "Gyro" and "Acc" that stand for magnitude, gyroscope and accelerometer, respectively. So, we will change the names of the columns by replacing "t" and "f" at the beginning, "Mag", "Gyro" and "Acc" with the strings "Time", "Frecuency", "Magnitude", "Gyroscope", and "Accelerometer", respectively, all the new values beginning with a capital for a better distinction.
 		
 	 One more time, after these transformations, the resulting data set will replace our previous __dataset__. Now the set of labels has more appropriate names.
 
6. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
 
 	 We will make use of dplyr package to simplify this task by using the group_by and the summarise_each functions to group by activity and subject and then apply the mean for each variable, storing the result in a new data frame called __tidy.dataset__.
 	 
 	 Finally the tidy data set will be exported to a txt file created with write.table() using row.names = FALSE.
 	 
 	 

### Variables in the data set

* __subject__: 

  Volunteer within an age bracket of 19-48 years who took part in the experiment.
   
* __activity__: 

  Name of one of the following six activities that a person is able to perform wearing a smartphone on the waist: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING.
   
* __Variables that were estimated from sensor signals__: 
	
	The final data set computes their mean grouping by subject and activity. 
	Their names have been extended to be self-explanatory. Further information is available in files README.txt and features_info.txt in the original data archives.
	
  __TimeBodyAccelerometerMeanX, TimeBodyAccelerometerMeanY, TimeBodyAccelerometerMeanZ, TimeBodyAccelerometerStdX, TimeBodyAccelerometerStdY, TimeBodyAccelerometerStdZ, TimeGravityAccelerometerMeanX, TimeGravityAccelerometerMeanY, TimeGravityAccelerometerMeanZ, TimeGravityAccelerometerStdX, TimeGravityAccelerometerStdY, TimeGravityAccelerometerStdZ, TimeBodyAccelerometerJerkMeanX, TimeBodyAccelerometerJerkMeanY, TimeBodyAccelerometerJerkMeanZ, TimeBodyAccelerometerJerkStdX, TimeBodyAccelerometerJerkStdY, TimeBodyAccelerometerJerkStdZ, TimeBodyGyroscopeMeanX, TimeBodyGyroscopeMeanY, TimeBodyGyroscopeMeanZ, TimeBodyGyroscopeStdX, TimeBodyGyroscopeStdY, TimeBodyGyroscopeStdZ, TimeBodyGyroscopeJerkMeanX, TimeBodyGyroscopeJerkMeanY, TimeBodyGyroscopeJerkMeanZ, TimeBodyGyroscopeJerkStdX, TimeBodyGyroscopeJerkStdY, TimeBodyGyroscopeJerkStdZ, TimeBodyAccelerometerMagnitudeMean, TimeBodyAccelerometerMagnitudeStd, TimeGravityAccelerometerMagnitudeMean, TimeGravityAccelerometerMagnitudeStd, TimeBodyAccelerometerJerkMagnitudeMean, TimeBodyAccelerometerJerkMagnitudeStd, TimeBodyGyroscopeMagnitudeMean, TimeBodyGyroscopeMagnitudeStd, TimeBodyGyroscopeJerkMagnitudeMean, TimeBodyGyroscopeJerkMagnitudeStd, FrequencyBodyAccelerometerMeanX, FrequencyBodyAccelerometerMeanY, FrequencyBodyAccelerometerMeanZ, FrequencyBodyAccelerometerStdX, FrequencyBodyAccelerometerStdY, FrequencyBodyAccelerometerStdZ, FrequencyBodyAccelerometerJerkMeanX, FrequencyBodyAccelerometerJerkMeanY, FrequencyBodyAccelerometerJerkMeanZ, FrequencyBodyAccelerometerJerkStdX, FrequencyBodyAccelerometerJerkStdY, FrequencyBodyAccelerometerJerkStdZ, FrequencyBodyGyroscopeMeanX, FrequencyBodyGyroscopeMeanY, FrequencyBodyGyroscopeMeanZ, FrequencyBodyGyroscopeStdX, FrequencyBodyGyroscopeStdY, FrequencyBodyGyroscopeStdZ, FrequencyBodyAccelerometerMagnitudeMean, FrequencyBodyAccelerometerMagnitudeStd, FrequencyBodyBodyAccelerometerJerkMagnitudeMean, FrequencyBodyBodyAccelerometerJerkMagnitudeStd, FrequencyBodyBodyGyroscopeMagnitudeMean, FrequencyBodyBodyGyroscopeMagnitudeStd, FrequencyBodyBodyGyroscopeJerkMagnitudeMean, FrequencyBodyBodyGyroscopeJerkMagnitudeStd__                       
