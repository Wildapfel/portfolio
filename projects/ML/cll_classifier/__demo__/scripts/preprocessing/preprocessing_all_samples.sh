VERSION=cll_classifier
GSE_RAW_PATHS="./mnt/data/raw/GSE13159/GSE13159_RAW,./mnt/data/raw/GSE16455/GSE16455_RAW"
PREPROCESS="DQN"
EXPR_MAT_OUT="./mnt/data/processed/bg_corrected_dqn_all_samples/dqn_all_samples.csv"

# /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/$VERSION
docker run -v \
    ./:/mnt:z \
    localhost/r-bioinfo_v2.0 \
    Rscript ./mnt/scripts/preprocessing/preprocessing_all_samples.R \
        $GSE_RAW_PATHS \
        $PREPROCESS \
        $EXPR_MAT_OUT