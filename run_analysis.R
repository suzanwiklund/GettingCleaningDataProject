#Getting & Cleaning Data Course - Course Project

install.packages("downloader")
library(downloader)

setwd("/Users/Non-corrupt user/Desktop/Suzy/DataScience/GettingCleaningData/Project/")

#if(!file.exists("data")){
#  dir.create("data")
#}

#download and unzip files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 
download(fileUrl, dest = "dataset.zip",mode = 'wb')
unzip("dataset.zip" )
dateDownloades<-date()


#read in column labels for both groups- in features.txt
###col_labels <- read.table(file="./UCI HAR Dataset/features.txt", 
###                         col.names=c("n","feature"), colClasses="character")
col_labels <- read.table(file="./UCI HAR Dataset/features.txt" )
dim(col_labels) #561X2
head(col_labels)

# make valid R names 
col_labels<-make.names(col_labels$V2, unique = TRUE, allow_=TRUE)

#cleaning up R names so they don't have ...
col_labels<-gsub("[[:punct:]]{3}","-",col_labels)
col_labels<-gsub("[[:punct:]]{2}","",col_labels)
#col_labels

###str(col_labels)
###col_labels$V1 <-NULL
###col_labels <- as.vector(col_labels['feature'])
###col_labels <- make.unique(col_labels$feature)
####head(col_labels)
####str(col_labels) #col_labels is now a char list with 561 elements
###col_labels <- as.data.frame(col_labels)
###colnames(col_labels) <- c("Features")


#read in data for test group
raw_test_data <- read.table(file="./UCI HAR Dataset/test/X_test.txt")
#dim(raw_test_data) 
subject_test_data <- read.table(file="./UCI HAR Dataset/test/subject_test.txt")
#dim(subject_test_data)
activity_labels_test <- read.table(file="./UCI HAR Dataset/test/y_test.txt")
dim(activity_labels_test)
str(activity_labels_test)

#add activity field to activity_labels_test
names(activity_labels_test)
colnames(activity_labels_test) <- c("Activity_Code")
#make Activity_Code a factor so I can add in activity
activity_labels_test$Activity <- factor(activity_labels_test$Activity_Code)
#add in activity levels
levels(activity_labels_test$Activity) <- list(
      walking = c(1),
      walking_upstairs = c(2),
      walking_downstairs = c(3),
      sitting = c(4),
      standing = c(5),
      laying = c(6)
  )
table(activity_labels_test$Activity_Code, activity_labels_test$Activity)


#mesh test files together
### works if using make.names but not with make.unqie
colnames(raw_test_data) <-(col_labels)  
colnames(subject_test_data) <- c("Subject") 
test_data <- cbind(activity_labels_test,raw_test_data)
test_data <- cbind(subject_test_data, test_data)
dim(test_data)
names(test_data)
head(test_data,n=2)


#read in data for train group
raw_train_data <- read.table(file="./UCI HAR Dataset/train/X_train.txt")
#dim(raw_train_data) 
subject_train_data <- read.table(file="./UCI HAR Dataset/train/subject_train.txt")
#dim(subject_train_data)
activity_labels_train <- read.table(file="./UCI HAR Dataset/train/y_train.txt")
dim(activity_labels_train)
str(activity_labels_train)

#add activity field to activity_labels_train
names(activity_labels_train)
colnames(activity_labels_train) <- c("Activity_Code")
#make Activity_Code a factor so I can add in activity
activity_labels_train$Activity <- factor(activity_labels_train$Activity_Code)
#add in activity levels
levels(activity_labels_train$Activity) <- list(
  walking = c(1),
  walking_upstairs = c(2),
  walking_downstairs = c(3),
  sitting = c(4),
  standing = c(5),
  laying = c(6)
)
head(activity_labels_train)
table(activity_labels_train$Activity_Code, activity_labels_train$Activity)


#mesh train files together
colnames(raw_train_data) <-(col_labels)
colnames(subject_train_data) <- c("Subject") 
train_data <- cbind(activity_labels_train,raw_train_data)
train_data <- cbind(subject_train_data, train_data)
dim(train_data)
#head(train_data,n=2)

#combine test and training files together
combined_data <- rbind(test_data,train_data)
#drop activity code
combined_data$Activity_Code <-NULL


#change form of dataset to long form
library(reshape2)
names(combined_data)
combined_data_long <- melt(combined_data,id=c("Subject","Activity"))
#rename col
colnames(combined_data_long)[3] <- "Features"
dim(combined_data_long)
head(combined_data_long)




#keep only mean and std for each measurement
library(dplyr)
data_long_filtered <-filter(combined_data_long,grepl('mean|std',Features))
#meanFreq features need to be excluded - Angle features were
# beause of case sensitivity (Mean)
data_long_filtered <-filter(data_long_filtered,!grepl('meanFreq',Features))
#table(data_long_filtered$Features)


library(plyr)
head(data_long_filtered)
Features_by_Subj_Activity <- ddply(data_long_filtered,.(Subject,Activity,Features), 
                   summarise,Average=mean(value))
## Average = round(mean(value),2)
head(Features_by_Subj_Activity,n=10)

#write data out
write.table(Features_by_Subj_Activity,file="Features_by_Subject_Activity.txt",row.name=FALSE)



