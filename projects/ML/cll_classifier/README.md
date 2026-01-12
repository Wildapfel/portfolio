# Machine learning on public cross-experimental microarray blood samples for Chronic Lymphocytic Leukemia (CLL) diagnosis.

This project arose from the idea that I wanted to use transciprtional data to train diagnosis classifiers. Previously, I searched the internet for some RNA-seq experiments for subtypes of Leukemia patients that I can use to train and evaluate models. The first data that I found was brilliant for demonstrating the application of dimensionality reduction techniques to visualize subtype-specific clustering. Later on, I realized that the data was just great, but for the ML tasks that I wished to do, it was not sufficient. After digging some deeper, I found two public data set ([GSE13159](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE131599), [GSE16455](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE16455)) from DNA-microarray data, that were matching w.r.t. CLL cases. So I got the idea the train and evaulate the performace of a binary CLL classifier cross-experimentally using the raw CEL files found on NCBI GEO and usin different scaling techniques, because I wanted to tackle the data leakge problem with the preprocessed data.    


### About
- I trained multiple ML algorithms with different scalings onto the peripheral blood train subset of GSE13159 using CLL associated gene feature selection
- I evaluted their performance onto a within-expierment test set
- Furhter I investigate how the probability outputs align with the CLL classes of a different experiment: GSE16455 (cross-experiment)


### Core Competencies  
- Project orchestration and reprdocuability with Makefiles
- Applied different scalings: robust mulit-array average (RMA), standard scaling and robust scaling
- Approximated the RMA of train using a shift-scale-vector for data leakage free scaling of the test data
- Performed a gridsearch for hyperparameter tuning of different ML algorithms 
- Performed the training evaluation of the multi-model and -scaling combinations using Receiver Operator Curve (ROC), Precision Recall Cuve (PRC), Confusion Matrix (CM) for different optimal thresholds 


### Project Structure
```
cll_classifier/  
├── __demo__/               # reproduce here
├── archive                 # depracted code or some crtefacts from development
├── data/                   # raw and process data
├── experiments/            # produced experiments 
├── Makefiles/              # Makefile orchestration for this project
├── notebooks/              # some notebooks that I used for this proejct
├── report/                 # evaluation of model trainings 
├── scripts/                # my scripts
├── src/                    # src logic (not much)
├── env.yml                 # conda env installer  
├── make.md                 # some runners for the orchestration
└── README.md               # Just the README  
```



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
make -f Makefiles/preprocess.mk all
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