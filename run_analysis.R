library(plyr)
library(dplyr)
library(tidyr)

## Step 0: Load variable names and clean them up a bit for easier use
feat <- read.table("features.txt")
feat <- gsub("\\(\\)","",feat[,2])

###############################################################################

## Step 1-2: Load the test and train data, and filter for means and stds.
# I chose to filter first, since that keeps memory usage a little lower.
dt_test <- read.table("test/X_test.txt", col.names = feat)
dt_train <- read.table("train/X_train.txt", col.names = feat)
dt_test <- select(dt_test,contains("mean"),-contains("Freq"),contains("std"),-contains("angle"))
dt_train <- select(dt_train,contains("mean"),-contains("Freq"),contains("std"),-contains("angle"))

# Then we bind and get rid of the two old datasets.
dt <- rbind(dt_test,dt_train)
rm(dt_test,dt_train)

# We load the subjects, bind them together and append to the dataset.
subject_test <- read.table("test/subject_test.txt")
subject_train <- read.table("train/subject_train.txt")
dt$subject <- rbind(subject_test,subject_train)[,1]
rm(subject_test,subject_train)

###############################################################################

## Step 3: Use descriptive activity names to name the activities in the data set
# We load the activities, link them to a descriptive version of the activity,
# bind together and append to dataset.
y_test <- read.table("test/y_test.txt")
y_train <- read.table("train/y_train.txt")
activity_labels <- read.table("activity_labels.txt")

y_test <- inner_join(y_test,activity_labels)
y_train <- inner_join(y_train,activity_labels)
dt$activity <- rbind(y_test,y_train)[,2]
rm(y_test,y_train)

###############################################################################

## Step 4: Appropriately label the data set with descriptive variable names. 

# First, a little reordering.
dt <- select(dt, subject, activity, tBodyAcc.mean.X:fBodyBodyGyroJerkMag.std)
cols <- names(dt)

cols <- gsub("^t","time",cols)
cols <- gsub("^f","frequential",cols)
cols <- gsub("mean","Mean",cols)
cols <- gsub("std","StdDev",cols)
cols <- gsub("BodyBody","Body",cols)
cols <- gsub("\\.","",cols)
cols <- gsub("(StdDev|Mean)(.)","\\2\\1",cols)

names(dt) <- cols

###############################################################################

## Step 5: create a second, independent tidy data set with the average of each
##         variable for each activity and each subject.

temp_dt<-ddply(dt,.(subject,activity),numcolwise(mean))

dt_2 <- gather(dt,variable,value,-subject:-activity) %>% 
  group_by(subject, activity,variable) %>% 
  summarize(mean = mean(value))

names(dt) <- c("Subject","Activity","Feature","Mean")
###############################################################################

## Create text file

write.table(dt_2,file="tidy_data.txt",row.name=F)