import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

RANDOM_STATE = 0
DATA         = "./data/GSE16455/GSE16455_merged.csv"
X_TEST_OUT   = "./data/classifiers/pb_cll_screener/GSE16455/X_test.csv"
Y_TEST_OUT   = "./data/classifiers/pb_cll_screener/GSE16455/y_test.csv"


DISEASE_LABEL_MAPPER = {
    "CLL (Chronic Lymphocytic Leukemia)"        : 0,
    "cMCL (conventional mantle cell lymphoma)"  : 1,
    "LF (follicular lymphoma)"                  : 1,
    "iMCL (indolent mantle cell lymphoma)"      : 1,
    "SMLZ (Splenic Marginal Zone Lymphoma)"     : 1,
    "HCL (Hairy Cell Leukemia)"                 : 1,
    "HCL (Hairy Cell Leukemia)-variant"         : 1,
    "cMCL (conventional)"                       : 1
}



if __name__ == "__main__":

    df = pd.read_csv(DATA, index_col=0)

    for disease in DISEASE_LABEL_MAPPER:
        df.replace(disease, DISEASE_LABEL_MAPPER[disease], inplace=True)

    X_test  = df.iloc[:, 1:]
    y_test  = df.iloc[:, 0]
   
    X_test.to_csv(X_TEST_OUT, index=False)
    y_test.to_csv(Y_TEST_OUT, index=False)

