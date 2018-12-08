#!/bin/bash
# random2.sh: 产生一个范围 0 - 1 的为随机数.
# 使用 awk 的 rand()函数.

AWKSCRIPT=' { srand(); print rand() } '
# Command(s) / 传到 awk 中的参数
# 注意,srand()函数用来产生 awk 的随机数种子.

echo -n "Random number between 0 and 1 = "

echo | awk "$AWKSCRIPT"
# 如果你省去'echo'那么将发生什么?

exit 0
