#!/bin/bash
# t-out.sh
# "syngin seven"的一个很好的提议 (thanks).


TIMELIMIT=4     # 4 seconds
read -n1 -t $TIMELIMIT variable <&1
#                           ^^^ 
# 在这个例子中,对于 Bash 1.x 和 2.x 就需要使用"<&1"
# 但对于 Bash 3.x 就不需要.

echo

if [ -z "$variable" ]   # Is null? 
then
    echo "Timed out, variable still unset." 
else
    echo "variable = $variable" 
fi

exit 0
