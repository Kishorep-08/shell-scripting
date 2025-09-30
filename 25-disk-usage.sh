#!/bin/bash

DISK_USAGE=$(df -h | grep -v Filesystem)
THRESHOLD=2
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

while IFS= read -r line
do
    USAGE=$(echo $line | awk '{print $5}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $6}')
    if [ $USAGE -ge $THRESHOLD ]
    then
        Message+="High usage on $PARTITION: $USAGE % \n"
    fi
done <<< $DISK_USAGE

echo -e "Message Body: $Message"
