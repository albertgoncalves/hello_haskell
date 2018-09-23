#!/usr/bin/env bash

ghc -O2 interact/interact.hs
ls | ./interact/interact
