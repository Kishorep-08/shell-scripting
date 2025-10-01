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

FILES_TO_DELETE=$(find $SOURCE_DIR -type f -mtime +14 -name "*.log")

while IFS= read -r filepath
do
    echo "Deleting file: $filepath"
    rm -rf $filepath
    echo "Deleted file: $filepath"
done <<< $FILES_TO_DELETE

# ###########################################
# Q. How do you write a script which deletes log files older than 14 days from a specific directory ?
# A. 
#     I will check if the given source directory exists or not. If directory exists, i will proceed.
#     Then i will search for the files which are older than 14 days using find command.
#     Then, using while loop i delete all files
#     My script would look like this:

#     if [ ! -d source_dir ]
#     then
#         echo "No directory"
#         exit 1
#     fi
#     FILES_TO_DELETE=$(find $SOURCE_DIR -type f -name:"*.log" -mtime +14)
    
#     #Here i would inititate while loop

#     while IFS= read -r file
#     do
#         rm -rf $file
#         echo "$file: deleted"
#     done <<< $FILES_TO_DELETE
###############################################
    
