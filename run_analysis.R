## import required libraries

library(dplyr)
library(plyr)
library(data.table)

##getwd()
## read in the Testing data - X_test, y_test, subject_test using read.csv
x.test <- read.csv("./test/X_test.txt",sep = "",header = FALSE)  ## read X_test file

y.test <- read.csv("./test/y_test.txt",sep = "",header = FALSE)  ## read y_test file (labels)

subject.test <- read.csv("./test/subject_test.txt",sep = "",header = FALSE) ## read subject file
    
test <- data.frame(subject.test, y.test, x.test)  ## combine files into a single data frame


## read training files using read.csv X_train, y_train.txt, subject_train 
x.train <- read.csv("./train/X_train.txt",sep = "",header = FALSE)
y.train <- read.csv("./train/y_train.txt",sep = "",header = FALSE) 
subject.train <- read.csv("./train/subject_train.txt",sep = "",header = FALSE) 


train <- data.frame(subject.train,y.train,x.train) ## combine files into a single data frame

# This data is removed because it is no longer needed
remove(x.test);remove(x.train);remove(y.test);remove(y.train);remove(subject.train);remove(subject.test)

trainTest <- rbind(train, test) #combine the train and test data frames using rbind

features <- read.csv("features.txt",sep = "",header = FALSE) ## read in features 
## create a vector from 2nd column, unique=true is needed to insure unique column names
col.name <- as.vector(make.names(features[,2],unique=TRUE))  


colnames(trainTest) <- c("subject_ID","activity_Label",col.name) # use colnames to add meaningful column names

## select mean and standard deviation columns and exclude cols with freq and angle in the name uses dplyr package
trainTest1 <- select(trainTest, contains("subject"),contains("activity"),contains("mean"),contains("std"),
                     -contains("freq"), -contains("angle"))


atvtLbls <-  read.csv("activity_labels.txt",sep = "",header = FALSE) ## read in activity labels 
## replace activity codes with activity labels
trainTest1$activity_Label <- as.character(atvtLbls[match(trainTest1$activity_Label, atvtLbls$V1),'V2'])
## set names needes data.table library
## change \\ to space ""
setnames(trainTest1, colnames(trainTest1), gsub("\\(\\)", "", colnames(trainTest1)))  
## change hyphens to underscores
setnames(trainTest1, colnames(trainTest1), gsub("-", "_", colnames(trainTest1)))
## change BodyBody to Body
setnames(trainTest1, colnames(trainTest1), gsub("BodyBody", "Body", colnames(trainTest1)))
## group data by subject and activity and calculate mean for each value
trainTest1Sum <- trainTest1 %>% group_by(subject_ID,activity_Label) %>% summarise_each(funs(mean))

## write data set 
write.table(trainTest1Sum, file="run_data_summary_dqf.txt", row.name=FALSE)

##dtest <- read.csv("run_data_summary_dqf.txt",sep = "",header = FALSE)




