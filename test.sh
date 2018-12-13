#!/bin/bash 

a1=11
a2=22
a3=33

for i in `seq 3`
do
    echo $i #1 2 3
    echo ${!"a$i"}    
#    eval "echo \$$(echo a${i})"
done

exit 0

