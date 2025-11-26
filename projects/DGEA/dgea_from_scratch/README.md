## Functional Analysis of ABF2/ABF3 Transfected Root Protoblasts public RNA-seq Data using Conda, Snakemake and Docker

This project demonstrates my ability to perform GO enrichment analyses on published raw RNA-seq data from ["Spatiotemporal analysis identifies ABF2 and ABF3 as key hubs of endodermal response to nitrate"](https://pubmed.ncbi.nlm.nih.gov/35046022/) while highlighting biological reasoning, interpretations and reporting. 


## About

- The original study focused on **spatial localization** and reported that ABF2 and ABF3 activity is predominantly observed in endodermal tissue

- My GO enrichment analysis reveals **functional roles** -
demonstrating these TFs upregulate cell division and RNA synthesis pathways.


## Core Competencies  
- Implement Snakemake pipelines using Python and R allowing reproducibility with YAML configuration files, package management with Conda and containerization with Docker
- Translating computational outputs to meaningful biological insights
- Professional GitHub usage and documentation practices
- Performing end-to-end enrichment analysis


## Project Structure
```
dge_from_scratch/  
├── config/                 # Pipeline runners  
├── data/                   # Were I processed data (experimental centric)
├── debugging/              # Documentation of debugging 
├── demo/                   # Reproduce directory
├── report/                 # Analysis results & interpretations  
├── workflow_v1.0.1/        # My snakemake workflow  
│ ├── config_templates      # Runner templates (TODO)
│ ├── docker/               # Containerization  
│ ├── envs/                 # Conda envs installers 
│ ├── rules/                # Modular rule definitions  
│ ├── scripts/              # Pipeline-specific scripts  
│ └── src/                  # Source for some custom fuctionality
├── .gitignore              # Exclude some files  
├── environment.yml         # Base environment   
├── README.md               # Just the README  
└── TODO.md                 # My personal TODO list  
```


## Data 
#### Source: 
- NCBI BioProject [PRJNA750466](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA750466&o=acc_s%3Aa)
#### Experiment:
- RNA-seq (single-end sequencing)
- Transfected root protoplasts of *Arabidopsis thaliana*
- Control: Empty Vector 
- Condition: ABF2, ABF3 (TF constructs)
- TF constructs were introduced to enhance transcriptomic signal, since ABF2 & ABF3 are natural TFs in plants nitrate response


##  Workflow-Overview
1. Data Acquisition
2. Preprocessing / Quality Control
3. Data Transformation
4. Differential Expression Analysis (DEA)
5. Exploratory Data Analysis (EDA) & Visualization
7. GO Term Enrichment Analysis (GOEA)
9. Reporting / Visualization


## Reproduce

Clone this repository:
```
git clone git@github.com:Wildapfel/dge_from_scratch.git
cd dge_from_scratch
```


Create a small conda environment  
- base conda with  snakemake 
```
conda env create -f environment.yml
conda activate dge_from_scratch
```


Install the R image (Docker)  
- size: ca. 10 Gb image (incl. base image) 
- name: localhost/r-docker
- after creating the image R packages will be installed 
```
docker build -f workflow_v1.0.1/docker/R/Dockerfile -t r-docker
```


Move to worklow directory:
```
cd workflow_v1.0.1
```


Init demo directory:
```
python scripts/init_config_base_dir.py ../demo/config/00_base.yml $(dirname $(pwd))/demo
```


Run snakemake sections from configfiles:
- Conda envs will be installed when running for the first time,
  this can take some time
- Either set the --cores N flag or just copy/paste
- Since this is real data, one must download ~30Gb !

```
# 1 Prepare transcriptome
snakemake --configfile ../demo/config/00_base.yml ../demo/config/00_prepare_transcriptome.yml --use-conda --cores 1 

# 2 Download Accessions from NCBI SRR
snakemake --configfile ../demo/config/00_base.yml ../demo/config/01_sample_download.yml --use-conda --cores 4 

# 3 QC raw reads
snakemake --configfile ../demo/config/00_base.yml ../demo/config/02_raw_reads_qc.yml --use-conda --cores 9 

# 4 Kallisto quantification
snakemake --configfile ../demo/config/00_base.yml ../demo/config/03+04_kallisto_quant.yml --use-conda --cores 9

# 5 Kallisto raw output Deseq2 
snakemake --configfile ../demo/config/00_base.yml ../demo/config/05_kallisto_raw_dge.yml --use-conda --cores 2 

# 6 Kallisto raw output GOEA
snakemake --configfile ../demo/config/00_base.yml ../demo/config/06_kallisto_raw_goea.yml --cores 10 

```