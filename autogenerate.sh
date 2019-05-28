#!/bin/sh
while true
do
inotifywait -r ./
racket generate.rkt
done
