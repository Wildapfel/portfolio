import sys

SERIES_PATH  = sys.argv[1]
OUT_FILE     = sys.argv[2]


if __name__ == "__main__":

    fp_series = open(SERIES_PATH, "r")
    fp_out = open(f"{OUT_FILE}", "w")

    lines = fp_series.readlines()
    for line in lines:
        if "!Series_sample_id" in line:
            gsm_id = line.split(sep="!Series_sample_id = ")[-1]
            fp_out.write(gsm_id)

    fp_series.close()
    fp_out.close()
