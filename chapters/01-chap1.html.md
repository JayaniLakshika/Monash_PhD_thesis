
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


A high-dimensional dataset is one in which each observation is described by many features, or dimensions, often with associations among them. To create visual representations of high-dimensional data, it is common to apply **dimension reduction** techniques. One established approach is **linear projection**, where high-dimensional points are represented as linear combinations of the original features. **Principal Component Analysis (PCA)** (for an overview see @jolliffe2011) is the most familiar method, identifying directions of maximum variance. Extending this idea, **tours** [@lee2021] provide dynamic sequences of linear projections, giving views from multiple angles to help reveal hidden structure. Tour methods are implemented in R packages such as `tourr` [@wickham2011], `langevitour` [@harisson2024], and `detourr` [@hart2022]. A key advantage of linear projections is that they preserve the geometric relationships of the original data, they do not introduce distortion. However, linear projections can become cluttered, and global structure may obscure local detail. Furthermore, *piling* [@laa2022] where points concentrate in the center of projections can mask important variation.

Because linear projections can reveal only limited aspects of high-dimensional structure, analysts often turn to nonlinear dimension reduction (NLDR) methods in the hope of revealing patterns that may not be visible in any linear view. Common NLDR techniques include t-distributed stochastic neighbor embedding (t-SNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) [@moon2019], large-scale dimensionality reduction using triplets (TriMAP) [@amid2022], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021]. The methods tSNE, UMAP, TriMAP, and PaCMAP can be considered for producing the \kD{} representation by minimizing the divergence between two inter-point distance distributions. PHATE is an example of a diffusion process spreading to capture geometric shapes, that include both global and local structure. (See @coifman2005 for an explanation of diffusion processes.) These methods are designed to *exaggerate structure*, making it easier for analysts to detect patterns that may not be apparent through linear projections.


::: {.cell}

:::


<!-- Paper: https://www.sciencedirect.com/science/article/pii/S0092867421005833?via%3Dihub#fig1 (CITE-seq data) -->

<!-- A human PBMC CITE-seq dataset typically contains both RNA expression data and surface protein (ADT) measurements. These datasets are ideal for multimodal single-cell analysis. -->


::: {.cell}
::: {.cell-output-display}
![Eight different NLDR representations of a human PBMC CITE-seq dataset (@hao2021). Different techniques and different hyper-parameter choices are used (*(a) UMAP (n_neighbors = 15, min_dist = 0.1), (b) UMAP (n_neighbors = 54, min_dist = 0.5), (c) PaCMAP (n_neighbors = 51, init = random, MN_ratio = 0.3, FP_ratio = 2), (d) tSNE (perplexity = 30), (e) tSNE (perplexity = 84), (f) PHATE (knn = 5), (g) TriMAP (n_inliers = 12, n_outliers = 4, n_random = 3), (h) PaCMAP (n_neighbors = 10, init = random, MN_ratio = 0.5, FP_ratio = 2)*). Researchers may have seen any of these in their analysis of this data, depending on their choice of method, or typical hyper-parameter choice. Would they make different decisions downstream in the analysis depending on which version seen? Which is the most accurate representation of the structure in high dimensions?](01-chap1_files/figure-html/fig-NLDR-variety-intro-1.png){#fig-NLDR-variety-intro fig-pos='H' width=50%}
:::
:::


Yet this strength also introduces a critical risk: **NLDR can hallucinate structure**, creating patterns in the low-dimensional space that do not exist in the high-dimensional data. This issue is strikingly illustrated in @fig-NLDR-variety-intro, where eight different NLDR representations of the same CITE-seq dataset vary dramatically due to differences in method or hyper-parameter choices. Such variability raises essential questions: *Which layout can be trusted? Which accurately represents the high-dimensional data structure(s)?*

Despite the widespread use of NLDR, there is no widely accepted or visually interpretable framework for **diagnosing the reliability of NLDR representations**. Analysts are left to rely on subjective judgment when choosing and interpreting NLDR layouts, without tools to distinguish faithful representations from artifacts. There is also a lack of benchmark clustering datasets for testing specially NLDR methods.

In addition to technical gaps, **little is known about how people perceive and misperceive structure in NLDR layouts**. It is unclear how different NLDR representations influence analysts’ conclusions, or how distortions introduced by NLDR affect decision making. Given the critical role of visualization in high-dimensional data analysis, understanding the human perception of NLDR representations is essential.

## Research Objectives

This thesis aims to achieve the key challenges in understanding and evaluating NLDR methods through four main objectives:

1. **Develop a new approach and software to evaluate NLDR techniques**, providing tools to assess whether low-dimensional representations accurately capture the high-dimensional data structures, using visual and quantitative diagnostics.

2. **Conduct a large-scale user study to explore perception and misperception in NLDR representations**, assessing how participants recognize the data structure similarly in NLDR layout compared to tour views. This cognitive perception experiment provides common mistakes made when choosing and reporting structure from NLDR representations, and will inform best practices for using these methods in data analysis.

3. **Generate benchmark clustering data structures in high dimensions with some additional properties like background noise**, using the `cardinalR` package, to evaluate the performance of the algorithms like clustering, NLDR.

4. **Provide a platform for NLDR users**, comparing multiple NLDR representations and select the most reasonable one. 

## Contribution

This research contributes to a deeper understanding of how NLDR methods can be evaluated and trusted in practice. It provides new tools and software for assessment, benchmark datasets for testing algorithms, and insights from a large-scale user study to guide effective use of NLDR in high-dimensional data analysis.

## Thesis Outline

The rest of the thesis is organized as follows:

@sec-first-paper introduces an algorithm to assess the NLDR and decide on which, if any, is the most reasonable representation of the structure(s) present in high-dimensional data. We create a model starting with NLDR layout that is then used to display as a wireframe in high dimensions.

@sec-third-paper presents the implementation of the work is available as an R package, named `quollr`, an acronym to "**qu**estioning how a high-dimensional **o**bject **l**ooks in **l**ow-dimensions using **r**" [@jayani2024a]. This package also contains a function for performing hexagonal binning using a new approach, for saving langevitour results with a specific projection, and link plots to understand the quirks that occur with different NLDR techniques.

@sec-fourth-paper introduces the R package, `cardinalR` [@jayani2024b] (**c**ollection of v**ar**ious high-**d**imens**i**o**nal** data
structures in **R**), which includes functions to generate high-dimensional clustering data structures, with features such as adding noise dimensions and background noise along with some already generated examples.

@sec-second-paper provides empirical evidence on how viewers recognize structure differently when using NLDR layouts versus the tour view, particularly with varying distances between clusters. The findings will help clarify common mistakes made when selecting and reporting structures based on NLDR layouts. 

@sec-fifth-paper introduces `menuraR` (**m**onitoring **e**mbeddings of **n**onlinear **u**nfoldings for **r**epresentation and **a**nalysis in **R**), a Shiny web application designed to select and evaluate NLDR layouts.

@sec-conclusion concludes the thesis, summarizes the contribution of the work, and discusses some future plans.
