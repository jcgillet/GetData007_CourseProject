Objective
=========
This is the repository corresponding to the "Getting and Cleaning Data" Course Project on Coursera.
The goal is to prepare tidy data that can be used for later analysis.

Available variables
===================
There are four available variables in the second tidy dataset:
- subject: identifies the subject who performed the activity for each window sample. Its range is from 1 to 30, and is stored as an integer.
- activity: denotes the activity the subject was performing during the measure. It has six values ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") and is stored as a string
- feature: pinpoints which of the following features (see below, "Feature Selection") is considered. It has 66 possible values (mean and standard deviation of 33 variables) and is stored as a string
- mean: is the result of the calculation of the average value for the corresponding feature, while the subject was performing the activity described.

Code description
================
The code is divided in five parts.

First, we load the required libraries. We then load the names of the features, which will enable us to do some quick selection in step 1, and we immediately get rid of pairs of brackets "()" for better readability.

Then, we try to perform steps 1 and 2. I chose to read the two tables separately, and then filter the interesting columns directly, as that enables us to limit our memory usage. I also chose to filter the pure means and standard deviations, getting rid of the angles (filtering out "angle") and the weighted average of frequency components (filtering out "Freq"). We can then bind the to datasets together using rbind() and append the subjects to the table. We then get rid of intermediary variables that only clug up the system.

We then move on to step 3. for this, we bind the two activity datasets together, make a link between the activity identifiers and their description, and finally append the descriptions to the working dataset.

In step 4, we first reorder the variables to make subject and activity the first ones available. We then substitute "t" and "f" for "time" and "frequential", capitalize "mean" and "std", get rid of dots and duplicate names, and finally make the calculation the last part of the name by exchanging the axis and the calculation names. We then apply the result to the columns of the dataset.

Finally, in step 5, we first calculate the mean of each column for a given subject-activity couple. We then Make the 66 columns into rows for easier reading by gathering. Thus, we get the 4 variables mentioned above and export them to a text file, after renaming the last 4 columns.

Note: I chose not to perform the gathering before step 5, because 10299*66=679734 rows seemed like a lot to me, and I preferred to keep the column-based layout for the first dataset, even if that didn't satisfy me much intellectually.

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAcc-XYZ and timeGyro-XYZ. These time domain signals (prefix 'time') were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcc-XYZ and timeGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccJerk-XYZ and timeBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccMag, timeGravityAccMag, timeBodyAccJerkMag, timeBodyGyroMag, timeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequentialBodyAcc-XYZ, frequentialBodyAccJerk-XYZ, frequentialBodyGyro-XYZ, frequentialBodyAccJerkMag, frequentialBodyGyroMag, frequentialBodyGyroJerkMag. (Note the 'frequential' prefix to indicate frequency domain signals). 

These signals were used to estimate 33 variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

timeBodyAcc-XYZ
timeGravityAcc-XYZ
timeBodyAccJerk-XYZ
timeBodyGyro-XYZ
timeBodyGyroJerk-XYZ
timeBodyAccMag
timeGravityAccMag
timeBodyAccJerkMag
timeBodyGyroMag
timeBodyGyroJerkMag
frequentialBodyAcc-XYZ
frequentialBodyAccJerk-XYZ
frequentialBodyGyro-XYZ
frequentialBodyAccMag
frequentialBodyAccJerkMag
frequentialBodyGyroMag
frequentialBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

Mean(): Mean value
StdDev(): Standard deviation
