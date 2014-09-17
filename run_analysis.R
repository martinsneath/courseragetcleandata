# run_analysis.R
# set working directory to where the data is and add libraries
library(reshape);library(reshape2)
setwd("UCI HAR Dataset")
# read the test and train data in
trainx=read.table("train/X_train.txt",header=FALSE)
trainy=read.table("train/Y_train.txt",header=FALSE)
trains=read.table("train/subject_train.txt",header=FALSE)
testx=read.table("test/X_test.txt",header=FALSE)
testy=read.table("test/Y_test.txt",header=FALSE)
tests=read.table("test/subject_test.txt",header=FALSE)
# get and set the column headings
featurenames=read.table("features.txt",header=FALSE)
colnames(trainx)=featurenames[,2]
colnames(testx)=featurenames[,2]
colnames(trains)="Subject"
colnames(tests)="Subject"
colnames(trainy)="Activity"
colnames(testy)="Activity"
# reduce the data to 79 columns with std or mean in them
meanandstdcols=(grepl("*mean*",c)|grepl("std",c))
trainxr=trainx[,c(meanandstdcols)]
testxr=testx[,c(meanandstdcols)]
# combine the activities from y with the measurements 
# from x and the subjects from s
train<-cbind (trainy,trains,trainxr)
test<-cbind(testy,tests,testxr)
# combine the two sets of data into one of 10299 rows
combineddata=rbind(test,train)
# read the activity names in and replace the code with the name
activitynames=read.table("activity_labels.txt",header=FALSE)
colnames(activitynames)=c("Activity","ActivityName")
labelleddata=combineddata
labelleddata$Activity=activitynames[labelleddata$Activity,2]
# Step 5 -create a data set with the average of each variable 
# for each activity and subject
setwd("../")
ndnames=c("Activity","Subject")
datnames=setdiff(colnames(b),names)
tidystart=melt(labelleddata,id=ndnames,measure.vars=datnames)
tidyaverages=dcast(tidystart,Subject + Activity ~ variable,mean)
write.table(tidyaverages,"tidyaverages.txt",row.names=F)