#!/usr/bin/env bash

ghc dot.hs -O2 >/dev/null 2>&1
echo && echo Haskell && time ./dot && echo

# rm dot.hi
# rm dot.o
# rm dot

ghc dotVec.hs -O2 >/dev/null 2>&1
echo && echo HaskellVector && time ./dotVec && echo

# rm dotVec.hi
# rm dotVec.o
# rm dotVec

source /Users/albert/.bash_profile
source activate pymain
echo Python && time python3 dot.py && echo

source deactivate
source activate rmain >/dev/null 2>&1
echo R && time Rscript dot.R && echo
