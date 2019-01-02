#!/bin/bash
# logon.sh: 简陋的检查你是否还处于连线的脚本.

umask 177 # 确定临时文件不是全部用户都可读的. 


TRUE=1
#LOGFILE=/var/log/wifi.log       # mac适应性修改
LOGFILE=~/MyPrj/shell/ABS_Guide/wzj.log  # mac适应性修改
# 注意 $LOGFILE 必须是可读的
#+ (用 root 来做:chmod 644 /var/log/messages).
TEMPFILE=temp.$$
# 创建一个"唯一的"临时文件名, 使用脚本的进程 ID. 
#   用 'mktemp' 是另一个可行的办法.
#   举例:
#   TEMPFILE=`mktemp temp.XXXXXX`
KEYWORD=address
# 上网时, 把"remote IP address xxx.xxx.xxx.xxx"这行
#               加到 /var/log/messages.
ONLINE=22
USER_INTERRUPT=13
CHECK_LINES=100
# 日志文件中有多少行要检查.

trap 'rm -f $TEMPFILE; exit $USER_INTERRUPT' TERM INT
# 如果脚本被 control-c 中断了,则清除临时文件.

echo

while [ $TRUE ] #死循环.
do
    tail -$CHECK_LINES $LOGFILE> $TEMPFILE
    # 保存系统日志文件的最后 100 行到临时文件.
    # 这是需要的, 因为新版本的内核在登录网络时产生许多日志文件信息.
    search=`grep $KEYWORD $TEMPFILE`
    # 检查"IP address" 短语是不是存在,
    #+ 它指示了一次成功的网络登录.

    if [ ! -z "$search" ]   # 引号是必须的,因为变量可能会有一些空白符.
    then
        echo "On-line"
        rm -f $TEMPFILE     # 清除临时文件.
        exit $ONLINE
    else
        echo -n "."         #-n 选项使 echo 不会产生新行符, 
                            #+ 这样你可以从该行的继续打印.
    fi 

    sleep 1
done


# 注: 如果你更改 KEYWORD 变量的值为"Exit",
#+ 这个脚本就能用来在网络登录后检查掉线
#

# 练习: 修改脚本,像上面所说的那样,并修正得更好
#

exit 0


# Nick Drage 建议用另一种方法: 

while true
do ifconfig ppp0 | grep UP 1> /dev/null && echo "connected" && exit 0
    echo -n "." # 在连接上之前打印点 (.....).
    sleep 2
done

# 问题: 用 Control-C 来终止这个进程可能是不够的.
#+ (点可能会继续被打印.)
# 练习: 修复这个问题.



# Stephane Chazelas 也提出了另一个办法: 

CHECK_INTERVAL=1

while ! tail -1 "$LOGFILE" | grep -q "$KEYWORD"
do echo -n .
    sleep $CHECK_INTERVAL
done
echo "On-line"

# 练习: 讨论这几个方法的优缺点.
#
################################End Script#########################################
