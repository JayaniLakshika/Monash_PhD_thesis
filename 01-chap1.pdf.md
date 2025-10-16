
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


High-dimensional data, where each observation is described by many variables, is increasingly prevalent in modern science, from bioinformatics to computer vision and social science. For example, **CITE-seq data** [@hao2021] simultaneously records RNA expression and protein markers for individual cells, producing rich, complex datasets. To make sense of such data, analysts often rely on **dimension reduction** methods to create low-dimensional visualizations that can reveal patterns and structure.

One established approach is **linear projection**, where high-dimensional points are represented as linear combinations of the original features. **Principal Component Analysis (PCA)** is the most familiar method, identifying directions of maximum variance. Extending this idea, **tours** [@lee2021] provide dynamic sequences of linear projections, giving views from multiple angles to help reveal hidden structure. Tour methods are implemented in R packages such as `tourr` [@wickham2011], `langevitour` [@harrison2023], and `detourr` [@hart2022]. A key advantage of linear projections is that they preserve the geometric relationships of the original data—they do not introduce distortion. However, linear projections can become cluttered, and global structure may obscure local detail. Furthermore, **piling** [@laa2022]—where points concentrate in the center of projections—can mask important variation.

To overcome these limitations, analysts frequently turn to **nonlinear dimension reduction (NLDR)** methods such as tSNE [@laurens2008], UMAP [@leland2018], PHATE [@moon2019], TriMAP [@amid2022], and PaCMAP [@yingfan2021]. NLDR applies nonlinear transformations to generate low-dimensional embeddings that aim to preserve local or global data relationships. These methods are designed to **exaggerate structure**, making it easier for analysts to detect patterns.


