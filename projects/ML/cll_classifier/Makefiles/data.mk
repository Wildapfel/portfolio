GSE13159_DIR 			   = ./data/raw/GSE13159
GSE16455_DIR 			   = ./data/raw/GSE16455

SERIES_GSE13159			   = $(GSE13159_DIR)/GSE13159_series.txt
SERIES_GSE16455 		   = $(GSE16455_DIR)/GSE16455_series.txt

SAMPLE_IDS_GSE13159 	   = $(GSE13159_DIR)/GSE13159_samples.txt
SAMPLE_IDS_GSE16455 	   = $(GSE16455_DIR)/GSE16455_samples.txt
SAMPLE_IDS_GSE13159_PB     = $(GSE13159_DIR)/GSE13159_samples_pb_only.txt

ANNOT_GSE13159_PB		   = $(GSE13159_DIR)/GSE13159_annot_pb_only.csv
ANNOT_GSE16455		       = $(GSE16455_DIR)/GSE16455_annot.csv

LABELS_GSE13159_PB		   = $(GSE13159_DIR)/GSE13159_labels_pb_only.csv
LABELS_GSE16455		       = $(GSE16455_DIR)/GSE16455_labels.csv

TRAIN_GSM_IDS_PK_GSE13159  = $(GSE13159_DIR)/split_gsm_ids/train_gsm_ids.pk
TEST_GSM_IDS_PK_GSE13159   = $(GSE13159_DIR)/split_gsm_ids/test_gsm_ids.pk
TRAIN_GSM_IDS_TXT_GSE13159 = $(GSE13159_DIR)/split_gsm_ids/train_gsm_ids.txt
TEST_GSM_IDS_TXT_GSE13159  = $(GSE13159_DIR)/split_gsm_ids/test_gsm_ids.txt

LABELS_GSE13159_PB_TRAIN   = $(GSE13159_DIR)/GSE13159_labels_pb_only_train.csv
LABELS_GSE13159_PB_TEST    = $(GSE13159_DIR)/GSE13159_labels_pb_only_test.csv



#
# Download only series sample ids (use '' to not download some weird source code :D). This is needed, 
# to extract the sample ids and download the GSM IDs separatly (I need this because of my bad wifi)
#
$(SERIES_GSE13159):
	wget -O $(SERIES_GSE13159) 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13159&targ=self&view=brief&form=text' 

$(SERIES_GSE16455):
	wget -O $(SERIES_GSE16455) 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE16455&targ=self&view=brief&form=text' 


#
# extact sample ids from series files
# 
$(SAMPLE_IDS_GSE13159): $(SERIES_GSE13159)
	python ./scripts/data/get_sample_ids_from_series.py $(SERIES_GSE13159) $(SAMPLE_IDS_GSE13159) 

$(SAMPLE_IDS_GSE16455): $(SERIES_GSE16455)
	python ./scripts/data/get_sample_ids_from_series.py $(SERIES_GSE16455) $(SAMPLE_IDS_GSE16455) 


#
# fetch geo annotations
#
$(ANNOT_GSE13159_PB):
	python ./scripts/data/fetch_annot_from_sample_id_list_only_blood_samples.py $(SAMPLE_IDS_GSE13159) $(ANNOT_GSE13159_PB)

$(ANNOT_GSE16455):
	python ./scripts/data/fetch_annot_from_sample_id_list.py $(SAMPLE_IDS_GSE16455) $(ANNOT_GSE16455)


#
# Annotations to labels
#
$(LABELS_GSE13159_PB): $(ANNOT_GSE13159_PB)
	python ./scripts/data/annotations_to_labels_GSE13159.py

$(LABELS_GSE16455): $(ANNOT_GSE16455)
	python ./scripts/data/annotations_to_labels_GSE16455.py


#
# filter pb labels only from GSE13159
#
$(SAMPLE_IDS_GSE13159_PB): $(ANNOT_GSE13159_PB) 
	python ./scripts/data/GSE13159_extract_pb_gsm_ids.py $(ANNOT_GSE13159_PB) $(SAMPLE_IDS_GSE13159_PB)


#
# Prepare GSE131599 split
#
$(TRAIN_GSM_IDS_PK_GSE13159) $(TEST_GSM_IDS_PK_GSE13159) $(TRAIN_GSM_IDS_TXT_GSE13159) $(TEST_GSM_IDS_TXT_GSE13159) &: $(LABELS_GSE13159_PB)
	python ./scripts/data/GSE13159_train_test_id_split.py


#
# Prepare GESE13159 train/test labels
#
$(LABELS_GSE13159_PB_TRAIN) $(LABELS_GSE13159_PB_TEST) &: $(LABELS_GSE13159_PB) $(TRAIN_GSM_IDS_PK_GSE13159) $(TEST_GSM_IDS_PK_GSE13159)
	python ./scripts/data/split_labels_by_gse_list.py

#
# downoad raw .CEL files from sample ids (separate)
# 
gse_13159_ids = $(shell cat $(SAMPLE_IDS_GSE13159_PB))
gse_13159_raws = $(foreach id, $(gse_13159_ids), $(GSE13159_DIR)/GSE13159_RAW/$(id).CEL.gz)
$(gse_13159_raws) &: 
	mkdir -p $(GSE13159_DIR)/GSE13159_RAW
	python ./scripts/data/download_raw_from_sample_ids.py $(SAMPLE_IDS_GSE13159_PB) $(GSE13159_DIR)/GSE13159_RAW 	# download pb samles only

gse_16455_ids = $(shell cat $(SAMPLE_IDS_GSE16455))
gse_16455_raws = $(foreach id, $(gse_16455_ids), $(GSE16455_DIR)/GSE16455_RAW/$(id).CEL.gz)
$(gse_16455_raws) &: 
	mkdir -p $(GSE16455_DIR)/GSE16455_RAW
	python ./scripts/data/download_raw_from_sample_ids.py $(SAMPLE_IDS_GSE16455) $(GSE16455_DIR)/GSE16455_RAW



.PHONY = all

all: $(SERIES_GSE13159) \
	 $(SERIES_GSE16455) \
	 $(SAMPLE_IDS_GSE13159) \
	 $(SAMPLE_IDS_GSE16455) \
	 $(ANNOT_GSE16455) \
#  	 $(ANNOT_GSE13159_PB) \
# 	 $(SAMPLE_IDS_GSE13159_PB) \
# 	 $(LABELS_GSE13159_PB) \
# 	 $(LABELS_GSE16455) \
# 	 $(TRAIN_GSM_IDS_PK_GSE13159) \
# 	 $(TEST_GSM_IDS_PK_GSE13159) \
# 	 $(TRAIN_GSM_IDS_TXT_GSE13159) \
# 	 $(TEST_GSM_IDS_TXT_GSE13159) \
# 	 $(LABELS_GSE13159_PB_TRAIN) \
# 	 $(LABELS_GSE13159_PB_TEST) \
# 	 $(gse_13159_raws) \
# 	 $(gse_16455_raws)
