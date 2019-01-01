#!/bin/bash
# dev-tcp.sh: 用/dev/tcp 重定向来检查 Internet 连接.

# Troy Engel 编写.
# 已得到作者允许.

TCP_HOST=${1:-www.dns-diy.com}      # 一个已知的 ISP. 
TCP_PORT=80                         # http 的端口是 80 .

# 尝试连接. (有些像 'ping' . . .)
echo "HEAD / HTTP/1.0" >/dev/tcp/${TCP_HOST}/${TCP_PORT}
MYEXIT=$?

: <<EXPLANATION
If bash was compiled with --enable-net-redirections, it has the capability of
using a special character device for both TCP and UDP redirections. These
redirections are used identically as STDIN/STDOUT/STDERR. The device entries
are 30,36 for /dev/tcp:

    mknod /dev/tcp c 30 36 21

>From the bash reference:
/dev/tcp/host/port
    If host is a valid hostname or Internet address, and port is an integer 
port number or service name, Bash attempts to open a TCP connection to the 
corresponding socket.
EXPLANATION


if [ "X$MYEXIT" = "X0" ]; then
    echo "Connection successful. Exit code: $MYEXIT"
else
    echo "Connection unsuccessful. Exit code: $MYEXIT"
fi

exit $MYEXIT 
################################End Script#########################################
