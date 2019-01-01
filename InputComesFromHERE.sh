#!/bin/bash

# 'echo' 对于打印单行消息是非常好的, 
# 但是在打印消息块时可能就有点问题了.
# 'cat' here document 可以解决这个限制.

cat <<-End-of-message           # -选项去除TAB对mac没有用
-------------------------------------
    This is line 1 of the message.
    This is line 2 of the message.
    This is line 3 of the message.
    This is line 4 of the message.
    This is the last line of the message.
-------------------------------------
End-of-message

# 用下边这行代替上边的第 7 行
#+  cat > $Newfile <<End-of-message
#+        ^^^^^^^^^^
#+ 那么就会把输出写到文件$Newfile 中, 而不是 stdout.

exit 0

#--------------------------------------------
# 下边的代码不会运行, 因为上边的"exit 0".

# S.C. 指出下边代码也可以运行.
echo "-------------------------------------
This is line 1 of the message.
This is line 2 of the message.
This is line 3 of the message.
This is line 4 of the message.
This is the last line of the message.
-------------------------------------"
# 然而, 文本可能不包含双引号, 除非它们被转义.
#==============================================================
# 与之前的例子相同, 但是...

# - 选项对于 here docutment 来说,<<-
#+ 可以抑制文档体前边的 tab,
#+ 而*不*是空格 *not* spaces.

cat <<-ENDOFMESSAGE             # mac下没有用
    This is line 1 of the message.
    This is line 2 of the message.
    This is line 3 of the message.
    This is line 4 of the message.
    This is the last line of the message.
ENDOFMESSAGE
# 脚本在输出的时候左边将被刷掉.
# 就是说每行前边的 tab 将不会显示.

# 上边 5 行"消息"的前边都是 tab, 不是空格.
# 空格是不受<<-影响的.

# 注意, 这个选项对于*嵌在*中间的 tab 没作用. 
exit 0
################################End Script#########################################
