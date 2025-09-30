#!/bin/bash

IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

THRESHOLD=2
TOTAL_RAM=$(free -m | awk '/Mem:/ {print $2}')
AVAILABLE_RAM=$(free -m | awk '/Mem:/ {print $7}')

USED_RAM=$(( ( (TOTAL_RAM - AVAILABLE_RAM) * 100 ) / TOTAL_RAM ))

if [ $USED_RAM -gt $THRESHOLD ]
then
    MESSAGE=$(echo -e " \e[31m Warning: Percentage of total RAM used: $USED_RAM % \e[0m ")
fi

echo "Message body: $MESSAGE"

sh mail.sh "info@joindevops.com" "High Disk Usage Alert" "High RAM usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team"

# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5
# TO_TEAM=$6