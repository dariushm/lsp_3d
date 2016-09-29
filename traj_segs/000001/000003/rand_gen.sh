#!/bin/bash

# This Script generate a random number and modify the “md_new.mdp”
#line_start_to_change = lstc
((lsc = lines  - charge))

#line to finish
((lfc = lsc+charge))

#awk -v s=50 -v f=52 -v rand=$RANDOM '{if (NR>s && NR<f) gsub(/ 473529/,rand,$0); print}' md_new.mdp > md_new_rand.mdp

rand=$RANDOM
sed "51s/.*/gen_seed                 = $rand/" md_new.mdp > md_new_rand.mdp
