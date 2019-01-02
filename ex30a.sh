#!/bin/bash
# ex30a.sh: ex30.sh 的"彩色" 版本.
#           没有加工处理的地址资料库


clear       # 清除屏幕.

echo -n "           "
echo -e "\033[37;44m""\033[1mContact List\033[0m"
                                        # 白色为前景色,蓝色为背景色
echo; echo
echo -e "\033[1mChoose one of the following persons:\033[0m"
                                        # 粗体
tput sgr0
echo "(Enter only the first letter of name.)"
echo
echo -en "\033[47;34m""\033[1mE\033[0m"   # 蓝色
tput sgr0                               # 把色彩设置为"常规"
echo "vans, Roland"                     # "[E]vans, Roland" 
echo -en "\033[47;35m""\033[1mJ\033[0m"   # 红紫色
tput sgr0
echo "ones, Mildred"
echo -en "\033[47;32m""\033[1mS\033[0m"   # 绿色
tput sgr0
echo "mith, Julie"
echo -en "\033[47;31m""\033[1mZ\033[0m"   # 红色
tput sgr0
echo "ane, Morris"
echo

read person

case "$person" in
# 注意变量被引起来了.

    "E"|"e")
    # 接受大小写的输入.
    echo
    echo "Roland Evans"
    echo "4321 Floppy Dr." 
    echo "Hardscrabble, CO 80753" 
    echo "(303) 734-9874"
    echo "(303) 734-9892 fax" 
    echo "revans@zzy.net"
    echo "Business partner & old friend"
    ;;

    "J"|"j")
    echo
    echo "Mildred Jones"
    echo "249 E. 7th St., Apt. 19" 
    echo "New York, NY 10009" 
    echo "(212) 533-2814" 
    echo "(212) 533-9972 fax" 
    echo "milliej@loisaida.com" 
    echo "Girlfriend"
    echo "Birthday: Feb. 11"
    ;;

# 稍后为 Smith 和 Zane 增加信息. 
    *)
    # 默认选项 Default option.
    # 空的输入(直接按了回车) 也会匹配这儿.
    echo
    echo "Not yet in database."
    ;;

esac

tput sgr0               # 把色彩重设为"常规".

echo

exit 0 
################################End Script#########################################

