Getting_Cleaning_Data
=====================

Creating a tidy data set

Contents of run_analysis.R file in this repo can be run in R to extract data about wearable tech, from this file location:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  The data includes both test and training conditions, collected with accelerometers from the Samsung Galaxy S smartphones.  

The zipped data file contains 4 files (activity_labels, features, features_info, and readme), and 2 data folders (test and train).  The test and train folders each contain 3 files (subject, x, and y), and 1 folder (Inertial Signals).

The README file contains information regarding all of the files and folders - read this file before running the analysis in R.

Test data contains 2947 observations, and Train data contains 7352 observations - if your export does not contain these observation counts, you may want to re-extract the data.

The dataset was sourced from:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

