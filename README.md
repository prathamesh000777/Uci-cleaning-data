---
title: "README.MD"
author: "Prathamesh"
date: "8/13/2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Files read
X_train.txt,y_train.txt,X_test.txt,y_test.txt, activity_labels.txt, features.txt in the shared file

# Data files created
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


ext_uci_feat_chr -             converted extracted features table to character vector


sub_train - vector of suject of training set


sub_test - vector of suject of test set


sub <- combined vector of subjects


combined_sub - tidy dataset of step 4 with suject column added to it


combined_grouped - Average of variable grouped by acitivity and subject
