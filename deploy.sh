#!/bin/bash
#git subtree push -P build sshmendez gh-pages;
git push sshmendez `git subtree split --prefix build shane/dev`:gh-pages --force

