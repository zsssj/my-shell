#!/bin/bash 
# 脚本开头以"#!/bin/bash -r"来调用
#+ 会使整个脚本在受限模式下运行.

echo 
echo "Changing directory."
cd /usr/local
echo "Now in `pwd`"
echo "Coming back home."
cd
echo "Now in `pwd`"
echo

# 不受限的模式下,所有操作都能正常成功. 
set -r
# set --restricted 也能起相同的作用.
echo "==> Now in restricted mode. <=="

echo
echo

echo "Attempting directory change in restricted mode."
cd ..
echo "Still in `pwd`"

echo
echo

echo "\$SHELL = $SHELL"
echo "Attempting to change shell in restricted mode."
SHELL="/bin/ash"
echo
echo "\$SHELL= $SHELL"

echo
echo

echo "Attempting to redirect output in restricted mode."
ls -l /usr/bin > bin.files
ls -l bin.files # Try to list attempted file creation effort.

echo

exit 0
