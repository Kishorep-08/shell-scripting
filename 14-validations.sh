#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R Error $N: Install with root privileges"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R Error $N: Installing $2 got failed"
        exit 1
    else
        echo -e "Installating $2......$G Success $N"
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "Mysql"
else
    echo -e "Mysql already exist.......$Y SKIPPING $N"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
    dnf install nginx -y
    VALIDATE $? "Nginx"
else
    echo -e "Nginx already exist.......$Y SKIPPING $N"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    dnf install python3 -y
    VALIDATE $? "python"
else 
    echo -e "Python already exist.......$Y SKIPPING $N"
fi