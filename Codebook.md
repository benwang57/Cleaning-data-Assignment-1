train_x, train_y, test_x, test_y read and stored the data frame from X_train, Y_train, X_test, Y_test

Main_dir stores the main directory

Sub_dir stores a new directory to store the data

features reads the features.txt

all_mean_std stores the columns with mean and standard deviation

tiday_data stores a dataframe with meaningful column namesa and rownames

summaryData is a 180 row x 68 column table. Column 1 is the activity being undertaken by a subject (factor, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) Column 2 is the subject ID (integer, 1-30) for that subject Columns 3-68 are normalized (-1 to +1) means of the named variables collected for that row's subject, while undertaking that row's activity
