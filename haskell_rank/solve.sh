#!/usr/bin/env bash

runhaskell "$1".hs < "$1"_stdin # > "$1"_$(date +"%Y%m%d%H%M")_stdout
echo ""
