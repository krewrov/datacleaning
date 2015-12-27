# Data cleaning using run_analysis.R

December 2015, Erwin Vorwerk

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This git repository is set up in the light of the "Getting and Cleaning Data" course in www.coursera.org

It contains the following files:

- run_analysis.R:    the R program written to clean data file

-  tidy.txt:         output file containing cleansed data

- code.book:         file containing description of feasures in tidy.txt

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script works as follows:

1. It reads data from the data source files
2. Then it merges the training and test set to create one data set
3. Next it is extracting only the measurements on the mean and standard deviation for each measurement
4. Then it places an appropriately label on the data set with descriptive variable names
5. Next it applies descriptive activity names to name the activities in the data set
6. And finally From the data set in step 4. it create a second, independent tidy data set with average of of each variable for each activity and each subject
