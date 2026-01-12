import pickle, os
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

LABELS              = "./data/raw/GSE13159/GSE13159_labels_pb_only.csv"
TRAIN_GSM_IDS_PK    = "./data/raw/GSE13159/split_gsm_ids/train_gsm_ids.pk"
TEST_GSM_IDS_PK     = "./data/raw/GSE13159/split_gsm_ids/test_gsm_ids.pk"
TRAIN_GSM_IDS_TXT   = "./data/raw/GSE13159/split_gsm_ids/train_gsm_ids.txt"
TEST_GSM_IDS_TXT    = "./data/raw/GSE13159/split_gsm_ids/test_gsm_ids.txt"
RANDOM_STATE        = 0


if __name__ == "__main__":

    df_labels_pb = pd.read_csv(LABELS)

    os.makedirs("./data/raw/GSE13159/split_gsm_ids", exist_ok=True)
    
    df_train, df_test = train_test_split(df_labels_pb, 
                                         test_size=0.2, 
                                         random_state=RANDOM_STATE)

    pickle.dump(list(df_train["GSM_ID"]),
                open(TRAIN_GSM_IDS_PK, "wb"))
    pickle.dump(list(df_test["GSM_ID"]),
                open(TEST_GSM_IDS_PK, "wb"))

    with open(TRAIN_GSM_IDS_TXT, "w") as fp:
        for ele in list(df_train["GSM_ID"]):
            fp.write(ele)
            fp.write("\n")                        

    with open(TEST_GSM_IDS_TXT, "w") as fp:
        for ele in list(df_test["GSM_ID"]):
            fp.write(ele)
            fp.write("\n")                    
