VERSION=tmp
MNT=./mnt
GSE_RAW_PATH=./data/raw/GSE16455/GSE16455_RAW
GSE_LIST=./data/raw/GSE16455/GSE16455_samples_cll_only.txt
PREPROCESS="DQN_EXT"
EXPR_MAT_OUT=./delete_later/__dev.csv
FREEZE="1"

docker run -v \
    /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/$VERSION:/mnt:z \
    localhost/r-bioinfo_v2.0 \
    Rscript ./mnt/scripts/preprocessing/preprocessing_single_exp_from_gse_list.R \
        $MNT${GSE_RAW_PATH:1} \
        $MNT${GSE_LIST:1} \
        $PREPROCESS \
        $MNT${EXPR_MAT_OUT:1} \
        $FREEZE