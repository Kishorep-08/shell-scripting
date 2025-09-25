#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-script-logs"
SCRIPT_NAME=$(echo "$0" | awk -F. '{print$1}')
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

if [ $USERID -ne 0 ]
then
    echo -e "$R Error $N: Install with root privileges" | tee -a $LOG_FILE
    exit 1
fi


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R Error $N: Installing $2 got failed" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "Installating $2......$G Success $N" | tee -a $LOG_FILE
    fi
}

for package in $@
do
    dnf list installed &>> $LOG_FILE
    if [ $? -ne 0 ];then
        dnf install $package -y &>> $LOG_FILE
        VALIDATE $? $package
    else
        echo -e "$package already exists .... $Y SKIPPING $N" | tee -a $LOG_FILE
    fi
done