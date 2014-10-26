# Getting and Cleaning Data
# Course Project
# WJSellers

# set working directory
setwd("~/Repos/GetCleanCourseProject")

##-------------------
## Pre-Processing

# load required package libraries
library(plyr)
library(dplyr)

# download and unzip data set
if(!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/dataset.zip", method="curl")
unzip(zipfile="./data/dataset.zip", exdir="./data")

##-------------------
## Step 1 - Merge the training and the test sets to create one data set.

# read in the three training files
Xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# merge the three training files
train <- cbind(subjectTrain, Ytrain, Xtrain)
names(train)[1:2] <- c("Subject","ActivityID")    ## adding for clarity

# read in the three test files
Xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# merge the three test files
test <- cbind(subjectTest, Ytest, Xtest)
names(test)[1:2] <- c("Subject","ActivityID")    ## adding for clarity

# merge training and testing files
mergedSet <- rbind(train,test) 

##-------------------
## Step 2 - Extract only the measurements on the mean and standard deviation 
## for each measurement. 

# read in feature info
features <- read.table("./data/UCI HAR Dataset/features.txt")
features$V2 <- as.character(features$V2)

# parse full feature name into three columns (Signal, Function, Direction)
# for easier manipulation
features <- cbind(features$V1, features$V2, read.table(text=features$V2,sep='-',colClasses="character",fill=TRUE))
names(features) <- c("featureId","featureName","featureSignal",
                     "featureFunction","featureDirection")

# create index for subsetting only mean and standard deviation measurements
# Note: While other functions and measurement descriptions mention mean and 
# standard deviation, after studying the data and reading the info files, 
# I decided to only include measurements using strictly mean() or std(), 
# as I believe that is the intent of the assignment and makes the most sense 
# of the data.
features$Step2 <- FALSE
features$Step2[features$featureFunction=="mean()"] <- TRUE
features$Step2[features$featureFunction=="std()"] <- TRUE

# extract the mean and standard deviation measurements from the merged set
# using the Step2 index created above
measurements <- mergedSet[,3:563]
extract <- measurements[,features$Step2]
extractSet <- cbind(mergedSet[,1:2],extract)


##-------------------
## Step 3 - Use descriptive activity names to name the activities in the data set

# read in and name activity label data
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
names(activityLabels) <- c("ActivityID","Activity")

# pull activity IDs from merged set
actIDs <- data.frame(ActivityID=extractSet[,2])

# fill in the applicable descriptive activity based on the ActivityID
# using the join function of the plyr package (loaded at top of file)
activitiesLabeled <- join(actIDs, activityLabels, by="ActivityID")

# merge data back together replacing ActivityID with the descriptive names
labeledSet <- cbind(extractSet[1],activitiesLabeled[2],extractSet[,3:68])


##-------------------
## Step 4 - Appropriately label the data set with descriptive variable names.

# pull only features/measurements specified in step 2
selectedFeatures <- features[features$Step2 == TRUE,]

# expanding variable names elements for more descriptive names using the three
# parsed name columns from step 2 (Signal, Function, Direction)
selectedFeatures$featureSignal <- gsub("^t","Time",selectedFeatures$featureSignal)
selectedFeatures$featureSignal <- gsub("^f","Frequency",selectedFeatures$featureSignal)
selectedFeatures$featureSignal <- gsub("Acc","AccelerometerSignal",selectedFeatures$featureSignal)
selectedFeatures$featureSignal <- gsub("Gyro","GyroscopeSignal",selectedFeatures$featureSignal)
selectedFeatures$featureSignal <- gsub("Mag","Magnitude",selectedFeatures$featureSignal)
selectedFeatures$featureSignal <- gsub("BodyBody","Body",selectedFeatures$featureSignal)
selectedFeatures$featureFunction <- gsub("mean","MeanOf",selectedFeatures$featureFunction)
selectedFeatures$featureFunction <- gsub("std","StandardDeviationOf",selectedFeatures$featureFunction)
selectedFeatures$featureFunction <- gsub("\\()","",selectedFeatures$featureFunction)
selectedFeatures$featureDirection <- gsub("X","inXDirection",selectedFeatures$featureDirection)
selectedFeatures$featureDirection <- gsub("Y","inYDirection",selectedFeatures$featureDirection)
selectedFeatures$featureDirection <- gsub("Z","inZDirection",selectedFeatures$featureDirection)

# combining Function-Signal-Director into new descriptive names
selectedFeatures$DescriptiveName <- paste(selectedFeatures$featureFunction,
                                          selectedFeatures$featureSignal,
                                          selectedFeatures$featureDirection,
                                          sep="")

# apply the remaining feature names to the measurement variable columns
names(labeledSet)[3:68] <- as.character(selectedFeatures$DescriptiveName)

# Note: Results are currently in the data frame: labeledSet

##-------------------
## Step 5 - From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.

# taking our labeledSet and turning into a tbl_df so we can use the dplyr package
# create our summary stats
step5set <- tbl_df(labeledSet)

# with dplyr's group_by function, the data is now grouped by Activity and Subject
groupedSet <- group_by(step5set,Activity,Subject)

# with dplyr's summarise_each function, an average is calculated for each 
# grouping and stored as the TidyDataSet
TidyDataSet <- summarise_each(groupedSet,funs(mean))


##-------------------
## Post-Processing

# write the tidy data set to file in our working directory
write.table(TidyDataSet, file="./TidyDataSet.txt",row.name=FALSE)

# print tidy data set to screen
print(TidyDataSet)



