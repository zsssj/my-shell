#!/bin/bash
# findstring.sh:
# 在一个指定目录的所有文件中查找一个特定的字符串.

directory=/usr/bin/
fstring="Free Software Foundation" # 查看那个文件中包含 FSF.

for file in $( find $directory -type f -name '*' | sort )
do
    strings -f $file | grep "$fstring" | sed -e "s/$directory//"
    # 在"sed"表达式中,
    #+ 我们必须替换掉正常的替换分隔符"/",
    #+ 因为"/"碰巧是我们需要过滤的字串之一.
    # 如果不用"%"代替"/"作为分隔符,那么这个操作将失败,并给出一个错误消息.(试试)
done

exit 0
