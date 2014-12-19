==================================================================
## Creating a tidy dataset from the 'Human Activity Recognition Using Smartphones' Dataset
________________________________________________________________________________________________
    
## Experimental design and background:
________________________________________________________________________________________________

A group of 30 volunteers between the ages of 19 and 48 wore a Samsung Galaxy S II on their waist while performing 
6 activities (walking, walking upstairs, walking downstairs, sitting, standing, laying). 
An embedded accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial 
angular velocity at a constant rate of 50Hz. Noise filters were applied to the sensor signals and 
they were then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal was seperated using a Butterworth low-pass  filter into body 
acceleration and gravity.The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features 
was obtained by calculating variables from the time and frequency domain.  Features are normalized and 
bounded within [-1,1].

The data was then partitioned randomly into two sets where 70% of the volunteers and their respective data were 
put in the training dataset and the remaining 30% into the test dataset.  (1)

 
We are now interested in creating a tidy dataset of the mean and standard deviation 
measurements from this data of all 30 volunteers.   

  

## Raw data:

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

__________



## Processed data:
______________________________________________________________________________________________________
I downloaded and unziped the data from the course website on 12/15/14.

I read in the files: 

raw data file	|contains   |R dataset
-------------|------------------|--------------------------
features.txt  |  	    column labels	                |  col_labels
X_test.txt	   |       raw features data for test group	| raw_test_data
y_test.txt	    |        activity codes(1-6)	           |  activity_labels_test
subject_test.txt|	    subject number for test group	|   subject_test_data
X_train.txt	  |    raw features data for train group	|   raw_train_data
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

## Field Names:
__________________________________________________________________________________________________________

* 'f' prefix indicates frequency domain signals 
* 't' prefix indicates time domain signals 
* '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
* .mean represents a calulated mean
* .std represnts a calculated standard deviation

** Every variable has been normalized into -1 to 1 range, so they have no units **

