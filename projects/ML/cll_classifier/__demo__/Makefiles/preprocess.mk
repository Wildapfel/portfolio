# 1. DQN both experiments
# 2. DQN GSE13159 train, Scale test
# 3. MEAN_SD GSE13159 train, Scale test
# 4. MEDIAN_MAD GSE13159 train, Scale test

DQN_FULL_DIR      = ./data/processed/bg_corrected_dqn_all_samples
DQN_TRAIN_DIR 	  = ./data/processed/bg_corrected_train_dqn_test_scaled
MEAN_SD_DIR 	  = ./data/processed/bg_corrected_train_mean_sd_test_scaled
MEDIAN_MAD_DIR 	  = ./data/processed/bg_corrected_train_median_mad_test_scaled
DQN_EXT_TRAIN_DIR = ./data/processed/bg_corrected_train_dqn_ext_test_scaled
GSE13159_RAW_DIR  = ./data/raw/GSE13159/GSE13159_RAW
GSE16455_RAW_DIR  = ./data/raw/GSE16455/GSE16455_RAW

GSE_LIST_GSE13159_TRAIN    = ./data/raw/GSE13159/split_gsm_ids/train_gsm_ids.txt
GSE_LIST_GSE13159_TEST     = ./data/raw/GSE13159/split_gsm_ids/test_gsm_ids.txt
GSE_LIST_GSE16455_TEST     = ./data/raw/GSE16455/GSE16455_samples_cll_only.txt

DQN_FULL_PROCESSED 	       = $(DQN_FULL_DIR)/dqn_all_samples.csv
DQN_FULL_GSE13159_TRAIN    = $(DQN_FULL_DIR)/GSE13159_train.csv
DQN_FULL_GSE13159_TEST     = $(DQN_FULL_DIR)/GSE13159_test.csv
DQN_FULL_GSE16455_TEST     = $(DQN_FULL_DIR)/GSE16455_test.csv

DQN_TRAIN_PROCESSED 	        = $(DQN_TRAIN_DIR)/GSE13159_train.csv
DQN_TRAIN_PARAMS 	            = $(DQN_TRAIN_DIR)/GSE13159_train_params.RData
DQN_TRAIN_GSE13159_TEST         = $(DQN_TRAIN_DIR)/GSE13159_test.csv
DQN_TRAIN_GSE16455_TEST         = $(DQN_TRAIN_DIR)/GSE16455_test.csv

MEAN_SD_TRAIN_PROCESSED         = $(MEAN_SD_DIR)/GSE13159_train.csv
MEAN_SD_TRAIN_PARAMS	        = $(MEAN_SD_DIR)/GSE13159_train_params.RData
MEAN_SD_TRAIN_GSE13159_TEST     = $(MEAN_SD_DIR)/GSE13159_test.csv
MEAN_SD_TRAIN_GSE16455_TEST     = $(MEAN_SD_DIR)/GSE16455_test.csv

MEDIAN_MAD_TRAIN_PROCESSED      = $(MEDIAN_MAD_DIR)/GSE13159_train.csv
MEDIAN_MAD_TRAIN_PARAMS         = $(MEDIAN_MAD_DIR)/GSE13159_train_params.RData
MEDIAN_MAD_TRAIN_GSE13159_TEST  = $(MEDIAN_MAD_DIR)/GSE13159_test.csv
MEDIAN_MAD_TRAIN_GSE16455_TEST  = $(MEDIAN_MAD_DIR)/GSE16455_test.csv

DQN_EXT_TRAIN_PROCESSED 	        = $(DQN_EXT_TRAIN_DIR)/GSE13159_train.csv
DQN_EXT_TRAIN_PARAMS 	            = $(DQN_EXT_TRAIN_DIR)/GSE13159_train_params.RData
DQN_EXT_TRAIN_GSE13159_TEST         = $(DQN_EXT_TRAIN_DIR)/GSE13159_test.csv
DQN_EXT_TRAIN_GSE16455_TEST         = $(DQN_EXT_TRAIN_DIR)/GSE16455_test.csv



#
# full stack
#
$(DQN_FULL_PROCESSED): $(GSE13159_RAW) $(GSE16455_RAW)
	mkdir -p $(shell dirname $(DQN_FULL_PROCESSED))
	./scripts/preprocessing/preprocessing_all_samples.sh

$(DQN_FULL_GSE13159_TRAIN) $(DQN_FULL_GSE13159_TEST) $(DQN_FULL_GSE16455_TEST) &: $(DQN_FULL_PROCESSED)
	python ./scripts/preprocessing/split_full_samples.py


