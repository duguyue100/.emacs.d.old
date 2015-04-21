#!/bin/sh

now="$(date): update all"

git add -A README.md
git add -A update-all.sh
git add -A init.el
git add -A site-lisp/*
git add -A elpa/*

git commit -m "$now"
git push origin master
