
::: {.cell}

:::



::: {.cell}

:::



# Introduction {#sec-intro}

<!-- - Topic statement -->
<!--   - Develop methods and software to understand NLDR techniques -->

<!-- - Background -->

<!--   - What is high-dimensional data? -->
<!--   - What is happening with Dimension reduction? -->
<!--   - What is LDR and NLDR? -->
<!--   - Introduce high-dimensional data visualization (tour, detour, liminal, langevitour) -->
<!--   - What are the advantages or why using NLDR? -->
<!--   - Introduce different NLDR methods (Add references of the main papers) -->
<!--   - When the NLDR layouts can trust or not? (Any literature of inferences) -->
<!--   - NLDR evaluation metrics -->
<!--   - How to compute distances between the clusters? -->
<!--   - Any literature of user-firendly platforms for NLDR users -->


A high-dimensional dataset is one in which each observation is described by many features, or dimensions, often with associations among them. To create visual representations of high-dimensional data, it is common to apply **dimension reduction** techniques. One established approach is **linear projection**, where high-dimensional points are represented as linear combinations of the original features. **Principal Component Analysis (PCA)** (for an overview, see @jolliffe2011) is the most familiar method, identifying directions of maximum variance. Extending this idea, **tours** (See @lee2021 for a review of tour methods) provide dynamic sequences of linear projections, giving views from multiple angles to help reveal hidden structure. Tour methods are implemented in R packages such as `tourr` [@wickham2011], `langevitour` [@harisson2024], and `detourr` [@casper2025]. A key advantage of linear projections is that they preserve the geometric relationships of the original data; they do not introduce distortion. However, linear projections can become cluttered, and global structure may obscure local detail. Furthermore, *piling* [@laa2022], where points concentrate in the center of projections, can mask important variation.

Because linear projections can reveal only limited aspects of high-dimensional structure, analysts often turn to nonlinear dimension reduction (NLDR) methods in the hope of revealing patterns that may not be visible in any linear view. Common NLDR techniques include t-distributed stochastic neighbor embedding (tSNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) [@moon2019], large-scale dimensionality reduction using triplets (TriMAP) [@amid2022], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021]. The methods tSNE, UMAP, TriMAP, and PaCMAP can be considered for producing the $2\text{-}D$ representation by minimizing the divergence between two inter-point distance distributions. PHATE is an example of a diffusion process spreading to capture geometric shapes that include both global and local structure. (See @coifman2005 for an explanation of diffusion processes.) These methods are designed to *exaggerate structure*, making it easier for analysts to detect patterns that may not be apparent through linear projections.


::: {.cell}

:::


<!-- Paper: https://www.sciencedirect.com/science/article/pii/S0092867421005833?via%3Dihub#fig1 (CITE-seq data) -->

<!-- A human PBMC CITE-seq dataset typically contains both RNA expression data and surface protein (ADT) measurements. These datasets are ideal for multimodal single-cell analysis. -->


