#!/bin/bash

if [ -n "$1" ];then
    printf "Hello, %s\n" "$1"
else
    echo "Hi, who are you?"
    read name
    echo "Hello, $name"
fi
