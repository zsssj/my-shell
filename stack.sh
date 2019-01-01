#!/bin/bash
# stack.sh: 下推的堆栈模拟

# 类似于 CPU 栈, 下推的堆栈依次保存数据项, 
#+ 但取出时则反序进行, 后进先出.

BP=100          # 栈数组的基点指针. 
                # 从元素 100 开始.

SP=$BP          # 栈指针.
                # 初始化栈底.

Data=           # 当前栈的内容.
                # 必须定义成全局变量,
                #+ 因为函数的返回整数有范围限制.

declare -a stack


push()          # 把一个数据项压入栈. # 没有可压入的?
{
if [ -z "$1" ] 
then
    return

fi

let "SP -= 1"           # 更新堆栈指针.
stack[$SP]=$1

return
}

pop()                   # 从栈中弹出一个数据项.
{
Data=                   # 清空保存数据项中间变量.

if [ "$SP" -eq "$BP" ]  # 已经没有数据可弹出?
then
    return
fi                      # 这使 SP 不会超过 100,
                        #+ 例如, 这可保护一个失控的堆栈. 

Data=${stack[$SP]}
let "SP += 1"           # 更新堆栈指针.
return
}

status_report()         # 打印堆栈的当前状态.
{
echo "-------------------------------------" 
echo "REPORT"
echo "Stack Pointer = $SP"
echo "Just popped \""$Data"\" off the stack."
echo "-------------------------------------"
echo
}

# ======================================================= 
# 现在,来点乐子.

echo

# 看你是否能从空栈里弹出数据项来.
pop
status_report

echo

push garbage
pop
status_report               # 压入 garbage, 弹出 garbage.

value1=23; push $value1
value2=skidoo; push $value2
value3=FINAL; push $value3

pop                         # FINAL
status_report
pop                         # skidoo
status_report
pop                         # 23
status_report               # 后进, 先出!

# 注意堆栈指针每次压栈时减,
#+ 每次弹出时加一.

echo
exit 0

# ======================================================= 

# 练习:
# ---------

# 1) 修改"push()"函数,使其调用一次就能够压入多个数据项.
#

# 2) 修改"pop()"函数,使其调用一次就能弹出多个数据项.
#

# 3) 给那些有临界操作的函数增加出错检查. 
#    即是指是否一次完成操作或没有完成操作返回相应的代码,
#  + 没有完成要启动合适的处理动作.
#

# 4) 这个脚本为基础,
#  + 写一个栈实现的四则运算计算器.

################################End Script#########################################
