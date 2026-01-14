import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

RANDOM_STATE = 0
DATA         = "./data/GSE13159/GSE13159_pb_merged.csv"
X_TRAIN_OUT  = "./data/classifiers/pb_cll_screener/GSE13159/X_train.csv"
Y_TRAIN_OUT  = "./data/classifiers/pb_cll_screener/GSE13159/y_train.csv"
X_TEST_OUT   = "./data/classifiers/pb_cll_screener/GSE13159/X_test.csv"
Y_TEST_OUT   = "./data/classifiers/pb_cll_screener/GSE13159/y_test.csv"



if __name__ == "__main__":

    df = pd.read_csv(DATA, index_col=0)

    non_cll = list(np.unique(df["Disease"]))
    non_cll.remove("CLL")
    non_cll

    for disease in non_cll:
        df.replace(disease, "Non-CLL", inplace=True)

    df.replace("CLL", 0, inplace=True)
    df.replace("Non-CLL", 1, inplace=True)

    df_train, df_test = train_test_split(df,
                                         test_size = 0.20, 
                                         random_state = RANDOM_STATE, 
                                         stratify = df.iloc[:, 0])

    X_train = df_train.iloc[:, 1:]
    y_train = df_train.iloc[:, 0]
    X_test  = df_test.iloc[:, 1:]
    y_test  = df_test.iloc[:, 0]
   
    X_train.to_csv(X_TRAIN_OUT, index=False)
    y_train.to_csv(Y_TRAIN_OUT, index=False)
    X_test.to_csv(X_TEST_OUT, index=False)
    y_test.to_csv(Y_TEST_OUT, index=False)

