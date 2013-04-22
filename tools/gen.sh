#!/bin/sh

LESSC="lessc --yui-compress"

build_file="$1"
slides_file="$2"

cat > $build_file <<EOF
#!/bin/sh

tools/render.py -o index.html -t template.html `basename "$slides_file"`
mkdir -p theme/gen
$LESSC theme/less/default.less > theme/gen/default.css
$LESSC theme/less/phone.less > theme/gen/phone.css
EOF
chmod +x $build_file