#
# dqn train
#
$(DQN_TRAIN_PROCESSED) $(DQN_TRAIN_PARAMS) &: $(GSE13159_RAW_DIR) $(GSE_LIST_GSE13159_TEST)
	mkdir -p $(shell dirname $(DQN_TRAIN_PROCESSED))
	./scripts/preprocessing/preprocessing_single_exp_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TRAIN) \
		"DQN" \
		$(DQN_TRAIN_PROCESSED) \
		"1"
	python ./scripts/utils/transpose.py $(DQN_TRAIN_PROCESSED) $(DQN_TRAIN_PROCESSED)

$(DQN_TRAIN_GSE13159_TEST): $(GSE13159_RAW) $(DQN_TRAIN_PARAMS) $(GSE_LIST_GSE13159_TEST)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TEST) \
		$(DQN_TRAIN_PARAMS) \
		$(DQN_TRAIN_GSE13159_TEST)
	python ./scripts/utils/transpose.py $(DQN_TRAIN_GSE13159_TEST) $(DQN_TRAIN_GSE13159_TEST)

$(DQN_TRAIN_GSE16455_TEST): $(GSE16455_RAW_DIR) $(GSE_LIST_GSE16455_TEST) $(DQN_TRAIN_PARAMS)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE16455_RAW_DIR) \
		$(GSE_LIST_GSE16455_TEST) \
		$(DQN_TRAIN_PARAMS) \
		$(DQN_TRAIN_GSE16455_TEST)
	python ./scripts/utils/transpose.py $(DQN_TRAIN_GSE16455_TEST) $(DQN_TRAIN_GSE16455_TEST)



#
# mean sd train
#
$(MEAN_SD_TRAIN_PROCESSED) $(MEAN_SD_TRAIN_PARAMS) &: $(GSE13159_RAW_DIR) $(GSE_LIST_GSE13159_TEST)
	mkdir -p $(shell dirname $(MEAN_SD_TRAIN_PROCESSED))
	./scripts/preprocessing/preprocessing_single_exp_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TRAIN) \
		"MEAN_SD" \
		$(MEAN_SD_TRAIN_PROCESSED) \
		"1"
	python ./scripts/utils/transpose.py $(MEAN_SD_TRAIN_PROCESSED) $(MEAN_SD_TRAIN_PROCESSED)

$(MEAN_SD_TRAIN_GSE13159_TEST): $(GSE13159_RAW) $(MEAN_SD_TRAIN_PARAMS) $(GSE_LIST_GSE13159_TEST)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TEST) \
		$(MEAN_SD_TRAIN_PARAMS) \
		$(MEAN_SD_TRAIN_GSE13159_TEST)
	python ./scripts/utils/transpose.py $(MEAN_SD_TRAIN_GSE13159_TEST) $(MEAN_SD_TRAIN_GSE13159_TEST)

$(MEAN_SD_TRAIN_GSE16455_TEST): $(GSE16455_RAW_DIR) $(GSE_LIST_GSE16455_TEST) $(MEAN_SD_TRAIN_PARAMS)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE16455_RAW_DIR) \
		$(GSE_LIST_GSE16455_TEST) \
		$(MEAN_SD_TRAIN_PARAMS) \
		$(MEAN_SD_TRAIN_GSE16455_TEST)
	python ./scripts/utils/transpose.py $(MEAN_SD_TRAIN_GSE16455_TEST) $(MEAN_SD_TRAIN_GSE16455_TEST)


#
# median mad train
#
$(MEDIAN_MAD_TRAIN_PROCESSED) $(MEDIAN_MAD_TRAIN_PARAMS) &: $(GSE13159_RAW_DIR) $(GSE_LIST_GSE13159_TEST)
	mkdir -p $(shell dirname $(MEDIAN_MAD_TRAIN_PROCESSED))
	./scripts/preprocessing/preprocessing_single_exp_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TRAIN) \
		"MEDIAN_MAD" \
		$(MEDIAN_MAD_TRAIN_PROCESSED) \
		"1"
	python ./scripts/utils/transpose.py $(MEDIAN_MAD_TRAIN_PROCESSED) $(MEDIAN_MAD_TRAIN_PROCESSED)

