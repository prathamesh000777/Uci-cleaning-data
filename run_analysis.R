library(readr)

setwd('D:/R_language/data cleaning/assignment_4')

uci_train <- read_table('./UCI_HAR_Dataset/train/X_train.txt', col_names = FALSE) 

uci_test <- read_table('./UCI_HAR_Dataset/test/X_test.txt', col_names = FALSE) 

combined <- rbind(uci_train,uci_test)

uci_feat <- read_table('./UCI_HAR_Dataset/features.txt', col_names = FALSE)

ext_mean <- grep('\\bmean()\\b',uci_feat$X1)

ext_std <- grep('\\bstd()\\b',uci_feat$X1)

ext_features <- c(ext_mean,ext_std)

combined_ext_features <- combined[ext_features]

uci_train_label <- read_table('./UCI_HAR_Dataset/test/y_train.txt', col_names = FALSE) 

uci_test_label <- read_table('./UCI_HAR_Dataset/test/y_test.txt', col_names = FALSE) 

uci_label <- rbind(uci_train_label,uci_test_label)

label <- read_table('./UCI_HAR_Dataset/activity_labels.txt', col_names = FALSE)

library(plyr)

uci_label_descrip <- join(uci_label,label)

combined_ext_features_labels <- cbind(combined_ext_features,uci_label_descrip$X2)

ext_uci_feat <- uci_feat[ext_features,]

ext_uci_feat <- rbind(ext_uci_feat,'labels')

ext_uci_feat_chr <- pull(ext_uci_feat,X1)

names(combined_ext_features_labels) <- ext_uci_feat_chr

sub_train <- read_table('./UCI_HAR_Dataset/train/subject_train.txt', col_names = FALSE)

sub_test <- read_table('./UCI_HAR_Dataset/test/subject_test.txt', col_names = FALSE)

sub <- rbind(sub_train,sub_test)

combined_sub <- cbind(combined_ext_features_labels,sub)

combined_sub <- rename(combined_sub, subject = X1)

combined_grouped <- aggregate(combined_sub[, 1:66], list(x$labels,x$subject), mean)

