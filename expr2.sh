#!/bin/bash
echo
echo "String operations using \"expr \$string : \" construct"
echo "==================================================="
echo

a=1234zipper5FLIPPER43231
echo "The string being operated upon is \"`expr "$a" : '\(.*\)'`\"."
# 转义括号对操作.                                       ==  ==

#   ***************************
#+          转移括号对
#+      用来匹配一个子串
#   ***************************


# 如果不转义括号的话...
#+ 那么 'expr' 将把 string 操作转换为一个整数.

echo "Length of \"$a\" is `expr "$a" : '.*'`."  # 字符串长度

echo "Number of digits at the beginning of \"$a\" is `expr "$a" : '[0-9]*'`." 

# ------------------------------------------------------------------------- #

echo

echo "The digits at the beginning of \"$a\" are `expr "$a" : '\([0-9]*\)'`."
#                                                               == ==
echo "The first 7 characters of \"$a\" are `expr "$a" : '\(.......\)'`."
#                                =====            ==      ==
# 再来一个, 转义括号对强制一个子串匹配.
#
echo "The last 7 characters of \"$a\" are `expr "$a" : '.*\(.......\)'`."
#                              ====            end of string operator ^^
# (最后这个模式的意思是忽略前边的任何字符，直到最后7个字符，
#+ 最后7个点就是需要匹配的任意7个字符的字串)

echo

exit 0
###############################################################
# 去掉字符串开头和结尾的空白.
LRFDATE=`expr "$LRFDATE" : '[[:space:]]*\(.*\)[[:space:]]*$'`
# 来自于 Peter Knowle 的 "booklistgen.sh" 脚本
#+ 用来将文件转换为 Sony Librie 格式.
# (http://booklistgensh.peterknowles.com)
