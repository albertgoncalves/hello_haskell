#!/usr/bin/env bash

ghc -prof -fprof-auto -o "$1" "$1".hs
./"$1" +RTS -p
cat "$1".prof

# rm "$1".prof
# rm "$1".hi
# rm "$1".o
# rm "$1"
