#!/bin/bash

sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config >/dev/null 2>&1

chattr -i /etc/{passwd,group,shadow,gshadow} >/dev/null 2>&1

groupadd -g 201 zabbix  >/dev/null 2>&1
echo 'zabbix用户组已创建'
useradd -g zabbix -u 201 zabbix -s /sbin/nologin >/dev/null 2>&1
echo 'zabbix用户已创建'

yum -y install net-tools.x86_64 >/dev/null 2>&1
echo "已安装ifconfig"

get1=`getenforce`
lvl=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
ip=`ifconfig ens33 | awk -F " " '/inet\>/{print $2}'`

if [[ $get1 = Enforcing ]];then
	echo "当前selinux状态为$get1 需要修改";
	setenforce 0 >/dev/null 2>&1 ;
	echo "修改后为$get";
else
	echo "当前selinux状态为$get1 不需要修改";
fi

mkdir -p /etc/yum.repos.d/bak
cd /etc/yum.repos.d >/dev/null 2>&1
mv * bak >/dev/null 2>&1

if [ $lvl -eq 7 ];then
	systemctl stop firewalld && systemctl disable firewalld >/dev/null 2>&1 ;
	echo "系统版本是$lvl 防火墙已关闭"
	rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm >/dev/null 2>&1 ;
	echo "zabbix.repo已安装"
	echo "开始清除yum缓存"
	yum clean all >/dev/null 2>&1 ;
	echo "清除yum缓存结束，更新缓存开始" 
	yum makecache >/dev/null 2>&1 ;
	echo "更新yum缓存结束，安装zabbix-agent开始"
	yum -y install zabbix-agent-4.0.12-1.el7.x86_64 >/dev/null 2>&1 ;
	echo "zabbix-agent已安装完成，开始修改配置文件"
	sed -i  's\Server=127.0.0.1\Server=10.37.20.222\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	sed -i  's\ServerActive=127.0.0.1\ServerActive=10.37.20.222\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	sed -i  's\Hostname=Zabbix server\Hostname='$ip'\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	echo "修改配置文件完成，开始重启zabbix-agent服务，并设置为开机启动"
	systemctl restart zabbix-agent && systemctl enable zabbix-agent >/dev/null 2>&1 ;
	echo "自动化安装zabbix-agent结束"

elif [ $lvl -eq 6 ];then
	service iptables stop && chkconfig iptables off >/dev/null 2>&1 ;
	echo "系统版本是$lvl 防火墙已关闭";
	rpm -Uvh http://repo.zabbix.com/zabbix/4.0/rhel/6/x86_64/zabbix-release-4.0-2.el6.noarch.rpm >/dev/null 2>&1 ;
	echo "zabbix.repo已安装"
	echo "开始清除yum缓存"
	yum clean all >/dev/null 2>&1 ;
	echo "清除yum缓存结束，更新缓存开始" 
	yum makecache >/dev/null 2>&1 ;
	echo "更新yum缓存结束，安装zabbix-agent开始"
	yum -y install zabbix-agent-4.0.12-1.el6.x86_64 >/dev/null 2>&1 ;
	echo "zabbix-agent已安装完成，开始修改配置文件"
	sed -i  's\Server=127.0.0.1\Server=10.37.20.222\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	sed -i  's\ServerActive=127.0.0.1\ServerActive=10.37.20.222\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	sed -i  's\Hostname=Zabbix server\Hostname='$ip'\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	echo "修改配置文件完成，开始重启zabbix-agent服务，并设置为开机启动"
	service zabbix-agent start ;
	chkconfig zabbix-agent on >/dev/null 2>&1 ;
	echo "自动化安装zabbix-agent结束"
elif [ $lvl -eq 5 ];then
	service iptables stop && chkconfig iptables off >/dev/null 2>&1 ;
	echo "系统是$lvl 防火墙已关闭";
	rpm -Uvh http://repo.zabbix.com/zabbix/4.0/rhel/5/x86_64/zabbix-release-4.0-2.el5.noarch.rpm >/dev/null 2>&1 ;
	echo "rpm安装"
	yum clean all >/dev/null 2>&1 ;
	yum makecache >/dev/null 2>&1 ;
	echo "清除yum缓存，并更新"
	yum -y install zabbix-agent-4.0.12-1.el5.x86_64 >/dev/null 2>&1 ;
	echo "zabbix-agent已安装完成，开始修改配置文件"
	sed -i  's\Server=127.0.0.1\Server=10.37.20.222\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	sed -i  's\ServerActive=127.0.0.1\ServerActive=10.37.20.222\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	sed -i  's\Hostname=Zabbix server\Hostname='$ip'\g' /etc/zabbix/zabbix_agentd.conf >/dev/null 2>&1 ;
	echo "修改配置文件完成，开始重启zabbix-agent服务，并设置为开机启动"
	service zabbix-agent start ;
	chkconfig zabbix-agent on >/dev/null 2>&1 ;
	echo "自动化安装zabbix-agent结束"
fi	
rm -rf zabbix.sh
