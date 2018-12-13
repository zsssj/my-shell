#!/bin/bash
# 练习 getopts 和 OPTIND
# 在 Bill Gradwohl 的建议下,这个脚本于 10/09/03 被修改.

# 这里我们将学习 'getopts'如何处理脚本的命令行参数.
# 参数被作为"选项"(标志)被解析,并且分配参数.

# 试一下通过如下方法来调用这个脚本
# 'scriptname -mn'
# 'scriptname -oq qOption' (qOption 可以是任意的哪怕有些诡异字符的字符串.)
# 'scriptname -qXXX -r'
#
# 'scriptname -qr' - 意外的结果, "r" 将被看成是选项 "q" 的参数. 
# 'scriptname -q -r' - 意外的结果, 同上.
# 'scriptname -mnop -mnop' - 意外的结果
# (OPTIND is unreliable at stating where an option came from).
#
# 如果一个选项需要一个参数("flag:"),那么它应该
#+ 取得在命令行上挨在它后边的任何字符.

NO_ARGS=0
E_OPTERROR=65

if [ $# -eq "$NO_ARGS" ]    # 不带命令行参数就调用脚本? 
then
    echo "Usage: `basename $0` options (-mnopqrs)"
    exit $E_OPTERROR        # 如果没有参数传进来,那就退出,并解释用法.
fi
# 用法: 脚本名 -选项名
# 注意: 破折号(-)是必须的


while getopts ":mnopq:rs" Option 
do
    case $Option in
        m ) echo "Scenario #1:option -m- [OPTION=${OPTION}]";;
        n | o ) echo "Scenario #2: option -$Option- [OPTIND=${OPTIND}]";;
        p ) echo "Scenario #3: option -p- [OPTIND=${OPTIND}]";; 
        q ) echo "Scenario #4: option -q-with argument \"$OPTARG\" [OPTIND=${OPTIND}]";; 
        # 注意,选项'q'必须分配一个参数,
        #+ 否则默认将失败.
        r | s ) echo "Scenario #5: option -$Option-";;
        * ) echo "Unimplemented option chosen.";;   # DEFAULT 
    esac
done 

shift $(($OPTIND-1))
# 将参数指针减 1,这样它将指向下一个参数.
# $1 现在引用的是命令行上的第一个非选项参数
#+ 如果有一个这样的参数存在的话. 

exit 0