::: {.cell}
::: {.cell-output-display}
![UMAP representation of a human PBMC CITE-seq dataset [@hao2021], generated using n_neighbors = $30$ and min_dist = $0.3$, used as a motivating example of NLDR layouts. The layout shows multiple clusters with distinct shapes, including compact, well-separated groups as well as elongated and partially overlapping structures. This raises the question of whether this layout faithfully represents the underlying high-dimensional structure in the PBMC CITE-seq data.](01-chap1_files/figure-pdf/fig-NLDR-variety-intro-1.pdf){#fig-NLDR-variety-intro fig-pos='H' fig-alt='A 2-D scatterplot shows a UMAP embedding of a high-dimensional CITE‑seq dataset, with each point representing a single cell. The horizontal and vertical axes are UMAP embedding 1 and UMAP embedding 2, each spanning an arbitrary, roughly symmetric range around zero (for example, from about –10 to +10), with no explicit biological units. Points are shaded, producing several visually distinct groups: some compact, roughly circular clusters, others elongated or curved, and a few smaller, more scattered groups at the periphery of the layout. The clusters appear well separated with clear gaps between them, suggesting strong structure and possible subpopulations; however, the figure is used to emphasize that these apparent shapes and separations may reflect the chosen NLDR method and hyper‑parameters rather than true structure in the original high‑dimensional data.' width=50%}
:::
:::


Yet this strength also introduces a critical risk: **NLDR can hallucinate structure**, creating patterns in the low-dimensional space that do not exist in the high-dimensional data. This is illustrated in @fig-NLDR-variety-intro, where a UMAP layout of a CITE-seq dataset appears to show several distinct clusters with different shapes. While these patterns are visually appealing and easy to interpret, it is not obvious whether they reflect true structure in the high-dimensional data or arise from the choice of method and hyper-parameters. This naturally leads to key questions: *Can this layout be trusted? Does it faithfully represent the structure of the underlying $10\text{-}D$ PBMC CITE-seq data?*

Despite the widespread use of NLDR, there is no widely accepted or visually interpretable framework for **diagnosing the reliability of NLDR representations**. Analysts are left to rely on subjective judgment when choosing and interpreting NLDR layouts, without tools to distinguish faithful representations from artifacts. There is also a lack of benchmark clustering datasets for testing, especially NLDR methods.

In addition to technical gaps, **little is known about how people perceive and misperceive structure in NLDR layouts**. It is unclear how different NLDR representations influence analysts’ conclusions, or how distortions introduced by NLDR affect decision-making. Given the critical role of visualization in high-dimensional data analysis, understanding the human perception of NLDR representations is essential.

## Research objectives

This thesis aims to address the key challenges in understanding and evaluating NLDR methods through four main objectives:

1. Develop a new approach and software to evaluate NLDR techniques, providing tools to assess whether low-dimensional representations accurately capture the high-dimensional data structures, using visual and quantitative diagnostics.

2. Design and conduct a user study to explore perception and misperception in NLDR representations, assessing whether participants conceptualize the data structure similarly in NLDR layout compared to tours of linear combinations. This will guide the development of further cognitive perception experiments for assessing NLDR.

3. Generate benchmark clustering data structures in high dimensions with some additional properties like background noise, using the `cardinalR` package, to evaluate the performance of the algorithms, like clustering, NLDR.

4. Provide a web tool for NLDR users to help select the most reasonable NLDR representation among a selection of possible layouts. 

## Contribution

This research contributes to a deeper understanding of how NLDR methods can be evaluated and trusted in practice. It provides new tools and software for assessment, benchmark datasets for testing algorithms, and insights from a user study exploring how participants perceive and misperceive structures in NLDR layouts.

## Thesis outline

The rest of the thesis is organized as follows:

@sec-first-paper introduces an algorithm to assess the NLDR and decide on which, if any, is the most reasonable representation of the structure(s) present in high-dimensional data. We create a model starting with an NLDR layout that is then used to display as a wireframe in high dimensions.

@sec-third-paper presents the implementation of the work, which is available as an R package named `quollr`, an acronym for "**qu**estioning how a high-dimensional **o**bject **l**ooks in **l**ow-dimensions using **r**" [@jayani2025a]. This package also contains a function for performing hexagonal binning using a new approach, for saving `langevitour` results with a specific projection, and link plots to understand the quirks that occur with different NLDR techniques.

@sec-fourth-paper introduces the R package, `cardinalR` [@jayani2025b] (**c**ollection of v**ar**ious high-**d**imens**i**o**nal** data
structures in **R**), which includes functions to generate high-dimensional clustering data structures, with features such as adding noise dimensions and background noise, along with some already generated examples.

@sec-second-paper provides empirical evidence on how viewers recognize structure differently when using NLDR layouts versus the tour view, particularly with varying distances between clusters. The findings will help clarify common mistakes made when selecting and reporting structures based on NLDR layouts. 

@sec-fifth-paper introduces `menuraR` (**m**onitoring **e**mbeddings of **n**onlinear **u**nfoldings for **r**epresentation and **a**nalysis in **R**), a Shiny web application designed to select and evaluate NLDR layouts.

@sec-conclusion concludes the thesis, summarizes the contribution of the work, and discusses some future plans.
