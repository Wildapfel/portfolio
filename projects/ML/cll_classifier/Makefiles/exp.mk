#
# Full sample rma (Data Leakage, just out of curiosity)
#

exp01_train:
	python ./scripts/train/run_grid_search.py \
		--models ./experiments/shared/models.py \
		--train ./experiments/01_bg_corrected_all_samples/configs/train.yaml

exp01_eval:
	python ./scripts/train/eval_grid_search.py \
		--models ._experiments/shared/models.py \
		--eval ./experiments/01_bg_corrected_all_samples/configs/eval_train.yaml \
		--gs \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/01_bg_corrected_all_samples/configs/eval_GSE13159_test.yaml \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/01_bg_corrected_all_samples/configs/eval_GSE16455_test.yaml \
		--one


#
# Standard Scaled
#

exp02_train:
	python ./scripts/train/run_grid_search.py \
		--models ./experiments/shared/models.py \
		--train ./experiments/02_bg_corrected_mean_sd_scaled/configs/train.yaml

exp02_eval:
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/02_bg_corrected_mean_sd_scaled/configs/eval_train.yaml \
		--gs \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/02_bg_corrected_mean_sd_scaled/configs/eval_GSE13159_test.yaml \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/02_bg_corrected_mean_sd_scaled/configs/eval_GSE16455_test.yaml \
		--one


#
# Robust Scaled
#

exp03_train:
	python ./scripts/train/run_grid_search.py \
		--models ./experiments/shared/models.py \
		--train ./experiments/03_bg_corrected_median_mad_scaled/configs/train.yaml

exp03_eval:
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/03_bg_corrected_median_mad_scaled/configs/eval_train.yaml \
		--gs \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/03_bg_corrected_median_mad_scaled/configs/eval_GSE13159_test.yaml \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/03_bg_corrected_median_mad_scaled/configs/eval_GSE16455_test.yaml \
		--one


#
# DQN EXT using a median-mad-shift-vector (Approxximate the DQN)
#

exp04_train:
	python ./scripts/train/run_grid_search.py \
		--models ./experiments/shared/models.py \
		--train ./experiments/04_bg_corrected_train_dqn_ext_test_scaled/configs/train.yaml

exp04_eval:
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/04_bg_corrected_train_dqn_ext_test_scaled/configs/eval_train.yaml \
		--gs \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/04_bg_corrected_train_dqn_ext_test_scaled/configs/eval_GSE13159_test.yaml \
		--roc \
		--pr \
		--cm
	python ./scripts/train/eval_grid_search.py \
		--models ./experiments/shared/models.py \
		--eval ./experiments/04_bg_corrected_train_dqn_ext_test_scaled/configs/eval_GSE16455_test.yaml \
		--one


#
# DEPRECATED: Mathematically incorrecot 
# DQN onto test, and wrongly scaled (this should me mathemcically incorrect)
#

# exp04_train:
# 	python ./scripts/train/run_grid_search.py \
# 		--models ./__experiments/shared/models.py \
# 		--train ./__experiments/04_bg_corrected_train_dqn_test_scaled/configs/train.yaml

# exp04_eval:
# 	python ./scripts/train/eval_grid_search.py \
# 		--models ./__experiments/shared/models.py \
# 		--eval ./__experiments/04_bg_corrected_train_dqn_test_scaled/configs/eval_train.yaml \
# 		--gs \
# 		--roc \
# 		--cm
# 	python ./scripts/train/eval_grid_search.py \
# 		--models ./__experiments/shared/models.py \
# 		--eval ./__experiments/04_bg_corrected_train_dqn_test_scaled/configs/eval_GSE13159_test.yaml \
# 		--roc \
# 		--cm
# 	python ./scripts/train/eval_grid_search.py \
# 		--models ./__experiments/shared/models.py \
# 		--eval ./__experiments/04_bg_corrected_train_dqn_test_scaled/configs/eval_GSE16455_test.yaml \
# 		--one
