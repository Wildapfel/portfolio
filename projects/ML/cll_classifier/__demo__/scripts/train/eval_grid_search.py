import os, pickle, warnings, argparse, yaml, glob, sys
warnings.filterwarnings("ignore")

import numpy as np
from tqdm import tqdm
import pandas as pd
import plotwrapper.pyplot as plt
from scipy.special import expit
from sklearn.metrics import (balanced_accuracy_score, 
                             accuracy_score,
                             precision_score,
                             recall_score,
                             f1_score)



def init_args():

    parser = argparse.ArgumentParser()
    parser.add_argument("--models", help="path to model yaml", required=True)               # I still need this for the grid_search_plot (param grid)
    parser.add_argument("--eval", help="path to eval yaml", required=True)
    parser.add_argument("--gs", help="plot grid_search", action="store_true")               # default: false
    parser.add_argument("--cm", help="plot confusion matrix", action="store_true")               # default: false
    parser.add_argument("--roc", help="plot roc curve", action="store_true")                # default: false
    parser.add_argument("--pr", help="plot precision recall curve", action="store_true")                # default: false
    parser.add_argument("--one", help="plot one class probabilities", action="store_true")  # default: false

    return parser.parse_args()



# Compute the metrics
def evaluate(y_test, y_pred, threshold):
    
    y_pred = (y_pred >= threshold).astype(int)

    return(balanced_accuracy_score(y_test, y_pred),
           precision_score(y_test, y_pred),
           recall_score(y_test, y_pred),
           f1_score(y_test, y_pred))


