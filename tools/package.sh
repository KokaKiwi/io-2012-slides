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

# ===== VARIABLES =====

LESSC="lessc --yui-compress"

# ===== MAIN =====

rm -rf build
mkdir build

cp -r images js tools theme template.html slide_config.template.js build

slides_file=$1

cp $slides_file build

cat > build/build.sh <<EOF
#!/bin/sh

tools/render.py -o index.html -t template.html `basename "$slides_file"`
mkdir -p theme/gen
$LESSC theme/less/default.less > theme/gen/default.css
$LESSC theme/less/phone.less > theme/gen/phone.css
EOF
chmod +x build/build.sh

cd build
tar -czf ../build.tar.gz *
cd ..

rm -rf build
