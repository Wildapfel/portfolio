import pandas as pd

LABELS           = "./data/raw/GSE16455/GSE16455_labels.csv"
LABELS_CLL_ONLY  = "./data/raw/GSE16455/GSE16455_labels_cll_only.csv"
SAMPLES_CLL_ONLY = "./data/raw/GSE16455/GSE16455_samples_cll_only.txt"

if __name__ == "__main__":

    labels = pd.read_csv(LABELS, index_col=0)
    lables_sel = labels[labels["Disease"] == 1]
    lables_sel.to_csv(LABELS_CLL_ONLY)

    with open(SAMPLES_CLL_ONLY, "w") as fp:
        for gse in lables_sel.index:
            fp.write(gse)
            fp.write("\n")