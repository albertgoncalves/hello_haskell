#!/usr/bin/env bash

# $ bash solve.sh HS_FILENAME_WITHOUT_DOT_HS

runhaskell "$1".hs < "$1"_stdin # > "$1"_$(date +"%Y%m%d%H%M")_stdout
echo ""
