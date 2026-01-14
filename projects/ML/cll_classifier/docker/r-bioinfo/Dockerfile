#
# This Dockerfile installs Bioconductor,
# and R dependencies for DGEA and GWAS.
# I strated using a docker image, when I
# faced server issues with the bioconductor-
# clusterprofiler conda installation.
# Besides that, I believe that using a
# image for R native packages is more reliable,
# then depending on python wrappers or reimple-
# mentations.
#

FROM bioconductor/bioconductor_docker:devel

#
# for the DGE/ GOEA anylsis
#
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('pheatmap')"
RUN R -e "BiocManager::install('clusterProfiler')"
RUN R -e "BiocManager::install('DESeq2')"
RUN R -e "BiocManager::install('org.At.tair.db')"
RUN R -e "BiocManager::install('org.Hs.eg.db')"

#
# for the GWAS analysis 
#
RUN R -e "install.packages('devtools')"
RUN R -e "devtools::install_github('jiabowang/GAPIT3',force=TRUE)"
RUN R -e "BiocManager::install('snpStats')"
COPY packages/LDheatmap_1.0-6.tar.gz /tmp/
RUN R -e "install.packages('/tmp/LDheatmap_1.0-6.tar.gz', repos=NULL, type='source')"
RUN R -e "BiocManager::install('impute')"
