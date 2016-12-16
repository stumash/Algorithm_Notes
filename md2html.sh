#!/bin/bash

### wrapper function for making html from markdown using custom css files
# ${1} input filename
function pandochtmlmath_local() {
    HTMLFILENAME=$(echo ${1} | sed 's/\.md/.html/')
    pandoc -s -S --toc --mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML --css pandoc.css ${1} -o ${HTMLFILENAME}
}

# run pandochtmlmath on every .md in the directory tree
find $(pwd) -regextype posix-extended -regex '.*\.md$' |
while read FL; do
    if [ "$FL" != "$(realpath README.md)" ]; then
        pandochtmlmath_local $FL
        HTMLFILENAME=$(echo $FL | sed 's/\.md/.html/')

        # must use dirname for realpath for correct results
        FLDIR=$(dirname $FL)
        CSSPATH=$(realpath --relative-to=$FLDIR pandoc.css)
        sed -i "s#pandoc\.css#$CSSPATH#" $HTMLFILENAME
    fi
done
