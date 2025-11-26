### Check version conflict

- since I change during rerun to the workflow/envs (moved aways from testing with my testing env)

# Initial (bioEnv)
conda env list | rep kallisto 
kallisto 0.51.1


# Rerun (.snakemake/conda)
- I found that using a nemo (file explorer)
../../../workflow_v1.0.1/.snakemake/conda/69d79c0f7aa112335f78ffa6f4f61814_/bin/kallisto --version
kallisto 0.51.1


- Equal !