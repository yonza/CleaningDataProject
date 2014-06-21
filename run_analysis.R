
### if the file/directory don't exist download and unzip it####

if(!file.exists("./GCDcourseraproject")){dir.create("./GCDcourseraproject")}

fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

if(!file.exists('./GCDcourseraproject/myProject.zip')){
   download.file(fileURL, destfile = './GCDcourseraproject/myProject.zip', method = 'curl')}

if(!file.exists("./GCDcourseraproject/UCI HAR Dataset")){
  unzip('./GCDcourseraproject/myProject.zip', exdir = './GCDcourseraproject')}

##########
features <- read.table("./GCDcourseraproject/UCI HAR Dataset/features.txt", 
                       col.names = c("index","features"))

labels <- read.table("./GCDcourseraproject/UCI HAR Dataset/activity_labels.txt", 
                       col.names = c("index","labels"))

testLabels <- read.table("./GCDcourseraproject/UCI HAR Dataset/test/y_test.txt")

testData <- read.table("./GCDcourseraproject/UCI HAR Dataset/test/X_test.txt")

testSubject <- read.table("./GCDcourseraproject/UCI HAR Dataset/test/subject_test.txt")

trainLabels <- read.table("./GCDcourseraproject/UCI HAR Dataset/train/y_train.txt")

trainData <- read.table("./GCDcourseraproject/UCI HAR Dataset/train/X_train.txt")

trainSubject <- read.table("./GCDcourseraproject/UCI HAR Dataset/train/subject_train.txt")

colnames(testData) <- features[,2]

colnames(trainData) <- features[,2]

###adding labels###
temptest <- cbind(factor(testLabels[,1], levels = labels[,1], labels = labels[,2]), testData)

temptrain <- cbind(factor(trainLabels[,1], levels = labels[,1], labels = labels[,2]), trainData)


##adding subject number###
 finaltest  <- cbind(  factor(testSubject[,1]), temptest)
 colnames(finaltest)[1:2]<- c('subject','label')

 finaltrain  <-  cbind( factor(trainSubject[,1]), temptrain)
colnames(finaltrain)[1:2] <- c('subject','label')

rm("features","labels","temptest","temptrain","testData","testLabels",
     "testSubject","trainData","trainLabels","trainSubject","fileURL")
##########MAKE ONE DATSET

myData <- rbind(finaltest,finaltrain)

myData <- myData[,1:8] ### just mean and std

colnames(myData)[3:8] <- c("meanAccelerationXaxis", "meanAccelerationYaxis", 
                           "meanAccelerationZaxis","stdAccelerationXaxis", 
                           "stdAccelerationYaxis", "stdAccelerationZaxis")

x <- melt(myData, id = colnames(myData)[c(1,2)], measure.vars = colnames(myData[3:8]))
y <- as.data.frame(ftable(acast(data = x, subject ~ label ~ variable, mean)))

rm(finaltest,finaltrain,myData, x)
colnames(y) <- c("subject","action","acceleration_measurements", "mean_value")

write.csv(y, file = "./GCDcourseraproject/tidyData.csv") ###save tidy data in directory


