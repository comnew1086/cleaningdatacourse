# cleaningdatacourse
coursera cleaning data submission

This repository contains the output of cleaning and analyzing data from the UCI HAR Exercise Activity Dataset. 
It intially reads in several tables of data from the txt files in the UCI Dataset.
Those files were initially divided in to training and test set data.
They also include separate imported files "y" that contain the exercise labels from 1 to 6 for different activities and subject_activity that contain the id number from 1 to 30 of the person who was exercising.

We column bind the exercise labels and subject ids to the measurement columns after filtering only the 12 columns that contain mean and standard deviation data from 2 measurement devices (the accelerometer and gyroscope).

The columns in the cleaned dataset each account for one variable with the following names:
"accel_mean_x",->average normalized value in the x axis from the accelerometer reading in gravity of earth "g"
"accel_mean_y",->same as above but in y axis
"accel_mean_z",->same as above but in z axis
"accel_stdev_x",-> standard deviation normalized value in the x axis from the accelerometer reading in gravity of earth "g"
"accel_stdev_y",-> standard deviation normalized value in the y axis from the accelerometer reading in gravity of earth "g"
"accel_stdev_z",-> standard deviation normalized value in the z axis from the accelerometer reading in gravity of earth "g"
 "gyro_mean_x",->average normalized value in the x axis from the gyroscope reading in angle of radians/second
 "gyro_mean_y",->average normalized value in the y axis from the gyroscope reading in angle of radians/second
 "gyro_mean_z",->average normalized value in the z axis from the gyroscope reading in angle of radians/second
 "gyro_stdev_x",->standard deviation normalized value in the x axis from the gyroscope reading in angle of radians/second
 "gyro_stdev_y",->standard deviation normalized value in the y axis from the gyroscope reading in angle of radians/second
 "gyro_stdev_z",->standard deviation normalized value in the z axis from the gyroscope reading in angle of radians/second
 "exercise_activity", -> a number 1 to 6 indicating the activity
 "subject_id" _> a number from 1 to 30 indicating which person did the exercise 
 
 We then use the group_by command to take the data in the previous dataset and summarize the mean values of each measurement for each combination of exercise performed by each of the 30 subjects in the study.
 
 The result is stored in a table that is written to a txt file called "step5_average_measure_exer_subj.txt"
