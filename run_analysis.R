# at first step train data is collected from all the files into single data table in following pattern

#at first step data is collected from all the files into single data source
trainS <- read.table('rawdata/train/subject_train.txt',header=FALSE) #read all subject
trainY <- read.table('rawdata/train/y_train.txt',header=FALSE) #read activites/Y
trainX <- read.table('rawdata/train/X_train.txt',header=FALSE)#read all train features
trainD <- cbind(trainS,trainY,trainX) #put everything into single data frame



#Read test data and put into one data frame

testS <- read.table('rawdata/test/subject_test.txt',header=FALSE) 
testY <- read.table('rawdata/test/y_test.txt',header=FALSE) 
testX <- read.table('rawdata/test/X_test.txt',header=FALSE)
testD <- cbind(testS,testY,testX)

#Combine test and train dataset into one data frame
dat <- rbind(testD,trainD)

# Read the feature name from file, add two more columns (subjectid,activityName) into feature vector, 
# and set these columnnames to dat data frame.

fnames<- read.table('rawdata/features.txt',header=FALSE) #featurenames
fv <- as.vector(fnames[,2]) #get vector
dcolumns <-c('subjectID','ActivityID',fv) #columns including subjectid,activityname and feature names
colnames(dat) <- dcolumns # set the column name for dataset
meancol <- dcolumns[grep('mean',dcolumns,ignore.case=T)] # filter column names containing mean
stdcol <- dcolumns[grep('std',dcolumns,ignore.case=T)] # filter column names contain std
requiredcol <- c('subjectID','ActivityID',meancol,stdcol) # merge mean and col name into one vector
fdata <- dat[,requiredcol] # retrieve the filter columns

#setting up activity name instead activity id

anames <- read.table('rawdata/activity_labels.txt',header=FALSE)
colnames(anames) <- c('ActivityID','ActivityName')
library(data.table)
dt_fdata <- data.table(fdata)
dt_anames <- data.table(anames)
setkey(dt_fdata,ActivityID)
setkey(dt_anames,ActivityID)
dt <- merge (dt_anames,dt_fdata)
requiredcol <- c('subjectID','ActivityName',meancol,stdcol)
dt <- dt[,requiredcol,with=F]

# calculate the average of each variable for each subject and activity
newdt <- dt[, lapply(.SD,mean),.SDcols=c(meancol,stdcol) ,by=c('subjectID','ActivityName')]
write.table(newdt,file='tidy.txt',row.name=FALSE) 
