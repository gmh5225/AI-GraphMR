#!/bin/bash

datasets=(
    mba_simplify
    poly1
    poly6
    algebra__linear_1d
    arithmetic__add_or_sub
    arithmetic__add_sub_multiple
    arithmetic__div
    arithmetic__mixed
    arithmetic__mul_div_multiple
    arithmetic__mul
    polynomials__collect
    polynomials__expand
    polynomials__simplify_power
)

for dataset in ${datasets[@]}
do 
    for model in gru lstm bert
    do
        echo "***************************************************************"
        echo "***************************************************************"
        python -u seq2seq.py --models $model --dataset $dataset --epochs=1000 | tee logs/$dataset/$model.log
        echo
        echo
    done
    for type in ast dag
    do
        echo "***************************************************************"
        echo "***************************************************************"
        echo $type
        python -u graph2seq.py --type $type --dataset $dataset --epochs=1000 | tee logs/$dataset/graphsr\_$type.log
        python -u graph2seq.py --type $type --dataset $dataset --epochs=1000
        echo
        echo
    done
done
