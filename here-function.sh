#!/bin/bash
# here-function.sh

GetPersonalData () 
{
    read firstname 
    read lastname 
    read address 
    read city
    read state
    read zipcode
} # 这个函数无疑的看起来就一个交互函数, 但是...

# 给上边的函数提供输入. 
GetPersonalData <<RECORD001 
Bozo
Bozeman
Nondescript Dr.
Baltimore
MD
21226
RECORD001

#=================================================================
:>wzj.log
echo -e "Nick\nKuta\n5388 Longwu Road.\nShanghai\nSH\n200241\n">wzj.log 
a=`cat wzj.log`
GetPersonalData <<RECORD002
$a
RECORD002
rm wzj.log
#=================================================================
echo
echo "$firstname $lastname"
echo "$address"
echo "$city, $state $zipcode"
echo

exit 0
#==================================================================
: <<TESTVARIABLES
${HOSTNAME?}${USER?}${MAIL?}    # 如果其中一个变量没被设置，那么就打印错误信息
TESTVARIABLES
#==================================================================
