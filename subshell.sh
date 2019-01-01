#!/bin/bash
# subshell.sh

echo

echo "Subshell level OUTSIDE subshell = $BASH_SUBSHELL"
# Bash, 版本 3, 增加了新的      $BASH_SUBSHELL 变量.
echo

outer_variable=Outer

(
echo "Subshell level INSIDE subshell = $BASH_SUBSHELL"
inner_variable=Inner

echo "From subshell, \"inner_variable\" = $inner_variable"
echo "From subshell, \"outer\" = $outer_variable"
)

echo
echo "Subshell level OUTSIDE subshell = $BASH_SUBSHELL"
echo

if [ -z "$inner_variable" ]
then
    echo "inner_variable undefined in main body of shell"
else
    echo "inner_variable defined in main body of shell"
fi

echo "From main body of shell, \"inner_variable\" = $inner_variable"
# $inner_variable 会以没有初始化的变量来打印
#+ 因为变量是在子 shell 里定义的"局部变量".
# 这个有办法补救的吗?

echo

exit 0
