# 
# Define the the docker command, you need the z (lowercase ) here ! 
# Note:
# :Z    private access
# :z    shared acces
#
docker_run = """ docker run \
                 -v $(dirname $(dirname $(pwd))):$(dirname $(dirname $(pwd))):z \
                 -w $(pwd) \
             """

#
# Define the docker image (bioconductor image)
#
bioc_image = "localhost/r-docker"


#
# GOEA with multiple groups in config.yml (a list)
#
try:

    if isinstance(cfg["enrich_go"]["params"]["group"], list):

        rule run_goea_multiple_groups:
            input:  cfg["enrich_go"]["input"]
            output: cfg["enrich_go"]["output"]
            params:
                docker = docker_run,
                image = bioc_image
            shell:
                """
                mkdir -p $(dirname {output})
                echo "Processing: {wildcards.group} {wildcards.ont} {wildcards.sorted} {wildcards.n_top_genes}"

                # execute docker
                {params.docker} {params.image} Rscript scripts/GOEA.R \
                    {input} \
                    $(dirname {output}) \
                    {wildcards.group} \
                    {cfg[enrich_go][params][org]} \
                    {wildcards.ont} \
                    {wildcards.sorted} \
                    {wildcards.n_top_genes}

                echo "Done: {wildcards.group} {wildcards.ont} {wildcards.sorted} {wildcards.n_top_genes}"
                """
            
        print("run_goea_multiple_groups from goea.smk")

    if isinstance(cfg["enrich_go"]["params"]["group"], str):

        # 
        # TODO
        # Handle also sinlge inputs (passed as string)
        #
        pass


except:
    pass
