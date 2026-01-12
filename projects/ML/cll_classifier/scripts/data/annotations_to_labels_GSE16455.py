import pandas as pd
import numpy as np

DATA = "./data/raw/GSE16455/GSE16455_annot.csv"
OUT = "./data/raw/GSE16455/GSE16455_labels.csv"

if __name__ == "__main__":

    df = pd.read_csv(DATA, index_col=0)
    
    non_cll = list(np.unique(df["Disease"]))
    non_cll.remove("CLL (Chronic Lymphocytic Leukemia)")

    for disease in non_cll:
        df.replace(disease, "Non-CLL", inplace=True)

    df.replace("CLL (Chronic Lymphocytic Leukemia)", 1, inplace=True)
    df.replace("Non-CLL", 0, inplace=True)
    
    df.to_csv(OUT)