# GettingCleaningData
Coursera: Getting &amp; Cleaning Data Course Project

Contains Code book file defining variables used in 'run_file.R'

Contains 'run_file.R' with code to perform required tasks for course project:
        1.  Merges the training and the test sets to create one data set.
        2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
        3. Uses descriptive activity names to name the activities in the data set
        4. Appropriately labels the data set with descriptive variable names.
        5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_file.R performs as follows:

        ## Step 1: Compile dataset for 'Test' group and 'Train' group, and combine both datasets into one big dataset called           'HAR_Test_Train'
        ## Create 'Test' group dataset

        ## Read 'X_test.txt' file from "~/UCI_HAR_Dataset/test/"
        xtest <- read.table("X_test.txt", header=FALSE)

        ## Reads 'y_test.txt' file from "~/UCI_HAR_Dataset/test/"
        ytest <- read.table("y_test.txt", header=FALSE)

        ## Reads 'subject_test.txt' file from "~/UCI_HAR_Dataset/test/"
        subjecttest <- read.table("subject_test.txt", header=FALSE)

        ## Reads 'features.txt' file from "~/UCI_HAR_Dataset/"
        features <- read.table("features.txt", header=FALSE)

        ## Subsets just the list of features from 'features.txt'
        features1 <- features[, "V2"]

        ## Set features list as.character
        labels <- as.character(features1)

        ## Names columns of 'xtest'
        xFeatures <- setNames(xtest, c(labels))

        ## Set 'ytest' to list to combine into a dataframe
        ytestlist <- as.list(ytest)

        ## Set 'subjecttest' to list to combine into a dataframe
        subjectlist <- as.list(subjecttest)

        ## 2-column dataframe with Test group subjects and Test group activity labels
        subjectY <- data.frame(subjectlist, ytestlist)

        ## Dataset for Test group, with 2,947 rows/observations and 563 columns, including column for Test group subjects,             column for Test group activity labels, and 561 columns of observation variables
        testdata <- data.frame(c(subjectY, xFeatures))

        ## Create 'Train' group dataset
        ## Reads 'X_train.txt' file from "~/UCI_HAR_Dataset/train/"
        xtrain <- read.table("X_train.txt", header=FALSE)

        ## Reads 'y_train.txt' file from "~/UCI_HAR_Dataset/train/"
        ytrain <- read.table("y_train.txt", header=FALSE)

        ## Reads 'subject_train.txt' file from "~/UCI_HAR_Dataset/train/"
        subjecttrain <- read.table("subject_train.txt", header=FALSE)

        ## 2-column dataframe with Train group subjects and Train group activity labels
        subjectYtrain <- data.frame(subjecttrain, ytrain)

        ## Names columns in "xtrain"
        XtrainFeatures <- setNames(xtrain, c(labels))

        ## Dataset for Train group, with 7,352 rows/observations and 563 columns, including column for Train group subjects,           column for Train group activity labels, and 561 columns of observation variables
        traindata <- data.frame(subjectYtrain, XtrainFeatures)

        ## Combines 'testdata' and 'traindata' into one large (10,299 x 563)
        HAR_Test_Train <- rbind(testdata, traindata)



        ## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
        ## Extract col labeled 'meanFreq' from working dataset (assuming 'mean' refers to mean values for each of the measured         body motions/angle variables) (10,299 x 550)
        nomeanFreq <- HAR_Test_Train[, !grepl("Freq", names(HAR_Test_Train))]

        ## New dataset containing only the measurements on the mean and standard deviation for each measurement (10,299 x 75)
        HARttmeanstd <- nomeanFreq[, grepl("V1|V1.1|[Mm]ean|std", names(nomeanFreq))]



        ## Step 3: Uses descriptive activity names to name the activities in the data set        
        ## Renames activity label "1" to "WALKING"
        x <- gsub("1", "WALKING", HARttmeanstd$v1.1)

        ## Renames activity label "2" to "WALKING_UPSTAIRS"
        x2 <- gsub("2", "WALKING_UPSTAIRS", x)

        ## Renames activity label "3" to "WALKING_DOWNSTAIRS"
        x3 <- gsub("3", "WALKING_DOWNSTAIRS", x2)

        ## Renames activity label "4" to "SITTING"
        x4 <- gsub("4", "SITTING", x3)

        ## Renames activity label "5" to "STANDING"
        x5 <- gsub("5", "STANDING", x4)

        ## Renames activity label "6" to "LAYING"
        x6 <- gsub("6", "LAYING", x5)

        ## Extract column 2 (activity labels) from dataset (10,299 x 74)
        V11 <- HARttmeanstd[, -2]

        ## Replace activity labels with activity names in dataset (10,299 X 75)
        HARttactivities <- cbind(x6, V11)



        ## Step 4: Appropriately labels the data set with descriptive variable names
        ## Descriptive labels for col 1 (x6='Activity') and col 2 (V1='Subject') added. Descriptive labels for col 3:75 already         added previously
        varnames <- rename(HARttactivities, c("x6"="Activity", "V1"="Subject"))



        ## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable          for each activity and each subject
        ## Groups dataframe by 'Subject' (10,299 x 75)
        sortedDf <- arrange(varnames, Subject)
        by_subject <- group_by(sortedDf, Subject)

        ## Groups dataframe by both 'Subject' & 'Activity' (10,299 x 75)
        by_both <- group_by(by_subject, Activity, add=TRUE)

        ## Calculates mean for each variable per 'Subject' and 'Activity' and arranges into a tidy dataset (180 x 75)
        tidy_data <- summarise_each_(by_both, funs(mean), names(by_both)[-(1:2)])

        ## Writes tidy set to .txt file
        write.table(tidy_data, "CPtidydata.txt", row.name=FALSE)
