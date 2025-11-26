#
# Perform a kallisto quantification
#
try:
    rule kallisto_quant:
        input:
            fasta = cfg["quant"]["kallisto"]["fasta_files"],
            ref = cfg["quant"]["kallisto"]["ref"]
        output:
            cfg["quant"]["kallisto"]["output"] 
        params:
            seq = cfg["quant"]["kallisto"]["end"],
            mean = cfg["quant"]["kallisto"]["length"],
            std = cfg["quant"]["kallisto"]["sd"]
        conda: "../envs/kallisto.yml"
        shell:
            """
            echo {output}
            mkdir -p $(dirname {output})
            kallisto quant \
                --{params.seq} \
                -l {params.mean} \
                -s {params.std} \
                -o $(dirname {output}) \
                -i {input.ref} \
                {input.fasta}
            """
except KeyError as e:
    # print(f"Not included: rule kallisto_quant from quantification.smk")
    #print(e)
    pass
    