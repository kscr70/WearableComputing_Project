#WearableComputing_Project
##Course project for Getting and Cleaning Data
The data used in this projedt was collected from the the accelerometers from the Samsung Galaxy S smartphone. A full descritption of the can be found at the [site where the data was obtained.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
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

###Packages required.

The run_Analysis.r script requires two packages to be loaded.
  * [`reshape2`](http://cran.r-project.org/web/packages/reshape2/index.html)
  * [`dplyr`](http://cran.r-project.org/web/packages/dplyr/index.html)





