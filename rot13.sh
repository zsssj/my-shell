#!/bin/bash
# 使用'eval'的一个"rot13"的版本,(译者:rot13 就是把 26 个字母,从中间分为 2 瓣,各 13 个)
# 与脚本"rot13.sh" 比较一下.

setvar_rot_13()     # "rot13" 函数 
{
    local varname=$1 varvalue=$2
    eval $varname='$(echo "$varvalue" | tr a-z n-za-m)'
}


setvar_rot_13 var "foobar"  # 用"foobar" 传递到 rot13 函数中. 
echo $var   # 结果是 sbbone

setvar_rot_13 var "$var" 
echo $var

# 这个例子是 Segebart Chazelas 编写的.
# 作者又修改了一下.

exit 0
