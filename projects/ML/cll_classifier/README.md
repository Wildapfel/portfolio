# Machine learning on public cross-experimental microarray blood samples for Chronic Lymphocytic Leukemia (CLL) diagnosis.

This project arose from the idea that I wanted to use transciprtional data to train diagnosis classifiers. Previously, I searched the internet for some RNA-seq experiments for subtypes of Leukemia patients that I can use to train and evaluate models. The first data that I found was brilliant for demonstrating the application of dimensionality reduction techniques to visualize subtype-specific clustering. Later on, I realized that the data was just great, but for the ML tasks that I wished to do, it was not sufficient. After digging some deeper, I found two public data set ([GSE13159](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE131599), [GSE16455](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE16455)) from DNA-microarray data, that were matching w.r.t. CLL cases. So I got the idea the train and evaulate the performace of a binary CLL classifier cross-experimentally using the raw CEL files found on NCBI GEO and usin different scaling techniques, because I wanted to tackle the data leakge problem with the preprocessed data.    


### Reproduce from here:
- I created a dedicated folder for rerunning this project: \_\_demo\_\_


```bash
# Install dependencies into conda environment
conda env create -f env.yml -y 
conda activate demo-env
```


```bash
# Change workig directory to __demo__
cd __demo__
```

```bash
# Prepare data
make -f Makefiles/data.mk all
```

```bash
# Preprocess data
make -f mḾakefiles/preprocess.mk all
```

```bash
# Run first Experiment
make -f Makefiles/exp.mk exp01_train && make -f Makefiles/exp.mk exp01_eval
```

```bash
# Run second Experiment
make -f Makefiles/exp.mk exp02_train && make -f Makefiles/exp.mk exp02_eval
```

```bash
# Run third Experiment
make -f Makefiles/exp.mk exp03_train && make -f Makefiles/exp.mk exp03_eval
```

```bash
# Run fourth Experiment
make -f Makefiles/exp.mk exp04_train && make -f Makefiles/exp.mk exp04_eval
```