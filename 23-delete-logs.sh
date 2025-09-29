#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script-logs"
SCRIPT_NAME=$(echo "$0" | awk -F. '{print$1}')
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

SOURCE_DIR=/home/ec2-user/app-logs

if [ ! -d $SOURCE_DIR ]
then
    echo "Error: $SOURCE_DIR does not exist"
    exit 1
fi

FILES_TO_DELETE=$(find -type f -mtime +14 -name "*.log" $SOURCE_DIR)

while IFS= read -r filepath
do
    echo "Deleting files in $filepath"
done <<< $FILES_TO_DELETE