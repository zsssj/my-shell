#!/bin/bash
# file-integrity.sh: 检查一个给定目录下的文件
#                    是否被改动了.

E_DIR_NOMATCH=70
E_BAD_DBFILE=71

dbfile=File_record.md5
# 存储记录的文件名 (数据库文件).


set_up_database () 
{
    echo ""$directory"" > "$dbfile"
    # 把目录名写到文件的第一行.
    md5 ""$directory"/*" >> "$dbfile"
    # 在文件中附上 md5 checksums 和 filenames.
}

check_database ()
{
    local n=0
    local filename 
    local checksum

    # ------------------------------------------- # 
    # 这个文件检查其实是不必要的,
    #+ 但是能安全一些.

    if [ ! -r "$dbfile" ] 
    then
        echo "Unable to read checksum database file!"
        exit $E_BAD_DBFILE 
    fi
    # ------------------------------------------- #

    while read record[n] 
    do

        directory_checked="${record[0]}"
        if [ "$directory_checked" != "$directory" ] 
        then
            echo "Directories do not match up!" # 换个目录试一下.
            exit $E_DIR_NOMATCH
        fi

        if [ "$n" -gt 0 ] # 不是目录名. 
        then
            filename[n]=$( echo ${record[$n]} | awk -F'[()]' '{ print $2 }' ) 
            # md5sum 向后写记录,
            #+ 先写 checksum, 然后写 filename.
            checksum[n]=$( md5 "${filename[n]}" )
            
            if [ "${record[n]}" = "${checksum[n]}" ] 
            then
                echo "${filename[n]} unchanged."
            elif [ "`basename ${filename[n]}`" != "$dbfile" ] 
                # 跳过 checksum 数据库文件,
                #+ 因为在每次调用脚本它都会被修改. 
            # ---
            # 这不幸的意味着当我们在 $PWD 中运行这个脚本
            #+ 时, 修改这个 checksum 数 
            #+ 据库文件将不会被检测出来. 
            # 练习: 修复这个问题.
                then
                    echo "${filename[n]} : CHECKSUM ERROR!"
                # 因为最后的检查, 文件已经被修改. 
            fi
        fi






        let "n+=1" 
    done <"$dbfile"         # 从 checksum 数据库文件中读.

}

# =================================================== # 
# main ()

if [ -z "$1" ]
then 
    directory="$PWD"        # 如果没制定参数,
else                        #+ 那么就使用当前的工作目录.
    directory="$1"
fi

clear                       # 清屏.
echo " Running file integrity check on $directory" 
echo

# ------------------------------------------------------------------ # 
if [ ! -r "$dbfile" ] # 是否需要建立数据库文件?
then
    echo "Setting up database file, \""$directory"/"$dbfile"\"."; echo
    set_up_database 
fi
# ------------------------------------------------------------------ # 
check_database              # 调用主要处理函数.

echo 

# 你可能想把这个脚本的输出重定向到文件中,
#+ 尤其在这个目录中有很多文件的时候.

exit 0

# 如果要对数量非常多的文件做完整性检查,
#+ 可以考虑一下 "Tripwire" 包,
#+ http://sourceforge.net/projects/tripwire/.

