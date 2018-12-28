#! /bin/sh
## Duplicate DaveG's ident-scan thingie using netcat. Oooh, he'll be p*ssed. 
## Args: target port [port port port ...]
## Hose stdout _and_ stderr together.
##
## 优点: runs slower than ident-scan, giving remote inetd less cause
##+ for alarm, and only hits the few known daemon ports you specify.
## 缺点: requires numeric-only port args, the output sleazitude,
##+ and won't work for r-services when coming from high source ports.
# 脚本作者: Hobbit <hobbit@avian.org>
# 授权使用在本书中.

# ---------------------------------------------------
E_BADARGS=65    # 至少需要两个参数. 
TWO_WINKS=2
THREE_WINKS=3
IDPORT=113      # Authentication "tap ident" port.
RAND1=999
RAND2=31337
TIMEOUT0=9      # 需要睡多长时间.
TIMEOUT1=8
TIMEOUT2=4
# ---------------------------------------------------

case "${2}" in
"" ) echo "Need HOST and at least one PORT." ; exit $E_BADARGS ;;
esac

# Ping 'em once and see if they *are* running identd.
nc -z -w $TIMEOUT0 "$1" $IDPORT || { echo "Oops, $1 isn't running identd." ; exit 0 ; }
# -z scans for listening daemons.
# -w $TIMEOUT = How long to try to connect.

# Generate a randomish base port.
RP=`expr $$ % $RAND1 + $RAND2`

TRG="$1"
shift

while test "$1" ; do
    nc -v -w $TIMEOUT1 -p ${RP} "$TRG" ${1}</dev/null>/dev/null&
    PROC=$!
    sleep $THREE_WINKS
    echo "${1},${RP}" | nc -w $TIMEOUT2 -r "$TRG" $IDPORT 2>&1 
    sleep $TWO_WINKS

# 这个脚本看起来是不是一个瘸腿脚本, 或者其它更差的什么东西?

# ABS Guide 作者注释: "并不是真的那么差,
#+                              事实上相当清楚."
    kill -HUP $PROC
    RP=`expr ${RP} + 1`
    shift
done

exit $?

# 注意事项：
# --------

# 尝试注释一下第30行的程序，并且使用"localhost.localdomain 25"
#+ 作为参数来运行这个脚本.

# For more of Hobbit's 'nc' example scripts,
#+ look in the documentation:
#+ the /usr/share/doc/nc-X.XX/scripts directory.
