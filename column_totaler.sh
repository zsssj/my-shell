#!/bin/bash

# "column totaler"脚本的另一个版本
# True
# False
#+ 这个版本在目标文件中添加了一个特殊的列(数字的).
# 这个脚本使用了间接引用.

ARGS=2
E_WRONGARGS=65

if [ $# -ne "$ARGS" ] # 检查命令行参数是否是合适的个数.
then
echo "Usage: `basename $0` filename column-number"
exit $E_WRONGARGS
fi

filename=$1
column_number=$2

#===== 上边的这部分,与原来的脚本一样 =====# 

# 一个多行的 awk 脚本被调用,通过 ' ..... '


# awk 脚本开始.
# ------------------------------------------------
awk ' 

{ total +="'"$${column_number} "'"     # 间接引用$$...,直接引用$...   
}
END {
    print total
    }   

    ' "$filename"
# ------------------------------------------------
# awk 脚本结束.

# 间接的变量引用避免了在一个内嵌的 awk 脚本中引用
#+ 一个 shell 变量的问题.
# Thanks, Stephane Chazelas.


exit 0
