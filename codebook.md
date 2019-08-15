---
title: "CodeBook.md"
author: "Prathamesh"
date: "8/12/2019"
output: html_document
---



# Features info

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag


The set of variables that were estimated from these signals are: 


mean(): Mean value
std(): Standard deviation


# Changes to features and dataset

First we combine the train and test set to form a single set. Then subset the combined dataset to get features with only mean() and std().
Next we will put some description to each row by adding descriptive labels and subject column at the end to this subsetted data.
Then to make features descriptive we remove the numbers from the feauture and replace 't' by time domain signal and 'f' by frequency domain signal.
Next we group the data by labels and subject to get mean of features for each.

# Data files created during cleaning with their description

uci_train - contains X_train data (1,7352) which is 70% of the total data


uci_test - contains X_test data (1,2947) which is 30% of the total data


combined - total training and test data 100% of the data


uci_feat - contains features of the data


ext_mean - vector of indices for features having mean() at the end


ext_std - vector of indices for features having std() at the end


combined_ext_features - contains only extracted features like mean() and std()


uci_train_label - labels of the X_train file


uci_test_label - labels of the X_test file


uci_labels -                   labels for combined train and test file


label -                        descriptive labels


uci_label_descrip -            adding description label to combined data


combined_ext_features_labels - adding the description label to the combined data


ext_uci_feat_des -             features with description and some cleaning


sub_train - vector of suject of training set


sub_test - vector of suject of test set


sub <- combined vector of subjects


combined_sub - tidy dataset of step 4 with suject column added to it


combined_grouped - Average of variable grouped by acitivity and subject