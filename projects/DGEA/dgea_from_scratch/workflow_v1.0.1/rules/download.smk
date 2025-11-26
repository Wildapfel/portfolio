try:
    rule download_transcriptome_single:
        output:
            cfg["download"]["transcriptome"]["out_dir"] + "/" + cfg["download"]["transcriptome"]["file_name"] + ".fa.gz"
        shell:
            """
            mkdir -p $(dirname {output})
            wget --directory-prefix $(dirname {output}) {cfg[download][transcriptome][url]}
            """
    print("Included: download_transcriptome from download.smk")
except:
    pass

# unzip transcriptome
try:
    rule unzip_transcriptome:
        output:
            cfg["download"]["transcriptome"]["out_dir"] + "/" + cfg["download"]["transcriptome"]["file_name"] + ".fa"
        input:
            cfg["download"]["transcriptome"]["out_dir"] + "/" + cfg["download"]["transcriptome"]["file_name"] + ".fa.gz",
        shell:
            """
            gzip -d {input}
            """
    print("Included: unzip_transcriptome from download.smk")
except KeyError as e:
    pass


# Download using accession numbers (acc) from ncbi sra
try:
    rule download_acc_zipped:
        output: cfg["download"]["samples"]["output"]
        conda:  "../envs/sra_tools.yml"
        shell:
            """
            mkdir -p $(dirname {output})
            mkdir -p tmp
            mkdir -p tmp/fasterq
            output_={output}
            TMPDIR=$(mktemp -d tmp/fasterq/{wildcards.acc}_XXXX)
            echo "Downloading {wildcards.acc}..."
            fasterq-dump {wildcards.acc} \
                -O $(dirname {output}) \
                -t $TMPDIR
            rm -rf $TMPDIR
            if [[ -f ${{output_::-9}}_1.fastq ]];then       # handle paired end <ACC>_1
                echo "Zipping {wildcards.acc}_1..."
                gzip ${{output_::-9}}_1.fastq
            fi
             if [[ -f ${{output_::-9}}_2.fastq ]];then      # hanlde paired end <ACC>_2
                echo "Zipping {wildcards.acc}_2..."
                gzip ${{output_::-9}}_2.fastq
            fi
            echo "Zipping {wildcards.acc}..."
            gzip ${{output_::-3}}  
            """
    print("Included: download_samples_zipped from download.smk")
except KeyError as e:
    pass