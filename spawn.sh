#!/bin/bash
# spawn.sh

PIDS=$(pidof sh $0)     # 这个脚本不同实例的进程 ID. 
P_array=( $PIDS )       # 把它们放到数组里(为什么?).
echo $PIDS              # 显示父进程和子进程的进程 ID.
let "instances = ${#P_array[*]} - 1"    # 计算元素个数,至少为 1.
                                        # 为什么减 1?
echo "$instances instance(s) of this script running."
echo "[Hit Ctl-C to exit.]"; echo

sleep 1     # 等.
# sh $0     # 再来一次.

exit 0      # 没必要: 脚本永远不会走到这里. # 为什么走不到这里?
