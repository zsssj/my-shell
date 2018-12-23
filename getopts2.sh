#!/bin/bash

# The following code fragment shows how one might process the arguments for a
# command that can take the options -a and -b, and the option -o, which requires
# an argument.

args=`getopt abo: $*`
# you should not use `getopt abo: "$@"` since that would parse
# the arguments differently from what the set command below does.
if [ $? != 0 ]
then
    echo 'Usage: ...'
    exit 2
fi
set -- $args
# you cannot use the set command with a backquoted getopt directly,
# since the exit code from getopt would be shadowed by those of set,
# which is zero by definition.
for i
do
    case "$i"
    in
        -a|-b)
            echo flag $i set; sflags="${i#-}$sflags";
            shift;;
        -o)
            echo oarg is "'"$2"'"; oarg="$2"; shift;
            shift;;
        --)
            shift; break;;
    esac
done
echo single-char flags: "'"$sflags"'"
echo oarg is "'"$oarg"'"

#--------------------------------------------------------------
# This code will accept any of the followiing as equivalent:
#
#       cmd -aoarg file file
#       cmd -a -o arg file file
#       cmd -oarg -a file file
#       cmd -a -oarg -- file file
#--------------------------------------------------------------

exit 0
########################END SCRIPT#############################