::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Eight different NLDR representations of a human PBMC CITE-seq dataset (@yuhan2021). Different techniques and different hyperparameter choices are used. Researchers may have seen any of these in their analysis of this data, depending on their choice of method, or typical hyperparameter choice. Would they make different decisions downstream in the analysis depending on which version seen? Which is the most accurate representation of the structure in high dimensions?](01-chap1_files/figure-pdf/fig-NLDR-variety-1.pdf){#fig-NLDR-variety fig-pos='H' width=100%}
:::
:::



Yet this strength also introduces a critical risk: **NLDR can hallucinate structure**, creating patterns in the low-dimensional space that do not exist in the high-dimensional data. This issue is strikingly illustrated in @fig-NLDR-variety, where eight different NLDR representations of the same CITE-seq dataset vary dramatically due to differences in method or hyperparameter choices. Such variability raises essential questions: *Which visualization can be trusted? Which accurately reflects the high-dimensional structure?*

Despite the widespread use of NLDR, there is no widely accepted or visually interpretable framework for **diagnosing the reliability of NLDR representations**. Analysts are left to rely on subjective judgment when choosing and interpreting NLDR layouts, without tools to distinguish faithful representations from artifacts. There is also a lack of benchmark datasets with known geometric structure for testing NLDR methods systematically.

In addition to technical gaps, **little is known about how people perceive and misperceive structure in NLDR layouts**. It is unclear how different visualizations influence analysts’ conclusions, or how distortions introduced by NLDR affect decision making. Given the critical role of visualization in high-dimensional data analysis, understanding the human perception of NLDR representations is essential.

## High-dimensional Data Visualization

## Dimension Reduction Methods

## Metrics to Evaluate NLDR quantitatively

### Neighborhood preservation metric ($R_{NX}(K)$)

Given:

* $X = {x_1, \ldots, x_N}$ — high-dimensional data
* $Y = {y_1, \ldots, y_N}$ — 2D (or low-dimensional) embedding

#### Step 1: Compute neighborhood ranks

For each point $i$:

* Compute pairwise distances in high-D: $\delta_{ij} = | x_i - x_j |$
* Compute pairwise distances in low-D: $d_{ij} = | y_i - y_j |$

Then define the **rank** of ( j ) w.r.t. ( i ):
$$
\rho_{ij} = \text{rank of } \delta_{ij} \text{ among all } j \neq i
$$
$$
r_{ij} = \text{rank of } d_{ij} \text{ among all } j \neq i
$$

#### Step 2: Define K-nearest neighborhoods

$$
\nu^K_i = { j : 1 \le \rho_{ij} \le K }
$$
$$
n^K_i = { j : 1 \le r_{ij} \le K }
$$

#### Step 3: Compute overlap fraction for each point

$$
Q_{NX}(K) = \frac{1}{N K} \sum_{i=1}^{N} | \nu^K_i \cap n^K_i |
$$

#### Step 4: Rescale for comparability (Lee et al., 2015)

To adjust for random embedding baseline:

$$
R_{NX}(K) = \frac{(N - 1) Q_{NX}(K) - K}{N - 1 - K}
$$

where $R_{NX}(K) \in [0,1]$:

* $R_{NX}(K) = 1$ → perfect preservation
* $R_{NX}(K) = 0$ → random preservation

#### Step 5: Compute **AUC** over log-scaled ( K )

$$
\text{AUC}*{\ln K}(R*{NX}(K)) =
\frac{\sum_{K=1}^{N/2} R_{NX}(K)/K}{\sum_{K=1}^{N/2} 1/K}
$$

This gives a single scalar summarizing local–to–global preservation quality.

### Shepard diagram

### Random Triplet Accuracy (RTA)

To measure how well relative distances between points are preserved by a NLDR method without requiring class labels.

It checks how often the embedding preserves the correct ordering of pairwise distances from the high-dimensional space.

A **triplet** is a set of three points:
$$
(i, j, k)
$$

* $i$: anchor point
* $j$: a point close to $i$ (in high-dimensional space)
* $k$: a point farther away from $i$

If in the high-dimensional space:
$$
|x_i - x_j| < |x_i - x_k|
$$

then the embedding $Y$ should ideally preserve this ordering:
$$
|y_i - y_j| < |y_i - y_k|
$$

We define a *triplet as correctly preserved* if both inequalities hold.
Formally, define an indicator:

$$
I_{ijk} =
\begin{cases}
1, & \text{if } \big(|x_i - x_j| < |x_i - x_k|\big) \text{ and } \big(|y_i - y_j| < |y_i - y_k|\big) \\
0, & \text{otherwise}
\end{cases}
$$

Then, the **Random Triplet Accuracy (RTA)** is:

$$
\text{RTA} = \frac{1}{|\mathcal{T}|} \sum_{(i,j,k) \in \mathcal{T}} I_{ijk}
$$

where $\mathcal{T}$ is the set of sampled triplets.

Triplets can be sampled randomly across all points.

- For each anchor $i$, randomly sample a few pairs $(j, k) \neq i$.
- Use only distances between points to check ordering consistency.

(In current implementation, 5 random triplets per point, computes which ones preserve the ordering)

If labels are available, you can restrict $j$ to be within the same class and 
$k$ from a different class. This variant measures how well class structure is preserved.


### Global score

Measures *how well a low-dimensional embedding $Y$* preserves the **global linear structure** of the high-dimensional data $X$.

We have:

* $X \in \mathbb{R}^{n \times p}$: the high-dimensional data (each row is an observation).
* $Y \in \mathbb{R}^{n \times d}$: the low-dimensional embedding (produced by t-SNE, UMAP, PHATE, etc.).
* $n$: number of observations, $p$: number of features, $d$: embedding dimension (usually 2).

The function computes a **global loss** based on how well $Y$ can linearly reconstruct $X$.


We want to find a linear mapping $A \in \mathbb{R}^{p \times d}$ such that:

$$
X^\top \approx A Y^\top
$$

Equivalently:

$$
X \approx Y A^\top
$$

This means: can we **linearly reconstruct** the high-D data $X$ from the low-D embedding $Y$?
That’s the key idea behind “global structure preservation”:
If $Y$ preserves the global geometry of $X$, then there exists such a linear mapping $A$ with low reconstruction error.

The optimal $A$ (in least squares sense) minimizes:

$$
\mathcal{L}(A) = | X^\top - A Y^\top |_F^2
$$

Setting the derivative $\frac{\partial \mathcal{L}}{\partial A} = 0$ gives:

$$
A = X^\top Y (Y^\top Y)^{-1}
$$

which matches exactly what the code computes (after transposing):

$$
A = X^\top (Y (Y^\top Y)^{-1})
$$

Now compute the **mean squared reconstruction error**:

$$
L_{\text{global}}(X, Y) = \frac{1}{np} | X^\top - A Y^\top |_F^2
$$

This measures how well $Y$ (through a linear transformation $A$) can reconstruct $X$.

* If $Y$ retains global structure well; low $L_{\text{global}}$
* If $Y$ distorts global structure; high $L_{\text{global}}$

Then, the function compares the embedding’s global loss against that of a **PCA embedding**:

So the final **Global Score (GS)** is:

$$
\text{GS} = \exp\left( - \frac{L_{\text{global}}(X, Y) - L_{\text{global}}(X, Y_{\text{PCA}})}{L_{\text{global}}(X, Y_{\text{PCA}})} \right).
$$

So, the **Global Score** acts as a *normalized measure of how well the embedding preserves global linear relationships*, relative to PCA.

## **3. KNN Accuracy**

### **Intuition:**

If an embedding preserves local neighborhoods well, then points close together in high-dimensional space should remain close in the low-dimensional embedding. A simple way to check this is to see how well a **K-Nearest Neighbors classifier** can predict labels in the embedding space.

### **Mathematical Definition:**

1. Let $Y = \{y_1, \dots, y_n\}$ be the low-dimensional embedding of high-dimensional data $X = \{x_1, \dots, x_n\}$.
2. Let $L = \{l_1, \dots, l_n\}$ be the true labels for each observation.
3. For each point $y_i$, find its $k$ nearest neighbors $\text{NN}_k(y_i)$ in the embedding space.
4. Predict $y_i$’s label as the **majority vote** among neighbors:

$$
\hat{l}_i = \text{mode}(\{l_j : j \in \text{NN}_k(y_i)\})
$$

5. KNN accuracy is:

$$
\text{KNN Accuracy} = \frac{1}{n} \sum_{i=1}^{n} \mathbf{1}\{\hat{l}_i = l_i\}
$$

* $\mathbf{1}\{\cdot\}$ is the indicator function.

**Notes:**

* This is a **leave-one-out cross-validation (LOO-CV)**.
* For larger datasets, you can use **k-fold CV** to reduce runtime.

## **4. SVM Accuracy (Local Evaluation)**

### **Intuition:**

SVM Accuracy measures local structure preservation in a **more flexible way**. It uses a kernel (e.g., RBF) to capture nonlinear separations in the embedding space. If the embedding preserves neighborhoods, an SVM trained on some points should correctly classify held-out points.

### **Mathematical Definition:**

1. Let $Y$ be the embedding and $L$ the labels.
2. Partition $Y$ into $K$ folds: $Y = Y_1 \cup \dots \cup Y_K$.
3. For each fold $k$:

   * Train an SVM on $Y \setminus Y_k$ (all other folds).
   * Predict labels on $Y_k$.
4. SVM Accuracy is the overall proportion of correct predictions:

$$
\text{SVM Accuracy} = \frac{1}{n} \sum_{i=1}^{n} \mathbf{1}\{\hat{l}_i = l_i\}
$$

* Often an **RBF kernel** is used:

$$
K(y_i, y_j) = \exp(-\gamma \|y_i - y_j\|^2)
$$

* To speed up large datasets, one can approximate the kernel with **Nyström method** (low-rank approximation).

### CTA

## Distance Metrics

Let dataset $X = \{x_1, x_2, \dots, x_n\}$ in some metric space with distance function $d(\cdot, \cdot)$, clustering assignment $C = \{C_1, C_2, \dots, C_k\}$, where $C_i$ is the set of indices of points in cluster $i$, and $n_i = |C_i|$ = size of cluster $i$.

#### min_avg_dist

`average.distance` = average pairwise distance within a cluster $C_k$:

$$
\text{average.distance}(C_k) = \frac{2}{n_k(n_k - 1)} \sum_{i<j, \, i,j \in C_k} d(x_i, x_j)
$$

with $n_k$ = number of points in cluster $k$.

Then:

$$
\text{min\_avg\_dist} = \min_k \; \text{average.distance}(C_k)
$$


#### min_dist

From `cluster_stats$min.separation`, the minimum **between-cluster separation**:

For clusters $C_k, C_\ell$ with $k \neq \ell$:

$$
\text{separation}(C_k, C_\ell) = \min_{x \in C_k, \, y \in C_\ell} d(x,y)
$$

Then:

$$
\text{min\_dist} = \min_{k \neq \ell} \text{separation}(C_k, C_\ell)
$$


#### avg_dist

From `cluster_stats$average.between`, the mean of all **between-cluster distances**:

For clusters $C_k, C_\ell$:

$$
\text{average.between}(C_k, C_\ell) = \frac{1}{n_k n_\ell} \sum_{x \in C_k} \sum_{y \in C_\ell} d(x,y)
$$

Then:

$$
\text{avg\_dist} = \frac{2}{K(K-1)} \sum_{k < \ell} \text{average.between}(C_k, C_\ell)
$$

where $K$ is the number of clusters.

#### Between-to-within (BW) ratio

To evaluate how well clustering structure is preserved in $\mathbb{R}^p$, we use the BW Ratio, which compares the dispersion between clusters to the dispersion within clusters. Let $\mathbf{x}_j \in \mathbb{R}^p$ be the $j$-th observation, and let $C_1, \dots, C_k$ denote the set of $k$ clusters. The centroid of cluster $C_i$ is denoted by $\bar{\mathbf{x}}_i$, and the overall data centroid by $\bar{\mathbf{x}}$. Distances are measured using the Euclidean norm: $d(\mathbf{x}, \mathbf{y}) = \|\mathbf{x} - \mathbf{y}\|_2$.

The within-cluster sum of squares (W) quantifies how tightly points are grouped within each cluster:

$$
W = \sum_{i=1}^{k} \sum_{\mathbf{x}_j \in C_i} \|\mathbf{x}_j - \bar{\mathbf{x}}_i\|^2,
$$

The between-cluster sum of squares (B) captures the extent to which clusters are separated from each other:

$$
B = \sum_{i=1}^{k} n_i \cdot \|\bar{\mathbf{x}}_i - \bar{\mathbf{x}}\|^2,
$$

where $n_i$ is the number of observations in cluster $C_i$.

The resulting BW Ratio is computed as:

$$
\text{BW Ratio} = \frac{B}{W} = \frac{ \sum_{i=1}^{k} n_i \cdot \|\bar{\mathbf{x}}_i - \bar{\mathbf{x}}\|^2 }{ \sum_{i=1}^{k} \sum_{\mathbf{x}_j \in C_i} \|\mathbf{x}_j - \bar{\mathbf{x}}_i\|^2 }.
$$

A higher BW Ratio indicates better clustering, with well-separated cluster centroids and minimal within-cluster dispersion. 

## Research Objectives

This thesis addresses these challenges through four main objectives:

1. **Develop methods and software to diagnose NLDR techniques**, providing tools to assess whether low-dimensional representations accurately reflect high-dimensional structures.

2. **Conduct a large-scale user study to explore perception and misperception in NLDR representations**, assessing how viewers recognize structure differently in NLDR layouts compared to tour-based views. This cognitive perception experiment will help identify common mistakes made when choosing and reporting structure from NLDR visualizations, and will inform best practices for using these methods in data analysis.

3. **Create benchmark datasets with known geometric properties**, via the `cardinalR` package, to systematically evaluate and validate NLDR methods.

4. **Provide a platform for NLDR evaluation**, combining linked linear projections (such as tours) and NLDR layouts to reveal where distortions arise and how structure is preserved or lost.

## Contribution

By addressing both computational and cognitive aspects of NLDR, this research aims to advance our understanding of when and how NLDR methods can be trusted. The work will provide practical tools, benchmark data, and empirical insights to support the responsible use of dimension reduction techniques in high-dimensional data analysis.

<!-- Paper: https://www.sciencedirect.com/science/article/pii/S0092867421005833?via%3Dihub#fig1 (CITE-seq data) -->

<!-- A human PBMC CITE-seq dataset typically contains both RNA expression data and surface protein (ADT) measurements. These datasets are ideal for multimodal single-cell analysis. -->

<!-- Non-linear dimension reduction (NLDR) is popular for making a convenient low-dimensional representation of high-dimensional data by applying non-linear transformation and all designed to better capture specific structures potentially existing in high-dimensions. Here we focus on five currently popular techniques, t-distributed stochastic neighbor embedding (tSNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) algorithm [@moon2019], large-scale dimensionality reduction Using triplets (TriMAP) [@amid2022], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021]. tNSE and UMAP can be considered to produce the 2D minimizing the divergence between two distributions, where the distributions are modeling the inter-point distances. PHATE, TriMAP and PaCMAP are examples of diffusion processes [@coifman2005] spreading to capture geometric shapes, that include both global and local structure. -->

