#!/bin/bash
# pb.sh: 电话本(phone book)

# 由 Rick Boivie 编写,已得到使用许可. 
# 由 ABS 文档作者修改.

MINARGS=1 # 脚本需要至少一个参数. 
DATAFILE=./phonebook
                # 在当前目录下名为"phonebook"的数据文件必须存在
                #
PROGNAME=$0
E_NOARGS=70     # 没有参数的错误值.

if [ $# -lt $MINARGS ]; then
    echo "Usage: "$PROGNAME" data" 
    exit $E_NOARGS
fi


if [ $# -eq $MINARGS ]; then 
    grep $1 "$DATAFILE"
    # 如果$DATAFILE 文件不存在,'grep' 会打印一个错误信息. 
else
    ( shift; "$PROGNAME" $@ ) | grep $1     
    # 脚本递归调用本身.
fi

exit 0      # 脚本在这儿退出.
            # 因此 Therefore, 从这行开始可以写没有#开头的的注释行
            #

# ------------------------------------------------------------------------
"phonebook"文件的例子:

John Doe    1555 Main St., Baltimore, MD 21228          (410) 222-3333 
Mary Moe    9899 Jones Blvd., Warren, NH 03787          (603) 898-3232
Richard Roe 856 E. 7th St., New York, NY 10009          (212) 333-4567 
Sam Roe     956 E. 8th St., New York, NY 10009          (212) 444-5678
Zoe Zenobia 4481 N. Baker St., San Francisco, SF 94338  (415) 501-1631
# ------------------------------------------------------------------------

$bash pb.sh Roe
Richard Roe 856 E. 7th St., New York, NY 10009          (212) 333-4567 
Sam Roe 956 E. 8th St., New York, NY 10009              (212) 444-5678

$bash pb.sh Roe Sam
Sam Roe 956 E. 8th St., New York, NY 10009              (212) 444-5678

# 当超过一个参数传给这个脚本时,
#+ 它只打印包含所有参数的行.
################################End Script#########################################
