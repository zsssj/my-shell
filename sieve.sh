#!/bin/bash
# sieve.sh (ex68.sh)

# 埃拉托色尼素数筛子
# 找素数的经典算法.

# 在同等数量的数值内这个脚本比用 C 写的版本慢很多. 
#

LOWER_LIMIT=1       # 从 1 开始.
UPPER_LIMIT=1000    # 到 1000.
# (如果你很有时间的话,你可以把它设得更高 . . . )

PRIME=1
NON_PRIME=0

let SPLIT=UPPER_LIMIT/2
# 优化:
# 只需要测试中间到最大之间的值 (为什么?).


declare -a Primes
# Primes[] 是一个数组.

# ============================================================
initialize ()
{
# 初始化数组.

i=$LOWER_LIMIT
until [ "$i" -gt "$UPPER_LIMIT" ]
do
    Primes[i]=$PRIME
    let "i += 1"
done
# 假定所有的数组成员都是需要检查的 (素数)
#+ 一直到检查完成前.
}
# ============================================================
print_primes ()
{
# 打印出所有 Primes[]数组中被标记为素数的元素.

i=$LOWER_LIMIT

until [ "$i" -gt "$UPPER_LIMIT" ] 
do

    if [ "${Primes[i]}" -eq "$PRIME" ] 
    then
        printf "%8d" $i
        # 每个数字打印前先打印8个空格, 数字是在偶数列打印的. 
    fi

    let "i += 1" 

done

}
# ============================================================
sift ()     # 查出非素数. 
{

    let i=$LOWER_LIMIT+1
    # 我们都知道 1 是素数, 所以我们从 2 开始.

#    until [ "$i" -gt "$UPPER_LIMIT" ] 
    until [ "$i" -gt "$SPLIT" ]     # 优化，可以减少一半循环数 
    do

        if [ "${Primes[i]}" -eq "$PRIME" ]
        # 不要处理已经过滤过的数字 (被标识为非素数). 
        then
    
            t=$i

            while [ "$t" -le "$UPPER_LIMIT" ]
            do
                let "t += $i " 
                Primes[t]=$NON_PRIME 
                # 标识为非素数.
            done

        fi 
        
        let "i += 1"
    done
} 

# ==============================================
# main ()
# 继续调用函数.
initialize
sift
print_primes
# 这就是被称为结构化编程的东西了.
# ==============================================

echo

exit 0


# -------------------------------------------------------- #
# 因为前面的一个'exit',所以下面的代码不会被执行.

# 下面是 Stephane Chazelas 写的一个埃拉托色尼素数筛子的改进版本,
#+ 运行会稍微快一点.

# 必须在命令行上指定参数(寻找素数的限制范围). 
UPPER_LIMIT=$1              # 值来自命令行.
let SPLIT=UPPER_LIMIT/2     # 从中间值到最大值.

Primes=( '' $(seq $UPPER_LIMIT) )

i=1
until(((i+=1)>SPLIT)) # 仅需要从中间值检查. 
do
    if [[ -n $Primes[i] ]] 
    then
        t=$i
        until (( ( t += i ) > UPPER_LIMIT )) 
        do
            Primes[t]= 
        done
    fi 
done

echo ${Primes[*]}
exit 0 
################################End Script#########################################
