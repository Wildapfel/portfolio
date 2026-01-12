import numpy as np

models = {
    "svm-linear" : { 
        "grid": {
            "C":            [0.001, 0.01, 0.1, 1, 10, 100, 1000],
            "gamma":        ["scale", "auto"],
            "kernel":       ["linear"]
        }
    },
    # "svm-rbf" : { 
    #   "grid": {
    #       "C":            [0.001, 0.01, 0.1, 1, 10, 100, 1000],
    #       "gamma":        [100.0, 10.0, 1.0, 0.1, 0.01, 0.001, 0.0001],
    #       "kernel":       ["rbf"]
    #   }
    # },
    # "rf": {
    #     "grid": {
    #         "n_estimators": [50, 100, 150, 200, 250],
    #         "max_features": [2, 3,4,5],
    #         "max_depth":    [5, 7, 9, 11]
    #     }
    # },
    # "nb": {
    #     "grid" : {
    #         "var_smoothing": np.logspace(0,-9, num=20)
    #     }
    # },
    # "logit" : {
    #     "grid" : {
    #         "C" : [0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0], 
    #         "solver": ["lbfgs", 'liblinear']
    #     }
    # },
    # "knn": {
    #     "grid": {
    #         "n_neighbors":  [1, 2, 3, 4, 5, 6, 7, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50],
    #         "weights":      ['distance'],
    #         "metric":       ['euclidean'] 
    #     }
    # }
}