#!/bin/bash

num=1

while [ $num -le 5 ]
do
    echo "Number is: $num"
    num=$(($num+1))
done