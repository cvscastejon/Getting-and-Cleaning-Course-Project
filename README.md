# Getting-and-Cleaning-Course-Project
Repo containing all files required for the course project: R script, output txt file, README.md and codebook.


This repo is made to summarise the information collected in the project "Human Activity Recognition Using Smartphones Dataset" by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 


It contains two files:
  run.analysis.R
  tidyData.txt
  
 The file run.analysis.R is an R script tha tcollects the information from the training and data sets from the "Human Activity Recognition Using Smartphones Dataset" and does the following processing:
 
 ATTENTION: Before running the script, make sure you have installed the package dplyr and the the working directory contains all files with the raw data in the format they were unzipped.
 
 
 First it reads all the .txt files regarding train and test sets, and also the files with descriptive information:
  features.txt: contains the names of the variables
  activity_labels.txt: contatins the description of the activities performed by the subjects
  X_train.txt, X_test.txt contain the observations in the training and testing sets, respectively
  Y_train.txt, Y_test.txt contain the labels for the activities in a number code
  subject_test.txt, subject_train.txt contain the subject who performed the test
 
For thi project, we didn't differentiate between training and testing information, so the observations were combined using the rbind function

For this experiment we were only interested in the mean and standard deviation observations, so we extracted the columns containing only -mean() and std() strings using the grpl function

We used the information in the activity_labels.txt to name the lables with descriptive information, rather than single digit numbers. So what was previously described as 1,2,3,4,5,6 became the human readable Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing and Laying. This fit the rule of tidy data.

The next step in turning the data frame into the tidy data format was to appropriately name all the columns with the name of the obsevation. The information was extracted from the features.txt and inserted into the data.frame The codebook contains  description of all the variables.

Finally, a tidyData data frame is generated summarising the observations by the means of all variables regarding the subject and activity.

The tidyData.txt is the output of the script, and it follows all rules of tidy data data:
  Each variable is in one column
  Each observation is in a different row
  Variable names are human readable
  There is a row with the names of the variables at the top
  
To read the output file, use the command:
>View(read.table("tidyData.txt",header = T))
