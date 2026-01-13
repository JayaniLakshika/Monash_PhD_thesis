

<!-- README.md is generated from README.qmd. Please edit that file -->

# New Interactive Visual Tools and Statistical Methodology for Selecting and Evaluating Non-linear Dimension Reduction Layouts of High-dimensional Data

This repository contains the **source code, datasets, and supplementary
materials** for my PhD thesis at **Monash University, Australia**.

## Overview

High-dimensional data, where each observation is described by many
features, is common in fields such as bioinformatics, ecology, and
forensic science. To visualise these data, researchers often reduce them
to lower dimensions, typically to two. However, popular non-linear
methods can sometimes distort or “hallucinate” patterns that do not
actually exist. This research develops a new methodology and software to
help users assess the reliability of these visualisations. It also
examines common mistakes people make when selecting visualisations.
Also, it provides software for generating benchmark datasets to test
algorithms, which helps researchers in exploring and interpreting
complex data.

## Software

- [`quollr`](https://github.com/JayaniLakshika/quollr): visualise how
  $2\text{-}D$ model looks in high dimensional space

- [`cardinalR`](https://github.com/JayaniLakshika/cardinalR): collection
  of high-dimensional data structures

- [`Match-a-roo`](https://github.com/JayaniLakshika/Match-a-roo): The
  survey Shiny web application is designed to collect survey responses
  and demographics and assess how participants recognise structure
  differently from the Non-linear dimension reduction (NLDR) layout and
  the tour view.

- [`menuraR`](https://github.com/JayaniLakshika/menuraR): The Shiny web
  application is used to compare multiple NLDR representations and
  select the most reasonable one using `quollr` functionalities.

## Repository structure

- [`preliminaries`](preliminaries): Preliminaries of the thesis.
- [`chapters`](chapters): Thesis chapters in source format.
- [`appendix`](appendix): Supplementary materials for each chapter.
- [`data`](data): The data sets used in the examples and empirical
  applications.
- [`figures`](figures): Figures used in the thesis.
- [`misc`](misc): Tables.
- [`scripts`](scripts): R scripts to reproduce the results presented in
  the thesis.
- [`_book`](_book): Rendered version of the thesis (e.g., PDF or HTML).
- [`_extensions`](_extensions): Monash thesis template from
  [qurato-monash/thesis](https://github.com/quarto-monash/thesis).

## Installation

Clone the repository:

    git clone https://github.com/JayaniLakshika/Monash_PhD_thesis.git

### Handle large files with Git LFS

Since this repo contains large data files (\>= 50MB), you need to first
download and install a git plugin called
[`git-lfs`](https://git-lfs.github.com) for versioning large files, and
set up Git LFS using command `git lfs install` in console, in order to
fully clone this repo.

    # Install Git LFS (if not already installed)
    git lfs install

    git lfs pull

### Install required packages

All the R packages required for this project, along with their versions,
are listed in [`_Rpackages.txt`](../_Rpackages.txt) and in
[`scripts/software.R`](scripts/software.R). You can install them by
sourcing the R script:

``` r
source("scripts/software.R")
```

## License

The code contained in this work is available under the [MIT
license](https://opensource.org/licenses/MIT).
