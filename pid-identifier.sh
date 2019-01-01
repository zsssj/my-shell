#!/bin/bash
# pid-identifier.sh: 给出指定PID的进程的程序全路径.

ARGNO=1         # 此脚本期望的参数个数.
E_WRONGARGS=65
E_BADPID=66
E_NOSUCHPROCESS=67
E_NOPERMISSION=68
PROCFILE=exe

if [ $# -ne $ARGNO ]
then
    echo "Usage: `basename $0` PID-number" >&2  # 帮助信息重定向到标准出错.
    exit $E_WRONGARGS
fi

pidno=$( ps ax | grep $1 | awk '{ print $1 }' | grep $1 )
# 搜索命令"ps"输出的第一列.
# 然后再次确认是真正我们要寻找的进程,而不是这个脚本调用而产生的进程.
# 后一个"grep $1"会滤掉这个可能产生的进程.
#
#   pidno=$( ps ax | awk '{ print $1 }' | grep $1 )
#   也可以, 由 Teemu Huovila 指出.

if [ -z "$pidno" ]  # 如果过滤完后结果是一个空字符串,
then                # 没有对应的 PID 进程在运行.
    echo "No such process running."
    exit $E_NOSUCHPROCESS 
fi

# 也可以用:
#   if ! ps $1 > /dev/null 2>&1
#   then            # 没有对应的 PID 进程在运行.
#       echo "No such process running." 
#       exit $E_NOSUCHPROCESS
#   fi 

# 为了简化整个进程,使用"pidof".
if [ ! -r "/proc/$1/$PROCFILE" ]    # 检查读权限.
then
    echo "Process $1 running, but..."
    echo "Can't get read permission on /proc/$1/$PROCFILE."
    exit $E_NOPERMISSION # 普通用户不能存取/proc 目录的某些文件.
fi

# 最后两个测试可以用下面的代替:
#   if ! kill -0 $1 > /dev/null 2>&1    # '0'不是一个信号,
                                        # 但这样可以测试是否可以
                                        # 向该进程发送信号. 
#   then 
#       echo "PID doesn't exist or you're not its owner" >&2
#       exit $E_BADPID 
#   fi



exe_file=$( ls -l /proc/$1 | grep "exe" | awk '{ print $11 }' )
# 或 exe_file=$( ls -l /proc/$1/exe | awk '{print $11}' )
#
# /proc/pid-number/exe 是进程程序全路径的符号链接.
#

if [ -e "$exe_file" ]   # 如果 /proc/pid-number/exe 存在 ...
then                    # 则相应的进程存在.
    echo "Process #$1 invoked by $exe_file."
else
    echo "No such process running."
fi



# 这个被详细讲解的脚本几乎可以用下面的命令代替:
# ps ax | grep $1 | awk '{ print $5 }'
# 然而, 这样并不会工作...
# 因为'ps'输出的第 5 列是进程的 argv[0](即命令行第一个参数,调用时程序用的程序路径本身),
# 但不是可执行文件.
# 
# 然而, 下面的两个都可以工作.
#       find /proc/$1/exe -printf '%l\n'
#       lsof -aFn -p $1 -d txt | sed -ne 's/^n//p'
# 由 Stephane Chazelas 附加注释.

exit 0 
################################End Script#########################################
