#
# run_analysis.R 
# 
# 1. Read data from files
# 2. Merge the training and test set to create one data set
# 3. Extract only the measurements on the mean and standard deviation for each measurement
# 4. Appropriately label the data set with descriptive variable names
# 5. Use descriptive activity names to name the activities in the data set
# 6. From the data set in step 4. create a second, independent tidy data set with average of
#    of each variable for each activity and each subject
#

#
# 1. Read data from files
#

# Read test data 
testdata <- read.csv(file="./ucidata/test/X_test.txt", header=FALSE, sep ="")
testdata[,562] <- read.csv(file="./ucidata/test/y_test.txt", header=FALSE, sep ="")
testdata[,563] <- read.csv(file="./ucidata/test/subject_test.txt", header = FALSE, sep="")

# Read train data 
traindata <- read.csv(file="./ucidata/train/X_train.txt", header=FALSE, sep ="")
traindata[,562] <- read.csv(file="./ucidata/train/y_train.txt", header=FALSE, sep ="")
traindata[,563] <- read.csv(file="./ucidata/train/subject_train.txt", header=FALSE, sep ="")

# Read features
features <- read.csv(file="./ucidata/features.txt", header=FALSE, sep ="")

# Read activity labels
activitylabels <- read.csv(file="./ucidata/activity_labels.txt", header=FALSE, sep ="")

#
# 2. Merge the training and test set to create one data set
#
onedataset <- rbind(traindata, testdata)

#
# 3. Extract only the measurements on the mean and standard deviation for each measurement
#

# Select only mean and standard deviation
remainingcols <- grep(".-mean|*-std", features[,2])
# Condense features
features <- features[remainingcols,]
# Add the subject & activity
remainingcols <- c(remainingcols,562, 563)
# And remove the columns we do not want
onedatasetclean <- onedataset[,remainingcols]

#
# 4. Appropriately label the data set with descriptive variable names
#

# Tidy up variable(feature) names first
features[,2] = gsub("-std", "Std", features[,2])
features[,2] = gsub("-mean", "Mean", features[,2])
features[,2] = gsub("-max", "Max", features[,2])
features[,2] = gsub("-min", "Min", features[,2])
features[,2] = gsub("\\(\\)", "", features[,2])
features[,2] = gsub("-", "", features[,2])

# Add appropriate column names
colnames(onedatasetclean) <- c(as.character(features$V2),"Activity","Subject")

#
# 5. Use descriptive activity names
#

# Loop through rows in activitylabels table and replace
for(counter in 1:nrow(activitylabels))
  {
    onedatasetclean$Activity[onedatasetclean$Activity==counter] <- as.character(activitylabels$V2[counter])  
  }

#
# 6. From the data set in step 4. create a second, independent tidy data set with average of
#    of each variable for each activity and each subject

# Calculate mean by Activity and by Subject
onedatasetcleanmean <- aggregate(onedatasetclean, by=list(Activity = onedatasetclean$Activity,
                                                          Subject  = onedatasetclean$Subject),
                                                  mean)

# Remove last two columns (Activity and Subject values)
width <- ncol(onedatasetcleanmean)
onedatasetcleanmean <- onedatasetcleanmean[,-c(width-1,width)]

#
# And finally, write it out
#

write.table(onedatasetcleanmean,"./ucidata/tidy.txt", sep=",", append=FALSE, row.name=FALSE)


