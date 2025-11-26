#
# This Dockerfile installs Bioconductor,
# and R dependencies for DGEA. I currently 
# need that especially for clusterProfiler,
# since there are server issues with the 
# bioconductor-clusterprofiler conda instal-
# lation
#

FROM bioconductor/bioconductor_docker:devel

RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('pheatmap')"
RUN R -e "BiocManager::install('clusterProfiler')"
RUN R -e "BiocManager::install('DESeq2')"
RUN R -e "BiocManager::install('org.At.tair.db')"
RUN R -e "BiocManager::install('org.Hs.eg.db')"
