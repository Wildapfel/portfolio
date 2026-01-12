VERSION=cll_classifier
MNT=./mnt
GSE_RAW_PATH=$1
GSE_LIST=$2
PREPROCESS=$3
EXPR_MAT_OUT=$4
FREEZE=$5

docker run -v \
    /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/$VERSION:/mnt:z \
    localhost/r-bioinfo_v2.0 \
    Rscript ./mnt/scripts/preprocessing/preprocessing_single_exp_from_gse_list.R \
        $MNT${GSE_RAW_PATH:1} \
        $MNT${GSE_LIST:1} \
        $PREPROCESS \
        $MNT${EXPR_MAT_OUT:1} \
        $FREEZE