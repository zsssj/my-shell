#!/bin/bash
# child.sh
# 在多处理器的机器里运行多进程.
# 这个脚本由 parent.sh 脚本调用(即上面的脚本). 
# 作者: Tedman Eng

temp=$RANDOM 
index=$1
shift
let "temp %= 5"
let "temp += 4" 
echo "Starting $index  Time:$temp" "$@"
sleep ${temp}
echo "Ending $index"
#kill -s SIGRTMIN $PPID
kill -s SIGUSR1 $PPID       # mac rewrite

exit 0


# ============================================== #
# +++脚 本 作 者 注+++-------------------------- #
# 这不是完全没有 bug 的脚本.
# 我运行 LIMIT = 500 ,在过了开头的一二百个循环后,
#+ 这些进程有一个消失了!
# 不能确定是不是因为捕捉信号产生碰撞还是其他的原因.
# 一但信号捕捉到,在下一个信号设置之前,
#+ 会有一个短暂的时间来执行信号处理程序,
#+ 这段时间内很可能会丢失一个信号捕捉,因此失去生成一个子进程的机会.

# 毫无疑问会有人能找出这个 bug 的原因,并且修复它
#+ . . . 在将来的某个时候.

#=====================================================================#


#---------------------------------------------------------------------# 



#######################################################################
# 下面的脚本由 Vernia Damiano 原创.
# 不幸地是, 它不能正确工作.

#######################################################################
#!/bin/bash

# 必须以最少一个整数参数来调用这个脚本

#+ (这个整数是协作进程的数目).
# 所有的其他参数被传给要启动的进程.


INDICE=8        # 要启动的进程数目
TEMPO=5         # 每个进程最大的睡眼时间
E_BADARGS=65    # 没有参数传给脚本的错误值.

if [ $# -eq 0 ] # 检查是否至少传了一个参数给脚本.
then
    echo "Usage: `basename $0` number_of_processes [passed params]"
    exit $E_BADARGS
fi

NUMPROC=$1          # 协作进程的数目
shift
PARAMETRI=( "$@" )  # 每个进程的参数

function avvia() {
    local temp
    local index
    temp=$RANDOM
    index=$1
    shift
    let "temp %= $TEMPO"
    let "temp += 1"
    echo "Starting $index Time:$temp" "$@"
    sleep ${temp}
    echo "Ending $index"
    kill -s SIGRTMIN $$
}

function parti() {
    if [ $INDICE -gt 0 ] ; then
        avvia $INDICE "${PARAMETRI[@]}" &
        let "INDICE--"
    else
        trap : SIGRTMIN
    fi
}

trap parti SIGRTMIN

while [ "$NUMPROC" -gt 0 ]; do
    parti;
    let "NUMPROC--" 
done

wait
trap - SIGRTMIN

exit $?

: <<SCRIPT_AUTHOR_COMMENTS
我需要运行能指定选项的一个程序,
能接受许多不同的文件,并在一个多处理器的机器上运行 
所以我想(我也将会)使指定数目的进程运行,并且每个进程终止后都能启动一个新的


"wait"命令没什么帮助, 因为它是等候一个指定的或所有的后台进程. 
所以我写了这个使用了 trap 指令的 bash 脚本来做这个任务.

    --Vernia Damiano 
SCRIPT_AUTHOR_COMMENTS
################################End Script#########################################
