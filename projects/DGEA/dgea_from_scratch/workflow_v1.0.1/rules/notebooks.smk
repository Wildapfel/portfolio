try:
    # Note:
    # This is a very ungeric way of integrating notebooks, 
    # but I guess with time, I will genralize that more 
    rule run_notebooks:
        conda:
            "../envs/notebooks_execution.yml"
        output:
            cfg["notebooks"]["output"]["tpm_rm"],
            cfg["notebooks"]["output"]["tpm_log2_rm"],
            cfg["notebooks"]["output"]["est_counts_rm"],
        notebook:
            cfg["notebooks"]["notebook"]

    print("Included run_notebooks from notebook.smk")

except:
    pass