#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script-logs"
SCRIPT_NAME=$(echo "$0" | awk -F. '{print$1}')
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR=$1
DEST_DIR=$2

mkdir -p $LOGS_FOLDER

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R Error $N: Install with root privileges" | tee -a $LOG_FILE
    exit 1
fi

if [ $# -lt 2 ]
then
    echo -e "$R USAGE: sudo sh 24-backup.sh <source_dir> <destination_dir> <days>(optional) $N" | tee -a $LOG_FILE
    exit 1
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R Source directory: $SOURCE_DIR doesn't exist $N" | tee -a $LOG_FILE
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R Destination directory: $DEST_DIR doesn't exist $N" | tee -a $LOG_FILE
    exit 1
fi