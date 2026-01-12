import pickle
import pandas as pd

LABELS         = "./data/raw/GSE13159/GSE13159_labels_pb_only.csv" 
GSE13159_TRAIN = "./data/raw/GSE13159/split_gsm_ids/train_gsm_ids.pk"
GSE13159_TEST  = "./data/raw/GSE13159/split_gsm_ids/test_gsm_ids.pk"

LABELS_TRAIN   = "./data/raw/GSE13159/GSE13159_labels_pb_only_train.csv"
LABELS_TEST    = "./data/raw/GSE13159/GSE13159_labels_pb_only_test.csv"

if __name__ == "__main__":

    labels = pd.read_csv(LABELS, index_col = 0)
    train = pickle.load(open(GSE13159_TRAIN, "rb"))
    test = pickle.load(open(GSE13159_TEST, "rb"))

    labels_train = labels[labels.index.isin(train)]
    labels_test = labels[labels.index.isin(test)]

    labels_train.to_csv(LABELS_TRAIN)
    labels_test.to_csv(LABELS_TEST)    