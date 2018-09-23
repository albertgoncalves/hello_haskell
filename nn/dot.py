#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np

rangeList = 250000

v1_ = 10
v2_ = 20

# too slow, large memory cost
    # v1 = np.asarray(range(v1_, v1_ + rangeList + 1))
    # v2 = np.asarray(range(v2_, v2_ + rangeList + 1))

# pretty fast, low memory overhead
v1 = np.arange(v1_, v1_ + rangeList + 1)
v2 = np.arange(v2_, v2_ + rangeList + 1)

print(np.dot(v1, v2))
