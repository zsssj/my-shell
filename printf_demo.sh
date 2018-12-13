#!/bin/bash
# printf demo

PI=3.14159265358979
DecimalConstant=31373
Message1="Greetings,"
Message2="Earthling."

echo

printf "Pi to 2 decimal places = %1.2f" $PI
echo
printf "Pi to 9 decimal places = %1.9f" $PI     # 都能正确地结束. 

printf "\n"         # 打印一个换行,
                    # 等价于 'echo'... 

printf "Constant = \t%d\n" $DecimalConstant     # 插入一个 tab (\t).
printf "%s %s \n" $Message1 $Message2

echo

# ==========================================#
# 模仿 C 函数, sprintf().
# 使用一个格式化的字符串来加载一个变量.

echo 
Pi12=$(printf "%1.12f" $PI)
echo "Pi to 12 decimal places = $Pi12"

Msg=`printf "%s %s \n" $Message1 $Message2`
echo $Msg; echo $Msg

# 向我们看到的一样,现在'sprintf'函数可以
#+ 作为一个可被加载的模块
#+ 但这是不可移植的.

exit 0
