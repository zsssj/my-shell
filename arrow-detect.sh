#!/bin/bash
# arrow-detect.sh: 检测方向键,和一些非打印字符的按键.
# Thank you, Sandro Magi 告诉了我怎么做.

# --------------------------------------------
# 按键产生的字符编码.
arrowup='\[A'
arrowdown='\[B'
arrowrt='\[C'
arrowleft='\[D'
insert='\[2'
delete='\[3'
# --------------------------------------------

SUCCESS=0
OTHER=65

echo "Press a key... \c"
# 如果不是上边列表所列出的按键,可能还是需要按回车.(译者:因为一般按键是一个字符)
read -n3 key        # 读3个字符. 

echo -n "$key" | grep "$arrowup"    # 检查输入字符是否匹配.
if [ "$?" -eq $SUCCESS ]
then
    echo "Up-arrow key pressed."
    exit $SUCCESS 
fi

echo -n "$key" | grep "$arrowdown" 
if [ "$?" -eq $SUCCESS ]
then
    echo "Down-arrow key pressed."
    exit $SUCCESS 
fi

echo -n "$key" | grep "$arrowrt" 
if [ "$?" -eq $SUCCESS ]
then
    echo "Right-arrow key pressed."
    exit $SUCCESS 
fi

echo -n "$key" | grep "$arrowleft" 
if [ "$?" -eq $SUCCESS ]
then
    echo "Left-arrow key pressed."
    exit $SUCCESS 
fi

echo -n "$key" | grep "$insert" 
if [ "$?" -eq $SUCCESS ]
then
    echo "\"Insert\" key pressed."
    exit $SUCCESS 
fi

echo -n "$key" | grep "$delete" 
if [ "$?" -eq $SUCCESS ]
then
    echo "\"Delete\" key pressed."
    exit $SUCCESS 
fi

echo " Some other key pressed." 

exit $OTHER
