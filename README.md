GettingCleaningDataProject
==========================

Coursera Class Project for Getting &amp; Cleaning Data - creating a tidy data set


###Creating a tidy dataset from the Human Activity Recognity Using Smartphones Dataset

    
Thirty volunteers ages 19 to 48 wore a Samsung Galaxy S II on their waist with 
an embedded accelerometer and gyroscope.  The smartphone collected data on their
movements.  The volunteers data were split into two groups with 70% in the training and 
30% in the test group.
 
We are now interested in creating a tidy dataset for the data of all 30 
volunteers combined concentrating on the mean and standard deviation features that were recorded.   

______________________________________________________________________________________________

The raw data that was collected on the volunteers can be found  at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

If unzipped there is a UCI HAR Dataset folder. Inside of which are the following files:
* activity_labels.txt - contains activities Walking, Walking Upstairs, Walking downstairs,
                        sitting, standing, laying and their corresponding codes
* features.txt - contains all the features that are in the data (X_test/X_train)
* features_info.txt -tells a little about the features provided in features.txt
* README.txt - describes the data provided

test folder contains:
* subject_test.txt - each row identifies the subject in the test group who preformed the activity. Ranges from 1-30.
* X_test.txt - data for all the features for the test group
* y_test.txt - codes for activity preformed by the test group

train folder contains:
* subject_train.txt - each row identifies the subject in the training group who preformed the activity. 
                Ranges from 1-30.
* X_train.txt - data for all the features for the training group
* y_train.txt - codes for activity preformed for the training group

_________________________________________________________________________________________________
### The script I used to process this data is:  run_analysis.R

A basic synopsis of what I did to the data to create a tidy dataset:

I downloaded and unziped the data from the course website on 12/15/14.

I read in the files: 

raw data file	|contains   |R dataset
-------------|------------------|--------------------------
features.txt  |  	    column labels	                |  col_labels
X_test.txt	   |       raw features data for test group	| raw_test_data
y_test.txt	    |        activity codes(1-6)	           |  activity_labels_test
subject_test.txt|	    subject number for test group	|   subject_test_data
X_train.txt	raw  |     features data for train group	|   raw_train_data
y_train.txt	      |    activity codes(1-6)	           |    activity_labels_train
subject_train.txt	 |  subject number for train group	  |  subject_train_data

 I applied the make.names function to the column labels (features.txt) to create valid
names. I then also changed '...' to '-' and eliminated '..''s to make the names easier to read.

 I added the activity (walking,walking upstairs, walking downstairs, sitting, standing, laying) 
that corresponded the activity code provided in y_test & y_train. This matching was provided
in activity_labels.txt.

 I combined the information for the test datasets and train datasets as follows:
 
* features.txt(col_lables) became the column names.
* I  column binded the activity information (activity_labels_test/train) with the raw data on each of features (raw_test/train_data). 
* I then column binded this information with the subject information (subject_test/train_data).
* I had two seperate datasets test_data and train_data at this point so I combined them into one by row binding (combined_data).

I reshaped the data to long form so I had Subject, Activity with all the features in a column and 
their corresponding values in the next column.

I only wanted to keep the features for mean and standard deviation so I filtered the features column for mean or std.  This also returned some features for meanFreq which I then excluded.  I also excluded the angle mean features.  (These were already excluded after my first filter by case sensitivity in my search.) 

The tidy dataset at this point is : data_long_filtered.

I then summarized this dataset to get the average value of each feature for each
subject for each activity.  This data is provided in Features_by_Subj_Activity.

Final Dataset:
============================================================================================

Features_by_Subj_Activity.txt         - averages each feature grouped by subject and activity

