#!/bin/bash

function echo_color() {
    case $1 in
        green)
            echo -e "\033[1;32;40m$2\033[0m"    # bright green[FG],black[BG]
            ;;
        red)
            echo -e "\033[31;47m$2\033[0m"      # red[FG],white[BG]
            ;;
        *)
            echo "Example: color.sh red string" # others
    esac
}

set +x
clear       # clear screen
while true  # inifinite loop
do
n=0
e=""
    while true
    do
        b=`expr $RANDOM % 8`
        if [ "$b" -ge 2 ] 
        then
            a=`expr $RANDOM % "$b"`
        else 
            continue
        fi
        if [ "$a" -ne 0 ] 
        then 
           a=" " 
        else
            a=`expr $RANDOM % 2`
        fi
        e="$e"$a
        let "n++"
        if [ "$n" -ge 80 ] 
        then
            echo_color green "$e"&&break
        fi
    done
done

