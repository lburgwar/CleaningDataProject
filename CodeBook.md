---
title: "CodeBook"
author: "Lester Burgwardt"
date: "9/30/2020"
output: html_document
---

The tibble xy_tbl is a merging of the training and test data sets and has the following variables:

- "means" the extracted row means of the x training and test data
- "stdev" the extracted row standard deviations of the x training and test data
- "activity" the activity found in the x training and test data
- "subject" the identifier of the person performing the activity
- "phase" the phase or stage of the machine learning process
 
The tibble activityMeans is a second, independent tidy data set created from xy_tbl with the average of each variable for each activity and each subject. activityMeans has the following variables:

- "activity" the activity being performed
- "subject" the identifier of the person performing the activity
- "averagemean" is the average of the means in xy_tbl for each combination of activity and subject.
- "averagestdev" is the average of the standard deviations in xy_tbl for each combination of activity and subject.
