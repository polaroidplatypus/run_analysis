  library(dplyr)
  
  #load data
  features <- read.table('./UCI Har Dataset/features.txt')
  activity_labels <- read.table('./UCI Har Dataset/activity_labels.txt')
  x_train <- read.table('./UCI HAR Dataset/train/X_train.txt',col.names=features[,2])
  y_train <- read.table('./UCI HAR Dataset/train/y_train.txt',col.names='yy')
  subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt',col.names='sub') 
  x_test <- read.table('./UCI Har Dataset/test/X_test.txt',col.names=features[,2])
  y_test <- read.table('./UCI Har Dataset/test/y_test.txt', col.names='yy')
  subject_test <- read.table('./UCI Har Dataset/test/subject_test.txt',col.names='sub')
  
  
  #1. Merges the training and test sets to create one data set.
  x <- rbind(x_train,x_test)
  y <- rbind(y_train,y_test)
  subject <- rbind(subject_train,subject_test)
  complete <- cbind(subject,x,y)
  
  #2. Extracts only the measurements on the mean and standard deviation 
  #for each measurement.
  mean <- complete[,grepl('[Mm]ean',names(complete))]
  std <- complete[,grepl('[Ss]td',names(complete))]
  meanstd <- cbind(complete$yy,complete$sub, mean, std)
  colnames(meanstd)[1:2] <- c('activity','subject')
  
  #3. Uses descriptive activity names to name the activities in the data set
  meanstd$activity <- activity_labels[meanstd$activity, 2]
  
  #4. Appropriately labels the data set with descriptive variable names.
  names(meanstd)<-gsub('Acc', ' Accelerometer ', names(meanstd))
  names(meanstd)<-gsub('Gyro', ' Gryoscope ', names(meanstd))
  names(meanstd)<-gsub('^f', 'Frequency ', names(meanstd))
  names(meanstd)<-gsub('^t', 'Time ', names(meanstd))
  names(meanstd)<-gsub('Mag', 'Magnitude', names(meanstd))
  names(meanstd)<-gsub('tBody', 'Time Body', names(meanstd))
  names(meanstd)<-gsub('angle', 'Angle', names(meanstd))
  
  #5. From the data set in step 4, creates a second, independent tidy data set 
  #with the average of each variable for each activity and each subject.
  df <- meanstd %>% group_by(activity,subject) %>% summarise_all(funs(mean))
  write.table(df, file = "./FinalDataSet.txt", row.names = FALSE)