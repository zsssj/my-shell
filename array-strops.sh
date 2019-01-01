#!/bin/bash
# array-strops.sh: 用于数组的字符串操作符.
# 由 Michael Zick 编码.
# 已征得作者的同意.

# 一般来说,任何类似 ${name ... } 写法的字符串操作符
#+ 都能在一个数组的所有字符串元素中使用
#+ 像${name[@] ... } 或 ${name[*] ...} 的写法.


arrayZ=( one two three four five five ) 

echo

# 提取尾部的子串
echo ${arrayZ[@]:0}     # one two three four five five 
                        # 所有的元素.

echo ${arrayZ[@]:1}     # two three four five five
                        # 在第一个元素 element[0]后面的所有元素.

echo ${arrayZ[@]:1:2}   # two three
                        # 只提取在元素 element[0]后面的两个元素.

echo "-----------------------" 

# 子串删除
# 从字符串的前部删除最短的匹配,
#+ 匹配字串是一个正则表达式.

echo ${arrayZ[@]#f*r}   # one two three five five
                        # 匹配表达式作用于数组所有元素. 
                        # 匹配了"four"并把它删除.

# 字符串前部最长的匹配
echo ${arrayZ[@]##t*e}  # one two four five five
                        # 匹配表达式作用于数组所有元素. 
                        # 匹配"three"并把它删除.

# 字符串尾部的最短匹配
echo ${arrayZ[@]%h*e}   # one two t four five five
                        # 匹配表达式作用于数组所有元素. 
                        # 匹配"hree"并把它删除.

# 字符串尾部的最长匹配
echo ${arrayZ[@]%%t*e}  # one two four five five
                        # 匹配表达式作用于数组所有元素. 
                        # 匹配"three"并把它删除.

echo "-----------------------" 
# 子串替换


# 第一个匹配的子串会被替换
echo ${arrayZ[@]/fiv/XYZ}   # one two three four XYZe XYZe
                            # 匹配表达式作用于数组所有元素.

# 所有匹配的子串会被替换
echo ${arrayZ[@]//iv/YY}    # one two three four fYYe fYYe
                            # 匹配表达式作用于数组所有元素.

# 删除所有的匹配子串
# 没有指定代替字串意味着删除
echo ${arrayZ[@]//fi/}      # one two three four ve ve
                            # 匹配表达式作用于数组所有元素.

# 替换最前部出现的字串
echo ${arrayZ[@]/#fi/XY}    # one two three four XYve XYve
                            # 匹配表达式作用于数组所有元素.

# 替换最后部出现的字串
echo ${arrayZ[@]/%ve/ZZ}    # one two three four fiZZ fiZZ
                            # 匹配表达式作用于数组所有元素.

echo ${arrayZ[@]/%o/XX}     # one twXX three four five 
                            # 为什么?

echo "-----------------------" 


# 在从 awk(或其他的工具)取得数据之前 -- 
# 记得:
#   $( ... ) 是命令替换.
#   函数以子进程运行. 
#   函数将输出打印到标准输出.
#   用read来读取函数的标准输出. 
#   name[@]的写法指定了一个"for-each"的操作.

newstr() {
    echo -n "!!!"
}

echo ${arrayZ[@]/%e/$(newstr)}
# on!!! two thre!!! four fiv!!! fiv!!!
# Q.E.D: 替换部分的动作实际上是一个'赋值'.

# 使用"For-Each"型的
echo ${arrayZ[@]//*/$(newstr optional_arguments)}
# 现在 Now, 如果 if Bash 只传递匹配$0 的字符串给要调用的函数. . .
#

echo 

exit 0
