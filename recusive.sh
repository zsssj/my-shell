#!/bin/bash

#                   阶乘
#                   --------- 


# bash 允许递归吗?
# 嗯, 允许, 但是...
# 它太慢以致你难以忍受.


MAX_ARG=20          # 源程序最大为5，使用返回值返回递归计算值
                    # Nick Kuta 进行了修改,适用于更大的递归计数
E_WRONG_ARGS=65
E_RANGE_ERR=66


if [ -z "$1" ]
then
    echo "Usage: `basename $0` number"
    exit $E_WRONG_ARGS
fi

if [ "$1" -gt $MAX_ARG ]
then
    echo "Out of range (20 is maximum)."    
    # Factorial of 20 is 2432902008176640000
    # 现在让我们来了解实际情况.
    # 如果你想求比这个更大的范围的阶乘,
    #+ 应该重新用一个真正的编程语言来写.
    exit $E_RANGE_ERR
fi

fact ()
{
    local number=$1
    local temp
    # 变量"number"必须声明为局部,
    #+ 否则它不会工作.
    if [ "$number" -eq 0 ]
    then
        factorial=1 # 0 的阶乘为 1.
    else
        let "decrnum = number - 1"
        temp=$(fact $decrnum)   # 递归调用(函数内部调用自己本身).
        let "factorial = $number * $temp"
    fi

    echo $factorial
}

return_val=$(fact $1)
echo "Factorial of $1 is $return_val."

exit 0
