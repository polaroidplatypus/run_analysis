# run_analysis
The repo uses the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

##Data
The data is downloaded, unzipped, and included in this repo for easier conenction.
The folder contains data for the test and training of 30 waist-mounted smartphones, along with labels and features of the data set.

##Code Explanation
The code functions to merge the training and test datasets, extract necessary mean and std data columns anad create a new table containing the averages for each column grouped by the subjects and their different activites.

##Final Output
The final output is contained in FinalDataSet.txt and contains the different variables' mean and std for each subject and activities.


