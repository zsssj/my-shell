#!/bin/bash
# script-array.sh: 把此脚本的内容传进数组.
# 从 Chris Martin 的 e-mail 中得到灵感 (多谢!).

script_contents=( $(cat "$0") )    # 把这个脚本($0)的内容存进数组. 
                                    #
# <<COMMENT
for element in $(seq 0 $((${#script_contents[@]} - 1)))
# for element in $(seq 0 `sed -n "$=" $0`) 
do              # ${#script_contents[@]} 
                #+ 表示数组中元素的个数. 
                #
                # 问题:
                # 为什么需要 seq 0 ?
                # 试试更改成 seq 1.
    echo -n "${script_contents[$element]}"
                        # 将脚本的每行列成一个域. 
    echo -n " -- "      # 使用" -- "作为域分隔符.

done
# COMMENT

<<COMMENT1
while read line     # 读取文件每行
do
    echo ${line}
done<$0
COMMENT1

echo 

exit 0
# 练习:
# --------
# 修改这个脚本使它能按照它原本的格式输出,
#+ 连同空白符,换行,等等.
#
################################End Script#########################################
