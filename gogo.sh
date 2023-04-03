#!/bin/bash

if [ $1 == "0" ]
then
    echo "stop"
    exit 1
fi

echo "$1"
var=$(($1-1))
$0 $var
