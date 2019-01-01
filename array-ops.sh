#!/bin/bash
# array-ops.sh: 数组更多有趣的用法.


array=( zero one two three four five ) 
#元素 0 1 2 3 4 5 7

echo ${array[0]}    # zero
echo ${array:0}     # zero
                    # 第一个元素的参数扩展,
                    #+ 从位置 0 开始 (即第一个字符). 
echo ${array:1}     # ero
                    # 第一个元素的参数扩展,
                    #+ 从位置 1 开始 (即第二个字符).

echo "--------------"

echo ${#array[0]}   # 4
                    # 数组第一个元素的长度.
echo ${#array}      # 4
                    # 数组第一个元素的长度. 
                    # (另一种写法)

echo ${#array[1]}   # 3
                    # 数组第二个元素的长度.
                    # Bash 的数组是 0 开始索引的.

echo ${#array[*]}   # 6
                    # 数组中元素的个数.
echo ${#array[@]}   # 6
                    # 数组中元素的个数.

echo "--------------"

array2=( [0]="first element" [1]="second element" [3]="fourth element" )

echo ${array2[0]}   # 第一个元素 
echo ${array2[1]}   # 第二个元素 
echo ${array2[2]}   #
                    # 因为初始化时没有指定,因此值为空(null). 
echo ${array2[3]}   # 第四个元素


exit 0
# ============================================================
# 复制一个数组.     
array2=( "${array1[@]}" ) 
#或
array2="${array1[@]}"

# 给数组增加一个元素.
array=( "${array[@]}" "new element" )
# 或
array[${#array[*]}]="new element"

# Thanks, S.C.
