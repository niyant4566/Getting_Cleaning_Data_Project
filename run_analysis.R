# Step 1:

# Reading "activity_labels" and "features" through data.table

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

## Files in "test" folder read through data.table

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_label <- read.table("UCI HAR Dataset/test/Y_test.txt")
body_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")  
body_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt") 
body_gyro_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt") 
body_gyro_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt") 
total_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

# Files in "train" folder read through data.table

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_set <- read.table("UCI HAR Dataset/train/X_train.txt")
train_label <- read.table("UCI HAR Dataset/train/Y_train.txt")
body_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")  
body_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt") 
body_gyro_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt") 
body_gyro_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt") 
total_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

# Step 2:

# Renaming column names of "test_set" and "train_set" using features

names(test_set) <- features$V2
names(train_set) <- features$V2

# Renaming column name of "test_label" and "train_label" from "V1" to "Activity"
# as each number in the column represents an activity mentioned in "activity_labels.txt"

names(test_label) <- "Activity"
names(train_label) <- "Activity"

# Renaming column name of "subject_test" and "subject_train" from "V1" to "Subject
# as each number represents the subject who performed an activity

names(subject_test) <- "Subject"
names(subject_train) <- "Subject"

# Step 3:

# Since each subject performed an activity that yielded the set of data collected,
# we merge the subject, label, and set for both "test" and "train"

sub_lab_set_test <- cbind(subject_test,test_label,test_set)
sub_lab_set_train <- cbind(subject_train,train_label,train_set)

# Step 4:

# Task 1: Merges the training and the test sets to create one data set.
# Completed by merging "sub_lab_set_test" and "sub_lab_set_train" into the
# data frame "sub_lab_set_both"

sub_lab_set_both <- rbind(sub_lab_set_test,sub_lab_set_train)

# Step 5:

# Task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Having had trouble with this task, I analysed the problem and found out that some
# column names are duplicated. Further analysis showed that the data in these duplicate
# columns are different, so merging them isn't an option. So first we must make them unique

names(sub_lab_set_both) <- make.unique(names(sub_lab_set_both))

# Now we can complete the task
# Since mean is supposed to be a measure of central tendency, and standard deviation a
# measure of the mean's variation, it wouldn't make sense to select columns that may
# somehow contain mean or std in its title. We only want mean() and std() as they represent
# numbers that can help us make quantitative analyses.

data_set_mean_std <- select(sub_lab_set_both, Subject, Activity, matches("mean()|std()"))

# Step 6:

# Task 3: Uses descriptive activity names to name the activities in the data set
# First we create a data frame "vec" that gives each number a corresponding activity.
# Then we replace the numbers in "data_set_mean_std" with the activity names.

vec <- activity_labels[data_set_mean_std$Activity,]
data_set_mean_std$Activity <- vec$V2

# Extension of Step 2: 

# Task 4: Appropriately labels the data set with descriptive variable names.

names(data_set_mean_std) <- gsub("tBodyAcc", "timeBodyAcceleration",names(data_set_mean_std))
names(data_set_mean_std) <- gsub("fBodyBody", "fBody", names(data_set_mean_std))
names(data_set_mean_std) <- gsub("tGravityAcc", "timeGravityAcceleration",names(data_set_mean_std))
names(data_set_mean_std) <- gsub("tBodyGyro", "timeBodyGyro", names(data_set_mean_std))
names(data_set_mean_std) <- gsub("fBodyAcc", "frequencyBodyAcceleration", names(data_set_mean_std))
names(data_set_mean_std) <- gsub("fBodyGyro", "frequencyBodyGyro", names(data_set_mean_std))

# Step 7:

# Task 5: From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

tidy_data <- data_set_mean_std %>%
        group_by(Subject, Activity) %>%
        summarize_each(mean)
write.table(tidy_data, "TidyData.txt", row.names = FALSE)

