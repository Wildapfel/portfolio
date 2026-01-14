from sklearn.model_selection import GridSearchCV, StratifiedKFold


def strat_search(X, y, param_grid, classifier, n_jobs, n_cv, score, verbose = False):

    #
    # grid search
    #
    cv = StratifiedKFold(n_splits=n_cv)

    grid = GridSearchCV(classifier, param_grid, cv=cv, scoring=score, n_jobs=n_jobs, verbose = 0)
    grid.fit(X, y)

    return grid
