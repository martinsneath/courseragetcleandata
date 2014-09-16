# run_analysis.R
# set working directory to where the data is
setwd("UCI HAR Dataset")
# read the test and train data in
trainx=read.table("train/X_train.txt",header=FALSE)
trainy=read.table("train/Y_train.txt",header=FALSE)
trains=read.table("train/subject_train.txt",header=FALSE)
testx=read.table("test/X_test.txt",header=FALSE)
testy=read.table("test/Y_test.txt",header=FALSE)
tests=read.table("test/subject_test.txt",header=FALSE)
# set the working directory back to the start directory
setwd("../")
# get and set the column headings
featurenames=read.table("features.txt",header=FALSE)
colnames(trainx)=featurenames[,2]
colnames(testx)=featurenames[,2]
colnames(trains)="Subject"
colnames(tests)="Subject"
colnames(trainy)="Activity"
colnames(testy)="Activity"
# reduce the data to 79 columns with std or mean in them
meanandstdcols=c(4,5,6,44,45,46,84,85,86,124,125,126,
164,165,166,202,215,228,241,254,269,270,271,348,
349,350,427,428,429,504,517,530,543,1,2,3,41,42,
43,81,82,83,121,122,123,161,162,163,201,214,227,
240,253,266,267,268,294,295,296,345,346,347,373,
374,375,424,425,426,452,453,454503,513,516,526,529,
539,542,552)
trainxr=trainx[,c(meanandstdcols)]
testxr=testx[,c(meanandstdcols)]
# combine the subjects from y with the measurements from x
train<-cbind (trainy,trains,trainxr)
test<-cbind(testy,tests,testxr)
# combine the two sets of data into one of 10299 rows
combineddata=rbind(test,train)
