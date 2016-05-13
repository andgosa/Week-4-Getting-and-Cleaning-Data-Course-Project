FinalProject <- function() {
library(dplyr)
# Dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating 
# the training data and 30% the test data.

# Objectives:
# 1. Merges the training and the test sets to create one data set.
X_test <- read.table("~/Desktop/Getting and Cleaning the Data/Week 4/Final Project/UCI HAR Dataset/X_test.txt", 
                     quote="\"", stringsAsFactors = FALSE, comment.char="") #read table with Test Set.
y_test <- read.table("~/Desktop/Getting and Cleaning the Data/Week 4/Final Project/UCI HAR Dataset/y_test.txt", 
                     quote="\"", comment.char="") #read table with Test Labels
X_train <- read.table("~/Desktop/Getting and Cleaning the Data/Week 4/Final Project/UCI HAR Dataset/X_train.txt", 
                      quote="\"", stringsAsFactors = FALSE, comment.char="") #read table with Training Set
y_train <- read.table("~/Desktop/Getting and Cleaning the Data/Week 4/Final Project/UCI HAR Dataset/y_train.txt", 
                      quote="\"", comment.char="") #read table with Training Labels
features <- read.table("/Users/AndreaDeGouveia/Desktop/Getting and Cleaning the Data/Week 4/Final Project/UCI HAR Dataset/features.txt", 
                       quote = "\"", comment.char = "") #read table with Features
subject_train <- read.table("~/Desktop/Getting and Cleaning the Data/Week 4/Final Project/UCI HAR Dataset/subject_train.txt",
                            quote = "\"", comment.char = "")  #read table with Subject for train
subject_test <- read.table("~/Desktop/Getting and Cleaning the Data/Week 4/Final Project/UCI HAR Dataset/subject_test.txt",
                            quote = "\"", comment.char = "")  #read table with Subject for test

#Process created to clean "features.txt"
        a <- apply(as.data.frame("features.txt"), 1, readLines)
        ad <- gsub("()", "", a, fixed = TRUE)    #remove symbol ()
        af <- gsub("^[0-9]", "", ad)    #remove numbers at the beginning
        ag <- gsub("^[0-9]", "", af)    #remove numbers at the beginning
        ah <- gsub("^[0-9]", "", ag)    #remove numbers at the beginning
        aj <- gsub("^ ", "", ah)    #remove space at the beginning
        ak <- as.data.frame(unlist(aj), ncol = 1, byrow = TRUE)  #transform ad to a matrix
        features <- ak
        
Tfeatures <- t(features) #Transpose matrix to be used later for descriptive column names

y_train <- transform(y_train, V1 = as.character.numeric_version(V1))
y_test <- transform(y_test, V1 = as.character.numeric_version(V1))
merge_y <- rbind(y_train, y_test) #Combination of rows of y_train and y_test
merge_y$V1 <- factor(merge_y$V1, levels = c(1,2,3,4,5,6), labels = c("walking",
"walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))
colnames(merge_y) <- "activity"  #Set colname of merge_y

merge_subject <- rbind(subject_train, subject_test) #Combination of rows of subject_train and subject_test
colnames(merge_subject) <- "subject" #Set colname of merge_subject

merge_x <- rbind(X_train, X_test) #Combination of rows of X_train and X_test
colnames(merge_x) <- Tfeatures  #Set colname of merge_x with vector "Tfeatures"
merge_x_y_subject <- cbind(merge_y, merge_subject, merge_x) #Merges the training and the test sets with subject to create one data set
View(merge_x_y_subject)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mmean_std <- merge_x_y_subject[, c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 
        242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)] 
        # New data frame with measurements of mean and standard deviation
View(mmean_std)

# 3.Uses descriptive activity names to name the activities in the data set
        #Applied in previous steps.

# 4.Appropriately labels the data set with descriptive variable names.
        #Applied in previous steps.

# 5.From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
tidy <- aggregate(mmean_std[,3:68], by=list(mmean_std$activity, mmean_std$subject), mean) 
#Claculates the mean for each variable subsetting activity (Group.1) and subject (Group.2) 
View(tidy)
write.table(tidy, file = "tidyData.txt")
}