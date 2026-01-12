#
# I dont need this anymore, because I can just fetch the ideas from the 
# series download with wget from ncbi geo.
#

import sys
import pandas as pd

DF_PATH  = sys.argv[1]
OUT_DIR  = sys.argv[2]
OUT_NAME = sys.argv[3]

if __name__ == "__main__":

    df = pd.read_csv(DF_PATH, nrows=2)
    gsm_from_col = df.columns[1:]
    
    with open(f"{OUT_DIR}/{OUT_NAME}", "w") as fp:
        for gsm in gsm_from_col:
            fp.write(f"{gsm}\n")