$(MEDIAN_MAD_TRAIN_GSE13159_TEST): $(GSE13159_RAW) $(MEDIAN_MAD_TRAIN_PARAMS) $(GSE_LIST_GSE13159_TEST)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TEST) \
		$(MEDIAN_MAD_TRAIN_PARAMS) \
		$(MEDIAN_MAD_TRAIN_GSE13159_TEST)
	python ./scripts/utils/transpose.py $(MEDIAN_MAD_TRAIN_GSE13159_TEST) $(MEDIAN_MAD_TRAIN_GSE13159_TEST)

$(MEDIAN_MAD_TRAIN_GSE16455_TEST): $(GSE16455_RAW_DIR) $(GSE_LIST_GSE16455_TEST) $(MEDIAN_MAD_TRAIN_PARAMS)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE16455_RAW_DIR) \
		$(GSE_LIST_GSE16455_TEST) \
		$(MEDIAN_MAD_TRAIN_PARAMS) \
		$(MEDIAN_MAD_TRAIN_GSE16455_TEST)
	python ./scripts/utils/transpose.py $(MEDIAN_MAD_TRAIN_GSE16455_TEST) $(MEDIAN_MAD_TRAIN_GSE16455_TEST)


#
# dqn ext. train (median-mad-shift-vector)
#
$(DQN_EXT_TRAIN_PROCESSED) $(DQN_EXT_TRAIN_PARAMS) &: $(GSE13159_RAW_DIR) $(GSE_LIST_GSE13159_TEST)
	mkdir -p $(shell dirname $(DQN_EXT_TRAIN_PROCESSED))
	./scripts/preprocessing/preprocessing_single_exp_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TRAIN) \
		"DQN_EXT" \
		$(DQN_EXT_TRAIN_PROCESSED) \
		"1"
	python ./scripts/utils/transpose.py $(DQN_EXT_TRAIN_PROCESSED) $(DQN_EXT_TRAIN_PROCESSED)

$(DQN_EXT_TRAIN_GSE13159_TEST): $(GSE13159_RAW) $(DQN_EXT_TRAIN_PARAMS) $(GSE_LIST_GSE13159_TEST)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE13159_RAW_DIR) \
		$(GSE_LIST_GSE13159_TEST) \
		$(DQN_EXT_TRAIN_PARAMS) \
		$(DQN_EXT_TRAIN_GSE13159_TEST)
	python ./scripts/utils/transpose.py $(DQN_EXT_TRAIN_GSE13159_TEST) $(DQN_EXT_TRAIN_GSE13159_TEST)

$(DQN_EXT_TRAIN_GSE16455_TEST): $(GSE16455_RAW_DIR) $(GSE_LIST_GSE16455_TEST) $(DQN_EXT_TRAIN_PARAMS)
	./scripts/preprocessing/preprocessing_with_frozen_params_from_gse_list.sh \
		$(GSE16455_RAW_DIR) \
		$(GSE_LIST_GSE16455_TEST) \
		$(DQN_EXT_TRAIN_PARAMS) \
		$(DQN_EXT_TRAIN_GSE16455_TEST)
	python ./scripts/utils/transpose.py $(DQN_EXT_TRAIN_GSE16455_TEST) $(DQN_EXT_TRAIN_GSE16455_TEST)



.PHONY = all

all: $(DQN_FULL_PROCESSED) \
	 $(DQN_FULL_GSE13159_TRAIN) \
	 $(DQN_FULL_GSE13159_TEST) \
	 $(DQN_FULL_GSE16455_TEST) \
	 $(DQN_TRAIN_PROCESSED) \
	 $(DQN_TRAIN_PARAMS) \
	 $(DQN_TRAIN_GSE13159_TEST) \
	 $(DQN_TRAIN_GSE16455_TEST) \
	 $(MEAN_SD_TRAIN_PROCESSED) \
	 $(MEAN_SD_TRAIN_PARAMS) \
	 $(MEAN_SD_TRAIN_GSE13159_TEST) \
	 $(MEAN_SD_TRAIN_GSE16455_TEST) \
	 $(MEDIAN_MAD_TRAIN_PROCESSED) \
	 $(MEDIAN_MAD_TRAIN_PARAMS) \
	 $(MEDIAN_MAD_TRAIN_GSE13159_TEST) \
	 $(MEDIAN_MAD_TRAIN_GSE16455_TEST) \
	 $(DQN_EXT_TRAIN_PROCESSED) \
	 $(DQN_EXT_TRAIN_PARAMS) \
	 $(DQN_EXT_TRAIN_GSE13159_TEST) \
	 $(DQN_EXT_TRAIN_GSE16455_TEST) 