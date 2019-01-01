#!/bin/bash
# poem.sh: 排印出作者喜欢的一首诗.

# 诗的行数 (一小节诗).
Line[1]="I do not know which to prefer,"
Line[2]="The beauty of inflections"
Line[3]="Or the beauty of innuendoes,"
Line[4]="The blackbird whistling"
Line[5]="Or just after."

# 出处.
Attrib[1]=" Wallace Stevens"
Attrib[2]="\"Thirteen Ways of Looking at a Blackbird\""
# 此诗是公众的 (版权期已经到期了). 

echo

for index in 1 2 3 4 5  # 5 行.
do
    printf "    %s\n" "${Line[index]}"
done

for index in 1 2        # 打印两行出处行. 
do
    printf "        %s\n" "${Attrib[index]}"
done

echo

exit 0 
# 练习:
# --------
# 修改这个脚本使其从一个文本文件中提取内容打印一首行.
