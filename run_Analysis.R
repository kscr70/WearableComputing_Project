# load packages used in this script
library("dplyr")
library("reshape2")

##read in the files from the UCI HAR Dataset folder
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")

xtest <- read.table("UCI HAR Dataset/test/X_test.txt")

ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")

ytest <- read.table("UCI HAR Dataset/test/y_test.txt")

trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

activity <- read.table("UCI HAR Dataset/activity_labels.txt")

features <- read.table("UCI HAR Dataset/features.txt")

##assign column names to the imported data

colnames(trainsubjects) <- "subjectid"
colnames(testsubjects) <- "subjectid"

colnames(activity) <- c("activityid", "activity")

colnames(ytest) <- "activityid"
colnames(ytrain) <- "activityid"

colnames(xtrain) <- features[,2]
colnames(xtest) <- features[,2]

##combine all data into a single data set

training_data <- cbind(trainsubjects, ytrain, xtrain)

test_data <- cbind(testsubjects, ytest, xtest)

alldata <- tbl_df(rbind(training_data, test_data))

##select only the measures of mean and standard deviation


meanstdcols <- grepl("mean\\(\\)", names(alldata)) | grepl("std\\(\\)", names(alldata))

meanstdcols[1:2] <- TRUE

meanstdtbl <- alldata[,meanstdcols]

##create descriptive names for the activity.

meanstdtbl$activityid <- factor(meanstdtbl$activityid, labels=c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

meanstdtbl <- rename(meanstdtbl, activity = activityid)


## create the independent tidy data set with the average of each variable for each activity and each subject. 
melted <- melt(meanstdtbl, id=c("subjectid","activity"))

tidy <- dcast(melted, subjectid+activity ~ variable, mean)

write.table(tidy, "tidy.txt", row.names = FALSE) #writes the tidy data set to a text file.

checktable <- read.table("tidy.txt", header = TRUE) #checks that the file is readable.
