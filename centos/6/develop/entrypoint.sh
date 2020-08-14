#!/usr/bin/env bash


####################################################################################################


#
# 刷新配置
#
source /etc/profile


####################################################################################################


#
# 开启服务
#
service sshd restart
service httpd restart
service crond restart
service mysqld restart
service rsyslog restart


#
# 捕捉信号
#
trap "exit 0" SIGINT


#
# 死循环
#
while true; do

	sleep 1s

done


####################################################################################################
