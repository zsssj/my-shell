#!/bin/bash
# alias.sh

shopt -s expand_aliases
# 必须设置这个选项,否则脚本不会扩展别名功能.


# 首先, 来点有趣的.
alias Jesse_James='echo "\"Alias Jesse James\" was a 1959 comedy starring Bob Hope."'
Jesse_James

echo; echo; echo; 

alias ll="ls -l"
# 可以使用单引号(')或双引号(")来定义一个别名.

echo "Trying aliased \"ll\":"
ll /Users/Nick/M*    #* 别名工作了.

echo

directory=/Users/Nick/
prefix=M*           # 看通配符会不会引起麻烦.
echo "Variables \"directory\" + \"prefix\" = $directory$prefix"
echo

alias lll="ls -l $directory$prefix" 

echo "Trying aliased \"lll\":"
lll         # 详细列出在/usr/X11R6/bin 目录下所有以 mk 开头的文件.
# 别名能处理连接变量 -- 包括通配符 -- o.k.





TRUE=1

echo

if [ TRUE ]
then
    alias rr="ls -l"
    echo "Trying aliased \"rr\" within if/then statement:"
    rr /Users/Nick/M*   #* 引起错误信息!
    # 别名不能在混合结构中使用.
    echo "However, previously expanded alias still recognized:"
    ll /Users/Nick/M*
fi

echo

count=0
while [ $count -lt 3 ]
do
    alias rrr="ls -l"
    echo "Trying aliased \"rrr\" within \"while\" loop:"
    rrr /Users/Nick/M*      #* 在这儿,别名也不会扩展.
                            # alias.sh: line 57: rrr: command not found
    let count+=1 
done

echo; echo

alias xyz='cat $0'      # 脚本打印自身内容.
                        # 注意是单引号(强引用).
xyz
# 虽然 Bash 的文档它是不会工作的,但好像它是可以工作的.
#
#
# 然而,就像 Steve Jacobson 指出,
#+ 参数"$0"立即扩展成了这个别名的声明.

exit 0
################################End Script#########################################
