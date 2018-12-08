#!/bin/bash

remoteNet=0

# ---------------------------------------------
# 这部分内容可能来自于单独的文件.
isdnMyProviderRemoteNet=172.16.0.100
isdnYourProviderRemoteNet=10.0.0.10
isdnOnlineService="MyProvider"
# ---------------------------------------------

# remoteNet=$(eval "echo \$$(echo isdn${isdnOnlineService}RemoteNet)")
remoteNet=$(eval "echo \$$(echo isdnMyProviderRemoteNet)")
# remoteNet=$(eval "echo \$isdnMyProviderRemoteNet")
# remoteNet=$(eval "echo $isdnMyProviderRemoteNet")

echo "$remoteNet" # 172.16.0.100 18

# exit 0

#=================================================================
#
# 同时，它甚至能更好。
# 
#  考虑下边的脚本，给出一个变量getSparc,
#+ 但是没给出变量 getIa64:

chkMirrorArchs () {
    arch="$1";
    if [ "$(eval "echo \${$(echo get$(echo -ne $arch |
            sed 's/^\(.\).*/\1/g' | tr 'a-z' 'A-Z'; echo $arch |
            sed 's/^.\(.*\)/\1/g')):-false}")" = true ]
    then
        return 0;
    else
        return 1;
    fi;
}

getSparc="true"
unset getIa64
chkMirrorArchs sparc
echo $?     # 0
            # True

chkMirrorArchs Ia64
echo $?     # 1
            # False

# 注意:
# -----<rojy bug>
# Even the to-be-substituted variable name part is built explicitly.
# The parameters to the chkMirrorArchs calls are all lower case.
# The variable name is composed of two parts: "get" and "Sparc" . . .
