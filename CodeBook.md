==========================================
Getting and Cleaning Data - Course Project
==========================================

============
STUDY DESIGN

The raw data for this project, the Human Activity Recognition Using Smartphones Data Set, comes from the UCI Machine Learning Repository and can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

------------
This explanation of the experiments comes from the raw data README.txt:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details."

------------

To create the tidy data set, 4 major changes have been made to the raw data:

1. The raw data was broken into multiple files which had to be assembled into a single data set based on the structure laid out in the original documentation. (Steps 1 & 3)

2. The 561 features have been filtered down to 66, focusing only on the measurements on the mean and standard deviation for each measurement. (Step 2)

3. The feature measurment variable names have been expanded from abbreviated format into more descriptive and readable names. (Step 4)

4. Using the 'dplyr' package, the prepped data was grouped by Subject and Activity and then the mean of each measurement for each Subject and Activity was calculated for the final tidy data set. (Step 5)

Please see README.md and the comments in 'run_analysis.R' for a full accounting of all steps.

=============
CODE BOOK

Variable List 

 [1] "Activity" - Factor w/6 Levels - Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing and Laying                                                           
 [2] "Subject"  - int from 1 to 30
 
 The following 66 variables have been normalized and bounded within [-1,1].
 Because the data is normalized, the units have been cancelled out.
 
 [3] "MeanOfTimeBodyAccelerometerSignalinXDirection"                      
 [4] "MeanOfTimeBodyAccelerometerSignalinYDirection"                      
 [5] "MeanOfTimeBodyAccelerometerSignalinZDirection"                      
 [6] "StandardDeviationOfTimeBodyAccelerometerSignalinXDirection"         
 [7] "StandardDeviationOfTimeBodyAccelerometerSignalinYDirection"         
 [8] "StandardDeviationOfTimeBodyAccelerometerSignalinZDirection"         
 [9] "MeanOfTimeGravityAccelerometerSignalinXDirection"                   
[10] "MeanOfTimeGravityAccelerometerSignalinYDirection"                   
[11] "MeanOfTimeGravityAccelerometerSignalinZDirection"                   
[12] "StandardDeviationOfTimeGravityAccelerometerSignalinXDirection"      
[13] "StandardDeviationOfTimeGravityAccelerometerSignalinYDirection"      
[14] "StandardDeviationOfTimeGravityAccelerometerSignalinZDirection"      
[15] "MeanOfTimeBodyAccelerometerSignalJerkinXDirection"                  
[16] "MeanOfTimeBodyAccelerometerSignalJerkinYDirection"                  
[17] "MeanOfTimeBodyAccelerometerSignalJerkinZDirection"                  
[18] "StandardDeviationOfTimeBodyAccelerometerSignalJerkinXDirection"     
[19] "StandardDeviationOfTimeBodyAccelerometerSignalJerkinYDirection"     
[20] "StandardDeviationOfTimeBodyAccelerometerSignalJerkinZDirection"     
[21] "MeanOfTimeBodyGyroscopeSignalinXDirection"                          
[22] "MeanOfTimeBodyGyroscopeSignalinYDirection"                          
[23] "MeanOfTimeBodyGyroscopeSignalinZDirection"                          
[24] "StandardDeviationOfTimeBodyGyroscopeSignalinXDirection"             
[25] "StandardDeviationOfTimeBodyGyroscopeSignalinYDirection"             
[26] "StandardDeviationOfTimeBodyGyroscopeSignalinZDirection"             
[27] "MeanOfTimeBodyGyroscopeSignalJerkinXDirection"                      
[28] "MeanOfTimeBodyGyroscopeSignalJerkinYDirection"                      
[29] "MeanOfTimeBodyGyroscopeSignalJerkinZDirection"                      
[30] "StandardDeviationOfTimeBodyGyroscopeSignalJerkinXDirection"         
[31] "StandardDeviationOfTimeBodyGyroscopeSignalJerkinYDirection"         
[32] "StandardDeviationOfTimeBodyGyroscopeSignalJerkinZDirection"         
[33] "MeanOfTimeBodyAccelerometerSignalMagnitude"                         
[34] "StandardDeviationOfTimeBodyAccelerometerSignalMagnitude"            
[35] "MeanOfTimeGravityAccelerometerSignalMagnitude"                      
[36] "StandardDeviationOfTimeGravityAccelerometerSignalMagnitude"         
[37] "MeanOfTimeBodyAccelerometerSignalJerkMagnitude"                     
[38] "StandardDeviationOfTimeBodyAccelerometerSignalJerkMagnitude"        
[39] "MeanOfTimeBodyGyroscopeSignalMagnitude"                             
[40] "StandardDeviationOfTimeBodyGyroscopeSignalMagnitude"                
[41] "MeanOfTimeBodyGyroscopeSignalJerkMagnitude"                         
[42] "StandardDeviationOfTimeBodyGyroscopeSignalJerkMagnitude"            
[43] "MeanOfFrequencyBodyAccelerometerSignalinXDirection"                 
[44] "MeanOfFrequencyBodyAccelerometerSignalinYDirection"                 
[45] "MeanOfFrequencyBodyAccelerometerSignalinZDirection"                 
[46] "StandardDeviationOfFrequencyBodyAccelerometerSignalinXDirection"    
[47] "StandardDeviationOfFrequencyBodyAccelerometerSignalinYDirection"    
[48] "StandardDeviationOfFrequencyBodyAccelerometerSignalinZDirection"    
[49] "MeanOfFrequencyBodyAccelerometerSignalJerkinXDirection"             
[50] "MeanOfFrequencyBodyAccelerometerSignalJerkinYDirection"             
[51] "MeanOfFrequencyBodyAccelerometerSignalJerkinZDirection"             
[52] "StandardDeviationOfFrequencyBodyAccelerometerSignalJerkinXDirection"
[53] "StandardDeviationOfFrequencyBodyAccelerometerSignalJerkinYDirection"
[54] "StandardDeviationOfFrequencyBodyAccelerometerSignalJerkinZDirection"
[55] "MeanOfFrequencyBodyGyroscopeSignalinXDirection"                     
[56] "MeanOfFrequencyBodyGyroscopeSignalinYDirection"                     
[57] "MeanOfFrequencyBodyGyroscopeSignalinZDirection"                     
[58] "StandardDeviationOfFrequencyBodyGyroscopeSignalinXDirection"        
[59] "StandardDeviationOfFrequencyBodyGyroscopeSignalinYDirection"        
[60] "StandardDeviationOfFrequencyBodyGyroscopeSignalinZDirection"        
[61] "MeanOfFrequencyBodyAccelerometerSignalMagnitude"                    
[62] "StandardDeviationOfFrequencyBodyAccelerometerSignalMagnitude"       
[63] "MeanOfFrequencyBodyAccelerometerSignalJerkMagnitude"                
[64] "StandardDeviationOfFrequencyBodyAccelerometerSignalJerkMagnitude"   
[65] "MeanOfFrequencyBodyGyroscopeSignalMagnitude"                        
[66] "StandardDeviationOfFrequencyBodyGyroscopeSignalMagnitude"           
[67] "MeanOfFrequencyBodyGyroscopeSignalJerkMagnitude"                    
[68] "StandardDeviationOfFrequencyBodyGyroscopeSignalJerkMagnitude"  

