#!/bin/bash

set -x

var1=$(echo "scale=4;3.44/5" |bc )
echo $var1

echo oldboy{1..3}.txt
