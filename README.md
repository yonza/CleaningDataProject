CleaningDataProject
===================


Contains tidyData.csv dataset, run_analysis.R, README.md, and CodeBook.md

Running the running run_analysis.R will:

(1)
Download “https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip” to a newly created directory and unzip it.  The zipped file contains
data collected from an accelerometer attached to each of 30 subjects for which
each subject performed 6 distinct actions.  Data exists in multiple .txt files. 

(2)
Combine all files into a single dataset containing all subjects and all actions and
the measured means and standard deviations for the x,y, and z axis.  Note that 
there are multiple measurements for each one of these. 

(3) 
The multiple measurements are combined so that we get the mean of means or 
mean of the standard deviation for each subject, for each action.  The variable
names are modified for readability. 

(4) 
This new dataset will be written to the same directory as the .zip file as a cdv file. 


