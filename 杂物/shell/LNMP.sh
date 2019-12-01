#!/bin/bash
cat <<END 
+----------------------------------+
|                                  |
|         This  is  a LNMP         |
|                                  |
|         1.安装Nginx              |
|         2.安装MySQL              |
|         3.安装PHP                |
|         4.配置LNMP环境           |
+----------------------------------+
END
#node 1
  read  -p "请你输入一个数字:" NUM
  expr $NUM + 1 &> /dev/null
  if [ "$?" -ne 0 ];then
    action "对不起，请你输入整数！！！" /bin/false
    exit 1
  elif [ "$NUM" -eq 0 ];then
    action "对不起，请你输入比0大的数字！！！" /bin/false
    exit 1
  fi
