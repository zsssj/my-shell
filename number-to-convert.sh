#!/bin/bash

# 阿拉伯数字转化为罗马数字
# 转化范围:0-200
# 这是比较粗糙的,但可以工作.

# 扩展可接受的范围来作为脚本功能的扩充,这个作为练习完成. 

# 用法: roman number-to-convert

LIMIT=200 
E_ARG_ERR=65 
E_OUT_OF_RANGE=66

if [ -z "$1" ] 
then
    echo "Usage: `basename $0` number-to-convert"
    exit $E_ARG_ERR 
fi

num=$1
if [ "$num" -gt $LIMIT ] 
then
    echo "Out of range!"
    exit $E_OUT_OF_RANGE 
fi

to_roman()     # 在第一次调用函数前必须先定义.
{
number=$1
factor=$2
rchar=$3
let "remainder = number - factor" 
while [ "$remainder" -ge 0 ]
do
    echo -n $rchar
    let "number -= factor"
    let "remainder = number - factor"
done

return $number 
    # 练习:
    # --------
    # 解释这个函数是怎么工作的. 
    # 提示: 靠不断地除来分割数字.
}


to_roman $num 100 C num=$?
to_roman $num 90 LXXXX num=$?
to_roman $num 50 L num=$?

to_roman $num 40 XL
num=$?
to_roman $num 10 X
num=$?
to_roman $num 9 IX
num=$?
to_roman $num 5 V
num=$?
to_roman $num 4 IV
num=$?
to_roman $num 1 I

echo

exit 0
