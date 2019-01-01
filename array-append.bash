#! /bin/bash
# array-append.bash

# Copyright (c) Michael S. Zick, 2003, All rights reserved. 
# 许可: 可以无限制的以任何目的任何格式重复使用. 
# 版本: $ID$
#
# 格式上由 M.C 做了轻微的修改. 


# 数组操作是 Bash 特有的属性.
# 原来的 UNIX /bin/sh 没有类似的功能. 


# 把此脚本的输出管道输送给 'more'
#+ 以便输出不会滚过终端屏幕.


# 下标依次使用.
declare -a array1=( zero1 one1 two1 )
# 下标有未使用的 ([1] 没有被定义).
declare -a array2=( [0]=zero2 [2]=two2 [3]=three2 )

echo
echo '- Confirm that the array is really subscript sparse. -'
echo "Number of elements: 4"    # 这儿是举例子就用硬编码.
for (( i = 0 ; i < 4 ; i++ ))
do
    echo "Element [$i]: ${array2[$i]}"
done
# 也可以参考 basics-reviewed.bash 更多的常见代码.


declare -a dest

# 组合 (添加) 两个数组到第三个数组.
echo
echo 'Conditions: Unquoted, default IFS, All-Elements-Of operator'
echo '- Undefined elements not present, subscripts not maintained. -'
# # 那些未定义的元素不存在; 组合时会丢弃这些元素.

dest=( ${array1[@]} ${array2[@]} )
#dest=${array1[@]}${array2[@]}     # 奇怪的结果, 或者叫臭虫.

# 现在, 打印出结果.
echo
echo '- - Testing Array Append - -'
cnt=${#dest[@]}

echo "Number of elements: $cnt"
for (( i = 0 ; i < cnt ; i++ ))
do
    echo "Element [$i]: ${dest[$i]}"
done

# 把一个数组赋值给另一个数组的单个元素 (两次).
dest[0]=${array1[@]}
dest[1]=${array2[@]}

# 列出结果.
echo

echo '- - Testing modified array - -'
cnt=${#dest[@]}

echo "Number of elements: $cnt"
for (( i = 0 ; i < cnt ; i++ ))
do
    echo "Element [$i]: ${dest[$i]}"
done

# 检测第二个元素的改变.
echo
echo '- - Reassign and list second element - -'

declare -a subArray=${dest[1]} 
cnt=${#subArray[@]}

echo "Number of elements: $cnt"
for (( i = 0 ; i < cnt ; i++ ))
do
    echo "Element [$i]: ${subArray[$i]}"
done

# 用 '=${ ... }' 把整个数组的值赋给另一个数组的单个元素
#+ 使数组所有元素值被转换成了一个字符串,
#+ 各元素的值由一个空格分开(其实是IFS的第一个字符). 
#
# 
# 如果原先的元素没有包含空白符 . . . 
# 如果原先的数组下标都是连续的 . . . 
# 我们就能取回最初的数组结构.

# 恢复第二个元素的修改回元素.
echo
echo '- - Listing restored element - -'

declare -a subArray=( ${dest[1]} )
cnt=${#subArray[@]}

echo "Number of elements: $cnt"
for (( i = 0 ; i < cnt ; i++ ))
do
    echo "Element [$i]: ${subArray[$i]}"
done
echo '- - Do not depend on this behavior. - -'
echo '- - This behavior is subject to change - -'
echo '- - in versions of Bash newer than version 2.05b - -'

# MSZ: 很抱歉早先时混淆的几个要点(译者注:应该是指本书早先的版本).

exit 0
################################End Script#########################################
