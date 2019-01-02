#!/bin/bash
# assert.sh

assert ()       # 如果条件测试失败,
{               #+ 则打印错误信息并退出脚本.
    E_PARAM_ERR=98 
    E_ASSERT_FAILED=99

    
    if [ -z "$2" ]              # 没有传递足够的参数.
    then
        return $E_PARAM_ERR     # 什么也不做就返回.
    fi 
    
    lineno=$2

    if [ ! $1 ] 
    then
        echo "Assertion failed: \"$1\""
        echo "File \"$0\", line $lineno" 
        exit $E_ASSERT_FAILED
    # else
    # return 
    # 返回并继续执行脚本后面的代码.
    fi
}


a=5
b=4
condition="$a -lt $b"   # 会错误信息并从脚本退出.
                        # 把这个“条件”放在某个地方, 
                        #+ 然后看看有什么现象.

assert "$condition" $LINENO
# 脚本以下的代码只有当"assert"成功时才会继续执行.

# 其他的命令.
# ...
echo "This statement echoes only if the \"assert\" does not fail."
# ...
# 余下的其他命令.

exit 0 
################################End Script#########################################
