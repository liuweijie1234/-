#!/bin/bash
dst_path=$1
for file in `ls $dst_path`
do
	if [ -d $1/$file ]
		then echo `$0 $1/$file`
	elif [ -f $1/$file ]
		then mv $1/$file $1/$file.$2
		echo "修改后缀成功！$1/$file改为$1/$file.$2"
	else
		echo $1/$file is Unknow file type
	fi
done;
