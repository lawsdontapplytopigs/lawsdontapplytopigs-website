#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
BUILT_DIR="$SCRIPT_DIR/built"
PREBUILT_DIR="$SCRIPT_DIR/prebuilt"

if [[ ! -d $BUILT_DIR ]]; then
    echo "making build dir"
    mkdir $BUILT_DIR
fi
echo $BUILT_DIR

cp "$PREBUILT_DIR/index.html" "$BUILT_DIR/"
cp "$PREBUILT_DIR/pog.jpg" "$BUILT_DIR/"
cp "$PREBUILT_DIR/0.png" "$BUILT_DIR/"





JS="$BUILT_DIR/elm.js"
MIN="$BUILT_DIR/elm.min.js"
ELM_MAIN="$SCRIPT_DIR/src/Main.elm"
if [[ "$1" = "--optimize" ]]; then
    
    elm make $ELM_MAIN --optimize --output="$JS"
    uglifyjs $JS --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle > $MIN
    echo "Compiled size:$(cat $JS | wc -c) bytes  ($JS)"
    echo "Minified size:$(cat $MIN | wc -c) bytes  ($MIN)"
    echo "Gzipped size: $(cat $MIN | gzip -c | wc -c) bytes"
else
    elm make $ELM_MAIN --output="$JS"

fi
