#!/bin/bash

START_TIME=$(date +%s)

sleep 5s

END_TIME=$(date +%s)

TOTAL_TIME=$(($START_TIME-$END_TIME))

echo "Time taken for ($0) script to execute is $TOTAL_TIME seconds."