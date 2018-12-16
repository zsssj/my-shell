#!/bin/bash
# wf2.sh: Crude word frequency analysis on a text file.

# 使用 'xargs' 将文本行分解为单词.
# 于后边的 "wf.sh" 脚本相比较.


# 检查命令行上输入的文件.
ARGS=1
E_BADARGS=65
E_NOFILE=66

if [ $# -ne "$ARGS" ]
# 纠正传递到脚本中的参数个数?
then
    echo "Usage: `basename $0` filename"
    exit $E_BADARGS
fi

if [ ! -f "$1" ] # 检查文件是否存在.
then
    echo "File \"$1\" does not exist."
    exit $E_NOFILE
fi



###############################################################
cat "$1" | xargs -n1 | \
# 列出文件, 每行一个单词.
tr A-Z a-z | \
# 将字符转换为小写.
sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\
/g' | \
# 过滤掉句号和逗号,
#+ 并且将单词间的空格修改为换行,
sort | uniq -c | sort -nr
# 最后统计出现次数,把数字显示在第一列,然后显示单词,并按数字排序.
###############################################################

# 这个例子的作用与"wf.sh"的作用是一样的,
#+ 但是这个例子比较臃肿, 并且运行起来更慢一些(为什么?).

exit 0
