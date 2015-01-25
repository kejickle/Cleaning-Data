#download the file from the web
fileUrl= "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp = tempfile(fileext=".zip")
download.file(fileUrl, destfile = temp, mode="wb", method="curl")
dateDownloaded = date()

#merge test and train sets together to get one data set 
data.test = unzip(temp,"UCI HAR Dataset/test/X_test.txt")
data.train = unzip(temp, "UCI HAR Dataset/train/X_train.txt")
data.features = unzip(temp, "UCI HAR Dataset/features.txt")
data.labels = unzip(temp, "UCI HAR Dataset/activity_labels.txt")
data.trainlabel = unzip(temp, "UCI HAR Dataset/train/y_train.txt")
data.testlabel = unzip(temp, "UCI HAR Dataset/test/y_test.txt")
data.subjecttest = unzip(temp, "UCI HAR Dataset/test/subject_test.txt")
data.subjecttrain = unzip(temp, "UCI HAR Dataset/train/subject_train.txt")
features = read.table(data.features)
labels = read.table(data.labels)
test = read.table(data.test, col.names = features[,2])
subjecttest = read.table(data.subjecttest, col.names = "Subject")
testlabel = read.table(data.testlabel, col.names = "Activity")
test = cbind(subjecttest, testlabel, test)
train = read.table(data.train, col.names = features[,2])
subjecttrain = read.table(data.subjecttrain, col.names = "Subject")
trainlabel = read.table(data.trainlabel, col.names = "Activity")
train = cbind(subjecttrain, trainlabel, train)
data = rbind(test, train)
unlink(temp)

#extract only mean and standard deviations for each measurement 
col.index =c(1,2,grep("mean", colnames(data)), grep("std", colnames(data)), grep("Mean", colnames(data)))
col.index = sort(col.index)
data = data[,col.index]

#use descriptive names to name the activities 
data[,2] = gsub(1, labels[1,2], data[,2])
data[,2] = gsub(2, labels[2,2], data[,2])
data[,2] = gsub(3, labels[3,2], data[,2])
data[,2] = gsub(4, labels[4,2], data[,2])
data[,2] = gsub(5, labels[5,2], data[,2])
data[,2] = gsub(6, labels[6,2], data[,2])

#label data set with appropriate variable names

c = sub("()", "", colnames(data), fixed=T)
c = sub(".", "", c, fixed = T)
c = sub("...", "", c, fixed=T)
c = sub("..", "", c, fixed=T)
c = sub(".", "", c, fixed = T)
c = sub(".", "", c, fixed = T)

colnames(data) = c

#Create independent tidy data set with average of each variable for each activity and each subject.
library(dplyr)
tidy = tbl_df(data)
by_subject_activity = group_by(tidy, Subject, Activity)
tidy.data = by_subject_activity %>% summarise_each(funs(mean))
write.table(as.data.frame(tidy.data), "tidydata.txt", row.names=F, col.names=T)

