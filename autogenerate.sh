#!/bin/sh

#cd ./whitepapers
#sh generate.sh
#echo "Whitepaper generation complete"
#cd ..
sass templates/style/scss/custom-bootstrap.scss build/css/custom-bootstrap.css
pug templates/routes
echo "SASS compilation complete"
if [ -z "`raco pkg show | grep yaml`" ]
then
    raco pkg install yaml
fi
echo "Packages installed"
racket generate.rkt
