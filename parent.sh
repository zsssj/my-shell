#!/bin/bash
# parent.sh
# 在多处理器的机器里运行多进程.
# 作者: Tedman Eng

# 这是要介绍的两个脚本的第一个,
#+ 这两个脚本都在要在相同的工作目录下.




LIMIT=$1    # 要启动的进程总数
NUMPROC=4   # 当前进程数 (forks?)
PROCID=1    # 启动的进程 ID
echo "My PID is $$"

function start_thread() {
    if [ $PROCID -le $LIMIT ] ; then
        ./child.sh $PROCID&
        let "PROCID++" 
    else
        echo "Limit reached." 
        wait
        exit
    fi 
}

while [ "$NUMPROC" -gt 0 ]; do 
    start_thread;
    let "NUMPROC--" 
done


while true 
do

#    trap "start_thread" SIGRTMIN    # wrong, mac not support SIGRTMIN signal.
    trap "start_thread" SIGUSR1     # mac rewrite,SIGUSR1 小于32
                                    # 不是安全实时的线程信号.

done

exit 0
