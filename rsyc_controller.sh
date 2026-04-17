#!/bin/bash

#
# Remark:
# - since i also have git repos initialized in the projects, I must exclude them 
#   to not get any conflicts with my showcase repo (this one) 
# - Since I use data that might be private, I will exclude sensitive data
# 


COLOR_NC='\e[0m' # No Color
COLOR_BLACK='\e[0;30m'
COLOR_GRAY='\e[1;30m'
COLOR_RED='\e[0;31m'
COLOR_LIGHT_RED='\e[1;31m'
COLOR_GREEN='\e[0;32m'
COLOR_LIGHT_GREEN='\e[1;32m'
COLOR_BROWN='\e[0;33m'
COLOR_YELLOW='\e[1;33m'
COLOR_BLUE='\e[0;34m'
COLOR_LIGHT_BLUE='\e[1;34m'
COLOR_PURPLE='\e[0;35m'
COLOR_LIGHT_PURPLE='\e[1;35m'
COLOR_CYAN='\e[0;36m'
COLOR_LIGHT_CYAN='\e[1;36m'
COLOR_LIGHT_GRAY='\e[0;37m'
COLOR_WHITE='\e[1;37m'



# #
# # ML: CLL-Classifier
# #
# CLL_CLASSIFIER_PROJECT_DIR="/var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier"
# CLL_CLASSIFIER_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_local/portfolio/projects/ML"
# mkdir -p $CLL_CLASSIFIER_PORTFOLIO_DIR
# rsync -r \
#     --delete \
#     --exclude="dqn_all_samples.csv" \
#     --exclude="GSE13159_train.csv" \
#     --exclude="GSE13159_test.csv" \
#     --exclude="GSE16455_test.csv" \
#     --exclude="bg_corrected_train_dqn_test_scaled" \
#     --exclude="*.CEL.gz" \
#     --exclude="notes" \
#     --exclude="_debugging.md" \
#     --exclude="_log.md" \
#     --exclude="_notes.md" \
#     --exclude="_runner.md" \
#     --exclude="_todo.md" \
#     --exclude="_train_val_test_split.md" \
#     --exclude="todo.md" \
#     $CLL_CLASSIFIER_PROJECT_DIR \
#     $CLL_CLASSIFIER_PORTFOLIO_DIR
# echo -e "${COLOR_LIGHT_BLUE}Synced cll-classifier${COLOR_NC}"


# #
# # Reproducable dgea from scratch with conda, docker and snakemake.
# # - I must exclude the git repo, a repo within another repo is not allowed
# # - I also exclude the .gitignore
# # 
# # DGEA_FROM_SCRATCH_PROJECT_DIR="/var/home/maxpetzold/HUB_local/projects/build_skills/dgea_from_scratch"
# # DGEA_FROM_SCRATCH_PORTFOLIO_DIR="./projects/DGEA/"
# # mkdir -p $DGEA_FROM_SCRATCH_PORTFOLIO_DIR
# # rsync -r \
# #     --delete \
# #     --exclude=".git/" \
# #     --exclude=".gitignore" \
# #     --exclude=".snakemake/" \
# #     --exclude="__pycache__/" \
# #     --exclude="*.fastq" \
# #     --exclude="*.fastq.gz" \
# #     --exclude="*.fa" \
# #     --exclude="*.kai" \
# #     $DGEA_FROM_SCRATCH_PROJECT_DIR \
# #     $DGEA_FROM_SCRATCH_PORTFOLIO_DIR
# # echo -e "${COLOR_LIGHT_BLUE}Synced dgea-from-scratch ${COLOR_NC}"



# # 
# # root-to-shoot
# # 
# ROOT_TO_SHOOT_PROJECT_DIR="/var/home/maxpetzold/HUB_local/projects/personal/modelling/root_to_sproot"
# ROOT_TO_SHOOT_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_local/portfolio/projects/modelling"
# mkdir -p $ROOT_TO_SHOOT_PORTFOLIO_DIR
# rsync -r \
#     --delete \
#     --exclude=".git/" \
#     --exclude=".gitignore" \
#     --exclude="model/" \
#     --exclude="pflanzen.tsv" \
#     --exclude="pflanzen_incl_ratio.csv" \
#     $ROOT_TO_SHOOT_PROJECT_DIR \
#     $ROOT_TO_SHOOT_PORTFOLIO_DIR
# echo -e "${COLOR_LIGHT_BLUE}Synced root-to-shoot${COLOR_NC}"


# #
# # GWAS barley (private data)
# #
# GWAS_BARLEY_PROJECT_DIR="/var/home/maxpetzold/HUB_local/projects/personal/population_genetics/quantitative_GWAS_hordeum_vulgare"
# GWAS_BARLEY_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_local/portfolio/projects/population_genetics"
# mkdir -p $GWAS_BARLEY_PORTFOLIO_DIR
# rsync -r \
#     --delete \
#     --exclude=".git/" \
#     --exclude=".env" \
#     --exclude=".vscode/" \
#     --exclude="phenotype_matrix.xlsx" \
#     --exclude="phenotype_matrix.csv" \
#     --exclude="genotype_matrix.xlsx" \
#     --exclude="genotype_matrix.csv" \
#     --exclude="genotype_location.csv" \
#     --exclude="genotype_matrix_nan.csv" \
#     --exclude="genotype_matrix_mode.csv" \
#     --exclude="genotype_matrix_knn.csv" \
#     $GWAS_BARLEY_PROJECT_DIR \
#     $GWAS_BARLEY_PORTFOLIO_DIR
# echo -e "${COLOR_LIGHT_BLUE}Synced GWAS barley${COLOR_NC}"


    
#
# bachelorarbeit
#
BACHELORARBEIT_PROJECT_DIR="/run/media/maxpetzold/HDD_5TB/HUB_PARA/projects/active/prepare_bachelorarbeit_folder_for_portoflio_upload"
BACHELORARBEIT_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB_PARA/areas/Wildapfel/portfolio/projects/theses/bachelor"

mkdir -p $BACHELORARBEIT_PORTFOLIO_DIR
rsync -r \
    --delete \
    $BACHELORARBEIT_PROJECT_DIR \
    $BACHELORARBEIT_PORTFOLIO_DIR
echo -e "${COLOR_LIGHT_BLUE}Synced bachelorarbeit${COLOR_NC}"

#
# Docker
# 
# DOCKERFILE_LOCAL_DIR="/var/home/maxpetzold/HUB_local/codebase/docker/r-bioinfo"
# DOCKERFILE_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_local/portfolio/docker/"
# mkdir -p $DOCKERFILE_PORTFOLIO_DIR
# rsync -r \
#     --delete \
#     $DOCKERFILE_LOCAL_DIR \
#     $DOCKERFILE_PORTFOLIO_DIR
# echo -e "${COLOR_LIGHT_BLUE}Synced dockerfile${COLOR_NC}"