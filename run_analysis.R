
###################################################################################
# Initial Set Up
###################################################################################
# Script must be capable of running as long as the Samsung data is in your working directory
# so download and extraction steps are external to this script

#list file contents
list.files()

###################################################################################
#Component 1:  Merge the training and the test sets to create one data set.
###################################################################################

##### Review and clean data #####
labels  <-  read.table("./activity_labels.txt")
#labels   #(6 obs ov 2 variables)

features  <-  read.table("./features.txt")
#features  #(561 obs of 2 variables)

#Clean up feature names, for labelling
featlabls<-gsub("-|,", "", features[,2])
#featlabls

##### Now, start putting the pieces together #####
#Create training dataset, read in tables, add lables, then combine
Set_Train <- read.table("./train/X_train.txt")
Labels_Train <- read.table("./train/y_train.txt")
Subjects_Train <- read.table("./train/subject_train.txt")

#####...using appropriately descriptive variable names - Component 4 ####
colnames(Set_Train)<-featlabls  
colnames(Labels_Train) <- c("Lable")
colnames(Subjects_Train) <- c("Sbjt")

combine_Train <- cbind(Subjects_Train,Labels_Train,Set_Train)

#identify as training data, with new variable - Condition = Train
combine_Train$Condition = "Train"

#Create test dataset, repeat above steps, with test data this time
Set_Test <- read.table("./Test/X_Test.txt")
Labels_Test <- read.table("./Test/y_Test.txt")
Subjects_Test <- read.table("./Test/subject_Test.txt")

colnames(Set_Test)<-featlabls
colnames(Labels_Test) <- c("Lable")
colnames(Subjects_Test) <- c("Sbjt")

combine_Test <- cbind(Subjects_Test,Labels_Test,Set_Test)

#identify as Test data, with new variable - Condition = Test
combine_Test$Condition = "Test"

#Now combine together into one big monster dataset
#Combining the test and train dataframes
AllData<-rbind(combine_Test,combine_Train)
dim(AllData)  #10299 obs 564 variables


###################################################################################
#Component 3:  Uses descriptive activity names to name the activities in the data set.
###################################################################################
#Add Activity labels 
AllData2 <- AllData
AllData2$Lable2 <- AllData$Lable
AllData2$Lable2[AllData2$Lable == "1"] <- "WALKING"
AllData2$Lable2[AllData$Lable == "2"] <- "WALKING_UPSTAIRS"
AllData2$Lable2[AllData$Lable == "3"] <- "WALKING_DOWNSTAIRS"
AllData2$Lable2[AllData$Lable == "4"] <- "SITTING"
AllData2$Lable2[AllData$Lable == "5"] <- "STANDING"
AllData2$Lable2[AllData$Lable == "6"] <- "LAYING"


###################################################################################
#Component 2:  Extracts only the measurements on the mean and standard deviation.
###################################################################################

DataMeanSd<-AllData2[,grepl("mean()|std()", colnames(AllData2))]
dim (DataMeanSd)
names(DataMeanSd)
# 10299 obs. of 79 variables

#This dataset contains mean and standard deviation measures, along with identifying variables
Final<-AllData2[,grepl("Lable2|Sbjt|mean()|std()", colnames(AllData2))]


##########################################################################################
##### Create a 2nd tidy data set with the avg of each variable for each activity and each subject
##########################################################################################
names(Final)
Final <- Final[,c(1,81,2:80)] #reorder columns

Final_Tidy<-aggregate(Final[3:81],by=list(Subject=Final$Sbjt, Activity=Final$Lable2), FUN=mean )
dim(Final_Tidy) #180 X 81

##########################################################################################
##### Write the final, tidy dataset to a file
##########################################################################################

write.table(Final_Tidy, "./FinalTidyData.txt",sep="/", row.names=FALSE)
