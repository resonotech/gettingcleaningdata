##Read Me
1. run_analysis.R file required data folder in same root directory. The scirpt consider data folder name is rawdata. Folder structure should be as follow
run_analysis.R
/rawdata
  /test
  /train
  activity_labels.txt
  features.txt
  features_info.txt

2. script will generate tidy.txt data into same folder of run_analysis.R

The following steps was involved to prepare the data set.

### 1.  Merged the training and the test sets to create one data set.
     
a. At first train data is collected from all three files into single data table in following pattern. Data is read through read.table and then cbind is used to combine subject,activity and features86
SubjectID  Activity  Features1,,,,Features

b.	Next test data is collected similarly as done in a.
c.	Finally both data frames combined into single data frame with help of rbind operation.

### 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
a.	Before exclude other columns we need to give column names to data frame that was generated in step 1. In this step, feature names are read from features.txt and then two more column name (subjectID,activityName)  added along with these features.
b.	At second step used grep command to separate the columns containing mean and std. Then this vector is use to filter data frame of step, the new data frame only contains the column that have mean and std in their name.

### 3.	Uses descriptive activity names to name the activities in the data set
a)	Read activity name in dataframe.
b)	convert both dataframe step 2b and  step3a into data table and merge datatables  into new datatable with activity name
c)	sub set the columns to make the order as given in step1a (used with=False for subsetting columns in data table)

### 4.	Appropriately labels the data set with descriptive variable names. 
Already done in step 2a

### 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I use ".SD", "lapply" and "by" option to generate the average of each column and put results into new data table.
  