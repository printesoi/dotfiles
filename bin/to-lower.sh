#!/bin/bash

finder='echo "$@" | tr " " "\n"'
apply_cmd="cat"

LOWER='abcdefghijklmnopqrstuvwxyz'
UPPER='ABCDEFGHIJKLMNOPQRSTUVWXYZ'

FROM=$UPPER
TO=$LOWER

eval $finder | sed -n '
s/\/*$//
/\//! s/^/.\//
h
s/.*\///
y/'$FROM'/'$TO'/
x
G
/^.*\/\(.*\)\n\1/b
s/^\(.*\/\)\(.*\)\n\(.*\)$/mv "\1\2" "\1\3"/p
' | $apply_cmd
