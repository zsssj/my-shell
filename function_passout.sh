#!/bin/bash 
# function_passout.sh
# 返回参数函数外可见 

count_lines_in_etc_passwd() 
{
    [[ -r /etc/passwd ]] && REPLY=$(echo $(wc -l < /etc/passwd))
    # 如果/etc/passwd 可读,则把 REPLY 设置成文件的行数.
    # 返回一个参数值和状态信息.
    # 'echo'好像没有必要,但 . . .
    #+ 它的作用是删除输出中的多余空白字符.
} 

if count_lines_in_etc_passwd 
then
    echo "There are $REPLY lines in /etc/passwd." 
else
    echo "Cannot count lines in /etc/passwd." 
fi

# Thanks, S.C.
