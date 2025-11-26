import sys
import pandas as pd
import argparse


def assign_number(exp_names):
    
    names = {}
    for name in exp_names:
        i = 1
        while True:
            if not name + f".{i}" in names:
                names[name + f".{i}"] = None
                break
            else:
                i += 1
    print(list(names.keys()))
    return list(names.keys())


def list_of_strings(arg):
    return arg.split(sep = " ")


def _init_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument("--col_name", type=str, required=True)
    parser.add_argument("--exp_names", type=str, required=True)
    parser.add_argument("--target_names", type=str, required=True)
    parser.add_argument("--df_paths", type=str, required=True)
    parser.add_argument("--fout", type=str, required=True)
    return parser


if __name__ == "__main__":

    parser = _init_parser()
    args = parser.parse_args()

    # read args
    col_name = args.col_name
    exp_names = list_of_strings(args.exp_names)
    target_names = list_of_strings(args.target_names)
    df_paths = list_of_strings(args.df_paths)
    fout = args.fout

    # init base df, first parsed table
    df_return = pd.read_csv(df_paths[0], sep="\t")
    df_return = df_return[["target_id", col_name]]

    for df_path in df_paths[1:]:
        df_tmp = pd.read_csv(df_path, sep="\t")
        assert list(df_tmp["target_id"]) == list(df_return["target_id"]), f"""
            TargetIdMismatchError: df_tmp has different target_ids then df_base"""  # check if target ids truely match 
        df_return = pd.concat(
                        objs=[df_return, df_tmp[[col_name]]],
                        axis=1
                    )

    df_return.columns = ["target_id"] + assign_number(exp_names)
    df_return = df_return[["target_id"] + target_names]                             # sort by target_names
    df_return.set_index("target_id", inplace=True)
    df_return.to_csv(fout)
