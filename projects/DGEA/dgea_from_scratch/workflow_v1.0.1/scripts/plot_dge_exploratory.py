import sys
sys.path.append("/var/home/maxpetzold/HUB_local/")

from multiprocessing import Pool

import os
import argparse
import pandas as pd

from codebase.src.plots.Plots import Plots


def InitArgparse():

    parser = argparse.ArgumentParser()

    parser.add_argument("-t", "--dge-table", help = "table with the differential expressed profiles", type = str, required=True)
    parser.add_argument("-o", "--out-dir", help = "Output Directory", type = str, required = True)
    parser.add_argument("-n","--name", help = "Name of output files", type = str, required = True)
    parser.add_argument("-s", "--separate", help = "Column speration [','|'\\t']", type = str, required = True) 
    parser.add_argument("--boxplots", help="boxplots in single plot", action="store_true", required = False)
    parser.add_argument("--histograms", help="separate histograms", action="store_true", required = False)
    parser.add_argument("--histograms-single-plot", help="histograms in single plot", action="store_true", required = False)
    parser.add_argument("--histograms-cum", help="cumuluative histograms of all columns in table", action="store_true", required = False)
    parser.add_argument("--scatter-matrix", help="scatter matrix", action="store_true", required = False)
    parser.add_argument("--mean-of-cols", help="scatter plot mean values of each column", action="store_true", required = False)
    parser.add_argument("--std-of-cols", help="scatter plot mean values of each column", action="store_true", required = False)
    parser.add_argument("--pca-with-labels", help="perform pca with label collering", action="store_true", required = False)
    parser.add_argument("--pca", help="principal component analysis", action="store_true", required = False)
    parser.add_argument("--mds", help="multidimensional scaling", action="store_true", required = False)
    parser.add_argument("--vulcano-plot", help="vulcano plot", action="store_true", required = False)
    parser.add_argument("--all", help = "Calculate all plots",action="store_true", required=False)
    
    args = parser.parse_args()

    return args


def DGE_Plots(job_args):

    df = job_args[0]
    output = job_args[1]
    args_dict = job_args[2]

    plots = Plots()

    FUNC_DICT = {
        "boxplots" : plots.boxplots,
        "histograms" : plots.histograms,
        "histograms-single-plot" : plots.histograms_single_plot,
        "histograms-cum" : plots.cum_hists_single_plot,
        "scatter-matrix" : plots.scatter_matrix,
        "mean-of-cols" : plots.mean_of_cols,
        "std-of-cols" : plots.std_of_cols,
        "pca-with-labels" : plots.pca_with_labels,
        "pca" : plots.pca,
        "mds" : plots.mds,
        "vulcano-plot" : plots.vulcano_plot
    }

    for param in args_dict:
        if args_dict[param]:
            FUNC_DICT[param](df, out_file=output)


if __name__ == "__main__":

    args = InitArgparse()

    PATH_DGE_TABLE = args.dge_table 
    PATH_OUT_DIR = args.out_dir
    NAME = args.name
    SEP = args.separate
    OUTPUT = f"{PATH_OUT_DIR}/{NAME}"

    df = pd.read_csv(PATH_DGE_TABLE, index_col=0, sep=SEP)

    args_dict = {
        "boxplots" : args.boxplots,
        "histograms" : args.histograms,
        "histograms-single-plot" : args.histograms_single_plot,
        "histograms-cum" : args.histograms_cum,
        "scatter-matrix" : args.scatter_matrix,
        "mean-of-cols" : args.mean_of_cols,
        "std-of-cols" : args.std_of_cols,
        "pca-with-labels" : args.pca_with_labels,
        "pca" : args.pca,
        "mds" : args.mds,
        "vulcano-plot" : args.vulcano_plot
    }

    if args.all:
        args_dict = {key: True for key in args_dict}

    job_args = [df, OUTPUT, args_dict]

    DGE_Plots(job_args)
    