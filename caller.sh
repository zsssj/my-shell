#!/bin/bash 

function1()
{
    # 在 function1()内部.
    caller 0    # 显示调用者的信息.
}

function1       # 脚本的第9行 

# 9 main test.sh
# ^                 函数调用者所在的行号.
#   ^^^^            从脚本的"main"部分调用的.
#        ^^^^^^^    调用脚本的名字

caller 0    # 没效果，因为这个命令不再函数中.
