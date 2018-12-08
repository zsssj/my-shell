#!/bin/bash
# 处理一个变量,C 风格,使用((...))结构.


echo 
(( a = 23 )) # 给一个变量赋值,从"="两边的空格就能看出这是 c 风格的处理.
echo "a (initial value) = $a"

(( a++ )) # 变量'a'后加 1,C 风格.
echo "a (after a++) = $a"

(( a-- )) # 变量'a'后减 1,C 风格.
echo "a (after a--) = $a"

(( ++a )) # 变量'a'预加 1,C 风格.
echo "a (after ++a) = $a"

(( --a )) # 变量'a'预减 1,C 风格.
echo "a (after --a) = $a"

echo

