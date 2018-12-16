#!/bin/bash
# test.sh

a=$(expr 3 + 1)
a=$(expr \( $a \) + 1)
echo "a + 1 = $a"

a=1234zipper4321
#export a

echo "The string being operated upon is \"$a\"."

b=$(expr \( "X$a" : ".*" \) - 1)
echo $b 

c=$(expr length " $a")
echo "Length of \"$a\" is $c."

exit 0
