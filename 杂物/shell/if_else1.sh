#!/bin/bash

num1=100
num2=200

if (($num1 >$num2));then
	echo "this $num1 > $num2 !"
else
	echo "this $num2 > $num1 !"
fi
