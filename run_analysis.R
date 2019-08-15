### Step1 : Reading the files

#Since the train and test data are space seperated files it is easy to read it using readr
#package.

library(readr)

#Reading the file X_train.txt but before that extract the files and store in UCI_HAR_Dataset
#folder. Next set working directory to the location where you extracted the above file.

setwd('D:/R_language/data cleaning/assignment_4')

#Reading train file in folder UCI_HAR_Dataset -> train -> X_train.txt.

uci_train <- read_table('./UCI_HAR_Dataset/train/X_train.txt', col_names = FALSE) 

#Reading test file

uci_test <- read_table('./UCI_HAR_Dataset/test/X_test.txt', col_names = FALSE) 

#Merging train and test data.

combined <- rbind(uci_train,uci_test)


## Step 2 : Reading Features and extracting mean and std columns

#Reading the feature file

uci_feat <- read_table('./UCI_HAR_Dataset/features.txt', col_names = FALSE)


#Extracting column numbers of the features with mean()

ext_mean <- grep('\\bmean()\\b',uci_feat$X1)


#Extracting column numbers of the features with std()

ext_std <- grep('\\bstd()\\b',uci_feat$X1)


#Merging the extracted column numbers of mean and std features

ext_features <- c(ext_mean,ext_std)


#Subsetting the original dataframe(combined) for mean and std only

combined_ext_features <- combined[ext_features]


### Step3 : Reading label and joining it to dataset

#Reading the training label file

uci_train_label <- read_table('./UCI_HAR_Dataset/train/y_train.txt', col_names = FALSE) 


#Reading the test label file

uci_test_label <- read_table('./UCI_HAR_Dataset/test/y_test.txt', col_names = FALSE) 


#Combining the train and test labels

uci_label <- rbind(uci_train_label,uci_test_label)


#Reading the descriptive label file

label <- read_table('./UCI_HAR_Dataset/activity_labels.txt', col_names = FALSE)


#Now for merging the labels from y_train, y_test and activity_labels file we use join from plyr package and not merge because merge shuffle the rows whereas join retains the row as it is

library(plyr)
uci_label_descrip <- join(uci_label,label)


#Merging this descriptive label column to dataset

combined_ext_features_labels <- cbind(combined_ext_features,uci_label_descrip$X2)


### Step 4: Labelling the dataset

#To get the feature names with mean() and std() in it we use the ext_features vector to subset the uci_feature dataset

ext_uci_feat <- uci_feat[ext_features,]


#Adding one more feature to the above dataset i.e. the labels column

ext_uci_feat <- rbind(ext_uci_feat,'labels')



#removing the initial multiple unwanted numbers

ext_uci_feat_des <- gsub('[0-9]','',as.character(ext_uci_feat$X1))  

#Giving description to the feature abbrevations

ext_uci_feat_des <- sub('^ t', 'time domain signal', ext_uci_feat_des)
ext_uci_feat_des <- sub('^ f', 'frequency domain signal', ext_uci_feat_des)

#Setting the column names of dataset to the above vector

names(combined_ext_features_labels) <- ext_uci_feat_des


# Step 5: Average of variable grouped by acitivity and subject


#Reading the subject files and combining

sub_train <- read_table('./UCI_HAR_Dataset/train/subject_train.txt', col_names = FALSE)
sub_test <- read_table('./UCI_HAR_Dataset/test/subject_test.txt', col_names = FALSE)
sub <- rbind(sub_train,sub_test)


#Combining the suject vector to new column of tidy data of step 4 and renaming it

combined_sub <- cbind(combined_ext_features_labels,sub)
library(dplyr)
combined_sub <- rename(combined_sub, subject = X1)


#Average of variable grouped by acitivity and subject

combined_grouped <- aggregate(combined_sub[, 1:66], list(combined_sub$labels,combined_sub$subject), mean)
