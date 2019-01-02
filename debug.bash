#!/bin/bash

# 注意: trap 的 DEBUG 参数在每个命令执行完后都会引起一个
# 指定的执行动作,例如,这可用来跟踪变量.

trap 'echo "VARIABLE-TRACE> \$variable = \"$variable\""' DEBUG
# 在每个命令行显示变量$variable 的值.

variable=29

echo "Just initialized \"\$variable\" to $variable."

let "variable *= 3"
echo "Just multiplied \"\$variable\" by 3." 

exit $?

# "trap 'command1 . . . command2 . . .' DEBUG" 的结构适合复杂脚本的环境
#+ 在这种情况下多次"echo $variable"比较没有技巧并且也耗时.
#
#

# Thanks, Stephane Chazelas 指出这一点. 


脚本的输出:

VARIABLE-TRACE> $variable = ""
VARIABLE-TRACE> $variable = "29"
Just initialized "$variable" to 29.
VARIABLE-TRACE> $variable = "29"
VARIABLE-TRACE> $variable = "87"
Just multiplied "$variable" by 3.
VARIABLE-TRACE> $variable = "87"
################################End Script#########################################
