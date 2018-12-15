#!/bin/bash
# ex40.sh (burn-cd.sh)
# 自动刻录 CDR 的脚本.

SPEED=2     # 如果你的硬件支持的话,你可以选用更高的速度.
IMAGEFILE=cdimage.iso
CONTENTSFILE=contents
DEVICE=cdrom
# DEVICE="0,0"      为了使用老版本的 CDR
DEFAULTDIR=/Users/Nick/MyPrj/C-language     # 这是包含需要被刻录内容的目录.
                    # 必须保证目录存在.
                    # 小练习: 测试一下目录是否存在. 

# Uses Joerg Schilling's "cdrecord" package:
# 使用 Joerg Schilling 的 "cdrecord"包:
# http://www.fokus.fhg.de/usr/schilling/cdrecord.html

# 如果一般用户调用这个脚本的话,可能需要 root 身份
#+ chmod u+s /usr/bin/cdrecord
# 当然, 这会产生安全漏洞, 虽然这是一个比较小的安全漏洞.

if [ -z "$1" ]
then
    IMAGE_DIRECTORY=$DEFAULTDIR
    # 如果命令行没指定的话, 那么这个就是默认目录.
else
    IMAGE_DIRECTORY=$1
fi 

# 创建一个内容列表文件.
ls -lRF $IMAGE_DIRECTORY > $IMAGE_DIRECTORY/$CONTENTSFILE
# "l" 选项将给出一个"长"文件列表.
# "R" 选项将使这个列表递归.
# "F" 选项将标记出文件类型 (比如: 目录是以 /结尾, 而可执行文件以 *结尾).
echo "Creating table of contents."

# 在烧录到 CDR 之前创建一个镜像文件.
mkisofs -r -o $IMAGEFILE $IMAGE_DIRECTORY
echo "Creating ISO9660 file system image ($IMAGEFILE)."

# 烧录 CDR.
echo "Burning the disk."
echo "Please be patient, this will take a while."
cdrecord -v -isosize speed=$SPEED dev=$DEVICE $IMAGEFILE

exit $? 
