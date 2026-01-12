import pandas as pd

GSE13159_TRAIN           = "./data/raw/GSE13159/split_gsm_ids/train_gsm_ids.txt"
GSE13159_TEST            = "./data/raw/GSE13159/split_gsm_ids/test_gsm_ids.txt"
GSE16455_TEST            = "./data/raw/GSE16455/GSE16455_samples_cll_only.txt"
DF_PROCESSED_ALL_SAMPLES = "./data/processed/bg_corrected_dqn_all_samples/dqn_all_samples.csv"
GSE13159_TRAIN_DF        = "./data/processed/bg_corrected_dqn_all_samples/GSE13159_train.csv"
GSE13159_TEST_DF         = "./data/processed/bg_corrected_dqn_all_samples/GSE13159_test.csv"
GSE16455_TEST_DF         = "./data/processed/bg_corrected_dqn_all_samples/GSE16455_test.csv"


if __name__ == "__main__":

    df = pd.read_csv(DF_PROCESSED_ALL_SAMPLES, index_col=0) 
    df_T = df.transpose()

    gse13159_train_gsm_ids = [gsm_id[:-1] for gsm_id in open(GSE13159_TRAIN).readlines()]
    gse13159_test_gsm_ids = [gsm_id[:-1] for gsm_id in open(GSE13159_TEST).readlines()]
    gse16455_test_gsm_ids = [gsm_id[:-1] for gsm_id in open(GSE16455_TEST).readlines()]
    
    df_sel = df_T[df_T.index.isin(gse13159_train_gsm_ids)]
    df_rest = df_T[~df_T.index.isin(gse13159_train_gsm_ids)]
    del df_T 
    df_sel.to_csv(GSE13159_TRAIN_DF)

    df_sel = df_rest[df_rest.index.isin(gse13159_test_gsm_ids)]
    df_rest = df_rest[~df_rest.index.isin(gse13159_test_gsm_ids)]
    df_sel.to_csv(GSE13159_TEST_DF)

    df_sel = df_rest[df_rest.index.isin(gse16455_test_gsm_ids)]
    df_rest = df_rest[~df_rest.index.isin(gse16455_test_gsm_ids)]
    df_sel.to_csv(GSE16455_TEST_DF)

    # ignore for now, because i fine select for CLL only in GSE16455
    # assert df_rest.shape[0] == 0, f"All gsm_ids should be in the df. Not found: {df_rest.index}"

