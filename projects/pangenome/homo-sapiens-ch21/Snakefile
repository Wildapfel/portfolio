# *quick note*
# - download all fasta from ncbi (male & female)
# - graph generation from fastas (male & female)
# - generates bed files

configfile: "configs/data.yaml"

DATA = config["outdir"]["data"]
RESULTS = config["outdir"]["results"]
MINIGRAPH_THREADS = config["minigraph-threads"]
N_CHROMOSOME = config["n_chromosome"]
ACCESSIONS_MALE = config["accessions"]["male"]
ACCESSIONS_FEMALE = config["accessions"]["female"]
ALL_MALE_FASTA_AS_SINGLE_STRING = " ".join([f"data/male/{acc}.chr21.fna" for acc in ACCESSIONS_MALE])
ALL_FEMALE_FASTA_AS_SINGLE_STRING = " ".join([f"data/female/{acc}.chr21.fna" for acc in ACCESSIONS_FEMALE])

rule all:
    input:
        expand("{data}/male/{accession_male}.chr{chromosome}.fna", accession_male=ACCESSIONS_MALE, chromosome=N_CHROMOSOME, data=DATA),
        expand("{data}/female/{accession_female}.chr{chromosome}.fna", accession_female=ACCESSIONS_FEMALE, chromosome=N_CHROMOSOME, data=DATA),
        f"{RESULTS}/pangenomes/homo_sapiens_male_chr{N_CHROMOSOME}_pangenome.grf",
        f"{RESULTS}/pangenomes/homo_sapiens_female_chr{N_CHROMOSOME}_pangenome.grf",
        f"{RESULTS}/call-bubbles/homo_sapiens_male_chr21_pangenome.bed",
        f"{RESULTS}/call-bubbles/homo_sapiens_female_chr21_pangenome.bed",
        f"{RESULTS}/paths/GCA_056717095.1.bed"

rule download_male:
    output:
        "{DATA}/male/{accession_male}.chr{chromosome}.fna"
    params:
        accession_male = "{accession_male}"
    shell:
        """
        datasets download genome accession {params.accession_male} \
            --chromosomes {N_CHROMOSOME} \
            --filename {DATA}/male/{params.accession_male}.chr{N_CHROMOSOME}.zip;
        mkdir -p {DATA}/male/.tmp-{params.accession_male};
        unzip {DATA}/male/{params.accession_male}.chr{N_CHROMOSOME}.zip -d {DATA}/male/.tmp-{params.accession_male};
        rm {DATA}/male/{params.accession_male}.chr{N_CHROMOSOME}.zip;
        mv {DATA}/male/.tmp-{params.accession_male}/ncbi_dataset/{DATA}/{params.accession_male}/chr{N_CHROMOSOME}.fna {DATA}/male/{params.accession_male}.chr{N_CHROMOSOME}.fna;
        rm -rf {DATA}/male/.tmp-{params.accession_male}
        """          

rule download_female:
    output:
        "{DATA}/female/{accession_female}.chr{chromosome}.fna"
    params:
        accession_female = "{accession_female}"
    shell:
        """
        datasets download genome accession {params.accession_female} \
            --chromosomes {N_CHROMOSOME} \
            --filename {DATA}/female/{params.accession_female}.chr{N_CHROMOSOME}.zip;
        mkdir -p {DATA}/female/.tmp-{params.accession_female};
        unzip {DATA}/female/{params.accession_female}.chr{N_CHROMOSOME}.zip -d {DATA}/female/.tmp-{params.accession_female};
        rm {DATA}/female/{params.accession_female}.chr{N_CHROMOSOME}.zip;
        mv {DATA}/female/.tmp-{params.accession_female}/ncbi_dataset/{DATA}/{params.accession_female}/chr{N_CHROMOSOME}.fna {DATA}/female/{params.accession_female}.chr{N_CHROMOSOME}.fna;
        rm -rf {DATA}/female/.tmp-{params.accession_female}
        """  

rule build_male_pangenome:
    output:
        f"{RESULTS}/pangenomes/homo_sapiens_male_chr{N_CHROMOSOME}_pangenome.grf"
    input:
        expand("{data}/male/{accession_male}.chr{chromosome}.fna", accession_male=ACCESSIONS_MALE, chromosome=N_CHROMOSOME, data=DATA)
    shell:
        """
        minigraph -cxggs -t{MINIGRAPH_THREADS} {ALL_MALE_FASTA_AS_SINGLE_STRING} > {output}
        """

rule build_female_pangenome:
    output:
        f"{RESULTS}/pangenomes/homo_sapiens_female_chr{N_CHROMOSOME}_pangenome.grf"
    input:
        expand("{data}/female/{accession_female}.chr{chromosome}.fna", accession_female=ACCESSIONS_FEMALE, chromosome=N_CHROMOSOME, data=DATA)
    shell:
        """
        minigraph -cxggs -t{MINIGRAPH_THREADS} {ALL_FEMALE_FASTA_AS_SINGLE_STRING} > {output}
        """

rule call_bubbles_male:
    output:
        f"{RESULTS}/call-bubbles/homo_sapiens_male_chr21_pangenome.bed"
    input:
        f"{RESULTS}/pangenomes/homo_sapiens_male_chr21_pangenome.grf"
    shell:
        """
        gfatools bubble {input} > {output}
        """

rule call_bubbles_female:
    output:
        f"{RESULTS}/call-bubbles/homo_sapiens_female_chr21_pangenome.bed"
    input:
        f"{RESULTS}/pangenomes/homo_sapiens_female_chr21_pangenome.grf"
    shell:
        """
        gfatools bubble {input} > {output}
        """

rule path_male_sample:
    output:
        f"{RESULTS}/paths/GCA_056717095.1.bed"
    input:
        graph = f"{RESULTS}/pangenomes/homo_sapiens_male_chr{N_CHROMOSOME}_pangenome.grf",
        fasta = f"{DATA}/male/GCA_056667625.1.chr21.fna"
    shell:
        """
        minigraph \
            -cxasm \
            --call \
            -t{MINIGRAPH_THREADS} \
            {input.graph} \
            {input.fasta} \
          > {output}
        """
