#!/bin/bash
# script-detector.sh: 在一个目录中检查所有的脚本文件.

ARGS=1
E_BADARGS=65
E_NODIRECTORY=67
TESTCHARS=2     # 测试前两个字节.
SHABANG='#!'    # 脚本都是以 "sha-bang." 开头的.

if [ $# -ne "$ARGS" ]   # 检验传递到脚本中的参数的个数。
then
    echo "Usage: `basename $0` [directory]"
    exit $E_BADARGS
fi

if [ ! -d "$1" ]    # 检查传入的目录参数是否存在.
then
    echo "Directory \"$1\" does not exist."
    exit $E_NODIRECTORY
fi

###############################################################
# main()
for file in `ls $1`   # 遍历当前目录下的所有文件.
do
    dirfile=$1"/"$file      # 需要切换到$1目录下，或补全文件名称
    if [[ `head -c$TESTCHARS "$dirfile"` = "$SHABANG" ]]
#    if [[ $( cat "$dirfile" | head -c$TESTCHARS ) = "$SHABANG" ]]
    # head-c2 
    # '-c' 选项将从文件头输出指定个数的字符,
    #+ 而不是默认的行数.
    then
        echo "File \"$file\" is a script."
    else
        echo "File \"$file\" is *not* a script."
    fi
done

exit 0

# 练习:
# -----
# 1) 将这个脚本修改为可以指定目录
#+  来扫描目录下的脚本. 
#+  (而不是只搜索当前目录).
#
# 2) 就目前看来, 这个脚本将不能正确识别出
#+ Perl, awk, 和其他一些脚本语言的脚本文件. 
# 修正这个问题.
