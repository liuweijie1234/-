#!/bin/bash

scores=80

if [[ $scores > 85 ]];then
	echo "very Good!";
elif [[ $scores > 75 ]];then
	echo "Good!";
elif [[ $scores > 60 ]];then
	echo "pass!";
else
	echo "no pass!"
fi
