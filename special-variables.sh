#!/bin/bash

echo "File name is $0"
echo
echo "All arguments passed to the script: $@"
echo
echo "No. of arguments passed to the script: $#"
echo
echo "This is the first argument passed: $1"
echo
echo "Process ID of this script: $$"
echo
sleep 5 &
echo "Process ID of the last command executed in background: $!"
echo