<!-- - Research gap -->

<!--   - There is no visually interpretable way to diagnose NLDR techniques  -->
<!--   - Lack of benchmark data structures to capture the various geometric properties -->
<!--   - Users don't know when to trust NLDR representations -->
<!--   - There is no platform to evaluate NLDR representations -->

<!-- Take on of the cardinalR dataset and generate 6/8 different layouts and explain why it is important to understand what's happening with NLDR methods.  -->


<!-- Historically, 2D representations of high-dimensional data have been computed using multidimensional scaling (MDS) [@borg2005], which includes principal components analysis (PCA) [@jolliffe2011] as a special case. The 2D representation can be viewed as a layout of points in 2D produced by an embedding procedure that maps the data from high dimensions. In MDS, the 2D layout is constructed by minimizing a stress function that differences distances between points in high-dimensions with potential distances between points in 2D. Various formulations of the stress function result in non-metric scaling [@saeed2018] and isomap [@silva2002]. Challenges in working with high-dimensional data, including visualization, are outlined in @johnstone2009.  -->

<!-- The various layouts created by @fig-NLDR-variety demonstrate the different outcomes that can result from the choices of methods and parameters, as well as the random seed used to start the calculation. Key structures interpreted from these views suggest: (1) highly **separated clusters** (a, b, e, g, h) with the number ranging from 3-6; (2) **stringy branches** (f), and (3) **barely separated clusters** (c, d) which would **contradict** the other representations.  -->

