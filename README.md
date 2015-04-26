Getting and Cleaning Data Project
=================================

This is a project for the peer assessment activity in the __Getting and Cleaning Data__ course provided by Johns Hopkins University through Coursera. 
The purpose is to collect, work with, and clean a given data set.

The following files are included in this repository:

* __README.md__

	Overall description of the project repository and files. 
* __CodeBook.md__

	- Study design describing how the data have been collected.
	- Code book describing each variable, the data, and any transformations or work performed to clean up the data.
* __run_analysis.R__

  Script in R performing the stepwise data cleansing.
  It consists of an ETL process, since it is intended to include all the necessary extractions, transformations and load operations required to perform the cleansing process according to the steps gathered in the code book. 
   
* __TidyData.txt__

	Tidy data set resulting from the cleansing process.
	It is obtained by executing the ETL process provided by the previous script in R. 