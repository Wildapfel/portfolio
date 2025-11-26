
docker_run = """ docker run \
                 -v $(dirname $(dirname $(pwd))):$(dirname $(dirname $(pwd))):z \
                 -w $(pwd) \
             """

bioc_image = "localhost/r-docker"



# Perform DeSeq2 on control vs treatment 
try:
    rule run_deseq2:
        input:
            cfg["deseq2"]["input"]
        output:
            table = cfg["deseq2"]["output"]["table"],
            dist_est = cfg["deseq2"]["output"]["disp_est"],
            ma = cfg["deseq2"]["output"]["ma"],
            sd = cfg["deseq2"]["output"]["sd"],
            pca = cfg["deseq2"]["output"]["pca"],
        params:
            docker = docker_run,
            image = bioc_image
        shell:
            """
            mkdir -p $(dirname {output.table})/sample_qc
            mkdir -p $(dirname {output.table})/gene_qc
            {params.docker} {params.image} Rscript ./scripts/deseq2.R \
                {input} \
                $(dirname {output.table}) \
                {cfg[deseq2][gene_col]} \
                {cfg[deseq2][control]} \
                {wildcards.condition}
            """
    print("Inlcuded: run_deseq2 from dge.smk")
except:
    pass

#
# DEPRECATED,
# I moved to docker for R tools

# # Perform DeSeq2 on control vs treatment 
# try:
#     rule run_deseq2:
#         input:
#             cfg["deseq2"]["input"]
#         output:
#             cfg["deseq2"]["output"]
#         conda:
#             "../envs/deseq2.yml"
#         shell:
#             """
#             mkdir -p $(dirname {output})
#             Rscript ./scripts/deseq2.R \
#                 {input} \
#                 {output} \
#                 {cfg[deseq2][gene_col]} \
#                 {cfg[deseq2][control]} \
#                 {wildcards.condition}
#             """
#     print("Inlcuded: run_deseq2 from dge.smk")
# except:
#     pass

