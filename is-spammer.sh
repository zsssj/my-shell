#! /bin/bash
# is-spammer.sh: 鉴别一个垃圾邮件域

# $Id: is-spammer, v 1.4 2004/09/01 19:37:52 mszick Exp $
# 上边这行是 RCS ID 信息.
#
# 这是附件中捐献脚本 is_spammer.bash
#+ 的一个简单版本.

# is-spammer <domain.name> 

# 使用外部程序: 'dig'
# 测试版本: 9.2.4rc5

# 使用函数.
# 使用 IFS 来分析分配在数组中的字符串. 
# 检查 e-mail 黑名单.

# 使用来自文本体中的 domain.name:
# http://www.good_stuff.spammer.biz/just_ignore_everything_else
#                       ^^^^^^^^^^^ 
# 或者使用来自任意 e-mail 地址的 domain.name:
# Really_Good_Offer@spammer.biz

# 并将其作为这个脚本的唯一参数.
#(另: 你的 Inet 连接应该保证连接)
#
# 这样, 在上边两个实例中调用这个脚本:
#       is-spammer.sh spammer.biz 

# Whitespace == :Space:Tab:Line Feed:Carriage Return:
WSP_IFS=$'\x20'$'\x09'$'\x0A'$'\x0D'

# No Whitespace == Line Feed:Carriage Return
No_WSP=$'\x0A'$'\x0D'

# 域分隔符为点分 10 进制 ip 地址
ADR_IFS=${No_WSP}'.'

# 取得 dns 文本资源记录.
# get_txt <error_code> <list_query>
get_txt() {

    # 分析在"."中分配的 $1.
    local -a dns
    IFS=$ADR_IFS
    dns=( $1 )
    IFS=$WSP_IFS
    if [ "${dns[0]}" == '127' ]
    then
        # 查看此处是否有原因.
        echo $(dig +short $2 -t txt)
    fi
}

# 取得 dns 地址资源记录.
# chk_adr <rev_dns> <list_server>
chk_adr() {
    local reply
    local server
    local reason

    server=${1}${2}
    reply=$( dig +short ${server} )

    # 假设应答可能是一个错误码 . . .
    if [ ${#reply} -gt 6 ]
    then
        reason=$(get_txt ${reply} ${server} )
        reason=${reason:-${reply}}
    fi

    echo ${reason:-' not blacklisted.'}
}

# 需要从名字中取得 IP 地址.
echo 'Get address of: '$1
ip_adr=$(dig +short $1)
dns_reply=${ip_adr:-' no answer '}
echo ' Found address: '${dns_reply}

# 一个可用的应答至少是 4 个数字加上 3 个点.
if [ ${#ip_adr} -gt 6 ]
then
    echo
    declare query

    # 分析点中的分配.
    declare -a dns
    IFS=$ADR_IFS
    dns=( ${ip_adr} )
    IFS=$WSP_IFS

    # Reorder octets into dns query order.
    rev_dns="${dns[3]}"'.'"${dns[2]}"'.'"${dns[1]}"'.'"${dns[0]}"'.'

# 参见: http://www.spamhaus.org (Conservative, well maintained)
    echo -n 'spamhaus.org says: '
    echo $(chk_adr ${rev_dns} 'sbl-xbl.spamhaus.org')

# 参见: http://ordb.org (Open mail relays)
    echo -n ' ordb.org says: '
    echo $(chk_adr ${rev_dns} 'relays.ordb.org')

# 参见: http://www.spamcop.net/ (你可以在这里报告 spammer)
    echo -n ' spamcop.net says: '
    echo $(chk_adr ${rev_dns} 'bl.spamcop.net')

### 其他的黑名单操作 ###

# 参见: http://cbl.abuseat.org.
    echo -n ' abuseat.org says: '
    echo $(chk_adr ${rev_dns} 'cbl.abuseat.org') 114

# 参见: http://dsbl.org/usage (Various mail relays) 116 echo

    echo
    echo 'Distributed Server Listings'
    echo -n ' list.dsbl.org says: '
    echo $(chk_adr ${rev_dns} 'list.dsbl.org')

    echo -n ' multihop.dsbl.org says: '
    echo $(chk_adr ${rev_dns} 'multihop.dsbl.org')

    echo -n 'unconfirmed.dsbl.org says: '
    echo $(chk_adr ${rev_dns} 'unconfirmed.dsbl.org')

else
    echo
    echo 'Could not use that address.'
fi

exit 0
# 练习: 
# -----
# 1) 检查脚本的参数, 
#    并且如果必要的话使用合适的错误消息退出.

# 2) 检查调用这个脚本的时候是否在线, 
#    并且如果必要的话使用合适的错误消息退出.

# 3) Substitute generic variables for "hard-coded" BHL domains. 

# 4) 通过对 'dig' 命令使用 "+time=" 选项
#    来给这个脚本设置一个暂停. 
