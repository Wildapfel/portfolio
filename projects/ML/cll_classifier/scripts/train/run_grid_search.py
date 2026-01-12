import os, pickle, sys, joblib, argparse, yaml, glob
sys.path.append("./")
joblib.parallel_backend(backend="threading") # removes some weird, new error that I get when runing parallel in training

import numpy as np
from src.grid_search import strat_search
import pandas as pd

from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn.naive_bayes import GaussianNB
from sklearn.model_selection import cross_val_predict
from sklearn.metrics import (roc_curve, 
                             balanced_accuracy_score, 
                             f1_score, 
                             precision_recall_curve)

MODEL_MAPPER = {
    "knn" :                 KNeighborsClassifier(),
    "logit" :               LogisticRegression(),
    "logit" :               LogisticRegression(),
    "logit-weighted" :      LogisticRegression(class_weight="balanced"),
    "nb" :                  GaussianNB(),
    "rf" :                  RandomForestClassifier(random_state=0),
    "svm-linear" :          SVC(kernel="linear", random_state=0),
    "svm-linear-weighted" : SVC(kernel="linear", random_state=0, class_weight="balanced"),
    "svm-poly" :            SVC(kernel="poly", random_state=0),
    "svm-sigmoid" :         SVC(kernel="sigmoid", random_state=0),
    "svm-rbf" :             SVC(kernel="rbf", random_state=0),
    "svm-rbf-weighted" :    SVC(kernel="rbf", random_state=0, class_weight="balanced")
}

N_JOBS = 6
N_CV   = 5
SCORE  = "balanced_accuracy" # roc_auc, balanced_accuracy, matthews_corrcoef, auc (this is for PR curve)


def init_args():

    parser = argparse.ArgumentParser()
    parser.add_argument("--models", help="path to model python (param grid)", required=True)
    parser.add_argument("--train", help="path to train yaml (train data)", required=True)

    return parser.parse_args()


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
    train_path = args.train
    with open(train_path) as f:
        train = yaml.safe_load(f)

    #
    # Extract multiple feature selections from model yaml
    #
    feat_sels = []
    if train["data"]["feature-selection"]:
        for path in glob.glob(train["data"]["feature-selection"]):
            cols = pickle.load(open(path, "rb"))
            feat_sels.append((cols, path))
    
   
    #
    # Run here, if no feature selection is specified
    #
    if len(feat_sels) == 0:
        
        X = pd.read_csv(train["data"]["X-train"]) # , index_col=0
        y = np.ravel(pd.read_csv(train["data"]["y-train"])) # , index_col=0

        out_dir = f"{train["out-dirs"]["models"]}/no_feat_sel"
        os.makedirs(out_dir, exist_ok=True)

        for model_name in models:
            model = MODEL_MAPPER[model_name]
       
            grid = strat_search(X = X, 
                                y = y, 
                                param_grid = models["models"][model_name]["grid"],
                                classifier = model,
                                n_jobs = N_JOBS,
                                n_cv = N_CV,
                                score = SCORE)

            grid_obj = {"grid_search": grid,    
                        "feature_selection_path": None,                         
                        "scaler": train.get("scale", None),
                        "features": None}

            pickle.dump(grid_obj,
                        open(f"{out_dir}/{model_name}.pk", "wb"))


    #
    # Else, Run here
    #
    for i, feat_sel in enumerate(feat_sels):    

        cols = feat_sel[0]
        path = feat_sel[1]

        out_dir = f"{train["out-dirs"]["models"]}/feat_sel_{i + 1}"
        os.makedirs(out_dir, exist_ok=True)

        X = pd.read_csv(train["data"]["X-train"], usecols=cols)    # quick note: I must rearange the order, 
        X = X.loc[:,list(cols)]                                    # because usecols only may arange to cols 
                                                                   # differently then I epxect from featsels
        y = pd.read_csv(train["data"]["y-train"])["Disease"] # np.ravel()

        for model_name in models:

            model = MODEL_MAPPER[model_name]
           
            grid = strat_search(X = X, 
                                y = y, 
                                param_grid = models[model_name]["grid"],
                                classifier = model,
                                n_jobs = N_JOBS,
                                n_cv = N_CV,
                                score = SCORE)

            # NEW: Threshold Tuning
            best_model = grid.best_estimator_
            try:
                cv_scores = cross_val_predict(best_model, X, y, cv=N_CV,  method="predict_proba")[:,1]
            except Exception as e:
                cv_scores = cross_val_predict(best_model, X, y, cv=N_CV,  method="decision_function") 

            fpr, tpr, t_roc = roc_curve(y, cv_scores)
            precisions, recalls, t_pr = precision_recall_curve(y, cv_scores)

            # roc based
            g_mean = np.sqrt(tpr * (1-fpr))
            g_opt_idx = np.argmax(g_mean)
            j_opt_idx = np.argmax(tpr-fpr)
            g_opt_t = t_roc[g_opt_idx]
            j_opt_t = t_roc[j_opt_idx]
         
            # pr based
            fscore = (2 * precisions * recalls) / (precisions + recalls)
            f1_opt_idx = np.argmax(fscore)
            f1_opt_t = t_pr[f1_opt_idx]

            grid_obj = {"grid_search": grid,    
                        "g_opt_t": g_opt_t,
                        "j_opt_t": j_opt_t,
                        "f1_opt_t": f1_opt_t,
                        "feature_selection_path": path,                         
                        "scaler": train.get("scale", None),
                        "features": cols}

            pickle.dump(grid_obj,
                        open(f"{out_dir}/{model_name}.pk", "wb"))

        with open(f"{out_dir}/log.txt", "w") as fp:
            fp.write(path)
        

if __name__ == "__main__":
    main()
    