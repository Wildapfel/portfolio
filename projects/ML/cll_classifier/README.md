# CLL Machine Learning Classification

### Machine learning on public cross-experimental microarray blood samples for Chronic Lymphocytic Leukemia (CLL) diagnosis.



### Reproduce from here:
- I created a dedicated folder for rerunning this project: \_\_demo\_\_


```bash
# Install dependencies into conda environment
conda env create -f env.yml -y 
```


```bash
# Change workig directory to __demo__
cd __demo__
```

```bash
# Prepare data
make -f data.mk all
```

```bash
# Preprocess data
make -f preprocess.mk all
```

```bash
# Run first Experiment
make -f exp.mk exp01_train && make -f exp.mk exp01_eval
```

```bash
# Run second Experiment
make -f exp.mk exp02_train && make -f exp.mk exp02_eval
```

```bash
# Run third Experiment
make -f exp.mk exp03_train && make -f exp.mk exp03_eval
```

```bash
# Run fourth Experiment
make -f exp.mk exp04_train && make -f exp.mk exp04_eval
```