#!/bin/bash

USERID=$(id -u)


if [ $USERID -ne 0 ]
then
        echo "Run the command with sudo access"
fi

echo

dnf install nginx -y


SCRIPT_STATUS=$?

if [ $SCRIPT_STATUS -eq 0 ]
then
        echo "Script $0 is Success"
else
        echo "Script $0 is failure"
fi
