#!/bin/sh

function echo_color() {
    case $1 in
        green)
            echo "\033[32;47m$2\033[0m"
            ;;
        red)
            echo "\033[31;47m$2\033[0m"
            ;;
        *)
            echo "Example: echo_color red string"
    esac
}

echo_color $1 $2
