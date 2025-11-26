import sys, yaml
from snakemake.io import glob_wildcards


def init_wildcards(cfg):

    # append this dict and return
    WILDCARDS_DICT = {}

    # Get the {exp} (experiemnts) and {acc} (accession) either from the
    # config.yml directly, when at download stage (file/folders not present)
    # or get it from the erxisitng file/folder structure with glob_wildcards
    try:
        SAMPLES = [
            (exp, acc)
            for exp, acc_list in cfg["download"]["samples"]["experiments"].items()
                for acc in acc_list.split()
        ]
        EXP = [x[0] for x in SAMPLES]
        ACC = [x[1] for x in SAMPLES]

        WILDCARDS_DICT["{exp}"] = EXP
        WILDCARDS_DICT["{acc}"] = ACC
    except KeyError as e:
        
        EXP, ACC = glob_wildcards(cfg["paths"]["raw_data"] + "/{exp}/{acc}.fastq.gz")
        
        WILDCARDS_DICT["{exp}"] = EXP
        WILDCARDS_DICT["{acc}"] = ACC
        

    # Hard code the {metric} since its just two values, and other files interfere
    # with glob_widlcards
    WILDCARDS_DICT["{metric}"] = ["est_counts", "tpm"]


    # Hardcode {condition}
    WILDCARDS_DICT["{condition}"] = ["abf2", "abf3"]


    # also hardcode {eda}
    try:
        WILDCARDS_DICT["{eda}"] = cfg["plot"]["quant_qc"]["params"]["eda"] #["boxplots", "histograms", "scatter-matrix"]
    except:
        pass


    # code the widlcards for the goea
    GROUPS_    = ["abf2", "abf3"]
    ONTS_      = ["BP", "MF", "CC"]
    SORTEDS_   = ["abs", "up", "down"]
    TOP_GENES_ = ["100", "500", "1000"]

    GROUPS = []
    ONTS = []
    SORTEDS = []
    TOP_GENES = []

    for group in GROUPS_:
        for ont in ONTS_:
            for sorted in SORTEDS_:
                for top_genes in TOP_GENES_:
                    ONTS.append(ont)
                    SORTEDS.append(sorted)
                    TOP_GENES.append(top_genes)
                    GROUPS.append(group)
    
    WILDCARDS_DICT["{ont}"]         = ONTS
    WILDCARDS_DICT["{sorted}"]      = SORTEDS
    WILDCARDS_DICT["{n_top_genes}"] = TOP_GENES
    WILDCARDS_DICT["{group}"]       = GROUPS
    
    return WILDCARDS_DICT