try:
    rule index_kallisto:
        input:  cfg["index"]["kallisto"]["transcriptome"]
        output: cfg["index"]["kallisto"]["output"]
        conda:  "../envs/kallisto.yml"
        shell:
            """
            mkdir -p $(dirname {output})
            kallisto index -i {output} {input}
            """
except KeyError as e:
    pass
    # print("Not included: rule index_kallisto from index.smk")