#!/bin/bash

anynowtime="date +'%Y-%m-%d %H:%M:%S'"
NOW="echo [\`$anynowtime\`][PID:$$]"

##### 可在脚本开始运行时调用，打印当时的时间戳及PID。
function job_start
{
    echo "`eval $NOW` job_start"
}

##### 可在脚本执行成功的逻辑分支处调用，打印当时的时间戳及PID。 
function job_success
{
    MSG="$*"
    echo "`eval $NOW` job_success:[$MSG]"
    exit 0
}

##### 可在脚本执行失败的逻辑分支处调用，打印当时的时间戳及PID。
function job_fail
{
    MSG="$*"
    echo "`eval $NOW` job_fail:[$MSG]"
    exit 1
}

job_start

###### 可在此处开始编写您的脚本逻辑代码
###### 作业平台中执行脚本成功和失败的标准只取决于脚本最后一条执行语句的返回值
###### 如果返回值为0，则认为此脚本执行成功，如果非0，则认为脚本执行失败

###### 脚本参数：上传的zip包名称
PACKAGE=$1

cd /data/bkee/open_paas/esb/components/generic/apis   # 请确认为您服务器上ESB安装路径下的/components/generic/apis目录

rm -rf $PACKAGE

## tar -xvf $PACKAGE.zip && rm $PACKAGE.zip
unzip $PACKAGE.zip && rm $PACKAGE.zip

## 更新组件文档
source `which virtualenvwrapper.sh`
workon esb

export proj_base_dir=""  # 请确认为您服务器上ESB的安装路径，例如/data/bkee/open_paas/esb
cd $proj_base_dir
python $proj_base_dir/manage.py sync_data_at_deploy

## 更新组件
source `which virtualenvwrapper.sh`
workon open_paas
export proj_etc_dir="" # 请确认为您服务器上蓝鲸安装路径下的etc目录，例如/data/bkee/etc

supervisorctl -c $proj_etc_dir/supervisor-open_paas.conf restart esb

supervisorctl -c $proj_etc_dir/supervisor-open_paas.conf status
