
#Load Data, extract row means and standard deviations and load into tibbles
library(tidyverse)
xtrainfile = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/UCI HAR Dataset/train/X_train.txt'
xtrain_means_tbl <- read_table(xtrainfile, col_names=FALSE) %>% rowMeans(.) %>% as_tibble(.)
names(xtrain_means_tbl) <- "means"

xtrain_stdev_tbl <- read_table(xtrainfile, col_names=FALSE) %>% apply(., 1, sd) %>% as_tibble(.)
names(xtrain_stdev_tbl) <- "stdev"

ytrainfile = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/UCI HAR Dataset/train/y_train.txt'
ytrain_tbl <- read_csv(ytrainfile, col_names = "activity")

xtestfile = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/UCI HAR Dataset/test/X_test.txt'
xtest_means_tbl <- read_table(xtestfile, col_names=FALSE) %>% rowMeans(.) %>% as_tibble(.)
names(xtest_means_tbl) <- "means"

xtest_stdev_tbl <- read_table(xtestfile, col_names=FALSE) %>% apply(., 1, sd) %>% as_tibble(.)
names(xtest_stdev_tbl) <- "stdev"

ytestfile = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/UCI HAR Dataset/test/y_test.txt'
ytest_tbl <- read_csv(ytestfile, col_names = "activity")

#Add subject ID
subject_train_file = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/UCI HAR Dataset/train/subject_train.txt'
subject_train <- read_csv(subject_train_file, col_names = "subject")

subject_test_file = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/UCI HAR Dataset/test/subject_test.txt'
subject_test <- read_csv(subject_test_file, col_names = "subject")

#Put the train, test, and subject tibbles together to form two, four column tibbles
#Then add a fifth column to each tibble labeled "phase" for the machine learning phase: train or test
library(dplyr)
xytrain_tbl <- bind_cols(xtrain_means_tbl,xtrain_stdev_tbl,ytrain_tbl,subject_train) %>% mutate(phase = "train")
xytest_tbl <- bind_cols(xtest_means_tbl,xtest_stdev_tbl,ytest_tbl,subject_test) %>% mutate(phase = "test")

#Stack the xytrain_tbl on top of xytest_tbl
xy_tbl <- bind_rows(xytrain_tbl,xytest_tbl)

#Use descriptive activity names to name the activities in the data set
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING
labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
xy_tbl %>% mutate(activity = cut(activity, breaks = 6, labels = labels))

outfile = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/xy_tbl.csv'
write.csv(xy_tbl, outfile, row.names = FALSE)

#Create a second, independent tidy data set with the average of each variable for each activity and each subject.
activityMeans <- ddply(xy_tbl,.(activity,subject),summarize,mean(means), mean(stdev)) %>% 
        mutate(activity = cut(activity, breaks = 6, labels = labels)) %>%
        as_tibble(.)
names(activityMeans)[3] <- "averagemean"
names(activityMeans)[4] <- "averagestdev"

outfile = 'C:/Users/Charlie/Documents/Coursera/DataScience/GettingAndCleaningData/CleaningDataProject/activityMeans.csv'
write.csv(activityMeans, outfile, row.names = FALSE)



