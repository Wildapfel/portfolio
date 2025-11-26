# TODO list from developing the pipeline

## TODO 1
<!-- - DGE Analysis
    - deseq2 snakefile integration  -->
- Downstream
    - GO-Terms


<!-- ## TODO 2
- remove double occurences of / in the resolver -->


<!-- ## TODO 3
- add a tests section for downloading with small sample sizes (single and paired end) -->


### TODO 4
- when I wrote the multiple bracket resolver, i know face problem that https:// also get removed....


### TODO 5 (for much later)
- introduce to the configfile a system taht allows to use keys multiple times (curently not working, since k/v mappping of hashmaps)
- from this:
    ```
    [
    {"download": {"transcriptome": ...}},
    {"download": {"rna_seq": ...}}
    ]```
- to this:
    ```
    {"download": {"transcriptome": ..., "rna_seq": ...}}
    ```

### TODO 6 (fgor much later)
- with my snakemake main controller, and the ability to chain multiple configs, you also can create greater DAG 
- inspect: --config merge_mode=deep


### TODO 7
- regarding the wildcard declaration, I will implemnt the logic, that if you  first run a script, a wildcards.json is 
  created, that will store all wildcards that are delcared on the fly, if this already exisits and nothing has changed, 
  keep it as it is.
- furthermore, if you declare a wildcard inside y config.yml, a reoslver should first look if this is defined within the 
  file before looking in the external widlcardss.json, e.g. {metric} --> metric : [est_counts, tpm]



