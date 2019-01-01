#!/bin/bash
# empty-array.sh

# 多谢 Stephane Chazelas 制作这个例子最初的版本,
#+ 并由 Michael Zick 扩展了.


# 空数组不同与含有空值元素的数组.

array0=( first second third )
array1=( '' )   # "array1" 由一个空元素组成.
array2=( )      # 没有元素 . . . "array2" 是空的.

echo
ListArray()
{
echo
echo "Elements in array0: ${array0[@]}" 
echo "Elements in array1: ${array1[@]}" 
echo "Elements in array2: ${array2[@]}"
echo
echo "Length of first element in array0 = ${#array0}"
echo "Length of first element in array1 = ${#array1}"
echo "Length of first element in array2 = ${#array2}"
echo
echo "Number of elements in array0 = ${#array0[*]}" # 3
echo "Number of elements in array1 = ${#array1[*]}" # 1(惊奇!)
echo "Number of elements in array2 = ${#array2[*]}" # 0
}

#===================================================================

ListArray

# 尝试扩展这些数组.

# 增加一个元素到数组.
array0=( "${array0[@]}" "new1" )
array1=( "${array1[@]}" "new1" )
array2=( "${array2[@]}" "new1" )

ListArray

# 或
array0[${#array0[*]}]="new2"
array1[${#array1[*]}]="new2"
array2[${#array2[*]}]="new2"

ListArray

# 当像上面的做法增加数组时,数组像 '栈'
# 上面的做法是 'push(压栈)'
# 栈高是:
height=${#array2[@]}
echo
echo "Stack height for array2 = $height"

# 'pop(出栈)' 是:
unset array2[${#array2[@]}-1]       # 数组是以0开始索引的,
height=${#array2[@]}                #+这就意味着第一个元素下标是 0.
echo
echo "POP"
echo "New stack height for array2 = $height"

ListArray

# 只列出数组 array0 的第二和第三个元素.
from=1      #是以0开始的数字
to=2        #
array3=( ${array0[@]:1:2} )
echo
echo "Elements in array3: ${array3[@]}"

# 像一个字符串一样处理(字符的数组).
# 试试其他的字符串格式.

# 替换:
array4=( ${array0[@]/second/2nd} )
echo
echo "Elements in array4: ${array4[@]}"

# 替换所有匹配通配符的字符串.
array5=( ${array0[@]//new?/old} )
echo
echo "Elements in array5: ${array5[@]}"

# 当你开始觉得对此有把握的时候 . . .
array6=( ${array0[@]#new} )
echo # 这个可能会使你感到惊奇.
echo "Elements in array6: ${array6[@]}"

array7=( ${array0[@]#new1} )
echo # 数组 array6 之后就没有惊奇了.
echo "Elements in array7: ${array7[@]}"
echo "Length of array7 is ${#array7[@]}"
# 这看起来非常像 ...
array8=( ${array0[@]/new1/} )
echo
echo "Elements in array8: ${array8[@]}"
echo "Length of array8 is ${#array8[@]}"
# 那么我们怎么总结它呢 So what can one say about this?

# 字符串操作在数组 var[@]的每一个元素中执行.
#
# 因此 Therefore : 如果结果是一个零长度的字符串,
#+ Bash 支持字符串向量操作,
#+ 元素会在结果赋值中消失不见.

# 提问, 这些字符串是强还是弱引用?

zap='new*'
array9=( ${array0[@]/$zap/} )
echo
echo "Elements in array9: ${array9[@]}"

# 当你还在想你在 Kansas 州的何处时 . . .
array10=( ${array0[@]#$zap} )
echo
echo "Elements in array10: ${array10[@]}"

# 把 array7 和 array10 比较.
# 把 array8 和 array9 比较.

# 答案: 必须用弱引用.

exit 0 
################################End Script#########################################
