import pandas as pd

LABELS  = "./data/raw/GSE16455/GSE16455_labels_cll_rest.csv"
TEST    = "./data/processed/bg_corrected_train_qdn_test_scaled/GSE16455_test.csv"
TEST_Y  = "./data/processed/bg_corrected_train_qdn_test_scaled/GSE16455_test_y.csv"

if __name__ == "__main__":

    df_train = pd.read_csv(TEST, index_col=0, usecols=[0])

    df_labels = pd.read_csv(LABELS)
    df_labels_train = df_labels[df_labels["GSM_ID"].isin(df_train.index)]
    df_labels_train.to_csv(TEST_Y, index=False)
