library(dplyr)

Main_dir <- "C:/Users/benwa/Documents/R Studio/Cleaning Data/Assignment 1"
Sub_dir <- "data"
#Define the main/sub working dirctory

dir.create(file.path(Main_dir, Sub_dir), showWarnings = FALSE)
setwd(file.path(Main_dir, Sub_dir))
#set the working directory

Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, "./data.zip")
unzip(zipfile = "./data.zip")
#Download and unzip the zip, now that we have the data unzipped in a folder called "UCI HAR Dataset"

pathdata = file.path("./", "UCI HAR Dataset")
#set the path to data folder

train_x <- read.table(file.path(pathdata, "train", "X_train.txt"), header = FALSE)
#read the observations
train_y <- read.table(file.path(pathdata, "train", "y_train.txt"), header = FALSE)
#read the variables
train_subject <- read.table(file.path(pathdata, "train", "subject_train.txt"), header = FALSE)

test_x <- read.table(file.path(pathdata, "test", "X_test.txt"), header = FALSE)
test_y <- read.table(file.path(pathdata, "test", "y_test.txt"), header = FALSE)
test_subject <- read.table(file.path(pathdata, "test", "subject_test.txt"), header = FALSE)
#read the testing data

features = read.table(file.path(pathdata, "features.txt"), header = FALSE)
#read the features data

activityLabels = read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)
#read the activity labels data

colnames(train_x) <- features[,2]
colnames(train_y) <- "activityId"
colnames(train_subject) <- "subjectId"
#Assign column values to training data

colnames(test_x) <- features[,2]
colnames(test_y) <- "activityId"
colnames(test_subject) <- "subjectId"
#Assign column values to testing data

train_mrg <- cbind(train_y, train_subject, train_x)
test_mrg <- cbind(test_y, test_subject, test_x)
all_mrg <- rbind(train_mrg, test_mrg)
#combine test data and train data

col_names <- colnames(all_mrg)
mean_std <- (grepl("activityId", col_names)|grepl("subjectId", col_names)
             |grepl("mean..", col_names)|grepl("std..", col_names))
all_mean_std <- all_mrg[, mean_std == TRUE]
#filter out columns with mean and standard deviation by grepl and subsetting

all_mean_std <- mutate(all_mean_std, activityId = as.character(activityId))
activityLabels <- mutate(activityLabels, V1 = as.character(V1), V2 = as.character(V2))
#change the type to character for substitution in next step

tidy_data <- all_mean_std
#duplicate a dataframe for specific names

for (i in 1:nrow(activityLabels)){
        tidy_data <- mutate(tidy_data, activityId = gsub(activityLabels[i,1], activityLabels[i,2], activityId))
}
#a for loop to change the replace the name one by one

names(tidy_data)[1] = "activity"
names(tidy_data)[2] = "subject"
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))
#give meaning names to colnames of tidy_data

final_data <- tidy_data %>%
        group_by(subject, activity) %>%
        summarise_all(mean)
write.table(final_data, "FinalData.txt", row.name=FALSE)
#summarize the mean for each subject, activity group, save it to final data txt file