#!/bin/bash

THRESHOLD=2
TOTAL_RAM=$(free -m | awk '/Mem:/ {print $2}')
AVAILABLE_RAM=$(free -m | awk '/Mem:/ {print $7}')

USED_RAM=$(( ( (TOTAL_RAM - AVAILABLE_RAM) * 100 ) / TOTAL_RAM ))

if [ $USED_RAM -gt $THRESHOLD ]
then
    MESSAGE=$(echo -e " \e[31m Warning: Percentage of total RAM used: $USED_RAM % \e[0m ")
fi

echo "Message body: $MESSAGE"