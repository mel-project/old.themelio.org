#!/bin/sh


## this doesn't handle unknown parameters well

#cd ./whitepapers
#sh generate.sh
#echo "Whitepaper generation complete"
#cd ..




while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s|--sass) 
        sass templates/style/scss/custom-bootstrap.scss build/css/custom-bootstrap.css
        echo "SASS compilation complete"
        shift ;;
        -p|--pug) 
        pug templates/routes/pug -o templates/routes/ 
        shift ;;

        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
done
        
   
if [ -z "`raco pkg show | grep yaml`" ]
then
    raco pkg install yaml
    echo "Packages installed"
fi

racket generate.rkt
