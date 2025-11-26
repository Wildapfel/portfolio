#
# Merge all abundance.tsv files from the kallisto quantification
# by their metrics (est_counts and tpm)
#
try:
    rule merge_kallisto_metric:
        input:
            expand(
                cfg["quant"]["kallisto"]["output"], 
                zip, 
                exp=WILDCARDS_DICT["{exp}"], 
                acc=WILDCARDS_DICT["{acc}"]
            ),
        output:
            cfg["merge"]["kallisto"]["output"]
        shell: 
            """
            mkdir -p $(dirname {output})
            python ./scripts/merge_kallisto.py \
                --col_name {wildcards.metric} \
                --exp_names '{WILDCARDS_DICT[{exp}]}' \
                --target_names '{cfg[merge][kallisto][new_labels]}' \
                --df_paths '{input}' \
                --fout {output}
            """

except Exception as e:
    # print(e) debug here
    pass
