#!/bin/bash
# 用 trap 捕捉变量值.

trap 'echo Variable Listing --- a = $a b = $b' EXIT
# EXIT 是脚本中 exit 命令产生的信号的信号名.
# trap 在脚本退出时打印上面这句话
# 由"trap"指定的命令不会被马上执行,只有当发送了一个适应的信号时才会执行. 
#

echo "This prints before the \"trap\" --"
echo "even though the script sees the \"trap\" first."
echo

a=39

b=36

exit 0
# 注意到注释掉上面一行的'exit'命令也没有什么不同,
#+ 这是因为执行完所有的命令脚本都会退出.
################################End Script#########################################
