suppressPackageStartupMessages(library(DESeq2))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(pheatmap))

#
# fetch from cmdline
#
args <- commandArgs(trailingOnly=TRUE)
fin <- args[1]
out_dir <- args[2]
gene_col <- args[3]
control <- args[4]      # first control
treatment <- args[5]    # then treatment

# 
# output file names (declared here, for easy debugging)
#
out_table = paste(out_dir, "/deseq2_control_", treatment, ".csv", sep="")
out_disp =paste(out_dir, "/gene_qc/disp_est_control_", treatment, ".png", sep="")
out_ma = paste(out_dir, "/gene_qc/ma_control_", treatment, ".png", sep="")
out_sd = paste(out_dir, "/sample_qc/sd_control_", treatment, ".png", sep="")
out_pca = paste(out_dir, "/sample_qc/pca_control_", treatment, ".png", sep="")

#
# read table
#
counts <- read.csv(
    fin,
    row.names = gene_col
)

#
# filter repeating cols for each group
# 
cols1 <- colnames(counts)[str_detect(colnames(counts), control)]
cols2 <- colnames(counts)[str_detect(colnames(counts), treatment)]
cols <- c(cols1, cols2)
counts_filtered <- counts[cols]

#
# prepare metadata
#
metadata <- data.frame(
  condition = c(rep(treatment, length(cols2)), rep(control, length(cols1)))
)
rownames(metadata) <- cols

#
# Build DESeq2 dataset
#
dds <- DESeqDataSetFromMatrix(
  countData = counts_filtered,
  colData = metadata,
  design = ~ condition
)

#
# Run DESeq2
#
dds <- DESeq(dds)
res <- results(dds)
vsd <- vst(dds, blind=FALSE)

#
# export table
# 
write.csv(as.data.frame(res), file = out_table)

#
# export dispersion plot
#
png(out_disp, height=800, width=600)
plotDispEsts(dds, main="Dispersion Estimates")
dev.off()

#
# export ma plot
#
png(out_ma, width = 800, height = 600)
plotMA(res, main="MA Plot")
dev.off()

#
# export sd plot
#
png(out_sd, width = 800, height = 600)
sampleDists <- dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDists)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         main="Sample-to-sample distances")
dev.off()

#
# export pca plot
#
pca_data <- plotPCA(vsd, intgroup="condition", returnData = TRUE) # fetch the actual data, not the plot
gg_pca <- ggplot(pca_data, aes(x = PC1, y = PC2, color = name)) +
  geom_point(size = 3) +
  xlab(paste("PC1")) +
  ylab(paste("PC2")) +
  ggtitle("PCA Plot") +
  theme_minimal()
ggsave(out_pca, gg_pca, width = 10, height = 8, dpi = 300)