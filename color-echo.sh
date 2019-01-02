#!/bin/bash
# color-echo.sh: 用彩色来显示文本.

# 依照需要修改这个脚本.
# 这比手写彩色的代码更容易一些.

black='\033[30;47m'
red='\033[31;47m'
green='\033[32;47m'
yellow='\033[33;47m'
blue='\033[34;47m'
magenta='\033[35;47m' 
cyan='\033[36;47m' 
white='\033[37;47m'


alias Reset="tput sgr0"     # 把文本属性重设回原来没有清屏前的
                            #


cecho ()                    # Color-echo.
                            # 参数 $1 = 要显示的信息 
                            # 参数 $2 = 颜色
{
local default_msg="No message passed."
                            # 不是非要一个本地变量. 

message=${1:-$default_msg}  # 默认的信息.
color=${2:-$black}          # 如果没有指定,默认使用黑色.

    echo -e "$color" 
    echo -e "$message\033[0m" 
    
#    Reset                   # 重设文本属性.

    tput init
    return 
}


# 现在,让我们试试.
# ----------------------------------------------------
cecho "Feeling blue..." $blue
cecho "Magenta looks more like purple." $magenta 
cecho "Green with envy." $green
cecho "Seeing red?" $red
cecho "Cyan, more familiarly known as aqua." $cyan 
cecho "No color passed (defaults to black)."
        # 缺失 $color (色彩)参数.
cecho "\"Empty\" color passed (defaults to black)." ""
        # 空的 $color (色彩)参数.
cecho
        # $message(信息) 和 $color (色彩)参数都缺失. "" ""
cecho "" ""
        # 空的 $message (信息)和 $color (色彩)参数.
# ----------------------------------------------------

echo 

exit 0 
# 练习:
# ---------
# 1) 为'cecho ()'函数增加粗体的效果.
# 2) 增加可选的彩色背景.
################################End Script#########################################
