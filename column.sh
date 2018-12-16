#!/bin/bash
# 这是"column" man 页中的一个例子, 作者对这个例子做了很小的修改.
#--------------------------------------------------------------
ARGS=2
E_BADARGS=65
a=${1:-}       # 默认参数a为<null>
b=${2:-}       # 默认参数b为<null>
#==============================================================
if [ $# -gt "$ARGS" -a $# -eq 0 ] #检查传递到脚本中的参数的个数
then 
    echo "Usage: `basename $0` [directory]"
    echo "Usage: `basename $0` [-ts] [directory]"
    exit $E_BADARGS
fi              # 默认为按文件名升序排序
#--------------------------------------------------------------
if [ $# -ge 1 ]   # 输入1个以上参数时候
then 
    case $1 in
        -t)
            a="tr" ;;   # 按时间进行升序排序
        -s)
            a="Sr" ;;   # 按文件大小进行升序排序
        "")
            ;;
        *)
            if [ ! -d "$1" ]
            then
                echo "Usage: `basename $0` [directory]"
                echo "Usage: `basename $0` [-ts] [directory]"
                exit $E_BADARGS
            else
                a=;b="$1"
            fi  ;;
    esac    
fi
#-------------------------------------------------------------
if [ $# -eq 2 ]      # 输入2个参数的时候
then
    b="$2"
fi
###############################################################
#---main()-----#
(printf "PERMISSIONS LINKS OWNER GROUP SIZE MONTH DAY HH:MM PROG-NAME\n" \
; ls -l$a $b | sed 1d) | column -t

# 管道中的 "sed 1d" 删除输出的第一行,
#+ 第一行将是 "total N",
#+ 其中 "N" 是 "ls -l" 找到的文件总数.
#+ 使用ls的命令参数对文件进行排序选择

# "column" 中的 -t 选项用来转化为易于打印的表形式. 
exit 0
