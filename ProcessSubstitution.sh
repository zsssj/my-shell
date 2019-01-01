cat <(ls -l)
# 等同于 ls-l|cat

sort -k 9 <(ls -l /bin) <(ls -l /usr/bin) <(ls -l /usr/X11R6/bin)
# 列出系统中 3 个主要的'bin'目录的所有文件,并且按文件名排序.
# 注意是三个明显不同的命令输出回馈给'sort'.


diff <(command1) <(command2) # 给出两个命令输出的不同之处.

tar cf >(bzip2 -c > file.tar.bz2) $directory_name
# 调用"tar cf /dev/fd/?? $directory_name",和"bzip2 -c > file.tar.bz2".
#
# 因为/dev/fd/<n>的系统属性,
# 所以两个命令之间的管道不必是命名的. 
#
# 这种效果可以模仿出来.
#
bzip2 -c < pipe > file.tar.bz2&
tar cf pipe $directory_name
rm pipe
#       或者
exec 3>&1
tar cf /dev/fd/4 $directory_name 4>&1 >&3 3>&- | bzip2 -c > file.tar.bz2 3>&-
exec 3>&-


# Thanks, St`phane Chazelas
