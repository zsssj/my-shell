#!/bin/bash
# 创建一个交换文件.

ROOT_UID=0          # Root 用户的 $UID 是 0.
E_WRONG_USER=65     # 不是 root?

FILE=~/swap
BLOCKSIZE=1024
MINBLOCKS=40
SUCCESS=0 


# 这个脚本必须用 root 来运行.
if [ "$UID" -ne "$ROOT_UID" ]
then
    echo; echo "You must be root to run this script."; echo
    exit $E_WRONG_USER
fi


blocks=${1:-$MINBLOCKS}     # 如果命令行没有指定, 
                            #+ 则设置为默认的 40 块.
#上面这句等同如:
# -------------------------------------------------- 
# if [ -n "$1" ]
# then
#    blocks=$1 
# else
#    blocks=$MINBLOCKS
# fi
# --------------------------------------------------

if [ "$blocks" -lt $MINBLOCKS ]
then
    blocks=$MINBLOCKS       # 最少要有40个块长.
fi

echo "Creating swap file of size $blocks blocks (KB)."
dd if=/dev/zero of=$FILE bs=$BLOCKSIZE count=$blocks    # 把零写入文件.

# ============================================================
# mac下没有以下两个命令---fail
mkswap $FILE $blocks    # 将此文件建为交换文件(或称交换分区).
swapon $FILE            # 激活交换文件.
# ============================================================
echo "Swap file created and activated."

exit $SUCCESS 
################################End Script#########################################
