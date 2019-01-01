#!/bin/bash
# max2.sh: 取两个超大整数中最大的.

# 这个脚本与前面的"max.sh"例子作用相同, 
#+ 经过修改可以适用于比较超大整数.

EQUAL=0             # 如果两个参数相同的返回值.
E_PARAM_ERR=-99999  # 没有足够的参数传递到函数中.
#           ^^^^^^    也可能是传递到函数中的某个参数超出范围了.

max2 ()     # 从这两个数中"返回"更大一些的.
{
if [ -z "$2" ] 
then
    echo $E_PARAM_ERR
    return 
fi

if [ "$1" -eq "$2" ] 
then
    echo $EQUAL
    return 
else
    if [ "$1" -gt "$2" ] 
    then
        retval=$1 
    else
        retval=$2 
    fi
fi

echo $retval    # echo(到 stdout), 而不是使用返回值. 
                # 为什么? ---(返回值最大只能到255)
}


return_val=$(max2 33001 33997)
#            ^^^^       函数名
#                 ^^^^^ ^^^^^ 这是传递进来的参数 
# 这事实上是一个命令替换的形式:
#+ 会把这个函数当作一个命令来处理,
#+ 并且分配这个函数的 stdout 到变量"return_val"中.


# ========================= OUTPUT ======================== 
if [ "$return_val" -eq "$E_PARAM_ERR" ]
then
    echo "Error in parameters passed to comparison function!" 
elif [ "$return_val" -eq "$EQUAL" ]
then
    echo "The two numbers are equal."
else
    echo "The larger of the two numbers is $return_val."
fi
# =========================================================

exit 0

# 练习:
# -----
# 1) 找出一种更优雅的方法来测试
#+传递到函数中的参数.
# 2) 在"OUTPUT"的时候简化 if/then 结构.
# 3) 重写这个脚本使其能够从命令行参数中来获取输入
