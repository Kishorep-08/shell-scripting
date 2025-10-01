#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

set -eo pipefail

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script-logs"
# SCRIPT_NAME=$(echo "$0" | awk -F. '{print$1}')
# LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
LOG_FILE=$LOGS_FOLDER/backup.log
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

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

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)

if [ ! -z "${FILES}" ]
then 
    echo "Files found $FILES"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME=$DEST_DIR/app-logs-$TIMESTAMP.zip
    echo "Zip file name: $ZIP_FILE_NAME"
    find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"

    if [ -f $ZIP_FILE_NAME ]
    then
        echo -e "Archival.......$G Success $N"
        while IFS= read -r file
        do
           echo "Deleting file: $file"
           rm -rf $file
           echo "Deleted file: $file"
        done <<< $FILES
    else
        echo -e "Archival ... $R FAILURE $N"
        exit 1
    fi

else
    echo -e "No files to archive.......$Y Skipping $N"
fi

# ########################################################################
# Q. How to archive old log files?
# A.
#    Since this is archival we would need source dir and a dest dir to place zipped files.
#    Firstly, I would check if both these directories or not. If exists, i will proceed.
#    Then i would find for the files in source directory using find command.
#    If files found, i would zip them into dest dir using zip command.
#    Then i would check if zip file got create or not.
#    If created, i would delete those files fromm source.

#    My script would look like this:

#    if [ ! -d source_dir ]; then
#     echo "source dir not found"
#     exit 1
#    fi

#    if [ ! -d dest_dir ]; then
#     echo "dest dir not found"
#     exit 1
#    fi

#    FILES_FOUND=$(find source_dir -type f -name "*.log" -mtime +14)

#    if [ !z $FILES_FOUND ]
#    then
#     zip $FILES_FOUND $DEST_DIR/app-logs-$TIMESTAMP.zip
#    fi 

   
