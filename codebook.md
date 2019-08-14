---
title: "CodeBook.md"
author: "Prathamesh"
date: "8/12/2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Step1 : Reading the files
Since the train and test data are space seperated files it is easy to read it using readr
package.

```{r eval=FALSE}
library(readr)
```

Reading the file X_train.txt but before that extract the files and store in UCI_HAR_Dataset
folder. Next set working directory to the location where you extracted the above file.

```{r eval=FALSE}
setwd('D:/R_language/data cleaning/assignment_4')
```

Reading train file in folder UCI_HAR_Dataset -> train -> X_train.txt.
```{r eval=FALSE}
uci_train <- read_table('./UCI_HAR_Dataset/train/X_train.txt', col_names = FALSE) 
```

Reading test file
```{r eval=FALSE}
uci_test <- read_table('./UCI_HAR_Dataset/test/X_test.txt', col_names = FALSE) 
```

Merging train and test data.
```{r eval=FALSE}
combined <- rbind(uci_train,uci_test)
```

# Step 2 : Reading Features and extracting mean and std columns
Reading the feature file
```{r eval=FALSE}
uci_feat <- read_table('./UCI_HAR_Dataset/features.txt', col_names = FALSE)
```

Extracting column numbers of the features with mean()
```{r eval=FALSE}
ext_mean <- grep('\\bmean()\\b',uci_feat$X1)
```

Extracting column numbers of the features with std()
```{r eval=FALSE}
ext_std <- grep('\\bstd()\\b',uci_feat$X1)
```
  
Merging the extracted column numbers of mean and std features
```{r eval=FALSE}
ext_features <- c(ext_mean,ext_std)
```

Subsetting the original dataframe(combined) for mean and std only
```{r eval = FALSE}
combined_ext_features <- combined[ext_features]
```

# Step3 : Reading label and joining it to dataset
Reading the training label file
```{r eval=FALSE}
uci_train_label <- read_table('./UCI_HAR_Dataset/test/y_train.txt', col_names = FALSE) 
```

Reading the test label file
```{r eval=FALSE}
uci_test_label <- read_table('./UCI_HAR_Dataset/test/y_test.txt', col_names = FALSE) 
```

Combining the train and test labels
```{r eval=FALSE}
uci_label <- rbind(uci_train_label,uci_test_label)
```

Reading the descriptive label file
```{r eval=FALSE}
label <- read_table('./UCI_HAR_Dataset/activity_labels.txt', col_names = FALSE)
```

Now for merging the labels from y_train, y_test and activity_labels file we use join from plyr package and not merge because merge shuffle the rows whereas join retains the row as it is
```{r eval=FALSE}
library(plyr)
uci_label_descrip <- join(uci_label,label)
```

Merging this descriptive label column to dataset
```{r eval=FALSE}
combined_ext_features_labels <- cbind(combined_ext_features,uci_label_descrip$X2)
```

# Step 4: Labelling the dataset
To get the feature names with mean() and std() in it we use the ext_features vector to subset the uci_feature dataset
```{r eval=FALSE}
ext_uci_feat <- uci_feat[ext_features,]
```

Adding one more feature to the above dataset i.e. the labels column
```{r eval=FALSE}
ext_uci_feat <- rbind(ext_uci_feat,'labels')
```

Next we need to convert the ext_uci_feat from tibble to character vector
```{r eval=FALSE}
ext_uci_feat_chr <- pull(ext_uci_feat,X1)
```

Setting the column names of dataset to the above vector
```{r eval=FALSE}
names(combined_ext_features_labels) <- ext_uci_feat_chr
```

# Step 5: Average of variable grouped by acitivity and subject

Reading the subject files and combining
```{r eval=FALSE}
sub_train <- read_table('./UCI_HAR_Dataset/train/subject_train.txt', col_names = FALSE)
sub_test <- read_table('./UCI_HAR_Dataset/test/subject_test.txt', col_names = FALSE)
sub <- rbind(sub_train,sub_test)
```

Combining the suject vector to new column of tidy data of step 4 and renaming it
```{r eval=FALSE}
combined_sub <- cbind(combined_ext_features_labels,sub)

combined_sub <- rename(combined_sub, subject = X1)
```

Average of variable grouped by acitivity and subject
```{r eval=FALSE}
combined_grouped <- aggregate(combined_sub[, 1:66], list(x$labels,x$subject), mean)
```
