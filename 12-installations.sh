#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error: Install with root privileges"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "Error: Installing $2 got failed"
        exit 1
    else
        echo "Installation of $2 is Success"
    fi
}

dnf install mysql -y

VALIDATE $? "Mysql"

dnf install nginx -y

VALIDATE $? "Nginx"

dnf install python3 -y

VALIDATE $? "python"