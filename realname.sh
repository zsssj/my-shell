#!/bin/bash
# realname.sh
#
# 由用户名而从/etc/passwd 取得"真实名". 


ARGCOUNT=1      # 需要一个参数.
E_WRONGARGS=65

file=/etc/passwd
pattern=$1

if [ $# -ne "$ARGCOUNT" ]
then
    echo "Usage: `basename $0` USERNAME"
    exit $E_WRONGARGS
fi

file_excerpt ()     # 以要求的模式来扫描文件,然后打印文件相关的部分. 
{
while read line     # "while" does not necessarily need "[ condition ]"
do
    echo "$line" | grep $1 | awk -F":" '{ print $5 }'   # awk 指定使用":"为界定符.
done
} <$file    # 重定向函数的标准输入.

file_excerpt $pattern

# Yes, this entire script could be reduced to
#       grep PATTERN /etc/passwd | awk -F":" '{ print $5 }'
# or
#       awk -F: '/PATTERN/ {print $5}'
# or
#       awk -F: '($1 == "username") { print $5 }' # real name from username
# 但是,这些可能起不到示例的作用.

exit 0
# ============================================================== 
# 还有一个办法,可能是更好理解的重定向函数标准输入方法.
# 它为函数内的一个括号内的 代码块调用标准输入重定向.
# 用下面的代替: 
Function ()
{
...
}<file

# 也试一下这个: 
Function ()
{
    {
    ...
    } < file 
}

# 同样,

Function ()     # 可以工作.
{
    {
        echo $*
    }|tr a b 
}

Function ()     # 这个不会工作
{
    echo $* 
}|tr a b        # 这儿的内嵌代码块是强制的.
