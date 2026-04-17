# Bachelor thesis
Quantitative Image-Analysis of Blastomeres in the early embryonic development of *Macrostomum Lignano* (Plathelminthes, Macrostomorpha).  



## Quick Note
I just quickly want to demonstrate the work of my bechlor thesis. This gives a consice overview of the research and tasks that I was involved in. 




## Abstact
The goal of thesis was to apply instance segmentation (supervised) in a developmental biology context and thereby gain new insights into the spatial distribution of cell nuclei during the early embryonic development of Macrostomum lignano, an animal undergoing spiral cleavage. Two *M. lignano* embryos were recorded using light-sheet fluorescence microscopy (SPIM), followed by determing cell lineage trees for both embryos. The model was trained using the dataset from Embryo I and then applied to both embryos. Comparable segmentations of the cell nuclei were obtained for both embryos.



## Background
#### Spiral Cleavage
- a conserved, early embryonic development pattern in spiralian animals (molluscs, annelids, platyhelminths and other taxa)

  <img src="./images_refactored/spiralfurchung_edit.png" width=400>

  [Source](http://placozoa.co.uk/student-2017/Jakob-Lecture-8-Annelida.pdf) 

#### *Macrostomum lignano*
- a free-living, hermaphroditic flatworm
- model organism for regeneration research

  <img src="./images_refactored/macrostomum_lignano.png" width=400>

  [Source](https://www.google.com/search?q=macrostomum+lignano&newwindow=1&udm=2&sxsrf=ANbL-n4zpDuSjvBJaCB_MN9ZPivHiokmWw%3A1776408803158#sv=CAMSVhoyKhBlLW1IT0FiZV9HMlZBdmlNMg5tSE9BYmVfRzJWQXZpTToOeUNRMUtnRmVyZVJRdE0gBCocCgZtb3NhaWMSEGUtbUhPQWJlX0cyVkF2aU0YADABGAcgofCW9ANKCBABGAEgASgB)


#### Model 
- [EmbedSeq](https://github.com/juglab/EmbedSeg) from Manan Lalit

#### Nomenclature
- Mainly used the standard nomencalure with slight adaptations

  <img src="./images_refactored/spiralian_nomenclature.png" width=500>
  
  [Source](https://www.researchgate.net/figure/Cleavage-pattern-during-spiralian-development-Each-row-shows-schematics-of-lateral-lat_fig1_318301853)





## Results
#### Model Training History 
History of the training from the model on embryo I. 

<p float="left">
  <img src="./images_refactored/Genauigkeits-Zeit-Diagramm.png" width="200" />
  <img src="./images_refactored/Velust-Zeit-Diagramm.png" width="200" /> 
</p>

#### Cell Lineage with maximum spatial distribution  
The maximum spatial distribution of the tracked blastomeres in embryo 2 mapped onto the cell lineage (from tracking). 

<img src="images_refactored/zelllinienstammbaum_e2_01.png" width=700>
<img src="images_refactored/zelllinienstammbaum_e2_02.png" width=700>

#### Cell nuclei volume over time from embryo 2
Shows the plots of the quantitative analysis of emryo 2 from fertilization to the second split.

<p float="left">
    <img src="./images_refactored/Oocyte_.png" width="250" />
    <img src="./images_refactored/AB_CD.png" width="250" /> 
    <img src="./images_refactored/A_B_C_D.png" width="250" /> 
</p>


#### Cell nuclei voulme comarison over time
I only show some reference points that I want to demonstrate here. It demonstrates the third split during the early embryogenesis (A->1A 1a; B->1B 1b; C->1C 1c; D->1D 1d). 

E1 = Embryo 1 (left)

E2 = embryo 2 (right)

<p float="left">
    <img src="./images_refactored/1A_1a_1A_1a_.png" width="350" />
    <img src="./images_refactored/1B_1b_1B_1b_.png" width="350" /> 
    <img src="./images_refactored/1C_1c_1c1_1c2_.png" width="350" /> 
    <img src="./images_refactored/1D_1d_1D_1d_.png" width="350" /> 
</p>

