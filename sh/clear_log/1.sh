#!/bin/bash

LOG_DIR=/var/log
ERROR_ROOT=86
ROOT_UID=0
LINES=50
ERROR_LOG=87
#�ж�ִ�нű����û��ǲ���root����Ա�������򷵻ش������
if [ "$UID" -ne "${ROOT_UID}" ];then
        echo "This script must be run as root"
        exit ${ERROR_ROOT}
fi

#�ж��������Ƿ����������û�����������Ĭ�ϱ�����־�����50��
if [ -n "$1" ];then
        lines=$1
else
        lines=${LINES}
fi

#���뵽��־Ŀ¼��������ص���չ���
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