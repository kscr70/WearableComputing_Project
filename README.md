#WearableComputing_Project
##Course project for Getting and Cleaning Data
The data used in this project was collected from the the accelerometers from the Samsung Galaxy S smartphone. A full descritption of the can be found at the [site where the data was obtained.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
###Location of files for analysis
Zipped files were downloaded using the link on the course project page. The location of the files can be found [here.] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Date Downloaded:  "Wed Feb 11 21:44:03 2015"

Once download the file was unzipped and the folder named **"UCI HAR Dataset"** was placed in my working directory.

This script requires that there be a directory (or folder) labeled **"UCI HAR Dataset"** in your working directory.

The "UCI HAR Dataset" folder must include the following folders and files:

1. folder labeled **train** with the files:
 * `subject_train.txt`
 * `X_train.txt`
 * `y_train.txt`
2. folder labeled **test** with the files:
 * `subject_test.txt`
 * `X_test.txt`
 * `y_test.txt`
3. And these files directly in the **"UCI HAR Dataset folder"**:
 * `activity_labels.txt`
 * `features.txt`
 
##run_Analysis.R

###Packages required.

The run_Analysis.r script requires two packages to be loaded.
  * [`reshape2`](http://cran.r-project.org/web/packages/reshape2/index.html)
  * [`dplyr`](http://cran.r-project.org/web/packages/dplyr/index.html)

###How the script works.
1. **Read in the files from the "UCI HAR Dataset folder"**
     ``` 
      xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")

      xtest <- read.table("UCI HAR Dataset/test/X_test.txt")

      ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")

      ytest <- read.table("UCI HAR Dataset/test/y_test.txt")

      trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

      testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

      activity <- read.table("UCI HAR Dataset/activity_labels.txt")

      features <- read.table("UCI HAR Dataset/features.txt")
     ```
2. **Assign column names to the imported data**
     ```
     colnames(trainsubjects) <- "subjectid"
     colnames(testsubjects) <- "subjectid"

     colnames(activity) <- c("activityid", "activity")

     colnames(ytest) <- "activityid"
     colnames(ytrain) <- "activityid"

     colnames(xtrain) <- features[,2]
     colnames(xtest) <- features[,2]
     ```
3. **combine all data into a single data set**
     ```
     training_data <- cbind(trainsubjects, ytrain, xtrain)

     test_data <- cbind(testsubjects, ytest, xtest)

     alldata <- tbl_df(rbind(training_data, test_data))
     ```
4. **Select only the measures of mean and standard deviation**
     ```
     meanstdcols <- grepl("mean\\(\\)", names(alldata)) | grepl("std\\(\\)", names(alldata))

     meanstdcols[1:2] <- TRUE

     meanstdtbl <- alldata[,meanstdcols]
     ```
5. **Create descriptive names for the activities.**
     ```
     meanstdtbl$activityid <- factor(meanstdtbl$activityid, labels=c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

     meanstdtbl <- rename(meanstdtbl, activity = activityid) #requires dplyr package
     ```
6. **Create the independent tidy data set with the average of each variable for each activity and each subject (melt and dcast require the reshape2 package).**
     ```
     melted <- melt(meanstdtbl, id=c("subjectid","activity"))

     tidy <- dcast(melted, subjectid+activity ~ variable, mean)

     write.table(tidy, "tidy.txt", row.names = FALSE) #writes the tidy data set to a text file.

     checktable <- read.table("tidy.txt", header = TRUE) #checks that the file is readable.
     ```
### Script output
The output of the script is a text file `tidy.txt` that can be read into R with: `read.table("tidy.txt", header = TRUE)`

This final data set is in a wide format with 180 observations(30 subjects and 6 activities) and 68 variables. 

The variable descriptions can be found in the [CodeBook.md](../master/CodeBook.md)
