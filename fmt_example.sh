#!/bin/bash

WIDTH=40

b=`ls /usr/local/bin`

echo $b | fmt -w $WIDTH

# 也可以使用如下方法,作用相同
# 设为 40 列宽. # 取得文件列表...
# echo $b | fold - -s -w $WIDTH

exit 0
