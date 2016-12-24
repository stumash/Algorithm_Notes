#!/bin/bash

# When this script is run from the root directory of the project with
# no arguments, it uses pandoc to create an html document from every
# markdown file that is below the root directory.


### wrapper function for making html from markdown using custom css files
# ${1} is the markdown filename used as source for html file
function pandochtmlmath_local() {
    # make output html filename same as markdown filename but .html extension
    HTMLFILENAME=$(echo ${1} | sed 's/\.md/.html/')

    # run pandoc on the markdown file, producing an html file using
    # pandoc.css for styling, mathjax for latex rendering and other
    # pandoc-specific options
    pandoc -s -S --toc --mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML --css pandoc.css ${1} -o ${HTMLFILENAME}
}

# run pandochtmlmath on every .md in the directory tree rooted at project root
find $(pwd) -regextype posix-extended -regex '.*\.md$' | # find all .md files
while read FL; do
    if [ "$FL" != "$(realpath README.md)" ]; then # other than README.md
        # run pandochtmlmath_local on currect .md file
        pandochtmlmath_local $FL
        
        # markdown filename but with .html extension
        HTMLFILENAME=$(echo $FL | sed 's/\.md/.html/')

        # must use dirname of .md file in realpath command for correct
        # relative path to pandoc.css in project root
        FLDIR=$(dirname $FL)
        CSSPATH=$(realpath --relative-to=$FLDIR pandoc.css)
        sed -i "s#pandoc\.css#$CSSPATH#" $HTMLFILENAME
    fi
done
