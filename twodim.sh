#!/bin/bash
# twodim.sh: 模拟二维数组.

# 一维数组由单行组成.
# 二维数组由连续的行组成.

Rows=5
Columns=5
#5X5 的数组Array.

declare -a alpha        # char alpha [Rows] [Columns]; 
                        # 不必要的声明. 为什么?

load_alpha () 
{
local rc=0 
local index

for i in A B C D E F G H I J K L M N O P Q R S T U V W X Y
do  # 如果你高兴,可以使用不同的符号. 
    local row=`expr $rc / $Columns`
    local column=`expr $rc % $Rows`
    let "index = $row * $Rows + $column" 
    alpha[$index]=$i
#   alpha[$row][$column] 
    let "rc += 1"
done

# 更简单的办法
#+ declare -a alpha=( A B C D E F G H I J K L M N O P Q R S T U V W X Y ) 
#+ 但这就缺少了二维数组的感觉了.
}

print_alpha ()
{
local row=0
local index

echo 

while [ "$row" -lt "$Rows" ]    # 以行顺序为索引打印行的各元素: 
do                              #+ 即数组列值变化快,
                                #+ 行值变化慢.
    local column=0 

    echo -n "       "           # 依行倾斜打印正方形的数组.

    while [ "$column" -lt "$Columns" ] 
    do
        let "index = $row * $Rows + $column"
        echo -n "${alpha[index]} "  # alpha[$row][$column] 
        let "column += 1"
    done

    let "row += 1" 
    echo

done

# 等同于
#       echo ${alpha[*]} | xargs -n $Columns

echo 
}

filter ()           # 过滤出负数的数组索引. 
{

    echo -n "   "       # 产生倾斜角度.
                        # 解释怎么办到的.

    if [[ "$1" -ge 0 && "$1" -lt "$Rows" && "$2" -ge 0 && "$2" -lt "$Columns" ]] 
    then
        let "index = $1 * $Rows + $2"
        # Now, print it rotated 现在,打印旋转角度. 
        echo -n " ${alpha[index]}"
        #           alpha[$row][$column]
    fi 
}

rotate ()           # 旋转数组 45 度 --
{                   #+ 在左下角"平衡"图形.
local row
local column

for (( row = Rows; row > -Rows; row-- ))
do      # 从后面步进数组. 为什么? 

    for (( column = 0; column < Columns; column++ )) 
    do

        if [ "$row" -ge 0 ] 
        then
            let "t1 = $column - $row"
            let "t2 = $column" 
        else
            let "t1 = $column"
            let "t2 = $column + $row" 
        fi

        filter $t1 $t2      # 过滤出负数数组索引.
                            # 如果你不这样做会怎么样?
    done

    echo; echo

done

# 数组旋转灵感源于 Herbert Mayer 写的
#+ "Advanced C Programming on the IBM PC," 的例子 (页码. 143-146) #+ (看参考书目附录).
# 这也能看出 C 能做的事情有多少能用 shell 脚本做到.
#
}


#---------------     现在, 可以开始了.    ------------#
load_alpha      # 加载数组.
print_alpha     # 打印数组.
rotate          # 反时钟旋转数组 45 度.
#-----------------------------------------------------#

exit 0

# 这是有点做作,不太优雅.

# 练习: 
# ---------
# 1) 重写数组加载和打印函数, 
#    使其更直观和容易了解.
#
# 2) 指出数组旋转函数是什么原理.
#    Hint 索引: 思考数组从尾向前索引的实现.
#
# 3) 重写脚本使其可以处理非方形数组 Rewrite this script to handle a non-square array, 
#    例如 6X4 的数组.
#    尝试旋转数组时做到最小"失真".
################################End Script#########################################
