#!/bin/bash
# rfe.sh: 重命名文件扩展名.

# 用法: rfe old_extension new_extension

# 用法: rfe gif jpg
# 例子:
# 将指定目录的所有 *.gif 文件都重命名为 *.jpg,

E_BADARGS=65 
case $# in
    0|1)                    # "|" 在这里的意思是或操作.
    echo "Usage: `basename $0` old_file_suffix new_file_suffix"
    exit $E_BADARGS         # 如果只有 0 个或 1 个参数,那么就退出.
    ;; 
esac


for filename in *.$1
# 以第一个参数为扩展名的全部文件的列表 
do
    mv $filename ${filename%$1}$2
    # 从筛选出的文件中先去掉以第一参数结尾的扩展名部门, 
    #+ 然后作为扩展名把第 2 个参数添加上.
done    

exit 0
