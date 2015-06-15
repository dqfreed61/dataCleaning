# run_analysis.r script overview

The script run_analysis.r performs these  steps for the course project

1. Merges the training and the test sets to create one data frame
    (X_test.tst, y_test.text and subject_test.txt for test and X_train.txt, y_train.txt, subject_train.txt are the inputs) The       data frame with the merged data is trainTest

2. Next, the sript Reads features.txt and creates a vector of column names. The column name vector is named col.name and these     names are applied  to the  trainTest data frame columns
 
3. Next, a select is executed on trainTest to extract the mean and standard deviation columns and to exclude colums that include    freq and angle.  The select functionality is part of the dplyr library and the new data frame created is trainTest1
 
4. Next, the script Reads activity_labels.txt to create a list of labels. The labels are applied to trainTest1 so the labels for    the activities are meaningful.

5. Next, three setnames are performed to remove \\ characters, change hypens into underscores, and change column names contain     BodyBody to Body. The setnames funtionality is part of the data.table library.

6.  Finally the scripts writes out the tidy data set to a flat file named run_data_summary_dqf.txt


