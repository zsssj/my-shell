#! /bin/bash
# CopyArray.sh 
#
# 由 Michael Zick 编写.
# 在本书中使用已得到许可.

# 怎么传递变量名和值处理,返回就用使用该变量,
#+ 或说"创建你自己的赋值语句".


CpArray_Mac() {

# 创建赋值命令语句

    echo -n 'eval '
    echo -n "$2"            # 目的变量名 
    echo -n '=( ${'         # 源名字
    echo -n "$1"
    echo -n '[@]} )'

# 上面的全部会合成单个命令.
# 这就是函数所有的功能.
}

declare -f CopyArray        # 函数"指针" 
CopyArray=CpArray_Mac       # 建立命令

Hype()
{

# 要复制的数组名为 $1.
# (接合数组,并包含尾部的字符串"Really Rocks".)
# 返回结果的数组名为 $2.

    local -a TMP
    local -a hype=( Really Rocks )

    $($CopyArray $1 TMP)
    TMP=( ${TMP[@]} ${hype[@]} )
    $($CopyArray TMP $2)
}

declare -a before=( Advanced Bash Scripting )
declare -a after

echo "Array Before = ${before[@]}" 

Hype before after

echo "Array After = ${after[@]}"

# 有多余的字符串?

echo "What ${after[@]:3:2}?"

declare -a modest=( ${after[@]:2:1} ${after[@]:3:2} )
#       ---- 子串提取 ----

echo "Array Modest = ${modest[@]}"

# 'before'变量变成什么了 ?

echo "Array Before = ${before[@]}"

exit 0
