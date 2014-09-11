# run_analysis.R
# set working directory to where the data is
setwd("UCI HAR Dataset")
# read the test and train data in
train=read.table("train/X_train.txt")
test=read.table("test/X_test.txt")
# set the working directory back to the start directory
setwd("../")
# combine the two sets of data into one
# do search and replace later to give a a good name
a=rbind(test,train)