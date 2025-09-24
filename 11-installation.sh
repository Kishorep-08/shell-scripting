#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error: Install with admin privileges"
    exit 1
fi

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "Error: Installing mysql got failed"
    exit 1
else
    echo "Mysql is successfully installed"
fi
