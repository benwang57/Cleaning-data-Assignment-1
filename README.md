#Getting And Cleaning Data Assignment

This readme file covers the explanation related to the how the given data was transformed into a tidy set as well as the contents of this repository.

#Contents

This repository consists of 3 files

CodeBook.md : This markdown document indicates all the variables of the tidy data set.
README.md : This markdown document explains the transformations involved step by step.
run_analysis.R : This R script was used to transform the given data to a tidy data set.
tidyset.txt : This is the tidy data set produced as an output from the R script.
#Running the R script

To run the R script one must have the following files in their working directory

/train/X_train.txt
/test/X_test.txt
features.txt
/test/y_test.txt
/train/y_train.txt
/test/subject_test.txt
/train/subject_train.txt
dplyr package must be installed in R for this script to run

Once you have the unzipped folder as the working directory you can run the given R script which will create a tidy data set in a file named tidyset.txt

#Step-wise Transformation
