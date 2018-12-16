#!/bin/bash

function echo_color() {
    case $1 in
        green)
            echo -e "\033[32;47m$2\033[0m"
            ;;
        red)
            echo -e "\033[31;47m$2\033[0m"
            ;;
        *)
            echo "Example: color.sh red string"
    esac
}

echo_color $1 $2
