#!/bin/bash
# break-levels.sh: 退出循环.

# "break N" 退出 N 层循环.
for outerloop in 1 2 3 4 5
do
    echo "Group $outerloop:  \c"
    # -------------------------------------------------------- 
    for innerloop in 1 2 3 4 5
    do
        echo "$innerloop  \c"
        if [ "$innerloop" -eq 3 ] 
        then
            break   # 试试 break 2 来看看发生什么.
                    # (内部循环和外部循环都被退出了.)
        fi 
    done
    # -------------------------------------------------------- 
    echo
    
done

echo
exit 0
