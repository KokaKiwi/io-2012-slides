#!/bin/sh

# ===== UTILS =====

function prompt() {
    read -p "$1 [$2]: " result
    if [ "x$result" = "x" ]; then
        echo "$2"
    fi
    echo "$result"
}

function prompt_dir() {
    dir=$(prompt "$1" "$2")
    eval dir=$dir
    echo "$dir"
}

function ask() {
    QUESTION="$1"
    DEFAULT="$2"

    if [[ "x$DEFAULT" == "x" ]]; then
        DEFAULT="yes"
    fi

    case $DEFAULT in
        [Yy]|[Yy][Ee][Ss] ) CHOICE_MSG="[Y/n]";;
        [Nn]|[Nn][Oo] ) CHOICE_MSG="[y/N]";;
        * ) CHOICE_MSG="[Y/n]";;
    esac

    read -p "$QUESTION $CHOICE_MSG: " result
    case $result in
        [Yy]|[Yy][Ee][Ss] ) echo "yes"; break;;
        [Nn]|[Nn][Oo] ) echo "no"; break;;
        * ) echo "$DEFAULT"; break;;
    esac
}

# ===== MAIN =====

slides_file=$1
dest_dir=$2

tools/package.sh "$slides_file"
cp build.tar.gz "$dest_dir"
cd "$dest_dir"
tar -zxf build.tar.gz
./build.sh
cd ../template
