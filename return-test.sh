#!/bin/bash
# return-test.sh

# 一个函数最大可能返回的值是 255. 

return_test ()      # 无论传给函数什么都返回它.
{
    return $1
}

return_test 27      # o.k.
echo $?             # 返回 27.

return_test 255     # 仍然 o.k. 
echo $?             # 返回 255.

return_test 257     # 错误!
echo $?             # 返回 1 (返回代码指示错误).

# ======================================================
return_test -151896
echo $?

# 2.05b 版本之前的 Bash 是允许
#+ 超大负整数作为返回值的.
# 能够返回这个非常大的负数么? # 会返回-151896?
# 不! 它将返回 168.
# 但是比它更新一点的版本修正了这个漏洞.
# 这将破坏比较老的脚本.
# 慎用!
# ====================================================== 
exit 0

# ====================================================== 
Return_Val= # 全局变量, 用来保存函数中需要返回的超大整数. 

alt_return_test ()
{
    fvar=$1
    Return_Val=$fvar
    return # Returns 0 (success). 
}

alt_return_test 1                   
echo $?                             # 0
echo "return value = $Return_Val"   # 1

alt_return_test 256
echo "return value = $Return_Val"   # 256

alt_return_test 257
echo "return value = $Return_Val"   # 257

alt_return_test 25701
echo "return value = $Return_Val"   #25701

# 更优雅的方法是让函数echo出它的返回值，
# 输出到stdout上，然后再通过“命令替换”
# 的手段来捕获它.
# 参见 max2.sh
 
# ====================================================== 