def main():

    args = init_args()  

    #
    # Models (param grid)
    # --------------------
    # - Import from the param grid .py file
    #
    sys.path.append(os.path.dirname(args.models))
    from models import models

    #
    # Fetch the config
    # 
    eval_path = args.eval
    with open(eval_path) as f:
        eval = yaml.safe_load(f)

    #
    # Labels from yaml
    #
    LABELS = eval["data"]["labels"]

    #
    # eval
    #   
    y_test = pd.read_csv(eval["data"]["y-test"])["Disease"] # np.ravel()

    for model_path in glob.glob(f"{eval["dirs"]["models"]}/*"):

        feat_sel_dir = f"{eval["dirs"]["eval"]}/{model_path.split(sep="/")[-1]}"
        os.makedirs(feat_sel_dir, exist_ok=True)

        for f in os.listdir(model_path):

            stats = []

            if f.endswith(".pk"):

                model_name = f.split(sep=".")[0]
                grid_obj = pickle.load(open(f"{model_path}/{f}", "rb"))
                grid = grid_obj["grid_search"]
                g_opt_t = grid_obj["g_opt_t"]
                j_opt_t = grid_obj["j_opt_t"]
                f1_opt_t = grid_obj["f1_opt_t"]
                cols = grid_obj["features"]
                X_test = pd.read_csv(eval["data"]["X-test"], usecols=cols)      # quick note: Also reorder colusn here !
                X_test = X_test.loc[:, cols]

                y_score = None
                y_score_prob = None
                default = None
             
                try:
                    y_score = grid.best_estimator_.predict_proba(X_test)[:, 1]  # quick note: I assume that the true label is at index 1 
                    y_score_prob = y_score
                    default = 0.5
                except:
                    y_score = grid.best_estimator_.decision_function(X_test)
                    y_score_prob = expit(y_score)
                    default = 0.0

                y_pred_g = (y_score >= g_opt_t).astype(int)
                y_pred_j = (y_score >= j_opt_t).astype(int)
                y_pred_f1 = (y_score >= f1_opt_t).astype(int)
                y_pred_d = (y_score >= default).astype(int)
                
                acc_g = accuracy_score(y_test, y_pred_g)
                acc_j = accuracy_score(y_test, y_pred_j)
                acc_f1 = accuracy_score(y_test, y_pred_f1)
                acc_d = accuracy_score(y_test, y_pred_d)

                stats_g = evaluate(y_test, y_score, g_opt_t)
                stats_j = evaluate(y_test, y_score, j_opt_t)
                stats_f1 = evaluate(y_test, y_score, f1_opt_t)
                stats_d = evaluate(y_test, y_score, default)

                stats.append(stats_g) 
                stats.append(stats_j)
                stats.append(stats_f1)
                stats.append(stats_d)

                if args.gs:
                    # quick note: this is always the cv scoring from training !!
                    x_label = list(models[model_name]["grid"].keys())[0]
                    y_label = grid.scoring
                    fig, axs = plt.subplots(figh=8, figw=8)
                    axs[0][0].grid_search_plot(grid.cv_results_, 
                                            x_label, 
                                            y_label,
                                            *models[model_name]["grid"])
                    fig.savefig(f"{feat_sel_dir}/gs_{model_name}.png", bbox_inches = "tight")

                if args.cm:
                    fig, axs = plt.subplots(figh=8, figw=8)
                    axs[0][0].confusion_matrix_plot(y_test, y_pred_g, labels = LABELS)
                    fig.savefig(f"{feat_sel_dir}/cm_{model_name}_g.png", bbox_inches = "tight")

                    fig, axs = plt.subplots(figh=8, figw=8)
                    axs[0][0].confusion_matrix_plot(y_test, y_pred_j, labels = LABELS)
                    fig.savefig(f"{feat_sel_dir}/cm_{model_name}_j.png", bbox_inches = "tight")

                    fig, axs = plt.subplots(figh=8, figw=8)
                    axs[0][0].confusion_matrix_plot(y_test, y_pred_f1, labels = LABELS)
                    fig.savefig(f"{feat_sel_dir}/cm_{model_name}_f1.png", bbox_inches = "tight")

                    fig, axs = plt.subplots(figh=8, figw=8)
                    axs[0][0].confusion_matrix_plot(y_test, y_pred_d, labels = LABELS)
                    fig.savefig(f"{feat_sel_dir}/cm_{model_name}_d.png", bbox_inches = "tight")

                if args.roc:
                    fig, axs = plt.subplots()
                    axs[0][0].roc_curve_plot(y_test, y_score, g_opt_idx=True, j_opt_idx=True)
                    fig.savefig(f"{feat_sel_dir}/roc_{model_name}.png", bbox_inches = "tight")

                if args.pr:
                    fig, axs = plt.subplots()
                    axs[0][0].pr_curve_plot(y_test, y_score, f1_opt=True)
                    fig.savefig(f"{feat_sel_dir}/pr_{model_name}.png", bbox_inches = "tight")

                if args.one:
                    metrics = {
                        "acc(default)": acc_d,
                        "acc(gmean)": acc_g,
                        "acc(J stat.)": acc_j,
                        "acc(f1)": acc_f1,
                    }
                    max_key_len = max(len(k) for k in metrics)
                    fig, axs = plt.subplots()
                    axs[0][0].bar(x=[i for i in range(len(y_score))], 
                                  height=y_score_prob,
                                  ylim=[0.0, 1.0],
                                  ylabel="P",
                                  xlabel="Sample",
                                  label= "\n".join(
                                        "{:<14} = {:.2f}".format(k, v)
                                        for k, v in metrics.items()
                                    ))
                    axs[0][0]._ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))
                    axs[0][0]._ax.set_xticks([i for i in range(len(y_score))])
                    fig.savefig(f"{feat_sel_dir}/prob_{model_name}.png", bbox_inches = "tight")
        
                stats_np = np.array(stats)
                df_stats = pd.DataFrame(data=stats_np, index=["opt_g", "opt_j", "opt_f1", "opt_d"], columns=["bas", "p", "r", "f1"])
                df_stats.to_csv(f"{feat_sel_dir}/{model_name}_stats.csv")

if __name__ == "__main__":
    main()