import sys
import pandas as pd

LABELS = sys.argv[1]
DATA   = sys.argv[2]
Y_OUT  = sys.argv[3]

if __name__ == "__main__":

    df_train = pd.read_csv(DATA, index_col=0, usecols=[0])
    df_labels = pd.read_csv(LABELS)
    df_labels_train = df_labels[df_labels["GSM_ID"].isin(df_train.index)]
    df_labels_train.to_csv(DATA, index=False)
