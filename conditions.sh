#!/bin/bash

read -p "Enter a number here: " NUMBER

if [ $NUMBER -lt 10 ]; then
    echo "$NUMBER is less than 10"
else
    echo "$NUMBER is greater than or equal to 10"
fi