<!-- These variations occur due to the different perspectives on the distances between data points provided by the methods and parameter choices. -->

<!-- Another way to visualize high-dimensional data is through linear projections. PCA is the traditional method, resulting in a new set of variables that are linear combinations of the original variables. Tours, as defined by @lee2021, expand on this concept by producing dynamic linear projection visualizations that offer views of the data from all angles. @lee2021 provides an overview of the key advancements in tours. Numerous tour algorithms are available, with many included in the R package `tourr` [@wickham2011], and versions that offer enhanced interactivity in `langevitour` [@harrison2024] and `detourr` [@hart2022]. Linear projections offer a reliable way to view high-dimensional data as they do not distort the space, making them more accurate representations of the data structure. However, linear projections can become cluttered, and global patterns can obscure local structure. The simple act of projecting data from high-dimensional spaces leads to piling [@laa2022], where data concentrates in the center of the projections. -->

<!-- NLDR is designed to escape these issues, to exaggerate structure so that it can be observed. However, NLDR can hallucinate wildly, to suggest patterns that are not actually present in the data. The research project addresses this significant issue by proposing methods to understand better whether the NDLR representations are reliable or hallucinations. These methods are designed to enable a more profound understanding of the quality and validity of NLDR-derived low-dimensional representations. By incorporating rigorous evaluation techniques, the project seeks to identify instances where the NLDR models genuinely capture the essential structures present in the data and where they might introduce artifacts or distortions, leading to potentially misleading representations. This meticulous examination and validation process contribute to enhancing the robustness and credibility of NLDR techniques in high-dimensional data analysis. -->


