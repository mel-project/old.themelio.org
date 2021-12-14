#!/bin/sh

#cd ./whitepapers
#sh generate.sh
#echo "Whitepaper generation complete"
#cd ..
sass templates/style/scss/custom-bootstrap.scss build/css/custom-bootstrap.css
echo "SASS compilation complete"
raco pkg install yaml
echo "Packages installed"
racket generate.rkt
