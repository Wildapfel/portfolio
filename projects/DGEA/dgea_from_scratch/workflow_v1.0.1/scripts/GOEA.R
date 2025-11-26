# GO Term Enrichment Analysis
# BP - Biological Process
# CC - Cellular Component
# MF - Molecular Function


# read cmd args
args = commandArgs(trailingOnly=TRUE)
df_path     <- args[1] # str
out_dir     <- args[2]
condition   <- args[3]
organism    <- args[4] # Human | Arabidopsis
ont         <- args[5] # BP | CC | MF
sorted      <- args[6] # abs | up | down
n_top_genes <- args[7] # int


# select by organism
if (organism == "Human") {
    suppressPackageStartupMessages(library(org.Hs.eg.db))
    db <- org.Hs.eg.db
    keytype <- "ENSEMBL"
} else if (organism == "Arabidopsis") {
    suppressPackageStartupMessages(library(org.At.tair.db))
    db <- org.At.tair.db
    keytype <- "TAIR"
} else {
    print("Orgnism not implemented yet")
    quit()
}


# import rest
suppressPackageStartupMessages(library(clusterProfiler))
suppressPackageStartupMessages(library(tidyverse))


# load table 
data = read.csv(df_path, row.names = 1)
df = data.frame(data)
names = df$names


# output file name
file_name = paste(
    out_dir, "/", ont, "_df_", 
    sorted ,"_top_", n_top_genes, 
    "_control_", condition, ".pdf",
    sep=""
)


# fetch sorted df
if (sorted == "abs") {
    # abs, both
    df_sorted <- df[order(abs(df$log2FoldChange),decreasing = T),,drop=F]    
} else if (sorted == "up") {
    # decreasing lfc, upregulated
    df_sorted <- df[order(df$log2FoldChange,decreasing = T),,drop=F]         
} else if (sorted == "down") {
    # increasing lfc, downregulated
    df_sorted <- df[order(df$log2FoldChange),,drop=F]                        
} else {
    print("Sorting type not supported")
    quit()
}


# RUN
ego <- enrichGO(
    gene = gsub("\\..*$","", rownames(df_sorted[1:n_top_genes,,drop=F])), 
    OrgDb = db, 
    keyType = keytype, 
    ont = ont,
    pAdjustMethod = "BH",
    # pvalueCutoff  = 0.1,
    # qvalueCutoff  = 0.1 
)


# PLOT
pdf(paste(file_name), width = 6, height = 8)
if (nrow(ego) == 0) {
    # Create an empty plot with a 
    plot.new()
    text(0.5, 0.5, "no GO found")
} else {
    dp <- dotplot(
        ego, 
        showCategory = 14,
        font.size = 16,
        
    ) +
    theme(
        axis.text.x = element_text(angle = 45, hjust = 1)
    )
    plot(dp)
}
dev.off()


# LOG
write.csv(
    ego, 
    paste(
        out_dir, "/", ont, "_df_", 
        sorted ,"_top_", n_top_genes, 
        "_control_", condition, ".csv",
        sep=""
    ),
    row.names = FALSE
)
# sink(file = fp)
# head(ego)
# sink(file = NULL)
