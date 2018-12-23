#!/bin/bash
# fc4upd.sh

# 脚本作者: Frank Wang. 
# 本书作者作了少量修改. 
# 授权在本书中使用.


# 使用 rsync 命令从镜像站点上下载 Fedora 4 的更新. 
# 为了节省空间, 如果有多个版本存在的话,
#+ 只下载最新的包.

# URL=rsync://distro.ibiblio.org/fedora-linux-core/updates/
# URL=rsync://ftp.kddilabs.jp/fedora/core/updates/
# URL=rsync://rsync.planetmirror.com/fedora-linux-core/updates/

DEST=${1:-/var/www/html/fedora/updates/}
LOG=/tmp/repo-update-$(/bin/date +%Y-%m-%d).txt
PID_FILE=/var/run/${0##*/}.pid

E_RETURN=65     # 某些意想不到的错误.


# 一搬 rsync 选项
# -r: 递归下载
# -t: 保存时间
# -v: verbose

OPTS="-rtv --delete-excluded --delete-after --partial" 30

# rsync include 模式
# Leading slash causes absolute path name match.
INCLUDE=(
    "/4/i386/kde-i18n-Chinese*"
#   ^                         ^
# 双引号是必须的, 用来防止 file globbing.
)


# rsync exclude 模式
# 使用 "#" 临时注释掉一些不需要的包.
EXCLUDE=(
    /1
    /2
    /3
    /testing 
    /4/SRPMS 
    /4/ppc 
    /4/x86_64 
    /4/i386/debug
    "/4/i386/kde-i18n-*" 
    "/4/i386/openoffice.org-langpack-*" 
    "/4/i386/*i586.rpm" 
    "/4/i386/GFS-*"
    "/4/i386/cman-*" 
    "/4/i386/dlm-*" 
    "/4/i386/gnbd-*" 
    "/4/i386/kernel-smp*" 
#    "/4/i386/kernel-xen*" 
#    "/4/i386/xen-*"
)


init(){
    # 让管道命令返回可能的 rsync 错误, 比如, 网络延时(stalled network). 
    set -o pipefail

    TMP=${TMPDIR:-/tmp}/${0##*/}.$$     # 保存精炼的下载列表.
    trap "{
        rm -f $TMP 2>/dev/null 
    }" EXIT                             # 删除存在的临时文件.

} 


check_pid () {
# 检查进程是否存在.
    if [ -s "$PID_FILE" ]; then
        echo "PID file exists. Checking ..."
        PID=$(/bin/egrep -o "^[[:digit:]]+" $PID_FILE)
        if /bin/ps --pid $PID &>/dev/null; then
            echo "Process $PID found. ${0##*/} seems to be running!"
            /usr/bin/logger -t ${0##*/} \
                "Process $PID found. ${0##*/} seems to be running!"
            exit $E_RETURN
        fi
        echo "Process $PID not found. Start new process . . ."
    fi
}


# 根据上边的模式,
#+ 设置整个文件的更新范围, 从 root 或 $URL 开始.
set_range () {
    include=
    exclude=
    for p in "${INCLUDE[@]}"; do
        include="$include --include \"$p\""
    done

    for p in "${EXCLUDE[@]}"; do
        exclude="$exclude --exclude \"$p\""
    done
}


# 获得并提炼 rsync 更新列表.
get_list () {
    echo $$ > $PID_FILE || {
        echo "Can't write to pid file $PID_FILE"
        exit $E_RETURN
    }

    echo -n "Retrieving and refining update list . . ." 

    # 获得列表 -- 为了作为单个命令来运行 rsync 需要 'eval'.
    # $3 和 $4 是文件创建的日期和时间.
    # $5 是完整的包名字.
    previous=
    pre_file=
    pre_date=0
    eval /bin/nice /usr/bin/rsync \
        -r $include $exclude $URL | \
        egrep '^dr.x|^-r' | \
        awk '{print $3, $4, $5}' | \
        sort -k3 | \
        { while read line; do
            # 获得这段运行的秒数, 过滤掉不用的包.
            cur_date=$(date -d "$(echo $line | awk '{print $1, $2}')" +%s)
            # echo $cur_date

            # 取得文件名.
            cur_file=$(echo $line | awk '{print $3}') 
            # echo $cur_file
            
            # 如果可能的话, 从文件名中取得 rpm 的包名字. 
            if [[ $cur_file == *rpm ]]; then
                pkg_name=$(echo $cur_file | sed -r -e \ 
                        's/(^([^_-]+[_-])+)[[:digit:]]+\..*[_-].*$/\1/')
            else 
                pkg_name=
            fi
            # echo $pkg_name
                
            if [ -z "$pkg_name" ]; then     # 如果不是一个 rpm 文件, 
                echo $cur_file >> $TMP      #+ 然后添加到下载列表里.
            elif [ "$pkg_name" != "$previous" ]; then   # 发现一个新包.
                echo $pre_file >> $TMP      # 输出最新的文件.
                previous=$pkg_name          # 保存当前状态.
                pre_date=$cur_date 
                pre_file=$cur_file
            elif [ "$cur_date" -gt "$pre_date" ]; then  # 如果是相同的包, 但是更新一些,
                pre_date=$cur_date          #+ 那么就更新最新的.
                pre_file=$cur_file 
            fi
            done
            echo $pre_file >> $TMP          # TMP 现在包含所有 
                                            #+ 提炼过的列表.
            # echo "subshell=$BASH_SUBSHELL"
    }       # 这里的打括号是为了让最后这句"echo $pre_file >> $TMP"
            # 也能与整个循环一起放到同一个子 shell ( 1 )中.

    RET=$?  # 取得管道命令的返回码.

    [ "$RET" -ne 0 ]&&{
        echo "List retrieving failed with code $RET"
        exit $E_RETURN
    }

    echo "done"; echo
}
} 

# 真正的 rsync 的下载部分.
get_file () {

    echo "Downloading..."
    /bin/nice /usr/bin/rsync \
        $OPTS \
        --filter "merge,+/ $TMP" \
        --exclude '*' \
        $URL $DEST  \
        | /usr/bin/tee $LOG

    RET=$?
    
        # --filter merge,+/ is crucial for the intention.
        # +modifier means include and / means absolute path.
        # Then sorted list in $TMP will contain ascending dir name and
        #+ prevent the following --exclude '*' from "shortcutting the circuit."

    echo "Done"

    rm -f $PID_FILE 2>/dev/null 

    return $RET
}

# -------
# Main
init
check_pid
set_range
get_list
get_file
RET=$?
# -------

if [ "$RET" -eq 0 ]; then
    /usr/bin/logger -t ${0##*/} "Fedora update mirrored successfully."
else
    /usr/bin/logger -t ${0##*/} "Fedora update mirrored with failure code: $RET"
fi

exit $RET
