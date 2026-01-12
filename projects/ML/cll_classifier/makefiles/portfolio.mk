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

__demo__:
	ln -s /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/scripts
	ln -s /var/home/maxpetzold/HUB_local/projects/personal/transcriptomics/classifier/leukemia/cll_classifier/src
