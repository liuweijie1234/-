#!/bin/bash

string="liuweijie is a handsome boy"
echo "该字符串是:$string"
echo "该字符串长度是\${#string}:${#string}"
echo "将字符串切片\${string:1:4}:${string:1:4}"
echo "查找字符h、e位置是\`expr index "\$string" he\`:`expr index "$string" he`"
