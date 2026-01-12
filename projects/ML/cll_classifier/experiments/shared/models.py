import numpy as np

models = {
    "svm-linear" : { 
        "grid": {
            "C":            [0.001, 0.01, 0.1, 1, 10, 100, 1000],
            "gamma":        ["scale"],
            "kernel":       ["linear"]
        }
    },
    "svm-rbf" : { 
      "grid": {
          "C":            [0.001, 0.01, 0.1, 1, 10, 100, 1000],
          "gamma":        [0.001, 0.01, 0.1, 1], 
          "kernel":       ["rbf"]
      }
    },
    "svm-linear-weighted" : { 
        "grid": {
            "C":            [0.001, 0.01, 0.1, 1, 10, 100, 1000],
            "gamma":        ["scale"],
            "kernel":       ["linear"]
        }
    },
    "svm-rbf-weighted" : { 
      "grid": {
          "C":            [0.001, 0.01, 0.1, 1, 10, 100, 1000],
          "gamma":        [0.001, 0.01, 0.1, 1], 
          "kernel":       ["rbf"]
      }
    },
    "nb": {
        "grid" : {
            "var_smoothing": np.logspace(0,-12, num=25)
        }
    },
    "logit" : {
        "grid" : {
            "C" : [0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0], 
            "solver": ["saga", 'liblinear'],
            'penalty': ['l1', 'l2', 'elasticnet'],
            'l1_ratio': [0, 0.25, 0.5, 0.75, 1]  # only used with elasticnet
        }
    },
    "logit-weighted" : {
        "grid" : {
            "C" : [0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0], 
            "solver": ["saga", 'liblinear'],
            'penalty': ['l1', 'l2', 'elasticnet'],
            'l1_ratio': [0, 0.25, 0.5, 0.75, 1]  # only used with elasticnet
        }
    },
    "knn": {
        "grid": {
        "n_neighbors":  [1, 2, 3, 4, 5, 6, 7, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50],
        "weights":      ['uniform', 'distance'],
        "metric":       ['euclidean', 'manhattan', 'chebyshev', 'minkowski']
        }
    }

    #
    # I will exclude rf since, its not really comparable, I was just curios how those models 
    # behave...
    #
    # "rf": {
    #     "grid": {
    #         "n_estimators": [100, 300, 500],
    #         "max_features": [2, 3, 4, 5],
    #         "max_depth": [3, 5, 7, 10],
    #         "min_samples_split": [2, 5, 10],
    #     }
    # },
}