#!/usr/bin/env Rscript

rangeList = 250000

v1_ = 10
v2_ = 20

# slightly slower
    # v1 = as.numeric(seq(v1_, (v1_ + rangeList), 1))
    # v2 = as.numeric(seq(v2_, (v2_ + rangeList), 1))

v1 = as.numeric(v1_:(v1_ + rangeList))
v2 = as.numeric(v2_:(v2_ + rangeList))

cat(format(v1 %*% v2, scientific=FALSE))
