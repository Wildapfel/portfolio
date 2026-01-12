# 
# Quick Note: 
# - I removed the extractin of sample type
#

import sys, signal
from multiprocessing import Pool, cpu_count
from functools import partial
import GEOparse
import numpy as np
import pandas as pd

GSN_LIST = sys.argv[1]
OUT_FILE = sys.argv[2]
N_JOBS = 8

def init_worker():
    signal.signal(signal.SIGINT, signal.SIG_IGN)


def extract_leukemia_class(geo_id, dest_dir=None):

    try:

        gsm = GEOparse.get_GEO(geo=geo_id, destdir=dest_dir, silent=True, how="brief")
        metadata = gsm.metadata
        
        if 'characteristics_ch1' in metadata:
            sample_type = gsm.metadata["characteristics_ch1"][0].split(sep=":")[-1][1:] # fetch annoation
            disease = gsm.metadata["characteristics_ch1"][-1].split(sep=":")[-1][1:]    # fetch disease annoation
            if sample_type == "peripheral blood":
                return (geo_id, disease)

        return (geo_id, np.nan)
    
    except Exception as e:
        return (geo_id, f"ERROR: {str(e)}")


def main():

    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <geo_id_list_file> <output_dir> <output_name>")
        sys.exit(1)

    # Read GSM IDs
    with open(GSN_LIST, 'r') as f:
        geo_list = [line.strip() for line in f if line.strip()]
    
    print(f"Processing {len(geo_list)} GSM IDs...")
    
    # Setup multiprocessing
    num_workers = max(1, N_JOBS) # cpu_count() - 1
    results = []
    
    try:
        with Pool(processes=num_workers, initializer=init_worker) as pool:
            worker_func = partial(extract_leukemia_class, dest_dir="./geo_cache")
            
            # Process with progress updates
            for i, result in enumerate(pool.imap_unordered(worker_func, geo_list, chunksize=10)):
                results.append(result)
                
                # Print progress 
                print(f"  Processed {i+1}/{len(geo_list)} samples")


    except KeyboardInterrupt:
        print("\nProcess interrupted. Saving partial results...")
    
    df = pd.DataFrame(results, columns=['GSM_ID', 'Disease'])
    df.dropna(axis=0, inplace=True)
    df.set_index('GSM_ID', inplace=True)
    df.sort_index(inplace=True)
    df.to_csv(f"{OUT_FILE}")
    

if __name__ == '__main__':
    main()