field |                   description
------|--------------------------------
tBodyAcc.mean-X |	          body acceleration mean in X direction in time domain
tBodyAcc.std-X	|          body acceleration standard deviation in X direction in time domain
tBodyAcc.mean-Y	 |         body acceleration mean in Y direction  in time domain
tBodyAcc.std-Y	  |        body acceleration standard deviation in Y direction  in time domain
tBodyAcc.mean-Z	   |       body acceleration mean in Z direction  in time domain
tBodyAcc.std-Z	   |       body acceleration standard deviation in Z direction  in time domain
tGravityAcc.mean-X	|      acceleration due to gravity mean in X direction  in time domain
tGravityAcc.std-X	 |     acceleration due to gravity standard deviation in X direction  in time domain
tGravityAcc.mean-Y	|      acceleration due to gravity mean in Y direction  in time domain
tGravityAcc.std-Y	 |     acceleration due to gravity standard deviation in Y direction  in time domain
tGravityAcc.mean-Z	  |    acceleration due to gravity mean in Z direction  in time domain
tGravityAcc.std-Z	 |     acceleration due to gravity standard deviation in Z direction  in time domain
tBodyAccJerk.mean-X	  |    mean body acceleration jerk in the X direction in time domain
tBodyAccJerk.std-X	  |    standard deviation body acceleration jerk in the X direction in time domain
tBodyAccJerk.mean-Y	 |     mean body acceleration jerk in the Y direction in time domain
tBodyAccJerk.std-Y	 |     standard deviation body acceleration jerk in the Y direction in time domain
tBodyAccJerk.mean-Z	 |     mean body acceleration jerk in the Z direction in time domain
tBodyAccJerk.std-Z	 |    standard deviation body acceleration jerk in the Z direction in time domain
tBodyGyro.mean-X	 |    mean body gyroscope in the X direction in time domain
tBodyGyro.std-X	     |    standard deviation body gyroscope in the X direction in time domain
tBodyGyro.mean-Y	 |    mean body gyroscope in the Y direction in time domain
tBodyGyro.std-Y	     |    standard deviation body gyroscope in the Y direction in time domain
tBodyGyro.mean-Z	 |    mean body gyroscope in the Z direction in time domain
tBodyGyro.std-Z	     |    standard deviation body gyroscope in the Z direction in time domain
tBodyGyroJerk.mean-X |    mean body gyroscope jerk in the X  direction in time domain
tBodyGyroJerk.std-X	|      standard deviation body gyroscope jerk in the X  direction in time domain
tBodyGyroJerk.mean-Y |	  mean body gyroscope jerk in the Y  direction in time domain
tBodyGyroJerk.std-Y	 |     standard deviation body gyroscope jerk in the Y  direction in time domain
tBodyGyroJerk.mean-Z |	  mean body gyroscope jerk in the Z  direction in time domain
tBodyGyroJerk.std-Z	  |    standard deviation body gyroscope jerk in the Z  direction in time domain
tBodyAccMag.mean	  |    mean of body acceleration magnitude in time domain
tBodyAccMag.std	      |    standard deviation of body acceleration magnitude in time domain
tGravityAccMag.mean	  |    acceleration due to gravity mean magnitude  in time domain
tGravityAccMag.std	  |    acceleration due to gravity standard deviation magnitude  in time domain
tBodyAccJerkMag.mean |	  mean body acceleration jerk magnitude in time domain
tBodyAccJerkMag.std	 |     standard deviation body acceleration jerk magnitude in time domain
tBodyGyroMag.mean	 |     mean body gyroscope magnitude in time domain
tBodyGyroMag.std	  |    standard deviation body gyroscope magnitude in time domain
tBodyGyroJerkMag.mean	|  mean body gyroscope jerk magnitude in time domain
tBodyGyroJerkMag.std	 | standard deviation body gyroscope jerk magnitude in time domain
fBodyAcc.mean-Z	body     | acceleration mean in Z direction in frequency domain
fBodyAcc.mean-X	body     | acceleration mean in X direction in frequency domain
fBodyAcc.mean-Y	body     | acceleration mean in Y direction  in frequency domain
fBodyAcc.std-Z	body     | acceleration standard deviation in Z direction in frequency domain
fBodyAcc.std-X	body     | acceleration standard deviation in X direction in frequency domain
fBodyAcc.std-Y	body     | acceleration standard deviation in Y direction in frequency domain
fBodyAccJerk.mean-X	     | mean body acceleration jerk in the X direction in frequency domain
fBodyAccJerk.mean-Y	     | mean body acceleration jerk in the y direction in frequency domain
fBodyAccJerk.mean-Z	     | mean body acceleration jerk in the z direction in frequency domain
fBodyAccJerk.std-X	     | standard deviation body acceleration jerk in the X direction in frequency domain
fBodyAccJerk.std-Y	 |     standard deviation body acceleration jerk in the Y direction in frequency domain
fBodyAccJerk.std-Z	 |     standard deviation body acceleration jerk in the Z direction in frequency domain
fBodyGyro.mean-X	 |     mean body gyroscope in the X direction in frequency domain
fBodyGyro.mean-Y	 |     mean body gyroscope in the Y direction in frequency domain
fBodyGyro.mean-Z	 |     mean body gyroscope in the Z direction in frequency domain
fBodyGyro.std-X	     |     standard deviation body gyroscope in the X direction in frequency domain
fBodyGyro.std-Y	     |     standard deviation body gyroscope in the Y direction in frequency domain
fBodyGyro.std-Z	     |     standard deviation body gyroscope in the Z direction in frequency domain
fBodyBodyAccJerkMag.mean | mean body acceleration jerk magnitude in frequency domain
fBodyBodyGyroMag.std	|  mean body gyroscope magnitude in frequency domain
fBodyAccMag.mean	    |  mean of body acceleration magnitude in frequency domain
fBodyAccMag.std	        |  standard deviation of body acceleration magnitude in frequency domain
fBodyBodyAccJerkMag.std	|  standard deviation body acceleration jerk magnitude in frequency domain
fBodyBodyGyroMag.mean	|  mean body gyroscope jerk magnitude in frequency domain
fBodyBodyGyroJerkMag.mean | mean body gyroscope jerk magnitude in frequency domain
fBodyBodyGyroJerkMag.std | standard deviation body gyroscope jerk magnitude in frequency domain




## References:
___________________________________________________________________________________________________________
(1) http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
