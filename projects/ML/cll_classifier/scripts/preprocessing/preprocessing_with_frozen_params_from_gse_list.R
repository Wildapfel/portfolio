library(affy)
library(preprocessCore) 
library(matrixStats)
source("./mnt/src/preprocessing.R")

args            <- commandArgs(TRUE)
GSE_RAW_PATH    <- args[1]
GSE_LIST        <- args[2]
gse_list        <- readLines(GSE_LIST)
PARAMS          <- args[3]
load(PARAMS)
EXPR_MAT_OUT    <- args[4]


cel_files   <- load_cel_files_from_gse_list(GSE_RAW_PATH, gse_list)
affy_data   <- ReadAffy(filenames = cel_files)

expr_matrix <- preprocess_from_frozen_params(affy_data, params)
colnames(expr_matrix) <- substr(colnames(expr_matrix), 1, 9)
write.csv(expr_matrix, file = EXPR_MAT_OUT, row.names = TRUE)