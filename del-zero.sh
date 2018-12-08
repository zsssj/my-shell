#!/bin/bash
# 去掉传递进来的参数开头的0.

strip_leading_zero()    # 去掉开头的0
{                       #+从传递进来的参数中.
    return=${1#0}       # "1"指的是"$1" -- 传进来的参数.
}                       # "0"就是我们想从"$1"中删除的子串.

# 下边是Manfred Schwarb's对上边函数的一个改版.
strip_leading_zero2()
{
    shopt -s extglob        
        local val=${1##+(0)}
    shopt -u extglob
        _strip_leading_zero2=$(val:-0)

}

echo `basename $PWD`
echo "${PWD##*/}"
echo
echo `basename $0`
echo $0
echo "${0##*/}"
echo
filename=test.data
echo "${filename##*.}"

