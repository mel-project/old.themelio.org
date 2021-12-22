#!/bin/sh


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
    pug templates/routes/pug -o templates/routes/ 
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s|--sass) 
            SASS=true
            shift ;;
        -p|--pug) 
            PUG=true
            shift ;;
        --init)
            SASS=true
            PUG=true
            shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
done

test $PUG && build_pug
test $SASS && build_sass

   
if [ -z "`raco pkg show | grep yaml`" ]
then
    raco pkg install yaml
    echo "Packages installed"
fi

racket generate.rkt
