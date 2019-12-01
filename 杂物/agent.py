#!/usr/bin/env python
# -*- coding: utf-8 -*-  # 设置编码
# 引入os
import os
print("引入os---完成")
# 引入socket
import socket
print("引入socket---完成")
# 获取主机名字
hostname = socket.gethostname()
print("获取主机名字---完成")
# 根据主机名字获取主机ip地址
hostip = socket.gethostbyname(hostname)
print("根据主机名字获取主机ip地址---完成")
# 通过rpm命令安装 zabbix-agent
os.system('rpm -ivh /home/zabbix-agent-4.2.4-1.el7.x86_64.rpm') 			# rpm安装文件 名称
print("通过rpm命令安装 zabbix-agent---完成")
# 定义一个方法
def alter():
    print("进入定义一个方法---完成")
# 路径赋值
    file= '/etc/zabbix/zabbix_agentd.conf'	# 不用修改
    print("路径赋值")
# 给需要修改的内容条件
    old_strS='Server=127.0.0.1'		# 不用修改
    print("给需要修改的内容条件")
# 需要修改结果
    new_strS='Server=10.11.10.88'										# 服务器地址在这里修改
    print("需要修改结果")
# 给需要修改的内容条件
    old_strSA='ServerActive=127.0.0.1'	# 不用修改
    print("给需要修改的内容条件")										# 服务器地址在这里修改
# 需要修改结果
    new_strSA='ServerActive=10.11.10.88'
    print("需要修改结果")
# 给需要修改的内容条件
    old_strHN='Hostname=Zabbix server'   # 不用修改
    print("给需要修改的内容条件")
# 需要修改结果
    new_strHN='Hostname='+hostip										# Hostname名字
    print("需要修改结果")
# 创建一个地址对象
    file_data = ""
    print("创建一个地址对象---完成")
# 以只读形式打开

    with open(file, "r") as f:
	print("以只读形式打开---进入S")
# 循环文本中的每一行
        for line in f:
	    print("循环文本中的每一行---进入S")
	    if old_strS in line:	
		line = line.replace(old_strS,new_strS)	
	    file_data += line	
# 把循环到的file_data数据写到f文件里
    with open(file,"w") as f:
        f.write(file_data)
	file_data=""

    with open(file, "r") as f:
	print("以只读形式打开---进入SA")
# 循环文本中的每一行
        for line in f:
	    print("循环文本中的每一行---进入SA")
            if old_strSA in line:	
                line = line.replace(old_strSA,new_strSA)
            file_data += line	
# 把循环到的file_data数据写到f文件里
    with open(file,"w") as f:
        f.write(file_data)
	file_data=""
       
    with open(file, "r") as f:
	print("以只读形式打开---进入HN")
# 循环文本中的每一行
        for line in f:
	    print("循环文本中的每一行---进入HN")
	    if old_strHN in line:   
                line = line.replace(old_strHN,new_strHN)  
            file_data += line
# 把循环到的file_data数据写到f文件里
    with open(file,"w") as f:
        f.write(file_data)
	file_data=""

# 调用方法执行
print("开始调用方法执行---完成")
alter()
print("完毕调用方法执行---完成")
# 设置开启自启动
os.system('systemctl enable zabbix-agent.service')
print("设置开启自启动---完成")
# 启动服务
os.system('systemctl start zabbix-agent.service')
print("启动服务---完成")
# 开放防火墙10050端口
os.system('-A INPUT -m state --state NEW -m tcp -p tcp --dport 10050 -j ACCEPT')
print("开放防火墙10050端口---完成")
# 删除rpm安装文件
os.system('rm -rf /home/zabbix-agent-4.2.4-1.el7.x86_64.rpm') 						       # 修改这里文件名字       			
print("删除rpm安装文件---完成")
# 删除脚本文件
os.system('rm -rf /home/zabbix_agent.py')                             						        # 修改这里删除脚本
print("删除脚本文件---完成")
# 提示执行完了
print("执行完了")