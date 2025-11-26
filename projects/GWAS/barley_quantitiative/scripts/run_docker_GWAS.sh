#! /bin/bash


#
# Simple docker runner for GAPIT
#
mkdir -p data/gapit
vol=$(pwd)
docker run -v $vol:$vol:Z localhost/r-bioinfo Rscript $vol/scripts/GWAS_GAPIT.R \
    $vol/data/phenotype/phenotype_matrix.csv \
    $vol/data/genotype/genotype_location.csv \
    $vol/data/genotype/genotype_matrix_knn.csv \
    $vol/data/gapit 