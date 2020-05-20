
filename<-"Coursera_DS·_Final.zip"
xy<- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",filename,method="curl")
unzip(filename)


##List of all features.
features<-read.csv("./UCI HAR Dataset/features.txt",header=FALSE,sep="")
features<-as.character(features[,2])

#Links the class labels with their activity name
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
activity_labels<-as.character(activity_labels[,2])


#Training set
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
                    
#Training labels
y_train<-read.csv("./UCI HAR Dataset/train/y_train.txt",header=FALSE,sep="")

#Test set
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")

#Test labels
y_test<-read.csv("UCI HAR Dataset/test/y_test.txt",header=FALSE,sep="")


# Each row identifies the subject who performed the activity for each window sample
subject_train<-read.csv("UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep="")
subject_test<-read.csv("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep="")


#The acceleration signal from the smartphone accelerometer, x, y, z axis
total_acc_x_train<-read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train<-read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train<-read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")


#The body acceleration signal obtained by subtracting the gravity from the total acceleration
body_acc_x_train<-read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train<-read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train<-read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")


#The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second
body_gyro_x_train.txt<-read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train.txt<-read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train.txt<-read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")


#Merges

data_train<-data.frame(subject_train, y_train,X_train)
names(data_train)<-c(c("subject","activity"),features )
data_test<-data.frame(subject_test, y_test,X_test)
names(data_test)<-c(c("subject","activity"),features )
data<-rbind(data_train,data_test)

#mean|std

mean_std<-grep("mean|std",features)
dm<-data[,c(1,2,mean_std+2)]

#activities
dm$activity<-activity_labels[dm$activity]






#Labels
names(dm)<-gsub("[(] [ ) ])","",names(dm))
names(dm)<-gsub("Acc","Accelerometer",names(dm))
names(dm)<-gsub("Gyro","Gyroscope",names(dm))
names(dm)<-gsub("Mag","Magnitude",names(dm))
names(dm)<-gsub("^t","TimeDomain_",names(dm))
names(dm)<-gsub("^f","FrequencyDomain_",names(dm))
names(dm)<-gsub("-mean-","_Mean_",names(dm))
names(dm)<-gsub("-std","_Std_",names(dm))
names(dm)<-gsub("-","_",names(dm))


#Write table

Tidy<-aggregate(dm[,3:81],by=list(activity=dm$activity,subject=dm$activity),FUN=mean)
write.table(x=Tidy,file="Tidy.txt",row.names=FALSE)



