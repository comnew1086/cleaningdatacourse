#load the required libraries for functions called
library(tidyverse)
library(readr)
#set the working directory to the folder for the unzipped dataset from UCI HAR Dataset

#read in the training data
X_train <- read_table2("train/X_train.txt",
col_names = FALSE)
View(X_train)
#read in the test data
X_test <- read_table2("test/X_test.txt",
col_names = FALSE)
View(X_test)
#read in the training exercise labels 1-6 for each row
y_train <- read_table2("train/y_train.txt",
                      col_names = FALSE)
#read in the testing exercise labels 1-6 for each row
y_test <- read_table2("test/y_test.txt",
                      col_names = FALSE)
#read in the subject labels 1-30 for each row
subject_train<-read_table2("train/subject_train.txt",
                                     col_names = FALSE)
#read in the subject labels 1-30 for each row
subject_test<-read_table2("test/subject_test.txt",
                           col_names = FALSE)




#select the columns from X train and test for the mean and standard deviation of the accelerometer (1:6) and gyrometer readings (41:46) based on info in features.txt file
xtrainfil<-select(X_train,X1:X6,X41:X46)
xtestfil<-select(X_test,X1:X6,X41:X46)
#column bind together the mean and standard deviation measurements for the training group with the activity labels (y_train) and the subject id (1:30) labels (subject_train)
traintot<-cbind(xtrainfil,y_train,subject_train)
#change the names of the columns to reflect the variables
names(traintot)<-c("accel_mean_x","accel_mean_y","accel_mean_z","accel_stdev_x","accel_stdev_y","accel_stdev_z",
                   "gyro_mean_x","gyro_mean_y","gyro_mean_z","gyro_stdev_x","gyro_stdev_y","gyro_stdev_z","exercise_activity","subject_id")
#check the new names for the columns of train tot
traintot %>% head

#bind together the mean and standard deviation measurements of test group with the activity labels (y_test) and the subject id (1:30) labels (subject_test)
testtot<-cbind(xtestfil,y_test,subject_test)
testtot %>% head
#change the names of the test tot columns to reflect the variables
names(testtot)<-c("accel_mean_x","accel_mean_y","accel_mean_z","accel_stdev_x","accel_stdev_y","accel_stdev_z",
                   "gyro_mean_x","gyro_mean_y","gyro_mean_z","gyro_stdev_x","gyro_stdev_y","gyro_stdev_z","exercise_activity","subject_id")


#rowbind the train group data with the test group data since all variables are in seperate columns and all in the same order

totaldat<-rbind(traintot,testtot)
#confirm we 10299 observations of 30 different subjects performing 6 different activities
#confirm each observation row has 6 measurements for the acceleromter, 6 observations of the gyro, 1 exercise and 1 subject
totaldat %>% str



#change the exercise activity number to the associated label name provided in the activity_labels.txt file
totaldat$exercise_activity<-factor(totaldat$exercise_activity, levels = c(1,2,3,4,5,6),
       labels = c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING", "LAYING"))
#confirm the label names have been added
totaldat %>% head

#totaldat provides a labeled dataset that meets requirements 1-4 next we need to create a second tidy data set
#this dataset will average each variable for each activity and each subject

## CLEANED TIDY DATASET 1 totaldat with column labels
totaldat %>% spread(exercise_activity,subject_id)



#group data by exercise activity and subject id to create 180 different groups 
by_exercise_subject<-totaldat %>% group_by(exercise_activity,subject_id)
#provide a dataset with the average of the accelerometer and gyrometer data measurements of mean and standard deviation for X,Y,Z axes
#each row provides the average stats for each subject and exercise activity combination that participated in the research study
#view the dataset
by_exercise_subject%>% summarize_all(list(mean)) %>% View

## CLEANED TIDY DATASET 2 Average_measure_exercise_subject
Average_measure_exercise_subject<-by_exercise_subject%>% summarize_all(list(mean)) 

#Uncomment below to Write the second dataset to a text file for submission 

write.table(Average_measure_exercise_subject,"step5_average_measure_exer_subj.txt",row.name=FALSE)
