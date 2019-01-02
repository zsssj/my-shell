#!/bin/bash

#************************************************# 
#                       xyz.sh                   #
#               written by Bozo Bozeman          #
#                   July 05, 2001                # 
#                                                #
#                     清除项目文件.              #
#************************************************# 

E_BADDIR=65                     # 没有那样的目录.
projectdir=/home/bozo/projects  # 要清除的目录.

# --------------------------------------------------------- # 
# cleanup_pfiles ()
# 删除指定目录里的所有文件.
# 参数: $target_directory
# 返回: 成功返回 0 , 失败返回$E_BADDIR 值.
# --------------------------------------------------------- # 
cleanup_pfiles ()
{
    if [ ! -d "$1" ]    # 测试目标目录是否存在. 
    then
        echo "$1 is not a directory."
        return $E_BADDIR 
    fi

    rm -f "$1"/*
    return 0    # 成功. 
}

cleanup_pfiles $projectdir

exit 0
#################################################################
fl=`ls -al $dirname`            # 含义含糊. 
file_listing=`ls -al $dirname`  # 更好的名字.


MAXVAL=10                       # 同一个脚本所有程序代码使用脚本常量.
while [ "$index" -le "$MAXVAL" ]
...

E_NOTFOUND=75                   # 把错误代码的代表的变量名大写 U, 
                                # +并以"E_"开头.
if [ ! -e "$filename" ]
then
    echo "File $filename not found."
    exit $E_NOTFOUND 
fi


MAIL_DIRECTORY=/var/spool/mail/bozo     # 环境变量名用大写.
export MAIL_DIRECTORY


GetAnswer ()                    # 函数名用适当的大小写混合组成.
{
    prompt=$1 
    echo -n $prompt 
    read answer 
    return $answer
}
GetAnswer "What is your favorite number? " 
favorite_number=$?
echo $favorite_number


_uservariable=23                # 语法允许, 但不推荐. 
# 用户定义的变量最好不要用下划线开头.
# 把这个留给系统变量使用更好.

# ===============================================================
# --选项参考---*/
-a      All: Return all information (including hidden file info). 
-b      Brief: Short version, usually for other scripts.
-c      Copy, concatenate, etc.
-d      Daily: Use information from the whole day, and not merely
        information for a specific instance/user.
-e      Extended/Elaborate: (often does not include hidden file info).
-h      Help: Verbose usage w/descs, aux info, discussion, help.
        See also -V.
-l      Log output of script.
-m      Manual: Launch man-page for base command.
-n      Numbers: Numerical data only.
-r      Recursive: All files in a directory (and/or all sub-dirs). 
-s      Setup & File Maintenance: Config files for this script.
-u      Usage: List of invocation flags for the script.
-v      Verbose: Human readable output, more or less formatted. 
-V      Version / License / Copy(right|left) / Contribs (email too).
# ===============================================================
