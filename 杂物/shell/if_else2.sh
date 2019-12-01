#!/bin/bash

DIR=/home/shell

if [ ! -d $DIR ];then
	mkdir -p $DIR
	echo -e "\033[32m This $DIR 文件夹已建立\033[0m"
else
	echo -e "\033[32m This $DIR 文件夹已存在！\033[0m"
fi
