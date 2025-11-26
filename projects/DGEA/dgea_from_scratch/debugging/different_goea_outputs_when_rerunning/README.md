### BUG
When I rerun the initial pipeline from the repo, I found that one control sample was differently mapped (different counts). 

#### Background:
At the initial run, I found that the sample didnt create many counts, that already made me suspicious. But at that time, I thought that this might be a bad sample (alinging with the fastqc report), that I am able to exclude. When I pulled the repo and rerun the pipeline, I spotted that this sample got actually well mapped (counts just like the other samples). As expected, GOEA outputs were totally different, meaning that complete different terms were significant.    

#### Debug Strategy:
- use m5sum to compare the raw bits
- go trough each step and compare the raw bit an the human-readable files


#### Bug spotted:
- Somehow I downloaded a SRR with the last digit missing !!!!
- SRR1528616 was a ChIP-seq data from Homo sapiens :D (no clue how that got there) 
