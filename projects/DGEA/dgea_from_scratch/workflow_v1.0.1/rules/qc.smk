try:
    rule fastqc:
        input:  cfg["fastqc"]["input"]
        output: cfg["fastqc"]["output"]
        conda:  "../envs/fastqc.yml"
        shell:  """
                mkdir -p $(dirname {output})
                fastqc -o $(dirname {output}) {input}
                """ 
    print("Inlcudeded: fastqc from qc.smk")
except KeyError as e:
    pass

