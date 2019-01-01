#!/bin/bash
# bubble.sh: 排序法之冒泡排序.

# 回忆冒泡排序法. 在这个版本中要实现它...

# 靠连续地多次比较数组元素来排序,
#+ 比较两个相邻的元素,如果排序顺序不对,则交换两者的顺序.
# 当第一轮比较结束后,最"重"的元素就被排到了最底部. 
# 当第二轮比较结束后,第二"重"的元素就被排到了次底部的位置. 
# 以此类推. 
# 这意味着每轮的比较不需要比较先前已"沉淀"好的数据. 
# 因此你会注意到后面数据的打印会比较快一些.


exchange()
{
    # 交换数组的两个元素.
    local temp=${Countries[$1]}     # 临时保存要交换的一个元素.
                                    #
    Countries[$1]=${Countries[$2]}
    Countries[$2]=$temp

    return
}

declare -a Countries    #声明数组,
                        #+ 在此是可选的,因为下面它会被按数组来初始化.

# 是否允许用转义符(\)将数组的各变量值放到几行上?  
#
# 是的.

Countries=(Netherlands Ukraine Zaire Turkey Russia Yemen Syria \
Brazil Argentina Nicaragua Japan Mexico Venezuela Greece England \
Israel Peru Canada Oman Denmark Wales France Kenya \
Xanadu Qatar Liechtenstein Hungary)

# "Xanadu" 是个虚拟的充满美好的神话之地.
#


clear                           # 开始之前清除屏幕.

echo "0: ${Countries[*]}"       # 从 0 索引的元素开始列出整个数组.

number_of_elements=${#Countries[@]}
let "comparisons = $number_of_elements - 1"

count=1 # 传递数字.

while [ "$comparisons" -gt 0 ]  # 开始外部的循环
do

    index=0 # 每轮开始前重设索引值为 0. 

    while [ "$index" -lt "$comparisons" ] # 开始内部循环
    do
        if [ ${Countries[$index]} \> ${Countries[`expr $index + 1`]} ]
        # 如果原来的排序次序不对...
        # 回想一下 \> 在单方括号里是 is ASCII 码的比较操作符.
        #

        # if [[ ${Countries[$index]} > ${Countries[`expr $index + 1`]} ]]
        #+ 也可以.
        then
            exchange $index `expr $index + 1`   # 交换.
        fi
        let "index += 1"
    done # 内部循环结束

# ----------------------------------------------------------------------
# Paulo Marcel Coelho Aragao 建议使用更简单的 for-loops.
#
# for (( last = $number_of_elements - 1 ; last > 1 ; last-- ))
# do
#   for (( i = 0 ; i < last ; i++ )) 
#   do
#       [[ "${Countries[$i]}" > "${Countries[$((i+1))]}" ]] \ 
#            && exchange $i $((i+1))
#   done 
# done
# ----------------------------------------------------------------------


let "comparisons -= 1"      # 因为最"重"的元素冒到了最底部, 
                            #+ 我们可以每轮少做一些比较.

echo
echo "$count: ${Countries[@]}"  # 每轮结束后，打印一次数组
echo
let "count += 1"                # 增加传递计数

done                            # 外部循环结束
                                # 完成.

exit 0 
################################End Script#########################################
