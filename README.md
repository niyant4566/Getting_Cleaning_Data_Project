# Getting_Cleaning_Data_Project

# Files in this Repository

*README.md - This file!
*CodeBook.md - Describes the variables and data
*run_analysis.R - The code to tidy the given data

Step 1: First, read all the files that have been provided
1. For simplicity, the names of the data frames are the same as the names of the files read (e.g. the contents of the file "activity_labels.txt" formed the data frame "activity_labels"
    1. subject_test and subject_train are data frames that list the subjects that form the test data (test) or the subjects that carried out the test numbered from 1 to 30
    2. test_set and train_set are data frames that list all the measurements collected in the experiments
    3. test_label and train_label are data frames that list the numeric value of 6 types of activities performed. Each activity corresponds to a number between 1 and 6.
    4. activity_label is a data frame that lists which activity corresponds to which number (See previous point)
    5. features is a data frame that lists all the types of measurements that the experiments are supposed to collect.
    
Step 2: Next, we add headers to each column of each data frame where necessary. For example, the elements of features will form the headers for test_set and train_set

Step 3: Now we combine the data frames subject_test, test_label, and test_set to form a complete test data. We do the same with subject_train, train_label, and train_set to get the complete train data

Step 4: Merge the two datasets formed in step 3 to form one large dataset.

Step 5: We only want data relevant to what we want to analyze, so we only select measurements of mean and standard deviation. We create the data frame data_set_mean_std that holds all this relevant data.

Step 6: Referring to another data frame to see which number means which activity is too much of a hassle. So we replace the numbers in the now renamed "Activity" column with the activities those numbers represent.

Step 7: We finally create our tidy data by separating the data into groups of subjects then the activities performed. Then we calculate the mean of every measurement collected that corresponds to each combination of subject and activity. We create a file "TidyData.txt" that will hold this clean data.

# Notes:
*Unfortunately, some measurements that were collected were given the same name. We get around this problem by using the function make.unique on the names of all the columns of the relevant data collected after step 5. This adds ".1" the first time the same measurement appears, ".2" the next time, and so on.

*Packages were installed in the console of RStudio as required.
