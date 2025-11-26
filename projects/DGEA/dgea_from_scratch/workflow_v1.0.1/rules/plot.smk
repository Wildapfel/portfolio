try:
    rule quant_qc:
        input:  eda = cfg["plot"]["quant_qc"]["input"]["eda"]
        output: eda = cfg["plot"]["quant_qc"]["output"]["eda"]   
        conda:  "../envs/plotting.yml"
        shell:
            """
            echo {wildcards.eda}
            # EDA
            mkdir -p $(dirname {output.eda})
            python scripts/plot_dge_exploratory.py \
                -t {input.eda} \
                -o $(dirname {output.eda}) \
                -n {wildcards.eda}.png \
                -s ',' \
                --{wildcards.eda}
            """

    print("Included: quant_qc from plots.smk")

except:
    pass

try:
    rule plot_pca:
        input:  cfg["plot"]["quant_qc"]["input"]["pca"]
        output: cfg["plot"]["quant_qc"]["output"]["pca"]
        params: pca_params = cfg["plot"]["quant_qc"]["params"]["pca"]
        conda:  "../envs/plotting.yml"
        shell:
            """
            # PCA
            mkdir -p $(dirname {output})
            python scripts/plot_dge_exploratory.py \
                -t {input} \
                -o $(dirname {output}) \
                -n pca.png \
                -s ',' \
                --{params.pca_params}
            """
except:
    pass

try:
    rule dge_vulcano:
        input:  cfg["plot"]["dge_vulcano"]["input"]
        output: cfg["plot"]["dge_vulcano"]["output"]
        conda:  "../envs/plotting.yml"
        shell:
            """
            echo {wildcards}
            echo {output}
            mkdir -p $(dirname {output})
            python scripts/plot_dge_exploratory.py \
            -t {input} \
            -o $(dirname {output}) \
            -n vulcano_control_{wildcards.condition}.png \
            -s ',' \
            --vulcano-plot
            """
except:
    pass