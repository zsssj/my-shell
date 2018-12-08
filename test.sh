#!/bin/bash
# 还是行星.

# 分配行星的名字和它距太阳的距离. 
for planet in "Mercury 36" "Venus 67" "Earth 93" "Mars 142" "Jupiter 483" 
do
    set -- $planet # 解析变量"planet"并且设置位置参数.
    # "--" 将防止$planet 为空,或者是以一个破折号开头.

    # 可能需要保存原始的位置参数,因为它们被覆盖了.
    # 一种方法就是使用数组,
    # original_params=("$@")

    echo "$1 $2,000,000 miles from the sun"
    #-------two tabs---把后边的 0 和$2 连接起来
done

# (Thanks, S.C., for additional clarification.)

exit 0
