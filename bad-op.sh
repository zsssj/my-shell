#!/bin/bash
# bad-op.sh: 在整数比较中使用字符串比较.

echo
number=1

# 下面的 "while" 循环有两个错误:
#+ 一个很明显,另一个比较隐蔽.

while [ "$number" < 5 ] # 错误! 应该是: while [ "$number" -lt 5 ]
do
    echo -n "$number "
    let "number += 1"
done
# 尝试运行时会收到错误信息而退出:
#+ bad-op.sh: line 10: 5: No such file or directory
# 在单括号里, "<" 需要转义,
#+ 而即使是如此, 对此整数比较它仍然是错的.


echo "---------------------"


while["$number"\<5] # 1 2 3 4  
do                  #
    echo -n "$number "  # 看起来好像是能工作的, 但 . . . 
    let "number += 1"   #+ 它其实是在对 ASCII 码的比较,
done                    #+ 而非是对数值的比较.

echo; echo "---------------------"

# 下面这样便会引起问题了. 例如:

lesser=5
greater=105

if [ "$greater" \< "$lesser" ]
then
    echo "$greater is less than $lesser"
fi           # 105 is less than 5
# 事实上, "105" 小于 "5"
#+ 是因为使用了字符串比较 (以 ASCII 码的排序顺序比较).

echo

exit 0 
################################End Script#########################################
