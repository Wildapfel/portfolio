# validate kallisto indices md5sums

#### initial 
md5sum /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/data/reference/transcriptome/kallisto/Arabidopsis_thaliana.TAIR10.cdna.all.kai 
b5ff50ac9c273aff423db366bd534966  /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel/dge_from_scratch/data/reference/transcriptome/kallisto/Arabidopsis_thaliana.TAIR10.cdna.all.kai

### rerun (shown from the demo dir)
md5sum /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_test/dge_from_scratch/demo/data/reference/transcriptome/kallisto/Arabidopsis_thaliana.TAIR10.cdna.all.kai
4fc795b58c2888a225b28e989eb3fe69  /run/media/maxpetzold/HDD_5TB/HUB/Wildapfel_test/dge_from_scratch/demo/data/reference/transcriptome/kallisto/Arabidopsis_thaliana.TAIR10.cdna.all.kai

-> NOT EQUAL !
-> This made me suspicious, since I couldnt believe that there would be non-determenstic inside a index (maybe slightly, but not of such high impact)
-> Since you cannot just inspect the .kai files (binaries), I thought that there must be something like a time stemp or a some pointer adresses that would explain different md5sums ! 
-> I started using hexdump, to inspect the raw binaries !
