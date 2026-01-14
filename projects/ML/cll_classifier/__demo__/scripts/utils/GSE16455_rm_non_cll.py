import sys
import pandas as pd

X     = sys.argv[1]
Y     = sys.argv[2]
X_OUT = sys.argv[3]
Y_OUT = sys.argv[4]

if __name__ == "__main__":

    df = pd.read_csv(X, index_col=0)
    labels = pd.read_csv(Y, index_col=0)
    labels_sel = labels[labels["Disease"] == 0]
    df_sel = df[labels["Disease"] == 0]

    df_sel.to_csv(X_OUT)
    labels_sel.to_csv(Y_OUT)

