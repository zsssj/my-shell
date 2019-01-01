#! /bin/bash
# array-assign.bash

# 数组操作是 Bash 特有的,
#+ 因此脚本名用".bash"结尾.

# Copyright (c) Michael S. Zick, 2003, All rights reserved. 
# 许可证: 没有任何限制,可以用于任何目的的反复使用.
# Version: $ID$
#
# 由 William Park 添加注释.

# 基于 Stephane Chazelas 提供在本书中的一个例子
#

# 'times' 命令的输出格式:
# User CPU <空格> System CPU
# User CPU of dead children <空格> System CPU of dead children

# Bash 赋一个数组的所有元素给新的数组变量有两种办法. 
#
# 在 Bash 版本 2.04, 2.05a 和 2.05b,
#+ 这两种办法都对 NULL 的值的元素全部丢弃.
# 另一种数组赋值办法是维护[下标]=值之间的关系将会在新版本的 Bash 支持.
#

# 可以用外部命令来构造一个大数组,
#+ 但几千个元素的数组如下就可以构造了.
#

declare -a bigOne=( /dev/* )
echo
echo 'Conditions: Unquoted, default IFS, All-Elements-Of'
echo "Number of elements in array is ${#bigOne[@]}"

# set -vx 



echo
echo '- - testing: =( ${array[@]} ) - -'
times
declare -a bigTwo=( ${bigOne[@]} )
#                 ^              ^ 
times

echo
echo '- - testing: =${array[@]} - -'

times
declare -a bigThree=${bigOne[@]}
# 这次没有用括号.
times

# 正如 Stephane Chazelas 指出的那样比较输出的数组可以了解第二种格式的赋值比第三和
# 第四的 times 的更快
#
#
# William Park 解释 explains:
#+ bigTwo 数组是被赋值了一个单字符串,
#+ bigThree 则赋值时一个一个元素的赋值.
#  所以, 实际上的情况是:
#               bigTwo=( [0]="... ... ..." )
#               bigThree=( [0]="..." [1]="..." [2]="..." ... ) 


# 我在本书的例子中仍然会继续用第一种格式,
#+ 因为我认为这会对说明清楚更有帮助.

# 我的例子中的可复用的部分实际上还是会使用第二种格式,
#+ 因为这种格式更快一些.

# MSZ: 很抱歉早先的失误(应是指本书的先前版本).


# 注:
# ----
# 在31和43行的"declare -a"语句不是必须的,
#+ 因为会在使用 Array=( ... )赋值格式时暗示它是数组.
#
# 但是, 省略这些声明会导致后面脚本的相关操作更慢一些.
#
# 试一下, 看有什么变化.

exit 0
