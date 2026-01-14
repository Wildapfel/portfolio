VERSION=cll_classifier
MNT=./mnt
GSE_RAW_PATH=$1
GSE_LIST=$2
PARAMS=$3
EXPR_MAT_OUT=$4

docker run -v \
    ./:/mnt:z \
    localhost/r-bioinfo_v2.0 \
    Rscript ./mnt/scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.R \
        $MNT${GSE_RAW_PATH:1} \
        $MNT${GSE_LIST:1} \
        $MNT${PARAMS:1} \
        $MNT${EXPR_MAT_OUT:1}