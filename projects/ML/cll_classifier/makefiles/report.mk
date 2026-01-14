KNN=knn
LOGIT=logit
LOGIT_WEIGHTED=logit-weighted
NB=nb
SVM_LINEAR=svm-linear
SVM_LINEAR_WEIGHTED=svm-linear-weighted
SVM_RBF=svm-rbf
SVM_RBF_WEIGHTED=svm-rbf-weighted

EXP01=01_bg_corrected_all_samples
EXP02=02_bg_corrected_mean_sd_scaled
EXP03=03_bg_corrected_median_mad_scaled
EXP04=04_bg_corrected_train_dqn_ext_test_scaled


cp:
	# make dirs
	mkdir -p ./report/images/$(EXP01)
	mkdir -p ./report/images/$(EXP02)
	mkdir -p ./report/images/$(EXP03)
	mkdir -p ./report/images/$(EXP04)

	# exp01
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(KNN).png ./report/images/$(EXP01)/
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(LOGIT).png ./report/images/$(EXP01)/
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(LOGIT_WEIGHTED).png ./report/images/$(EXP01)/
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(NB).png ./report/images/$(EXP01)/
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(SVM_LINEAR).png ./report/images/$(EXP01)/
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(SVM_LINEAR_WEIGHTED).png ./report/images/$(EXP01)/
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(SVM_RBF).png ./report/images/$(EXP01)/
	cp ./experiments/$(EXP01)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(SVM_RBF_WEIGHTED).png ./report/images/$(EXP01)/

	# exp02
	mkdir -p ./report/images/$(EXP02)
	cp ./experiments/$(EXP02)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(NB).png ./report/images/$(EXP02)/roc_$(NB)_test.png
	cp ./experiments/$(EXP02)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/pr_$(NB).png ./report/images/$(EXP02)/pr_$(NB)_test.png
	cp ./experiments/$(EXP02)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/roc_$(NB).png ./report/images/$(EXP02)/roc_$(NB)_train.png
	cp ./experiments/$(EXP02)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/pr_$(NB).png ./report/images/$(EXP02)/pr_$(NB)_train.png

	# EXP03
	cp ./experiments/$(EXP03)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(SVM_RBF).png ./report/images/$(EXP03)/
	cp ./experiments/$(EXP03)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/pr_$(SVM_RBF).png ./report/images/$(EXP03)/
	cp ./experiments/$(EXP03)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_RBF)_d.png ./report/images/$(EXP03)/
	cp ./experiments/$(EXP03)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_RBF)_f1.png ./report/images/$(EXP03)/
	cp ./experiments/$(EXP03)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_RBF)_g.png ./report/images/$(EXP03)/
	cp ./experiments/$(EXP03)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_RBF)_j.png ./report/images/$(EXP03)/

	# EXP04
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(LOGIT).png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/pr_$(LOGIT).png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(LOGIT)_d.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(LOGIT)_f1.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(LOGIT)_g.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(LOGIT)_j.png ./report/images/$(EXP04)/
	
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(SVM_LINEAR).png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/pr_$(SVM_LINEAR).png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR)_d.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR)_f1.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR)_g.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR)_j.png ./report/images/$(EXP04)/
	
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/roc_$(SVM_LINEAR).png ./report/images/$(EXP04)/roc_$(SVM_LINEAR)_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/pr_$(SVM_LINEAR).png ./report/images/$(EXP04)/pr_$(SVM_LINEAR)_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR)_d.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR)_d_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR)_f1.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR)_g_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR)_g.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR)_j_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR)_j.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR)_f1_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE16455_test/feat_sel_1/prob_$(SVM_LINEAR).png ./report/images/$(EXP04)/prob_$(SVM_LINEAR)_f1_test2.png

	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/roc_$(SVM_LINEAR_WEIGHTED).png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/pr_$(SVM_LINEAR_WEIGHTED).png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_d.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_f1.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_g.png ./report/images/$(EXP04)/
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE13159_test/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_j.png ./report/images/$(EXP04)/

	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/roc_$(SVM_LINEAR_WEIGHTED).png ./report/images/$(EXP04)/roc_$(SVM_LINEAR_WEIGHTED)_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/pr_$(SVM_LINEAR_WEIGHTED).png ./report/images/$(EXP04)/pr_$(SVM_LINEAR_WEIGHTED)_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_d.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR_WEIGHTED)_d_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_f1.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR_WEIGHTED)_g_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_g.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR_WEIGHTED)_j_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_train/feat_sel_1/cm_$(SVM_LINEAR_WEIGHTED)_j.png ./report/images/$(EXP04)/cm_$(SVM_LINEAR_WEIGHTED)_f1_train.png
	cp ./experiments/$(EXP04)/classifiers/cll_assoc_probes/eval_GSE16455_test/feat_sel_1/prob_$(SVM_LINEAR_WEIGHTED).png ./report/images/$(EXP04)/prob_$(SVM_LINEAR_WEIGHTED)_f1_test2.png

rm:
	rm ./report/images/$(EXP01)/*
	rm ./report/images/$(EXP02)/*
	rm ./report/images/$(EXP03)/*
	rm ./report/images/$(EXP04)/*