#! /bin/bash

#
# Pass SNPs, might change that, to also apply for all markers
#
SNPs=$1

#
# Simple docker runner for LD heatmap
#
mkdir -p report/LD
vol=$(pwd)
docker run -v $vol:$vol:Z localhost/r-bioinfo Rscript $vol/scripts/LD_heatmap.R \
    $vol/data/genotype/genotype_location.csv \
    $vol/data/genotype/genotype_matrix_knn.csv \
    $SNPs \
    $vol/report/LD
