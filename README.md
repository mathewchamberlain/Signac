[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPL License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full">
    <img src="images/GitHubFigure.svg" alt="Logo" width="600" height="300">
  </a>

  <h3 align="center">Signac 2.1.1</h3>

  <p align="center">
    Get the most out of your single cell data.
    <br />
    <a href="#getting-started"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/signac-Seurat_CITEseq.html">View Demo</a>
    ·
    <a href="https://github.com/mathewchamberlain/Signac/issues">Report Bug</a>
    ·
    <a href="https://github.com/mathewchamberlain/Signac/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [What is Signac?](#about-the-project)
* [Data portal](#data-portal)
* [Getting Started](#getting-started)
  * [Installation](#installation)
  * [Quick start](#quickstart)
* [Usage](#usage)
  * [SPRING](#spring)
  * [Seurat](#seurat)
    * [MASC](#masc)
  * [Non-human data](#non-human-data)
  * [Genes of interest](#genes-of-interest)
  * [Learning from single cell data](#learning-from-single-cell-data)
  * [Fast Signac](#fast-signac)
* [Benchmarking](#benchmarking) 
  * [CITE-seq](#cite-seq)
  * [Flow-sorted synovial cells](#flow-sorted-synovial-cells)
  * [PBMCs](#pbmcs)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)

<!-- ABOUT THE PROJECT -->
## What is Signac?

Signac is software developed and maintained by the Savova lab at Sanofi with a focus on single cell genomics for clinical applications. Signac helps solve the cell type classification problem in single cell RNA sequencing: We have gene expression profiles for each individual cell, but we do not know the cellular phenotypes. Signac classifies the cellular phenotype for each individual cell in single cell RNA-sequencing data using neural networks trained with sorted bulk gene expression data from the [Human Primary Cell Atlas](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-14-632). Signac can: integrate single cell data (mapping cells from one data set to another), classify non-human data, identify novel cell types, and classify single cell data across many tissues, diseases and technologies. We used Signac to identify potential gene drug targets for rheumatoid arthritis, employing a precision medicine strategy to seek immune-modifying therapies that might have reduced side effects, and to identify conserved gene expression-based representations of cellular phenotypes. Check out the pre-print [here](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full).

## Data portal

Here, we provide interactive access to Signac-processed data from the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full). Each data set is accessible with SPRING (video tutorials [here](https://kleintools.hms.harvard.edu/tools/spring.html)). Annotations from Signac can be explored at the single-cell level with four annotation layers: CellTypes, CellTypes_Novel, CellStates and CellStates_Novel. When available, we also provide information about covariates (i.e., diagnosis, age, gender, etc.):

| Links | Tissue | Disease | Number of cells | Number of samples | Source | Signac version |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/AMP_Phase1_RA_Apr2019/FullDataset_v1) | Synovium | Rheumatoid arthritis and osteoarthritis | 8,920 | 26 | [Zhang et. al 2019](https://www.nature.com/articles/s41590-019-0378-1) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/AMP_Phase1_SLE_Apr2019/FullDataset_v1) | Kidney and urine | Lupus nephritis and healthy | 5,886 | 39 | [Arazi et al. 2019](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6726437/) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/Immunity_LungCancer_lung/FullDataset_v1) | Lung | Cancer | 42,844 | 18 | [Zilionis et al. 2020](https://pubmed.ncbi.nlm.nih.gov/30979687/) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/Immunity_LungCancer_blood/FullDataset_v1) | Blood | Cancer | 14,048 | 8 | [Zilionis et al. 2020](https://pubmed.ncbi.nlm.nih.gov/30979687/) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/EXPLORATORY_AD_FIBROBLASTS_EMMA_GUTTMAN/FullDataset_v1) | Skin | Atopic dermatitis | 36,690 | 17 | [He et al. 2020](https://pubmed.ncbi.nlm.nih.gov/32035984/) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/CITESEQ_EXPLORATORY_CITESEQ_5K_PBMCS/FullDataset_v1_protein) | PBMCs | Healthy | 7,902 | 1 | [10X Genomics](https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/pbmc_10k_protein_v3) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/PBMCs_5k_10X/FullDataset_v1) | PBMCs | Healthy | 4,784 | 1 | [10X Genomics](https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.2/5k_pbmc_v3) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/EXPLORATORY_FIBROTICLUNGARIZONA/FullDataset_v1) | Lung | Fibrosis | 96,461 | 31 | [Habermann et al. 2020](https://advances.sciencemag.org/content/6/28/eaba1972) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/EXPLORATORY_FIBROTICLUNGCHICAGO/FullDataset_v1) | Lung | Fibrosis | 109,421 | 16 | [Reyfman et al. 2019](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6580683/) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/EXPLORATORY_KIDNEY_IMMUNE_ZONATION/FullDataset_v1) | Kidney | Cancer | 48,037 | 47 | [Stewart et al. 2019](https://science.sciencemag.org/content/365/6460/1461.abstract) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/Monkey_Sample3003/FullDataset_v1) | Monkey PBMCs | Healthy | 5,491 | 1 | [Chamberlain et al. 2021](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/Monkey_Sample3004/FullDataset_v1) | Monkey PBMCs | Healthy | 5,220 | 1 | [Chamberlain et al. 2021](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full) | v2.0.7 |
| [Explore data](https://kleintools.hms.harvard.edu/tools/springViewer_1_6_dev.html?client_datasets/Monkey_Tcells/FullDataset_v1) | Monkey T cells | Healthy | 5,496 | 1 | [Chamberlain et al. 2021](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full) | v2.0.7 |

<!-- GETTING STARTED -->
## Getting Started

To install Signac in R, simply do:

### Installation

```r
devtools::install_github("mathewchamberlain/Signac")
```

### Quick start

The main functions in Signac are:

```r
# load the library
library(Signac)

# Load the reference training data set
data("training_HPCA")

# Generate initial labels
labels = Signac(your_data_here, R = training_HPCA)

# Get cell type labels
celltypes = Generate_lbls(labels, your_data_here)
```

<!-- USAGE EXAMPLES -->
## Usage

To make life easier, Signac was integrated with [Seurat](https://satijalab.org/seurat/) (versions 3 and 4), and with [SPRING](https://pubmed.ncbi.nlm.nih.gov/29228172/). We provide a few vignettes:

### SPRING
In the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full), we often used Signac integrated with [SPRING](https://pubmed.ncbi.nlm.nih.gov/29228172/). To reproduce our findings and to generate new results with SPRING, please visit the SPRING repository which has [example notebooks and installation instructions](https://github.com/AllonKleinLab/SPRING_dev), particularly for [processing CITE-seq and scRNA-seq data from 10X Genomics](https://github.com/AllonKleinLab/SPRING_dev/blob/master/data_prep/spring_notebook_10X_CITEseq.ipynb). Briefly, Signac is integrated seamlessly with the output files of SPRING in R, requiring only a few functions:

```r
# load the Signac library
library(Signac)

# dir points to the "FullDataset_v1" directory generated by the SPRING Jupyter notebook
dir = "./FullDataset_v1" 

# load the expression data
E = CID.LoadData(dir)

# load the reference data
data("training_HPCA")

# generate cellular phenotype labels
labels = Signac(E, R = training_HPCA, spring.dir = dir)
celltypes = Generate_lbls(labels, E = E)

# write cell types and Louvain clusters to SPRING
dat <- CID.writeJSON(celltypes, data.dir = dir)
```

After running the above functions, cellular phenotypes and Louvain clusters are ready to be visualized with SPRING Viewer, which can be setup locally as described [here](https://github.com/AllonKleinLab/SPRING_dev).

### Seurat
Another way to use Signac is with Seurat. [In this vignette](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/signac-Seurat_CITEseq.html), we performed multi-modal analysis of CITE-seq PBMCs from 10X Genomics using Signac integrated with Seurat.

Note:
* This same data set was also processed using SPRING [in this notebook](https://github.com/AllonKleinLab/SPRING_dev/blob/master/data_prep/spring_notebook_10X_CITEseq.ipynb), and subsequently classified with Signac, which was used to generate SPRING layouts for these data in the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full) (Figures 2-4).

#### MASC

Sometimes, we have single cell genomics data with disease information, and we want to know which cellular phenotypes are enriched for disease. [In this vignette](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/signac-Seurat_AMP.html), we applied Signac to classify cellular phenotypes in healthy and lupus nephritis kidney cells, and then we used [MASC](https://pubmed.ncbi.nlm.nih.gov/30333237/) to identify which cellular phenotypes were disease-enriched.

Note:
* MASC typically requires equal numbers of cells and samples between case and control: an unequal number might skew the clustering of cells towards one sample (i.e., a "batch effect"), which could cause spurious disease enrichment in the mixed effect model. Since Signac classifies each cell independently (without using clusters), it can be used with MASC without balancing samples or cells, unlike cluster-based annotation methods.

### Non-human data

In Supplemental Figure 8 of the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full), we classified single cell data for a model organism (cynomolgus monkey) for which flow-sorted datasets were generally lacking without any additional species-specific training. Instead, we mapped homologous genes from the *Macaca fascicularis* genome to the human genome in the single cell data, and then performed cell type classification with Signac. We demonstrate how we mapped the gene symbols [here](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/Crabeating_vignette.html).

Note:
* This code can be used for to identify homologous genes between any two species.

### Genes of interest

In Figure 6 of the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full), we compiled data from three source ([CellPhoneDB](https://www.cellphonedb.org/), [GWAS catalog](https://www.ebi.ac.uk/gwas/) and [this paper](https://www.nature.com/articles/s41588-019-0460-5)) to find genes of immunological / pharmacological interest. These genes and their annotations can be accessed internally from within Signac:

```r
# load the library
library(Signac)

# See ?Genes_Of_Interest
data("Genes_Of_Interest")
```

### Learning from single cell data

In Figure 4 of the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full), we demonstrated that Signac mapped cell type labels from one single cell data set to another (CD56<sup>bright</sup> NK cells). [Here, we provide a vignette](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/signac-SPRING_Learning.html) for reproducing this analysis, which can be used to map cell populations (or clusters of cells) from one data set to another.

Note:
* The data used here were processed with SPRING prior to classification with Signac; those notebooks are available [here](https://github.com/mathewchamberlain/SPRING_dev/).

### Fast Signac

Sometimes we don't have time to run Signac, and need a quick solution. Although Signac scales fine with large data sets (>300,000 cells), we developed SignacFast to quickly classify single cell data:

```r
# load the library
library(Signac)

# load pre-trained neural network ensemble model
data("Models_HPCA")

# generate labels with pre-trained model
labels_fast <- SignacFast("your_data_here", Models = Models_HPCA, num.cores = 18)
celltypes_fast = Generate_lbls(labels_fast, E = "your_data_here")
```

Unlike Signac, SignacFast uses an ensemble of 1,800 pre-trained neural network models generated from the HPCA reference data, like so:

```r
# load the library
library(Signac)

# load pre-trained neural network ensemble model
data("training_HPCA")

# generate labels with pre-trained model
Models_HPCA = ModelGenerator(R = training_HPCA, N = 100, num.cores = 10)
```

We demonstrate how to use SignacFast in this [vignette](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/SignacFast-Seurat_AMP_RA.html).

<!-- BENCHMARKING -->
## Benchmarking

### CITE-seq

In Figure 2-3 of the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full), we validated Signac with CITE-seq PBMCs. Here, we reproduced that analysis with SPRING ([in this vignette](https://github.com/AllonKleinLab/SPRING_dev); as was performed in the pre-print) and additionally with Seurat ([in this vignette](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/signac-Seurat_CITEseq.html)).

### Flow-sorted synovial cells

In Figure 3 of the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full), we validated Signac with flow cytometry and compared Signac to SingleR. We reproduced that analysis using Seurat [in this vignette](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/signac-Seurat_AMP_RA.html).

### PBMCs

In Table 1 of the [pre-print](https://www.biorxiv.org/content/10.1101/2021.02.01.429207v3.full), we benchmarked Signac across seven different technologies: CEL-seq, Drop-Seq, inDrop, 10X (v2), 10X (v3), Seq-Well and Smart-Seq2; this analysis was reproduced [here](https://htmlpreview.github.io/?https://github.com/mathewchamberlain/Signac/master/vignettes/PBMC_bench.html).

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/mathewchamberlain/Signac/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

You can also open a pull request to commit to the master branch.

<!-- LICENSE -->
## License

Distributed under the GPL v3.0 License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Mathew Chamberlain - [linkedin](https://linkedin.com/in/chamberlainmathew) - mathew.chamberlain@sanofi.com

Project Link: [https://github.com/mathewchamberlain/Signac](https://github.com/mathewchamberlain/Signac)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/mathewchamberlain/Signac.svg?style=flat-square
[contributors-url]: https://github.com/mathewchamberlain/Signac/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/mathewchamberlain/Signac.svg?style=flat-square
[forks-url]: https://github.com/mathewchamberlain/Signac/network/members
[stars-shield]: https://img.shields.io/github/stars/mathewchamberlain/Signac.svg?style=flat-square
[stars-url]: https://github.com/mathewchamberlain/Signac/stargazers
[issues-shield]: https://img.shields.io/github/issues/mathewchamberlain/Signac.svg?style=flat-square
[issues-url]: https://github.com/mathewchamberlain/Signac/issues
[license-shield]: https://img.shields.io/github/license/mathewchamberlain/Signac.svg?style=flat-square
[license-url]: https://choosealicense.com/licenses/gpl-3.0/
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/chamberlainmathew
[product-screenshot]: images/screenshot.png