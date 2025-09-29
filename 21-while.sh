#!/bin/bash

num=10

while [ $num -ge 5 ]
do
    echo "Number is: $num"
    num=$(($num-1))
done