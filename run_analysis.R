# Script to generate tidy dataset based on Samsung information
# Attention: All Samsung files must be in the same directory as working directory to run


# Read all data sets - train and test
features <- read.table(".\\UCI HAR Dataset\\features.txt")
labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
train_x <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
train_y <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt")
test_y <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt")
test_x <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
  
## STEP 1: Merging training and test sets
# First we only merge the x files
# The y files contain labels and will be added later in STEP 3
allSets <- rbind(train_x,test_x)

## STEP 2:Extraction of the columns regarding mean and std of measurements
# grep used to select all columns ending in mean() and std()
# data table is subset to have only columns with mean and std
allSets <- allSets[,grepl(".*(-mean\\(\\)|-std\\(\\))", features$V2)]

## STEP 3:Use descriptive names to name activities
# First we make a single list with all the labels of the obervations:
allLabels <- rbind(train_y, test_y)

# Second: we define function to change label from number to corresponding description
applyLabels <- function(numberLabel){
  switch (numberLabel,
          return("Walking"),
          return("Walking upstairs"),
          return("Walking downstairs"),
          return("Sitting"),
          return("Standing"),
          return("Laying"))
}

# Finally we apply the function to all elements of labels and add new column to data.frame 
allSets$Activity <- unlist(lapply(allLabels$V1, applyLabels))

## STEP 4: label data set with descriptive variable names
# First we create a vector with new names
varNames <- append(as.character(features[grepl(".*(-mean\\(\\)|-std\\(\\))", features$V2),"V2"]),"Activity")

# Then we set the data.frame column names with new vector
colnames(allSets)<-varNames

## STEP 5: Create a second indepenedent tidy data set with average of each value for each actvity and subject
# First we create the new independent tidyData dataframe which we will make tidy
tidyData <- allSets
# Now we add the column with subject, which we will summarize later
tidyData$Subject <- unlist(subject)
# Next step we group the data.frame based on each activity and each subject
tidyData <- group_by(tidyData,Subject, Activity)
# Then we summarise the data.frame by calculating the mean of each variable for each subject and each activity
tidyData <- summarise_at(tidyData, names(tidyData2)[1:66], mean)
# Finally, we generate the txt file with the tidy data data.frame
write.table(tidyData, "tidyData.txt", row.names = F)
