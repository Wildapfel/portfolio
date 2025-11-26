# Snakemake

### CMD
- snakemake --configfile [path] --use-conda                                   # plain run
- snakemake --configfile [path] --use-conda --dag | dot -Tpdf > dag.pdf       # create DAG

### Fedora-Silverblue
- install graphviz in a toolbox if you want to make DAG visible and run
  envs with toolbox combined
- sudo dnf install graphviz

### Idea
- The main contorller (this workflow) lifes in the codebase (HUB)
- In a project you only symlink to the controller, by that you get
  the convenience of seeing the workflow in your project
- All the conda installations are therefore reusbale and only installed once
- Fully controlled my a local config.yml and its wildcards
- Makes it extremly reusable 

### Rules for config.yml 
- [...] specify the location of something from the config itself, 
- {...} declares a wildcard 
- Do not use [] for arrays !
- Use hyphen (-) with line break instead
- One must declare a output key, to resolve ALL_TARGETS

### ALL_TARGETS

### WILDCARDS

### Comments
- cfg is declareded in the Snakefile and must not be imported in /rules/*.smk 
  (that was my starting point, but is deprecated now)
- try/catch block in the rules, make it conventient to just import from rules/*,
  by only importing what is accessable specifed in the config.yml, the rest is not 
  inldued

## TODO
- logging might should be local to the project, especially useful
  if multiple project run
- inside the config_template directory, add a scratch of the syntax 
  how to use each rule
- In on of the resolver, implement a wildcard scanner, this must match the WILDCARDS