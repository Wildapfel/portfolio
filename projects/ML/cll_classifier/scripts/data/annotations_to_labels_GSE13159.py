import pandas as pd
import numpy as np

DATA = "./data/raw/GSE13159/GSE13159_annot_pb_only.csv"
OUT = "./data/raw/GSE13159/GSE13159_labels_pb_only.csv"

if __name__ == "__main__":

    df = pd.read_csv(DATA, index_col=0)

    non_cll = list(np.unique(df["Disease"]))
    non_cll.remove("CLL")

    for disease in non_cll:
        df.replace(disease, "Non-CLL", inplace=True)

    df.replace("CLL", 1, inplace=True)
    df.replace("Non-CLL", 0, inplace=True)
    
    df.to_csv(OUT)