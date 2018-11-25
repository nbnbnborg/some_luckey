#!/bin/bash

LOG_DIR=/var/log
ERROR_ROOT=86
ROOT_UID=0
LINES=50
ERROR_LOG=87
#判断执行脚本的用户是不是root管理员，不是则返回错误代码
if [ "$UID" -ne "${ROOT_UID}" ];then
        echo "This script must be run as root"
        exit ${ERROR_ROOT}
fi

#判断命令行是否输入参数，没有输入参数，默认保存日志的最后50行
if [ -n "$1" ];then
        lines=$1
else
        lines=${LINES}
fi

#进入到日志目录，进行相关的清空工作
cd ${LOG_DIR}
if [ `pwd` != "${LOG_DIR}" ];then
        echo "Cannot change to the ${LOG_DIR}"
        exit $ERROR_LOG
fi

tail -${LINES} messages > mesg.temp
mv mesg.temp messages

cat /dev/null > wtmp
cat /dev/null > utmp
echo "Logs clened up"