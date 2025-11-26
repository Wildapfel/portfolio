import yaml, re, sys
# sys.path.append("~/HUB_local/codebase/snakemake/workflow")
from src.config_resolver import ResolveConfig
from snakemake.io import expand



class ResolveAllTargets:


    def __init__(self, cfg, wildcards):

        self.ALL_TARGETS = []
        self.wildcards = wildcards


    def get_all_targets(self, dic):

        """ public api: fetch all targets from config.yml """

        self._traverse_and_resolve(dic)
        
        return self.ALL_TARGETS


    def _resolve_wildcards(self, files):

        expanded_files = []

        if isinstance(files, list):
            files = files

        elif isinstance(files, str):
            files = [files]
       
        for file in files:
            # resolve with snakemakes expand func
            if any(re.search(wildcard, file) for wildcard in self.wildcards.keys()):
                expanded_tmp = expand(file, zip, **{key[1:-1] : item for key,item in self.wildcards.items()})
                for f in expanded_tmp:
                    expanded_files.append(f)
            else:
                expanded_files.append(file)

        for f in expanded_files:
            self.ALL_TARGETS.append(f)
        

    def _traverse_and_resolve(self, dic):

        # v1.0.0
        # selection = ["output"]

        # if isinstance(dic, dict):
        #     for key in dic.keys():
        #         if key in selection:
        #             potential_file = dic[key]
        #             # print(potential_file)
        #             self._resolve_wildcards(potential_file)
        #         self._traverse_and_resolve(dic[key])
    
        # return
 
        
        selection = ["output"]

        if isinstance(dic, dict):
           for key in dic.keys():
                # print(key)
                if key in selection:

                    potential_file = dic[key]

                    # direct file after output key (output : ...)
                    if isinstance(potential_file, str):
                        self._resolve_wildcards(potential_file)
                    
                    # more keys after output key (output.<attribute> : ...)
                    elif isinstance(potential_file, dict):
                        for key_ in potential_file.keys():
                            self._resolve_wildcards(potential_file[key_])
                            # no further traversal here      
                    else:
                        print("Something is off. Only str and dict should appear here")

                self._traverse_and_resolve(dic[key]) 

        return


# TEST
# if __name__ == "__main__":
    
#     cfg_file = "/var/home/maxpetzold/HUB_local/sandbox/practice/dge_from_scratch/config/config.yml"

#     with open(cfg_file) as f:
#         yml = yaml.safe_load(f)

#     cfg = ResolveConfig(yml).resolve_config(yml)
    
#     SAMPLES = [
#         (exp, srr)
#         for exp, srr_list in cfg["download"]["rna_seq"]["experiments"].items()
#             for srr in srr_list.split()
#     ]
#     EXP = [x[0] for x in SAMPLES]
#     SRR = [x[1] for x in SAMPLES]

#     wildcards = {
#         "exp" : EXP,
#         "srr" : SRR,
#         "metric" : ["est_counts", "tpm"] 
#     }

#     rec_dict = cfg
#     rf = ResolveAllTargets()
#     __ALL_TARGETS__ = rf.get_all_tartgets(rec_dict)

#     for line in __ALL_TARGETS__:
#         print(line)
