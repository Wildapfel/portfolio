#
# Quick Note: 
# I dont need to freeze params here, becuause its preprocessing the 
# full stack of experiments.
#

library(affy)
library(preprocessCore) 
library(matrixStats)
source("./mnt/src/preprocessing.R")

args            <- commandArgs(TRUE)
GSE_RAW_PATHS   <- args[1]
PREPROCESSING   <- args[2]
EXPR_MAT_OUT    <- args[3]

cel_files   <- load_cel_files(GSE_RAW_PATHS)
affy_data   <- ReadAffy(filenames = cel_files)
expr_matrix <- preprocess(affy_data, PREPROCESSING, FALSE)
colnames(expr_matrix) <- substr(colnames(expr_matrix), 1, 9)
write.csv(expr_matrix, file = EXPR_MAT_OUT, row.names = TRUE)