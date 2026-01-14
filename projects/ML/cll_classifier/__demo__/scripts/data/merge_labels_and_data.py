import sys
import pandas as pd

LABELS      = sys.argv[1]
DATA        = sys.argv[2]
OUT_FILE    = sys.argv[3]


if __name__ == "__main__":

    labels = pd.read_csv(LABELS)
    data_T = pd.read_csv(DATA).transpose()

    probes = data_T.iloc[0, :].to_list() # fetch probes ids to merge into columns 

    data_T = data_T.iloc[1:, :]
    data_T.index = [i for i in range(len(data_T))]

    df_merged = pd.concat([labels, data_T], axis=1)
    df_merged.columns = df_merged.columns[:2].to_list() + probes
    df_merged.to_csv(OUT_FILE, index=False)
