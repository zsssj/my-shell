#!/bin/bash
# self-exec.sh

echo
echo "This line appears ONCE in the script, yet it keeps echoing."
echo "The PID of this instance of the script is still $$."
# 上边这句用来根本没产生子进程.

echo "==================== Hit Ctl-C to exit ====================" 
sleep 1

exec $0     # 产生了本脚本的另一个实例,
            #+ 并且这个实例代替了之前的那个.

echo "This line will never echo!" # 当然会这样. 

exit 0
