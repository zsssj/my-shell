#!/bin/bash 2
var1=abcd-1234-defg
echo "var= $var1"

t=${var1#*-}
echo "var(with everything, up to and including first - stripped out) = $t"
# t=${var1#*-} 在这个例子中作用是一样的,
#+ 因为 # 匹配这个最近的字符串,
#+ 并且 * 匹配前边的任何字符串,包括一个空字符.
# (Thanks, Stephane Chazelas, for pointing this out.)

t=${var1##*-*}
echo "If varcontains a \"-\", returns empty string...  var= $t"


t=${var1%*-*}
echo "var(with everything from the last - on stripped out) = $t" 

echo

# -------------------------------------------
path_name=/home/bozo/ideas/thoughts.for.today
# -------------------------------------------
echo "path_name = $path_name"
t=${path_name##/*/}
echo "path_name, stripped of prefixes = $t"
# 在这个特定的例子中,与 t=`basename $path_name` 的作用一致.
# t=${path_name%/}; t=${t##*/} 是一个更一般的解决办法,
#+ 但有时还是不行.
# 如果 $path_name 以一个新行结束, 那么`basename $path_name` 将不能工作,
#+ 但是上边这个表达式可以.
# (Thanks, S.C.)

t=${path_name%/*.*}
# 与 t=`dirname $path_name` 效果相同.
echo "path_name, stripped of suffixes = $t"
# 在某些情况下将失效,比如 "../", "/foo////", # "foo/", "/".
# 删除后缀,尤其是在 basename 没有后缀的时候,
#+ 但是 dirname 还是会使问题复杂化.
# (Thanks, S.C.)

echo

t=${path_name:11}
echo "$path_name, with first chars stripped off = $t"
t=${path_name:11:5}
echo "$path_name, with first chars stripped off, length = $t"

echo

t=${path_name/bozo/clown}
echo "$path_name with \"bozo\" replaced by \"clown\"=$t"
t=${path_name/today/}
echo "$path_name with \"today\" deleted = $t"
t=${path_name//o/O}
echo "$path_name with all o's capitalized = $t"
t=${path_name//o/}
echo "$path_name with all o's deleted = $t"

exit 0
