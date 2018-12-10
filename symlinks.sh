#!/bin/bash
# symlinks.sh: 列出目录中所有的符号连接文件.

directory=${1-`pwd`}
# 如果没有其他的特殊指定,
#+ 默认为当前工作目录.
# 下边的代码块,和上边这句等价.
# ----------------------------------------------------------
# ARGS=1                # 需要一个命令行参数. 
# if [ $# -ne "$ARGS" ] # 如果不是一个参数的话...
# then
#   directory=`pwd`     # 当前工作目录
# else
#   directory=$1 fi
# fi
# ----------------------------------------------------------


echo "symbolic links in directory \"$directory\""

for file in "$( find $directory -type l )" # -type l 就是符号连接文件
do
    echo "$file"
done | sort
# 严格上说,此处并不一定非要一个循环不可,
#+ 因为"find"命令的结果将被扩展成一个单词.
# 然而,这种方式很容易理解和说明.

# Dominik 'Aeneas' Schnitzer 指出,
#+ 如果没将 $( find $directory -type l )用""引用起来的话
#+ 那么将会把一个带有空白部分的文件名拆成以空白分隔的两部分(文件名中允许有空白).
# 即使这只将取出每个参数的第一个域.

exit 0


# Jean Helou 建议使用下边的方法: 
echo "symbolic links in directory \"$directory\""
# 当前 IFS 的备份.要小心使用这个值.
OLDIFS=$IFS
IFS=:

for file in $(find $directory -type l -printf "%p$IFS")
do              # 
    echo "$file"
done|sort

exit 0
