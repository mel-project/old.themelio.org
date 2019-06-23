#!/bin/sh
pandoc -f markdown -t html5 --bibliography=./design/design.bib --csl=ieee.csl ./design/design.md -o ./design/design.html