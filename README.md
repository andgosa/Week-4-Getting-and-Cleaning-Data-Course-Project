# Week-4-Getting-and-Cleaning-Data-Course-Project
This is the final project of Coursera Getting and Cleaning Data. Its purpose is to demonstrate student ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

#How Data was Collected
Data was collected by SmartLab with experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist with an embedded accelerometer and gyroscope, they captured 3-axial linear acceleration (with body and gravitational components) and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The features selected for this database (see CodeBook.md) come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. They were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

# Objectives:
# 1. Merges the training and the test sets to create one data set ; 3.Uses descriptive activity names to name the activities in the data set and 4. Appropriately labels the data set with descriptive variable names.
For merging the training and the test sets to create one data set.First, we read tables with Test Set, Test Labels, Training Set, Training Labels and Features in R. We can see that "features.txt" has varibles names but are difficult to understand and unpractical with some numbers/spaces at the beginning and () symbol, so we clean the data and transpose to "Tfeatures" so it can later be used as column names in the data frame of this step and step 5.

Merging was made by steps. First, for tables containing training and test labels (y_train and y_test) it was verified its dimensions and transformed column to a "character numeric version", so later could be sustitute levels per labels (levels = c(1,2,3,4,5,6), labels = c("walking","walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")). Both tables represent a person and an activity performed (one is for 70% of the volunteers generating the training data and 30% the test data.) for each one are merge with "rbind" function, getting data frame "merge_y"" and it is assigned is colname "activity"

Second, it was made a combination of rows with subject_train and subject_test to get a total list of each one of subject (30 in total) who realized and activity.

Third, for tables containing Test Set and Training Set (X_test and X_train), that have the same number of columns when checking dimensions, it was used againg "rbind" function for merging both data sets and asigned the name "merge_x". 
It is assigned colnames with previous "Tfeatures". Finally, it is used "cbind" function to merge training and test sets with subject to create one data set "merge_x_y_subject".

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
From previous data frame (merge_x_y_subject), it is selected those columns with mean and standard deviation in colnames c(1:7, 42:47, 82:87, 122:127, 162:167, 202:203, 215:216, 228:229, 241:242, 254:255, 267:272, 346:351, 425:430, 504:505, 517:518, 530:531, 543:544) with the subsetting function, getting "mmean_std". 

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
According to Hadley Wickham's Tidy Data paper and to facilitate the calculation of the mean, we will used wide narrow calculation of the data (please keep in mind marking rubric specifically accepts wide or long presentation of tidy data).For that we used "aggregate" function keeping activity and subject subsetting and calculating mean for the other variables (66 variables).
