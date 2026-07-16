FROM fedora:43
SHELL ["/usr/bin/bash", "-c"]

RUN dnf install unzip -y

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
RUN bin/micromamba shell init -s bash -r ~/micromamba

COPY envs/bioinfo-pangenome.yaml tmp/
RUN micromamba env create -f tmp/bioinfo-pangenome.yaml -y
RUN rm tmp/bioinfo-pangenome.yaml 
