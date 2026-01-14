snippets:
	head ./data/processed/bg_corrected_dqn_all_samples/dqn_all_samples.csv > ./data/processed/bg_corrected_dqn_all_samples/dqn_all_samples_snippet.csv
	head ./data/processed/bg_corrected_dqn_all_samples/GSE13159_test.csv > ./data/processed/bg_corrected_dqn_all_samples/GSE13159_test_snippet.csv
	head ./data/processed/bg_corrected_dqn_all_samples/GSE13159_train.csv > ./data/processed/bg_corrected_dqn_all_samples/GSE13159_train_snippet.csv
	head ./data/processed/bg_corrected_dqn_all_samples/GSE16455_test.csv > ./data/processed/bg_corrected_dqn_all_samples/GSE16455_test_snippet.csv

	head ./data/processed/bg_corrected_train_dqn_ext_test_scaled/GSE13159_test.csv > ./data/processed/bg_corrected_train_dqn_ext_test_scaled/GSE13159_test_snippet.csv
	head ./data/processed/bg_corrected_train_dqn_ext_test_scaled/GSE13159_train.csv > ./data/processed/bg_corrected_train_dqn_ext_test_scaled/GSE13159_train_snippet.csv
	head ./data/processed/bg_corrected_train_dqn_ext_test_scaled/GSE16455_test.csv > ./data/processed/bg_corrected_train_dqn_ext_test_scaled/GSE16455_test_snippet.csv

	head ./data/processed/bg_corrected_train_mean_sd_test_scaled/GSE13159_test.csv > ./data/processed/bg_corrected_train_mean_sd_test_scaled/GSE13159_test_snippet.csv
	head ./data/processed/bg_corrected_train_mean_sd_test_scaled/GSE13159_train.csv > ./data/processed/bg_corrected_train_mean_sd_test_scaled/GSE13159_train_snippet.csv
	head ./data/processed/bg_corrected_train_mean_sd_test_scaled/GSE16455_test.csv > ./data/processed/bg_corrected_train_mean_sd_test_scaled/GSE16455_test_snippet.csv

	head ./data/processed/bg_corrected_train_median_mad_test_scaled/GSE13159_test.csv > ./data/processed/bg_corrected_train_median_mad_test_scaled/GSE13159_test_snippet.csv
	head ./data/processed/bg_corrected_train_median_mad_test_scaled/GSE13159_train.csv > ./data/processed/bg_corrected_train_median_mad_test_scaled/GSE13159_train_snippet.csv
	head ./data/processed/bg_corrected_train_median_mad_test_scaled/GSE16455_test.csv > ./data/processed/bg_corrected_train_median_mad_test_scaled/GSE16455_test_snippet.csv

prepare__demo__:
	mkdir -p ./__demo__/experiments/01_bg_corrected_all_samples
	mkdir -p ./__demo__/experiments/02_bg_corrected_mean_sd_scaled
	mkdir -p ./__demo__/experiments/03_bg_corrected_median_mad_scaled
	mkdir -p  ./__demo__/experiments/04_bg_corrected_train_dqn_ext_test_scaled
	mkdir -p  ./__demo__/data/cll_assoc_probes

	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/scripts ./__demo__/
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/src ./__demo__/
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/Makefiles ./__demo__/
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/experiments/01_bg_corrected_all_samples/configs ./__demo__/experiments/01_bg_corrected_all_samples
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/experiments/02_bg_corrected_mean_sd_scaled/configs ./__demo__/experiments/02_bg_corrected_mean_sd_scaled
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/experiments/03_bg_corrected_median_mad_scaled/configs ./__demo__/experiments/03_bg_corrected_median_mad_scaled
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/experiments/04_bg_corrected_train_dqn_ext_test_scaled/configs ./__demo__/experiments/04_bg_corrected_train_dqn_ext_test_scaled
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/experiments/shared ./__demo__/experiments
	cp -r /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/data/cll_assoc_probes ./__demo__/data