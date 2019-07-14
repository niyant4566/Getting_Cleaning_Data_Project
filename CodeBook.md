# RELEVANT data frames created in this project and RELEVANT data it contains

* activity_labels
    * data frame of 6 possible activities:
        * 1 = WALKING
        * 2 = WALKING.UPSTAIRS
        * 3 = WALKING.DOWNSTAIRS
        * 4 = SITTING
        * 5 = STANDING
        * 6 = LAYING
* features
    * data frame of all different types of measurements collected
* subject_test
    * The subjects who performed the activities. They are numbered from 1 to 30; these form participants of test data
* test_set 
    * Measurements collected for each feature for test data
* test_label 
    * Numerical representation of activity performed


* subject_train
    * See subject_test; these form the participants of the train data
* train_set 
    * See test_set; for train data
* train_label
    * See test_label
    
* sub_lab_set_test
      * combined columns of subject_test,test_label, and test_set to form one test data frame of relevant data
* sub_lab_set_train
      * combined columns of subject_train, train_label, and train_set to form one train data frame of relevant data
* sub_lab_set_both
      * combination of all rows of sub_lab_set_test and sub_lab_set_train to form one large merged dataset of relevant data
* data_set_mean_std
      * subset of sub_lab_set_both only including observations of mean or standard deviation of collected data
* tidy_data
    * complete clean data consisting of average of each measurement for each subject and each activity performed by said subject.
