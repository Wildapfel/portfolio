#
# Quick Note: 
# I will need to freeze params here, becuause its relevenat for preprocessing  
# the test samples.
#

library(affy)
library(preprocessCore) 
library(matrixStats)
source("./mnt/src/preprocessing.R")


args            <- commandArgs(TRUE)
GSE_RAW_PATH    <- args[1]
GSE_LIST        <- args[2]
gse_list        <- readLines(GSE_LIST)
PREPROCESSING   <- args[3]
EXPR_MAT_OUT    <- args[4]
FREEZE_PARAMS   <- strtoi(args[5])


cel_files   <- load_cel_files_from_gse_list(GSE_RAW_PATH, gse_list)
affy_data   <- ReadAffy(filenames = cel_files)

if (!FREEZE_PARAMS){
    expr_matrix <- preprocess(affy_data, PREPROCESSING, freeze=FALSE)
} else {
    tmp <- preprocess(affy_data, PREPROCESSING, freeze = TRUE)
    expr_matrix <- tmp$expr_matrix 
    params <- tmp$params  
}

colnames(expr_matrix) <- substr(colnames(expr_matrix), 1, 9)
write.csv(expr_matrix, file = EXPR_MAT_OUT, row.names = TRUE)

if (FREEZE_PARAMS) {
    frozen_params_out <- paste(
        dirname(EXPR_MAT_OUT), 
        "/", 
        as.list(strsplit(basename(EXPR_MAT_OUT), '[.]')[[1]])[1], 
        "_params.RData",
        sep=""
    )
    save(params, file = frozen_params_out)
}
