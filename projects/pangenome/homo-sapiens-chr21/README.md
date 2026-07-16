# Pangenome-Graphs *homo sapiens* chr21

- I build a reproduceable workflow for downloading chr 21 of *homo sapiens* (males and females)
- I build pangenome graphs onto each subset (male and female)
- I inspected each pangenome graph using `Badange`
- I found hightly strutural variants region through out the genomes but also hightly conserved (long-reaching) regions
- Directly jump to some interesting variant/conserved regions (screenshoted from Bandage):
    - [regions](results/genomic_regions.md)

## data

- b-lymphocytes WGS (male and female)

## instructions

- build docker-image first

```bash
podman build --format docker -t pangenome-workflow .
```

- work inside the docker-image

```bash
./docker-container.sh
```

- prepare env and wd

```bash
micromamba activate bioinfo-pangenome
cd mnt
```

- run snakemake (set number of parellel process for yourself)

```bash
snakemake --cores <N>
```

## bandage

- run `Bandage`
- `file > load graph (.grf) > select male/female .grf > draw graph > node labels:name`

## run a demo

- inside the `__demo__` dir
- download: circa 900mb
- building the graphs takes time ... 
- set a number of cores !!!

```
cp Snakefile __demo__
cp -r configs __demo__/configs
cd __demo__
```
```
snakemake --cores <N>
```


*quick note*

- I set a number for multithreading in the minigraph build ...
- Bandage produces different looking grpahs
- `minigraph` also exports bed-like files which can be applied in downstream analysis
- `minigraph --call` outputs a reference to sample validation and takes sometime to compute,
  thats why only included a demo for a single sample
