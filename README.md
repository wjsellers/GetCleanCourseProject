==========================================
Getting and Cleaning Data - Course Project
==========================================

This repository contains files for the Course Project of Johns Hopkins' Getting and Cleaning Data class on Coursera. The purpose of the project is to demonstrate my ability to collect, work with and clean a data set.

Below you will find sections on:
- Files included in repository
- Files included in the unzipped raw data
- Explantion of the 'run_analysis.R' script

=============================
Files included in repository:
- 'README.md'
- 'CodeBook.md': Contains information about study design and data set variables
- 'run_analysis.R': the R script containing the full instruction list, which will guide you from downloading the raw data all the way through transforming it into a tidy data set
- 'TidyDataSet.txt': our goal, the tidy data set created from run_analysis.R

=======================================
Files included in the unzipped raw data:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

There is an additional folder of files labeled 'Inertial Signals' within both the 'test' and 'train' folders that are not used for the purposes of this project. For more information on those files, please see 'README.txt' from the raw data.

Full source info can be found at the UCI Machine Learning Repository - Human Activity Recognition Using Smartphones Data Set: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

==========================================
Explantion of the 'run_analysis.R' script

The 'run_analysis.R' script goes through five main steps, as laid out in the project description, plus some pre-processing and post-processing. For more information on any set, please see the comments within the script file.

---
Pre-Processing - 

The script begins by initializing the libraries of the two packages we will be using to create our tidy data set, plyr and dplyr. Then, it downloads and unzips the raw data into a data directory, which it will create if a data directory does not already exist.

---
Step 1 - Merge the training and test sets into one data set - 

The training and test sets are each composed of three different files with the measurement data and the corresponding subject and activity info. Each set of three files must be combined first, and then are merged themselves into our single data set.

---
Step 2 - Extract only measurements on the mean and standard deviation - 

Our merged data set from step 1 includes all 561 measurement variables collected in the original experiment and now in step 2 our goal is to extract only the measurements on the mean and stanard deviation. To do so however, we must first get more information on all the meauresement variables, which can be found in the 'features.txt' and 'features_info.txt'. 

The script pulls the basic info from 'features.txt' and then parses the measurement names into separate columns, breaking out and labeling the Signal, Function and Direction. Next, it creates an index looking for mean() and std() in the Function list, which is then used to extract the columns that match our criteria, leaving us with 66 columns of measurements, plus 2 more with subject and activity. 

Note: While other functions and measurement descriptions mention the mean and standard deviation, after studying the data, reading the info files and consulting the forums, I decided to only include measurements using strictly "mean()" or "std()", as I believe that is the intent of the assignment and makes the most sense of the data.

---
Step 3 - Use descriptive activity names to name the activities in the data set

The original activity data only included the IDs (1:6) for the six activities. Now we must read in data from the 'activity_labels.txt' file so that we may instead include the activity names themselves: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing and Laying. To do match up the IDs and names, the script uses the join function from the plyr package.

---
Step 4 - Appropriately label the data set with descriptive variable names

The given measurement names are a combination of abbreviations for the signal, function and direction of the measurements and as such are not user-friendly. In step 4 the script uses gsub to expand the abbreviations to more readable descriptions. Information from the 'features_info.txt' file was used to inform decisions on the meaning of the abbreviations and the measurements in general.

---
Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Now our prepped data set is placed in a wrapper with the tbl_df function so that we can take advantage of the 'dplyr' package to create our summary statistics.
Using group_by, the data is grouped by Activity and Subject and then, using summarise_each, the mean of the measurements is calculated for all the groupings. The result is saved as our tiday data set.

---
Post-Processing -

The final steps are writing the tidy data set from step 5 to a txt file ('TidyDataSet.txt') and printing the results.

==========================================







