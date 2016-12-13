#!/bin/bash

### wrapper function for making html from markdown using custom css files
# ${1} input filename
function pandochtmlmath() {
    HTMLFILENAME=$(echo ${1} | sed 's/\.md/.html/')
    pandoc -s -S --toc --mathjax=http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML --css pandoc.css ${1} -o ${HTMLFILENAME}
}

# run pandochtmlmath on every .md in the directory tree
find $(pwd) -regextype posix-extended -regex '.*\.md$' |
while read fl; do
    if [ "$fl" != "$(realpath README.md)" ]; then
        pandochtmlmath $fl
        HTMLFILENAME=$(echo $fl | sed 's/\.md/.html/')
        CSSPATH=$(realpath --relative-to=$fl pandoc.css)
        sed -i "s#pandoc\.css#$CSSPATH#" $HTMLFILENAME
        sed -i -r 's#\.\./(.*pandoc\.css)#\1#' $HTMLFILENAME
    fi
done
