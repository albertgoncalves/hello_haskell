#!/usr/bin/env bash

printf '\ngp_sep.hs'
time runhaskell gp_sep.hs < hegel.txt > hegel_gp_sep.txt
printf '\njon_sep.hs'
time runhaskell jon_sep.hs < hegel.txt > hegel_jon_sep.txt
printf "\n"
diff hegel_gp_sep.txt hegel_jon_sep.txt | head
