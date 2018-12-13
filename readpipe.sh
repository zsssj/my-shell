#!/bin/sh
# readpipe.sh
# 这个例子是 Bjon Eriksson 捐献的.

last="(null)"
cat $0 |
while read line
do
    echo "{$line}" 
    last=$line
done
printf "\nAll done, last:$last\n"

exit 0
