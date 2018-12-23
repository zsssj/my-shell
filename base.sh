#!/bin/bash
##########################################################################
# 脚本  : base.sh - 用不同的数值来打印数字 (Bourne Shell) 
# 作者  : Heiner Steven (heiner.steven@odn.de)
# 日期  : 07-03-95
# 类型  : 桌面
# $Id: base.sh,v 1.2 2000/02/06 19:55:35 heiner Exp $
# ==> 上边这行是 RCS ID 信息.
##########################################################################
# 描述
#
# Changes
# 21-03-95 stv fixed error occuring with 0xb as input (0.2)
##########################################################################

# ==> 在本书中使用这个脚本通过了作者的授权. 
# ==> 注释是本书作者添加的.

NOARGS=65
PN=`basename "$0"`      # 程序名
VER=`echo '$Revision: 1.2 $' | cut -d' ' -f2` # ==> VER=1.2

Usage () {
    echo "$PN - print number to different bases, $VER (stv '95)
usage: $PN [number ...]

If no number is given, the numbers are read from standard input. 
A number may be
    binary (base 2)         starting with 0b (i.e. 0b1100) 
    octal (base 8)          starting with 0 (i.e. 014) 
    hexadecimal (base 16)   starting with 0x (i.e. 0xc) 
    decimal otherwise (i.e. 12)" >&2
    exit $NOARGS
}   # ==> 打印出用法信息的函数.

Msg () {
    for i # ==> 省略 [list] . 
    do echo "$PN: $i" >&2 
    done
}

Fatal () { Msg "$@"; exit 66; }

PrintBases () {
    # 决定数值的数制
    for i   # ==> 省略 [list]...
    do      # ==> 所以是对命令行参数进行操作.
    case "$i" in
        0b*) ibase=2;;                  # 2 进制 
        0x*|[a-f]*|[A-F]*) ibase=16;;   # 16 进制
        *) ibase=8;;                    # 8 进制  
        [1-9]*) ibase=10;;              # 10 进制
        *)
        Msg "illegal number $i - ignored" 
        continue;;
    esac

    # 去掉前缀, 将 16 进制数字转换为大写(bc 需要大写) 
    number=`echo "$i" | sed -e 's:^0[bBxX]::' | tr '[a-f]' '[A-F]'` 
    # ==>使用":" 作为 sed 分隔符, 而不使用"/".

    # 将数字转换为 10 进制
    dec=`echo "ibase=$ibase; $number" | bc` # ==> 'bc' 是个计算工具. 
    case "$dec" in
        [0-9]*) ;;      # 数字没问题
        *) continue;;   # 错误: 忽略 
    esac

    # 在一行上打印所有的转换后的数字.
    # ==> 'here document' 提供命令列表给'bc'. 
    echo `bc <<!
        obase=16; "hex="; $dec 
        obase=10; "dec="; $dec
        obase=8;  "oct="; $dec 
        obase=2;  "bin="; $dec
!
    `|sed -e 's: :       :g'

    done 
}

while [ $# -gt 0 ]
# ==> 这里必须使用一个 "while 循环",
# ==>+ 因为所有的 case 都可能退出循环或者 # ==>+ 结束脚本.
# ==> (感谢, Paulo Marcel Coelho Aragao.)
do
    case "$1" in
    --)     shift; break;;  # ==> 帮助信息.
    -h)     Usage;; 
    -*)     Usage;;
    *)  break;;     # 第一个数字
    esac    # ==> 对于非法输入更严格检查是非常有用的.
    shift  
done

if [ $# -gt 0 ]
then
    PrintBases "$@"
else
    while read line
    do
        PrintBases $line
    done
fi


exit 0
