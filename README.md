Step 1: Download the zipped file from the url that is labeled fileUrl and be sure to save the date it was downloaded.

Step 2: Unzip the files that you want from the original zipped file. These files include getting X_test.txt, X_train.txt, features.txt, activity_labels.txt, y_train.txt, y_test.txt, subject_test.txt, and subject_train.txt.

Step 3: Then read all of these files in using the read.table() command.

Step 4: Bind the train and test data sets together in a variable called data.

Step 5: In order to get only the mean and standard deviation values for each measurement, first find the column indices that contain the words "mean", "std", or "Mean" in the dataframe called data and sort these indices.

Step 6: Then subset data to only contain the columns with these indices.

Step 7: Substitute the activity labels into data instead of numbers 1-6 using the gsub() function.

Step 8: In order to label the columns with appropriate variable names, substitute all characters such as (),., and - with "" which is nothing in order to remove these from the variable names.

Step 9: Load the dplyr package in order to use functions necessary to create the tidy data set

Step 10: Convert the data dataframe into a table labelled tidy using the tbl_df() function

Step 11: Group all the data inside the tidy table by subject and activity into a grouped object by_subject_activity

Step 12: Summarise each group in the by_subject_activity grouped object and find the mean in each group and store this in a variable called tidy.data

Step 13: Write a table of the tidy data set called tidy.data using the write.table() function into a text file tidydata.txt. Be sure to change the tidy.data into a data frame
