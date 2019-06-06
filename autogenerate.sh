#!/bin/sh
while true
do
inotifywait -r *src* scss
racket generate.rkt
done