## Thesis Outline

The rest of the thesis is organized as follows:

@sec-first-paper introduces an algorithm to assess the NLDR and decide on which, if any, is the most reasonable representation of the structure(s) present in high-dimensional data. We create a model starting with NLDR layout that is then used to display as a wireframe in high dimensions.

@sec-second-paper provides empirical evidence on how viewers recognize structure differently when using NLDR layouts versus the tour view, particularly with varying distances between clusters. The findings will help clarify common mistakes made when selecting and reporting structures based on NLDR layouts. 

@sec-software introduces two R packages developed as part of this research. @sec-third-paper presents the implementation of the work is available as an R package, named `quollr`, an acronym to "**qu**estioning how a high-dimensional **o**bject **l**ooks in **l**ow-dimensions using **r**" [@jayani2024a]. This package also contains a function for performing hexagonal binning using a new approach, for saving langevitour results with a specific projection, and link plots to understand the quirks that occur with different NLDR techniques. @sec-fourth-paper proposes the R package, `cardinalR` [@jayani2024b] (**c**ollection of v**ar**ious high-**d**imens**i**o**nal** data
structures in **R**), which includes functions to generate a large variety of structures in high dimensions along with some already generated examples.

@sec-fifth-paper introduces `menuraR` (**m**onitoring **e**mbeddings of **n**onlinear **u**nfoldings for **r**epresentation and **a**nalysis in **R**), a Shiny web application designed to select and evaluate NLDR layouts.

@sec-conclusion concludes the thesis, summarises the contribution of the work, and discusses some future plans.


