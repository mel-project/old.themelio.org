#!/bin/bash


## this doesn't handle unknown parameters well

#cd ./whitepapers
#sh generate.sh
#echo "Whitepaper generation complete"
#cd ..

build_sass () {
    sass templates/style/scss/custom-bootstrap.scss build/css/custom-bootstrap.css
    echo "SASS compilation complete"
}

build_pug () {
    pug dev/pug/src -o templates/routes/ 
}

build_racket() {
    if [ -z "`raco pkg show | grep yaml`" ]
    then
        raco pkg install yaml
        echo "Packages installed"
    fi

    racket generate.rkt
}

PUG=1
SASS=1
RACKET=1
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -ns|--no-sass) 
            echo 'Skipping SASS build'
            SASS=`false`
            shift ;;
        -np|--no-pug) 
            echo 'Skipping pug build'
            PUG=`false`
            shift ;;
        -nr|--no-racket)
            echo 'Skipping racket build'
            RACKET=`false`
            shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
done

test $PUG && build_pug
test $SASS && build_sass
test $RACKET && build_racket

