#!/bin/bash

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


#
# Reproducable dgea from scratch with conda, docker and snakemake.
# - I must exclude the git repo, a repo within another repo is not allowed
# - I also exclude the .gitignore
# 
DGEA_FROM_SCRATCH_PROJECT_DIR="/var/home/maxpetzold/HUB_local/projects/build_skills/dgea_from_scratch"
DGEA_FROM_SCRATCH_PORTFOLIO_DIR="./projects/DGEA/"
mkdir -p $DGEA_FROM_SCRATCH_PORTFOLIO_DIR
rsync -r \
    --delete \
    --exclude=".git/" \
    --exclude=".gitignore" \
    --exclude=".snakemake/" \
    --exclude="__pycache__/" \
    --exclude="*.fastq" \
    --exclude="*.fastq.gz" \
    --exclude="*.fa" \
    --exclude="*.kai" \
    $DGEA_FROM_SCRATCH_PROJECT_DIR \
    $DGEA_FROM_SCRATCH_PORTFOLIO_DIR
echo -e "${COLOR_LIGHT_BLUE}Synced dgea-from-scratch ${COLOR_NC}"



# 
# root-to-shoot
# 
ROOT_TO_SHOOT_PROJECT_DIR="/var/home/maxpetzold/HUB_local/projects/build_skills/statisical_modelling/root_to_sproot"
ROOT_TO_SHOOT_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_local/portfolio/projects/biostatistics"
mkdir -p $ROOT_TO_SHOOT_PORTFOLIO_DIR
rsync -r \
    --delete \
    --exclude=".git/" \
    --exclude=".gitignore" \
    --exclude="model/" \
    $ROOT_TO_SHOOT_PROJECT_DIR \
    $ROOT_TO_SHOOT_PORTFOLIO_DIR
echo -e "${COLOR_LIGHT_BLUE}Synced root-to-shoot${COLOR_NC}"


#
# GWAS barley
#
GWAS_BARLEY_PROJECT_DIR="/var/home/maxpetzold/HUB_local/projects/build_skills/GWAS/barley_quantitative/"
GWAS_BARLEY_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_local/portfolio/projects/GWAS/barley_quantitiative"
mkdir -p $GWAS_BARLEY_PORTFOLIO_DIR
rsync -r \
    --delete \
    --exclude=".git/" \
    $GWAS_BARLEY_PROJECT_DIR \
    $GWAS_BARLEY_PORTFOLIO_DIR
echo -e "${COLOR_LIGHT_BLUE}Synced GWAS barley${COLOR_NC}"


    
#
# Docker
# 
DOCKERFILE_LOCAL_DIR="/var/home/maxpetzold/HUB_local/codebase/docker/r-bioinfo"
DOCKERFILE_PORTFOLIO_DIR="/run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_local/portfolio/docker/"
mkdir -p $DOCKERFILE_PORTFOLIO_DIR
rsync -r \
    --delete \
    $DOCKERFILE_LOCAL_DIR \
    $DOCKERFILE_PORTFOLIO_DIR
echo -e "${COLOR_LIGHT_BLUE}Synced dockerfile${COLOR_NC}"