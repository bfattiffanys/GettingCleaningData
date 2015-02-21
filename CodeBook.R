## Step 1: Compile dataset for 'Test' group and 'Train' group, and combine both datasets into one big dataset called 'HAR_Test_Train'
## Create 'Test' group dataset
## xtest
        Reads 'X_test.txt' file from "~/UCI_HAR_Dataset/test/"
##  ytest
        Reads 'y_test.txt' file from "~/UCI_HAR_Dataset/test/"
## subjecttest
        Reads 'subject_test.txt' file from "~/UCI_HAR_Dataset/test/"
## features
        Reads 'features.txt' file from "~/UCI_HAR_Dataset/"
## features1
        Subsets just the list of features from 'features.txt'
## xFeatures 
        Names columns of 'xtest'
## ytestList
        Set 'ytest' to list to combine into a dataframe
## subjectlist
        Set 'subjecttest' to list to combine into a dataframe
## subjectY 
        2-column dataframe with Test group subjects and Test group activity labels
## testdata
        Dataset for Test group, with 2,947 rows/observations and 563 columns, including column for Test group subjects, column for Test group activity labels, and 561 columns of observation variables
## Create 'Train' group dataset
## xtrain
        Reads 'X_train.txt' file from "~/UCI_HAR_Dataset/train/"
## ytrain
        Reads 'y_train.txt' file from "~/UCI_HAR_Dataset/train/"
## subjecttrain 
        Reads 'subject_train.txt' file from "~/UCI_HAR_Dataset/train/"
## subjectYtrain
        2-column dataframe with Train group subjects and Train group activity labels
## XtrainFeatures 
        Names columns in "xtrain"
## traindata
        Dataset for Train group, with 7,352 rows/observations and 563 columns, including column for Train group subjects, column for Train group activity labels, and 561 columns of observation variables
## HAR_Test_Train
        Combines 'testdata' and 'traindata' into one large (10,299 x 563)
        

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
## nomeanFreq
        Extract col labeled 'meanFreq' from working dataset 
        (assuming 'mean' refers to mean values for each of the measured body motions/angle variables)
        10,299 x 550
## HARttmeanstd
        New dataset containing only the measurements on the mean and standard deviation for each measurement
        10,299 x 75

        

## Step 3: Uses descriptive activity names to name the activities in the data set        
## x 
        Renames activity label "1" to "WALKING"
## x2 
        Renames activity label "2" to "WALKING_UPSTAIRS"
## x3
        Renames activity label "3" to "WALKING_DOWNSTAIRS"
## x4
        Renames activity label "4" to "SITTING"
## x5
        Renames activity label "5" to "STANDING"
## x6 
        Renames activity label "6" to "LAYING"
## V11
        Extract column 2 (activity labels) from dataset 
        (10,299 x 74)
## HARttactivities
        Replace activity labels with activity names in dataset
        (10,299, 75)
        
        
## Step 4: Appropriately labels the data set with descriptive variable names
## varnames
        Descriptive labels for col 1 (x6='Activity') and col 2 (V1='Subject') added
        Descriptive labels for col 3:75 already added previously
        
        
        
## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
## by_subject
        Groups dataframe by 'Subject'
        (10,299 x 75)
## by_both
        Groups dataframe by both 'Subject' & 'Activity'
        (10,299 x 75)
## tidy_data
        Calculates mean for each variable per 'Subject' and 'Activity' and arranges into a tidy dataset
        (180 x 75)
        
        
        