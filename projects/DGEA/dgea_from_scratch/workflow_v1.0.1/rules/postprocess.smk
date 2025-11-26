# Postprocess Kallisto Tables
# 1.  remove low counts in est_counts table
# 2.  extract genes of interest (gene list)
# 3.  convert est_counts into itegers
# 3.  filter tpm table by gene list (polished tpm)
# 4.  log2 transform polished tpm 
try:
    rule postprocess_kallisto:
        input:
            merged_est_counts = cfg["merge"]["kallisto"]["out_dir"] + "/merged_est_counts.csv",
            merged_tpm = cfg["merge"]["kallisto"]["out_dir"] + "/merged_tpm.csv"
        output: 
            merged_est_counts_int = cfg["postprocess"]["kallisto"]["output"]["merged_est_counts_int"],
            merged_tpm_log2 = cfg["postprocess"]["kallisto"]["output"]["merged_tpm_log2"]
        shell:
            """
            # Make est_counts int (preprocess deseq2)
            python /var/home/maxpetzold/HUB_local/codebase/scripts/DGE/preprocessing/table.py \
                -t {input.merged_est_counts} \
                -o {output.merged_est_counts_int} \
                --make-int

            # tpm log2 transform (sample qc)
            python /var/home/maxpetzold/HUB_local/codebase/scripts/DGE/preprocessing/log2_transform.py \
                --table {input.merged_tpm} \
                --out_dir $(dirname {output.merged_tpm_log2})
            """
    print("Included: postprocess_kallisto from postprocess.smk")
except:
    pass


# TODO (shell:)
# # Remove low counts
# python /var/home/maxpetzold/HUB_local/codebase/scripts/DGE/preprocessing/table.py \
#     -t {input.est_counts_table} \
#     -o {output.rm_low_counts} \
#     --remove-low-counts      

# # Export gene list of processed table
# python /var/home/maxpetzold/HUB_local/codebase/scripts/DGE/preprocessing/table.py \
#     -t {output.rm_low_counts} \
#     -o {output.gene_list} \
#     --export-col target_id

# # Filter tpms by polished gene list
# python /var/home/maxpetzold/HUB_local/codebase/scripts/DGE/preprocessing/table.py \
#     -t {input.tpm_table} \
#     -o {cfg[merge][kallisto][out_dir]}/tpm_polished.csv \
#     --filter-by-col-list {output.gene_list}


