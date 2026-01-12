import sys
import pandas as pd

DATA_FILE      = sys.argv[1]
TRANSPOSE_FILE = sys.argv[2]

if __name__ == "__main__":

    df = pd.read_csv(DATA_FILE, index_col=0) # this index_col is specfic set for this data
    df_T = df.transpose()
    df_T.to_csv(TRANSPOSE_FILE)
