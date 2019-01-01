#!/bin/bash
# embedded-arrays.sh 
# 内嵌数组和间接引用.

# 由 Dennis Leeuw 编写. 
# 已获使用许可.
# 由本文作者修改.


ARRAY1=( 
    VAR1_1=value11
    VAR1_2=value12 
    VAR1_3=value13
)

ARRAY2=( 
    VARIABLE="test"
    STRING="VAR1=value1 VAR2=value2 VAR3=value3"
    ARRAY21=${ARRAY1[*]}
)   # 把 ARRAY1 数组嵌到这个数组里.

function print () { 
    OLD_IFS="$IFS"
    IFS=$'\n'       # 这是为了在每个行打印一个数组元素. 
                    #
    TEST1="ARRAY2[*]"
    local ${!TEST1} # 试下删除这行会发生什么.
    # 间接引用.
# 这使 $TEST1 只在函数内存取.
#


    # 我们看看还能干点什么. 
    echo
    echo "\$TEST1 = $TEST1"             # 变量的名称.
    echo; echo
    echo "{\$TEST1} = ${!TEST1}"        # 变量的内容.
                                        # 这就是间接引用的作用. 
                                        #
    echo
    echo "-------------------------------------------"; 
    echo


    # 打印变量
    echo "Variable VARIABLE: $VARIABLE"

    # 打印一个字符串元素
    IFS="$OLD_IFS"
    TEST2="STRING[*]"
    local ${!TEST2}     # 间接引用 (像上面一样). 
    echo "String element VAR2: $VAR2 from STRING"

    # 打印一个字符串元素
    TEST2="ARRAY21[*]"
    local ${!TEST2}     # 间接引用 (像上面一样).
    echo "Array element VAR1_1: $VAR1_1 from ARRAY21"
}

print
echo

exit 0 
# 脚本作者注,
#+ "你可以很容易地将其扩展成 Bash 的一个能创建 hash 的脚本."
# (难) 留给读者的练习: 实现它.
################################End Script#########################################
