import sys
import pandas as pd

DF      = sys.argv[1]
SAMPLES = sys.argv[2]

if __name__ == "__main__":

    df_pb = pd.read_csv(DF)
    
    gsm_ids = df_pb["GSM_ID"].to_list()
    fp = open(SAMPLES, "w")
    for gsm_id in gsm_ids:
        fp.write(gsm_id)
        fp.write("\n")
    fp.close()
