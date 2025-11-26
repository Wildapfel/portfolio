args = commandArgs(trailingOnly=TRUE)

fpheno  <- args[1]
floc    <- args[2]
fgeno   <- args[3]
out_dir <- args[4]

pheno   <- read.csv(fpheno) # must be all float
loc     <- read.csv(floc)   # including Chr and Pos
geno    <- read.csv(fgeno)  # as integer (zygoty to integer in {0, 1, 2}), no NaN

suppressPackageStartupMessages(library(impute))
suppressPackageStartupMessages(library(LDheatmap))
suppressPackageStartupMessages(library(GAPIT))

dir.create(out_dir)
setwd(out_dir)

gapit <- GAPIT(
    Y = pheno,
    GD = geno,
    GM = loc,
    PCA.total = 0,
    model=c("GLM", "FarmCPU")
)