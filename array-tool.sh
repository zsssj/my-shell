#!/bin/bash

declare -a colors
# 所有脚本后面的命令都会把
#+ 变量"colors"作为数组对待.

echo "Enter your favorite colors (separated from each other by a space)."

read -a colors  # 键入至少3种颜色以用于下面的示例.
# 指定'read'命令的选项,
#+ 允许指定数组元素.

echo

element_count=${#colors[@]}
# 专用语法来提取数组元素的个数.
# element_count=${#colors[*]} 也可以.
#
# "@"变量允许分割引号内的单词
#+ (依靠空白字符来分隔变量).
#
# 这就像"$@" 和"$*"在位置参数中表现出来的一样.
#

index=0

while [ "$index" -lt "$element_count" ]
do  # List all the elements in the array. 
    echo ${colors[$index]}
    let "index=$index+1"
done
# 每个数组元素被列为单独的一行.
# 如果这个没有要求, 可以用 echo -n "${colors[$index]} "
# 
# 可以用一个"for"循环来做: 
#   for i in "${colors[@]}"
#   do
#       echo "$i"
#   done
# (Thanks, S.C.)

echo

# 再次列出数组中所有的元素, 但使用更优雅的做法.
    echo ${colors[@]}   # echo ${colors[*]} 也可以.

echo

# "unset"命令删除一个数组元素或是整个数组.
unset colors[1]                 # 删除数组的第二个元素.
                                # 作用等同于 colors[1]=
echo ${colors[@]}               # 再列出数组,第二个元素没有了.

unset colors                    # 删除整个数组.
                                # unset colors[*] 或
                                #+unset colors[@] 都可以.
echo; echo -n "Colors gone."
echo ${colors[@]}               # 再列出数组,则为空了.

exit 0
################################End Script#########################################
