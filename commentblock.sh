#!/bin/bash
# commentblock.sh

# 通过here document技术，将文档中段落进行注释，不用每行都添加'#'
:<<COMMENTBLOCK
echo "This line will not echo."
This is a comment line missing the "#" prefix.
This is another comment line missing the "#" prefix.

&*@!!++=
The above line will cause no error message,
because the Bash interpreter will ignore it.
COMMENTBLOCK 

echo "Exit value of above \"COMMENTBLOCK\" is $?."
# 这里将不会显示任何错误.


# 上边的这种技术当然也可以用来注释掉
#+ 一段正在使用的代码, 如果你有某些特定调试要求的话.
# 这将比对每行都敲入"#"来得方便的多,
#+ 而且如果你想恢复的话, 还得将添加上的"#"删除掉.

:<<DEBUGXXX
for file in *
do
    cat "$file"
done
DEBUGXXX

exit 0
