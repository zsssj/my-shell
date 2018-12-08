#!/bin/bash
# param-sub.sh

# 一个变量是否被声明
#+ 将会影响默认选项的触发
#+ 甚至于这个变量被设为空. 

username0=
echo "username0 has been declared, but is set to null."
echo "username0 = ${username0-`whoami`}"
# 将不会 echo.

echo

echo username1 has not been declared.
echo "username1 = ${username1-`whoami`}"
# 将会 echo.

username2=
echo "username2 has been declared, but is set to null."
echo "username2 = ${username2:-`whoami`}"
#
#
#
#
variable=
# 变量已经被声明了,但是被设置为空.

echo "${variable-0}"
echo "${variable:-1}"
# 

unset variable 
echo "${variable-2}"
echo "${variable:-3}"

exit 0
