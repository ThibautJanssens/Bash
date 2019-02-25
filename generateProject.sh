#!/bin/bash

#check if there is a parameter when calling the script
#if not ask for the name of the folder
if [ -z "$1" ];then 
    echo "What the project's name?"
    read projectName
else 
    projectName="$1"
fi

#check if the folder already exist. If not create it.
if [ ! -d $projectName ];then
    mkdir $projectName
fi

#get into the folder newly create then initialise the git repo.
cd $projectName
#get the path of the project
dirPath= pwd

pwd >> ~/Documents/.generateProject.txt

git init
echo "This is a readme." >> README.md
touch .gitignore
git add .
git commit -m "First commit"
