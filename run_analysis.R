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
                       quote = "\"", comment.char = "")

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

merge_x <- rbind(X_train, X_test) #Combination of rows of X_train and X_test
colnames(merge_x) <- Tfeatures  #Set colname of merge_x with vector "Tfeatures"
merge_x_y <- cbind(merge_y, merge_x) #Merges the training and the test sets to create one data set
View(merge_x_y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mmean_std <- merge_x_y[, c(1:7, 42:47, 82:87, 122:127, 162:167, 202:203, 215:216, 228:229, 
        241:242, 254:255, 267:272, 346:351, 425:430, 504:505, 517:518, 530:531, 543:544)] 
        # New data frame with measurements of mean and standard deviation
View(mmean_std)

# 3.Uses descriptive activity names to name the activities in the data set
        #Applied in previous steps.

# 4.Appropriately labels the data set with descriptive variable names.
        #Applied in previous steps.

# 5.From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

#Activity: walking
filter1 <- filter(mmean_std, activity == "walking") #Divide by activity walking.
        avgsubj1 <- mutate(filter1, avgsub1 = rowMeans(filter1[,2:66])) #Calculates average per subject 
        View(avgsubj1)
        avgvar1 <- rbind(filter1, avgvar1 = colMeans(filter1[,2:66])) #Calculates average per variable
        View(avgvar1)

#Activity: walking_upstairs
filter2 <- filter(mmean_std, activity == "walking_upstairs") #Divide by activity walking_upstairs.
        avgsubj2 <- mutate(filter2, avgsub2 = rowMeans(filter2[,2:66])) #Calculates average per subject 
        View(avgsubj2)
        avgvar2 <- rbind(filter2, avgvar2 = colMeans(filter2[,2:66])) #Calculates average per variable
        View(avgvar2)

#Activity: walking_downstairs
filter3 <- filter(mmean_std, activity == "walking_downstairs") #Divide by activity walking_downstairs.
        avgsubj3 <- mutate(filter3, avgsub3 = rowMeans(filter3[,2:66])) #Calculates average per subject 
        View(avgsubj3)
        avgvar3 <- rbind(filter3, avgvar3 = colMeans(filter3[,2:66])) #Calculates average per variable
        View(avgvar3)

#Activity: sitting
filter4 <- filter(mmean_std, activity == "sitting") #Divide by activity sitting.
        avgsubj4 <- mutate(filter4, avgsub4 = rowMeans(filter4[,2:66])) #Calculates average per subject 
        View(avgsubj4)
        avgvar4 <- rbind(filter4, avgvar4 = colMeans(filter4[,2:66])) #Calculates average per variable
        View(avgvar4)

#Activity: standing
filter5 <- filter(mmean_std, activity == "standing") #Divide by activity standing.
        avgsubj5 <- mutate(filter5, avgsub5 = rowMeans(filter5[,2:66])) #Calculates average per subject 
        View(avgsubj5)
        avgvar5 <- rbind(filter5, avgvar5 = colMeans(filter5[,2:66])) #Calculates average per variable
        View(avgvar5)
        
#Activity: laying
filter6 <- filter(mmean_std, activity == "laying") #Divide by activity laying.
        avgsubj6 <- mutate(filter6, avgsub6 = rowMeans(filter6[,2:66])) #Calculates average per subject 
        View(avgsubj6)
        avgvar6 <- rbind(filter6, avgvar6 = colMeans(filter6[,2:66])) #Calculates average per variable
        View(avgvar6)
}