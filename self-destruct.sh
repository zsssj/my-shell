#!/bin/bash
# self-destruct.sh

kill $$


echo "This line will not echo."
# 而且 shell 将会发送一个"Terminated"消息到 stdout.

exit 0

# 在脚本结束自身进程之后,
#+ 它返回的退出码是什么? 
#
# sh self-destruct.sh
# echo $?
# 143
#
# 143 = 128 + 15
# 结束信号
