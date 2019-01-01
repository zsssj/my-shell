#!/bin/bash
# dereference.sh
# 给函数传递不同的参数.
# Bruce W. Clare 编写.

dereference ()
{
    y=\$"$1"    # 变量名. 
    echo $y     # $Junk

    x=`eval "expr \"$y\" "`
    echo $1=$x
    eval "$1=\"Some Different Text \""  # 赋新值.
}

Junk="Some Text" 
echo $Junk "before" # Some Text before

dereference Junk 
echo $Junk "after"  # Some Different Text after
exit 0
