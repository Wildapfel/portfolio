suppressPackageStartupMessages(library(LDheatmap))
suppressPackageStartupMessages(library(snpStats))
suppressPackageStartupMessages(library(stringr))

args = commandArgs(trailingOnly=TRUE)
floc    <- args[1]
fgeno   <- args[2]
SNPs    <- str_split_1(args[3], ",")
out_dir <- args[4]

loc  <- read.csv(floc)
geno <- read.csv(fgeno)

dir.create(out_dir, showWarnings=FALSE, recursive=TRUE)
setwd(out_dir)

geno_mat <- as.matrix(geno[, -1])  # remove sample ID column

if (SNPs[1] == "all") {
    geno_sel <- geno_mat
    loc_sel  <- loc
} else {
    geno_sel <- geno_mat[, SNPs, drop=FALSE]
    loc_sel  <- loc[ match(SNPs, loc$Marker), ]
}

# make SnpMatrix
geno_snp <- new("SnpMatrix", geno_sel)

# LD matrix for export
ld_matrix <- as.matrix(ld(geno_snp, depth=ncol(geno_sel)-1, stats="R.squared"))

ext <- paste0(SNPs, collapse=".")

write.csv(ld_matrix, paste0("LD.", ext, ".csv"))

# Heatmap
rgb.palette <- colorRampPalette(rev(c("blue", "orange", "red")), space="rgb")

png(paste0("LD.", ext, ".png"), width=2000, height=2000, res=300)

heatmap <- LDheatmap(
    geno_snp,
    genetic.distances = loc_sel$Pos,
    distance="genetic",
    flip=TRUE,
    color=rgb.palette(18)
)

# placeholder assoc = positions (won’t plot unless you give real stats)
assoc_vals <- loc_sel$Pos
LDheatmap.addScatterplot(heatmap, assoc_vals)

dev.off()
