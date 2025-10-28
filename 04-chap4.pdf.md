# Software {#sec-software}

## quollr: An R Package for Visualising $2\text{-}D$ Models from Non-linear Dimension Reductions in High Dimensional Space {#sec-third-paper}


## cardinalR: Generating interesting high-dimensional data structures {#sec-fourth-paper}

A high-dimensional dataset is one where each observation is described by many features, or dimensions, with associations between them. These datasets contain nonlinear manifolds in image and speech recognition, clusters in genomics and forensic analysis, and sparse distributions in text mining. Data with a variety of structures can be generated using mathematical functions and statistical distributions to create test datasets. High-dimensional data structures are useful for testing, validating, and improving algorithms used in dimensionality reduction, clustering, machine learning, and visualization. Their controlled complexity allows researchers to understand challenges posed in data analysis and helps to develop robust analytical methods across diverse scientific fields like bioinformatics, machine learning, and forensic science. Functions to generate a large variety of structures in high dimensions are organized into the R package `cardinalR`, along with some already generated examples, adding to the existing toolset of benchmark datasets for evaluating algorithms.




::: {.cell}

:::





::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


# Introduction

Generating synthetic datasets with clearly defined geometric properties is useful for evaluating and benchmarking algorithms in various fields, such as machine learning, data mining, and computational biology. Researchers often need to generate data with specific dimensions, noise characteristics, and complex underlying structures to test the performance and robustness of their methods. There are numerous packages available in R for generating synthetic data, each designed with unique characteristics and focus areas.The `geozoo` package (@barret2016) offers a large collection of geometric objects, allowing users to create and analyze specific shapes, primarily in lower-dimensional spaces. The package is `snedata` (@james2025), which provides tools for generating simplified datasets useful for evaluating dimensionality reduction techniques like tSNE, often focusing on understanding and evaluating low-dimensional embeddings of complex data structures. Additionally, `splatter` (@luke2017) is designed to simulate complex biological data, capturing field-specific nuances such as batch effects and differential expression. In contrast, `mlbench` (@friedrich2024) includes a collection of well-known benchmark datasets commonly associated with established classification or regression challenges. The `surreal` package (@james2024) implements the "Residual (Sur)Realism" algorithm (@leonard2007) to generate datasets that embed hidden images or text into residual plots, providing engaging visual demonstrations for teaching model diagnostics. Meanwhile, the `DHARMa` package (@florian2024) adopts a simulation-based approach to create scaled quantile residuals for generalized linear (mixed) models and related frameworks, supporting model diagnostics through intuitive residuals, plots, and tests for common misspecification issues. 

While these packages are valuable, their scope is often limited to specific applications or low-dimensional structures. To address this gap, this paper introduces the `cardinalR` R package. This package provides a collection of functions designed to generate customizable data structures in any number of dimensions, starting from basic geometric shapes. `cardinalR` offers important functionalities that extend beyond the capabilities of existing tools, allowing users to: (i) construct high-dimensional datasets based on geometric shapes, including the option to enhance dimensionality by adding controlled noise dimensions; (ii) introduce adjustable levels of background noise to these structures; and (iii) combine high-dimensional datasets into a single multi-faceted, clustered dataset in a space of arbitrary dimension. By using clearly defined geometric shapes and controllable characteristics such as number of dimensions, sample size; `cardinalR` allows researchers to generate transparent and interpretable synthetic datasets useful for evaluating the performance of nonlinear dimensionality reduction (NLDR) methods, clustering algorithms, and visualization techniques. Moreover, these datasets can serve as benchmark examples for exploring how different algorithmic choices affect the identification or representation of cluster and manifold structures in high-dimensional spaces.

The paper is organized as follows. In the next section, we introduce the implementation of the `cardinalR` package on GitHub, including a demonstration of the package's key functions. We illustrate how a clustering data structure affects the dimension reductions in the Application section. Finally, we give a brief conclusion of the paper and discuss potential opportunities for the use of our data collection.

# Implementation

The `cardinalR` package is built on a modular framework where individual geometric generators (e.g., Gaussian, cone, sphere) create well-defined shapes. The main function, `gen_multicluster()`, combines these shapes into a single dataset by applying scaling, rotation, and translation through `gen_rotation()`. Each generated shape is assigned a unique cluster label. This design allows flexible construction of complex, high-dimensional structures for evaluating clustering and dimension reduction methods. Figure \@ref(fig:workflow) illustrates the workflow of `gen_multicluster()`.


::: {.cell}
::: {.cell-output-display}
![Workflow for generating high-dimensional clustered data. The user specifies input parameters (number of points, clusters, cluster shapes, scaling, rotation, and optional background noise). Clusters are generated iteratively, transformed, optionally augmented with Gaussian noise dimensions, combined, and labeled, resulting in the final dataset.](figures/cardinalR/cardinalR_workflow.png){fig-pos='H' width=100%}
:::
:::


# Usage

The `cardinalR` R package is available on GitHub at [JayaniLakshika/cardinalR](https://github.com/JayaniLakshika/cardinalR).

## Main function

The main function of the package is `gen_multicluster()`, which generates datasets consisting of multiple clusters with user-specified characteristics. Users can control the number of clusters (`k`), and the number of points in each cluster (`n`). Each cluster can take on a different geometric shape (e.g., Gaussian, cone, uniform cube) by specifying the corresponding generator function (`shape`), can be scaled to adjust its spread, rotated using custom rotation matrices (`rotation`), and positioned at defined centroids (`loc`). The function ensures flexibility in cluster location and orientation, allowing users to simulate complex high-dimensional structures. 

To maintain consistency across generators, the function identifies the arguments required by each chosen generator function and supplies only those arguments that are valid for that specific generator. This design enables the combination of cluster types with differing parameter requirements within the same dataset. When clusters are generated with fewer dimensions than others, the function augments the lower-dimensional clusters with additional Gaussian noise variables so that all clusters are represented in the same dimensional space. These noise dimensions are drawn independently from normal distributions

$$
X \sim \mathcal{N}(m, s^2),
$$

where the mean ($m$) is set to the average of the cluster coordinates and the standard deviation ($s$) defaults to $0.2$.

An optional argument, `is_bkg`, adds background noise drawn from a multivariate normal distribution centered on the dataset’s overall mean with standard deviations matching the observed spread. Extra arguments (`...`) can be passed to cluster generators, allowing further control over per-cluster characteristics like radius of the sphere. The main arguments of the `gen_multicluster()` function are shown in Table \@ref(tab:main-tb-pdf).


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:main-tb-pdf}The main arguments for gen\_multicluster().}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{2cm}>{\raggedright\arraybackslash}p{3cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Argument & Type & Explanation\\
\midrule
n & numeric (vector) & Number of points in each cluster.\\
k & numeric & Number of clusters.\\
loc & numeric (matrix) & Locations/centroids of clusters.\\
scale & numeric (vector) & Scaling factors of clusters.\\
shape & character (vector) & Shapes of clusters.\\
rotation & numeric (list) & Rotation matrices, one per cluster.\\
is\_bkg & boolean & Background noise should exist or not.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


The following example demonstrates how to use `gen_multicluster()` to create a $4\text{-}D$ dataset with three clusters of different shapes and orientations:


::: {.cell}

```{.r .cell-code}
# Define example rotation matrices for 4D space
rot1 <- gen_rotation(p = 4, planes_angles = list(
  list(plane = c(1, 2), angle = 60),
  list(plane = c(3, 4), angle = 90)
))

rot2 <- gen_rotation(p = 4, planes_angles = list(
  list(plane = c(1, 3), angle = 30)
))

rot3 <- gen_rotation(p = 4, planes_angles = list(
  list(plane = c(2, 4), angle = 45)
))

# Generate the clustered dataset
clust_data <- gen_multicluster(
  n = c(200, 300, 500),
  k = 3,
  loc = matrix(c(
    0, 0, 0, 0,
    5, 9, 0, 0,
    3, 4, 10, 7
  ), nrow = 3, byrow = TRUE),
  scale = c(3, 1, 2),
  shape = c("gaussian", "cone", "unifcube"),
  rotation = list(rot1, rot2, rot3),
  is_bkg = FALSE
)
```
:::


## Shape generators

The shape generators form the foundation of the package, providing functions to create synthetic datasets from simple, well-defined geometric forms such as cones, pyramids, spheres, grids, and branching structures. Each generator includes the parameter `n`, which specifies the number of points to generate. Some functions, such as `gen_unifcube()`, also take the dimension `p`, while others include arguments specific to the geometry (e.g., radius for spheres (`r`), width for bands (`w`)). If higher-dimensional data are required, additional noise dimensions can be appended after data generation using any noise generator function. This flexibility allows users to construct both low- and high-dimensional datasets from the same underlying structures.

### Branching

A branching structure (Figure \@ref(fig:branch-proj)) captures trajectories that diverge or bifurcate from a common origin, similar to processes such as cell differentiation in biology (@trapnell2014). We introduce a set of data generation functions specifically designed to simulate high-dimensional branching structures with various geometries, numbers of points (`n`), and number of branches (`k`). Although these functions can generate multiple branches, they do not produce a formal *multicluster* dataset: the branches form a single connected structure, with multiple visually distinct arms rather than independent clusters. Table \@ref(tab:branching-tb-pdf) outlines these functions. The main arguments of the functions described in Table \@ref(tab:arg-branching-tb-pdf).


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:branching-tb-pdf}cardinalR branching data generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_expbranches & Exponential shaped branches.\\
gen\_linearbranches & Linear shaped branches.\\
gen\_curvybranches & Curvy shaped branches.\\
gen\_orglinearbranches & Linear shaped branches originated in one point.\\
gen\_orgcurvybranches & Curvy shaped branches originated in one point.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:arg-branching-tb-pdf}The main arguments for branching shape generators.}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{2cm}>{\raggedright\arraybackslash}p{3cm}l}
\toprule
Argument & Type & Explanation\\
\midrule
n & integer & Number of points.\\
k & integer & Number of clusters.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


The simplest structures are approximately linear branches in \gD{}, generated by the `gen_linearbranches(n, k)` function. These consist of $k$ short line segments in the first two dimensions, with added jitter to simulate variability. Mathematically, each branch $i$ is defined as

$$
X_1 \sim U(a_i, b_i), \quad X_2 = s_i (X_1 - x_{\text{start},i}) + y_{\text{start},i} + \epsilon, \quad \epsilon \sim U(0, \delta),
$$

where $(x_{\text{start},i}, y_{\text{start},i})$ is the starting point of branch $i$, $\delta$ controls local jitter, and $s_i$ is the slope, initialized as

$$
s_i =
\begin{cases}
0.5 & i = 1, \\
-0.5 & i = 2, \\
\text{randomly sampled from } [s_{\min}, s_{\max}] & i = 3, \dots, k.
\end{cases}
$$

Branches $1$ and $2$ are initialized with fixed slopes and intercepts, while later branches are iteratively added at locations chosen to avoid overlap with existing branches, producing a set of connected linear paths. 


::: {.cell}

```{.r .cell-code}
linearbranches <- gen_linearbranches(n = 1000, k = 4)
```
:::


To introduce curvature, the `gen_curvybranches(n, k)` function generates $k$ curvilinear branches in \gD{}. Branches $1$ and $2$ are simple parabolas defined as

$$
\begin{aligned}
\text{Branch 1: } & X_1 \sim U(0,1), \quad X_2 = 0.1 X_1 + X_1^2 + \epsilon, \\
\text{Branch 2: } & X_1 \sim U(-1,0), \quad X_2 = 0.1 X_1 - 2 X_1^2 + \epsilon, \quad \epsilon \sim U(0, \delta),
\end{aligned}
$$

where $\delta$ controls local jitter. Additional branches are attached iteratively to existing structures. Each new branch $i$ starts at a selected point $(x_{\text{start},i}, y_{\text{start},i})$ from the current structure and extends according to

$$
X_1 \sim U(x_{\text{start},i}, x_{\text{start},i}+1), \quad X_2 = 0.1 X_1 - s_i (X_1^2 - x_{\text{start},i}) + y_{\text{start},i},
$$

where $s_i$ is a scale factor controlling the curvature of branch $i$. For the first few initial branches, $s_i$ can be fixed (e.g., $s_1 = 1, s_2 = 2$), while for subsequent branches it is sampled from a predefined set, such as $s_i \in \{-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5\}$, to create variability in curvature. 


::: {.cell}

```{.r .cell-code}
curvybranches <- gen_curvybranches(n = 1000, k = 4)
```
:::


The `gen_expbranches(n, k)` function creates $k$ exponential branches in \gD{}, radiating from a central region. Each branch $i$ is defined as

$$
X_1 \sim U(-2,2), \quad X_2 = \exp(\sigma_i \, s_i \, X_1) + \epsilon, \quad \epsilon \sim U(0, \delta), \quad s_i \sim U(0.5,2),
$$

where $\sigma_i = (-1)^{i+1}$ alternates the sign of the exponent to produce mirror-symmetric branches. The parameter $s_i$ controls the steepness of branch $i$, and $\delta$ introduces small local jitter.


::: {.cell}

```{.r .cell-code}
expbranches <- gen_expbranches(n = 1000, k = 4)
```
:::


High-dimensional generalizations are provided by `gen_orglinearbranches(n, p, k)` (Figure \@ref(fig:branch-proj)) and `gen_orgcurvybranches(n, p, k)`. Each branch is embedded in a unique or repeated $2\text{-}D$ subspace of the $p\text{-}D$ space. When `allow_share = TRUE`, multiple branches may share the same subspace; otherwise, subspaces are sampled without replacement until all possible $\binom{p}{2}$ combinations are exhausted, after which additional branches may repeat subspaces. Linear branches follow

$$
X_{i_1} \sim U(a_i,b_i), \quad X_{i_2} = s_i X_{i_1} + \epsilon, \quad \epsilon \sim N(0, \sigma^2),
$$

while curvilinear branches include a quadratic term

$$
X_{i_1} \sim U(a_i,b_i), \quad X_{i_2} = - s_i X_{i_1}^2 + \epsilon, \quad \epsilon \sim N(0, \sigma^2),
$$

where $a_i, b_i$ define the range of the first coordinate for branch $i$, and $\epsilon$ is Gaussian noise added to introduce variability. The scale factor $s_i$ controls slope (linear branches) or curvature (curvilinear branches) and is assigned as follows: for the first $\binom{p}{2}$ branches, $s_i = 1$; for additional branches when $k > \binom{p}{2}$, $s_i$ is randomly drawn from the set $\{1, 1.5, 2, \dots, 8\}$.


::: {.cell}

```{.r .cell-code}
orglinearbranches <- gen_orglinearbranches(n = 1000, p = 4, k = 4)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

```{.r .cell-code}
orgcurvybranches <- gen_orgcurvybranches(n = 1000, p = 4, k = 4)
```
:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from the $4\text{-}D$ `orglinearbranches` data. Each shows a different projection, illustrating how the linear branches appear from multiple viewing angles. These views highlight the dataset’s underlying branching structure and demonstrate how projections reveal patterns that are otherwise hidden in higher dimensions.](04-chap4_files/figure-pdf/branch-proj-1.pdf){fig-pos='H' width=100%}
:::
:::


### Cone

To simulate a cone-shaped structure in arbitrary dimensions (Figure \@ref(fig:cone-proj)), we define a function `gen_cone(n, p, h, ratio)`, which creates a high-dimensional cone with options for a sharp or blunted apex, allowing for a dense concentration of points near the tip.

This function generates $n$ points in $p\text{-}D$, where the last dimension, $X_p$, represents the height along the cone's axis, and the first $p-1$ dimensions define a shrinking hyperspherical cross-section toward the tip. Heights are sampled from a truncated exponential distribution, $X_p \sim \text{Exp}(\lambda = 2/h)$, capped at the cone height $h$, producing a higher density of points near the tip. At each height $X_p$, the radius of the cross-section decreases linearly from base to tip according to $r = r_{\text{min}} + (r_{\text{max}} - r_{\text{min}}) X_p / h$, where $r_{\text{min}} = \text{ratio}$ and $r_{\text{max}} = 1$.

For each point, a direction in the first $p-1$ dimensions is sampled uniformly on a $(p-1)$-dimensional hypersphere using generalized spherical coordinates. The radial coordinates are scaled by the height-dependent radius $r$, producing the conical taper. In three dimensions ($p = 3$), this results in a classical $3\text{-}D$ cone, while for $p > 3$, additional dimensions provide a smooth embedding into higher-dimensional space, preserving the conical structure.


::: {.cell}

```{.r .cell-code}
cone <- gen_cone(n = 1000, p = 4, h = 5, ratio = 0.5)
```
:::


Cone-shaped structures appear in particle dispersions, light beams, and tapering processes, where spread decreases along one axis. They are also used to benchmark clustering and dimensionality reduction methods [@hadsell2006].


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from the $3\text{-}D$ `cone` data. Points are concentrated near the tip along the height dimension, while the radius of the hyperspherical cross-section decreases linearly toward the apex. These projections show how the conical geometry is preserved.](04-chap4_files/figure-pdf/cone-proj-1.pdf){fig-pos='H' width=100%}
:::
:::


### Cube

A cube structure represents uniformly or systematically distributed points within a high-dimensional hypercube, providing a useful framework for assessing how well algorithms preserve uniformity, and boundary properties in high dimensions. We provide a set of functions to generate high-dimensional cube structures with flexible configurations, including regular grids, and uniform random points. Table \@ref(tab:cube-tb-pdf) outlines these functions and their purposes.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:cube-tb-pdf}cardinalR cube data generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_gridcube & Cube with specified grid points along each axes.\\
gen\_unifcube & Cube with uniform points.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


The function `gen_gridcube(n, p)` is a wrapper around `geozoo::cube.solid.grid()`. It generates a regular lattice of points in \pD{}, producing a uniform hypercube grid. Each axis contains equally spaced coordinates, resulting in a well-defined geometric structure.


::: {.cell}

```{.r .cell-code}
gridcube <- gen_gridcube(n = 1000, p = 4)
```
:::


By contrast, `gen_unifcube(n, p)` wraps `geozoo::cube.solid.random()`, producing uniformly distributed points within a $p\text{-}D$ cube. To avoid including the cube’s vertices, these points are removed after generation. This results in a hypercube filled with random, but evenly distributed, samples rather than structured lattice points.


::: {.cell}

```{.r .cell-code}
unifcube <- gen_unifcube(n = 1000, p = 4)
```
:::


Such cube-based structures are commonly used as benchmarks in Monte Carlo sampling, computational geometry, and density estimation, where assessing how algorithms behave under uniform or grid-like distributions is critical [@devroye1986; @niederreiter1992].

### Gaussian

The `gen_gaussian(n, p, s)` function generates a multivariate Gaussian cloud in $p\text{-}D$, centered at the origin with user-defined covariance structure. Each point is independently drawn using the multivariate normal distribution with $X_i \sim N_p(\boldsymbol{0}, s)$, where $s$ is a user-defined $p \times p$ positive-definite matrix.


::: {.cell}

```{.r .cell-code}
gau <- gen_gaussian(n = 1000, p = 4, s = diag(4))
```
:::


Gaussian clouds are common benchmark structures in statistics and machine learning, used in clustering, classification, and anomaly detection, with applications in image segmentation, speech recognition, and forensic analysis [@geoffrey2000].

### Linear

The `gen_longlinear(n, p)` function generates a high-dimensional dataset representing a long linear structure with noise. Each variable is formed as $X_i = \text{scale}_i \cdot (0,1,\dots,n{-}1 + \epsilon) + \text{shift}_i$, where $\text{scale}\_i \sim U(-10, 10)$ determines the orientation of the line in each dimension, $\text{shift}\_i \sim U(-300, 300)$ offsets the line to separate dimensions, and $\epsilon \sim N(0, (0.03n)^2)$ introduces Gaussian noise. 


::: {.cell}

```{.r .cell-code}
linear <- gen_longlinear(n = 1000, p = 4)
```
:::


This structure appears in \pD{} data when variation is driven by a single factor, such as time-course or sensor measurements, providing a useful test case for trajectory and regression methods [@trapnell2014].

### Möbius

The `gen_mobius()` function is a wrapper around `geozoo::mobius()`, designed to simplify the generation of a Möbius strip in three dimensions for use in high-dimensional diagnostic studies. The function returns a tibble with $n$ sampled points forming the surface of a Möbius strip.


::: {.cell}

```{.r .cell-code}
mobius <- gen_mobius(n = 1000)
```
:::


The Möbius strip structure can model twisted or cyclic surfaces in physics and engineering, such as conveyor belts, molecular structures, or optical systems with non-orientable geometries [@optica2023].

### Polynomial

A polynomial structure generates data points that follow non-linear curvilinear relationships, such as quadratic or cubic trends, in \gD{} space. To extend these patterns into high-dimensional settings, additional noise dimensions can be added. These patterns are useful for evaluating how well algorithms capture smooth, non-linear trajectories and curvature in the data. We provide functions for generating quadratic and cubic structures, enabling controlled experiments with different degrees of polynomial complexity. Table \@ref(tab:polynomial-tb-pdf) summarizes these functions and their purposes.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:polynomial-tb-pdf}cardinalR polynomial data generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_quadratic & Quadratic pattern.\\
gen\_cubic & Cubic pattern.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


The first is the quadratic curve of $n$ points in two dimensions. This is generated using `gen_quadratic(n, range)`. The independent variable is defined as $X_1 \sim U(\text{range}[1], \text{range}[2])$, and a raw polynomial basis of degree 2 is applied to form $X_2 = X_1 - X_1^2 + \varepsilon_2$, where $\varepsilon_2 \sim U(0, 0.5)$. This produces a smooth parabolic arc opening downward, with vertical jitter introduced by the noise term.


::: {.cell}

```{.r .cell-code}
quadratic <- gen_quadratic(n = 1000)
```
:::


The second is the cubic curve of $n$ points in two dimensions. This is generated using `gen_cubic(n, range)`. The independent variable is defined as $X_1 \sim U(\text{range}[1], \text{range}[2])$, and a raw polynomial basis of degree $3$ is applied to construct $X_2 = X_1 + X_1^2 - X_1^3 + \varepsilon_2$, where $\varepsilon_2 \sim U(0, 0.5)$. This produces a more complex curvilinear structure than the quadratic case, with both upward and downward turning points.


::: {.cell}

```{.r .cell-code}
cubic <- gen_cubic(n = 1000)
```
:::


### Pyramid

A pyramid structure (Figure \@ref(fig:pyr-proj)) represents data arranged around a central apex and base, useful for exploring how algorithms handle pointed or layered geometries in \pD{} space. The functions provided allow users to generate pyramids with rectangular, triangular, and star-shaped bases, and sharp or blunted apexes. Additionally, it is possible to create a pyramid with a fractal-like internal structure, enabling the study of non-convex and sparse regions. Table \@ref(tab:pyramid-tb-pdf) summarizes these functions.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:pyramid-tb-pdf}cardinalR pyramid data generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_pyrrect & Rectangular-base, with a sharp or blunted apex.\\
gen\_pyrtri & Triangular-base, with a sharp or blunted apex.\\
gen\_pyrstar & Star-shaped base, with a sharp or blunted apex.\\
gen\_pyrfrac & Pyramid with triangular pyramid-shaped holes.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


Let $X_1, \dots, X_p$ denote the coordinates of the generated points. For the rectangular, triangular, and star-shaped based pyramid generator functions, the final dimension, $X_p$, encodes the height of each point and is drawn from an exponential distribution capped at the maximum height $h$. That is, $X_p = z \sim \min\left(\text{Exp}(\lambda = 2/h),\ h\right).$ This distribution creates a natural skew toward smaller height values, resulting in a denser concentration of points near the pyramid's apex. For the star-shaped base pyramid, the final dimension is drawn from a uniform distribution. That is, $X_p = z \sim U(0, h)$.

The remaining dimensions are based on the specific pyramid shape. For the rectangular based pyramid, `gen_pyrrect(n, p, h, l_vec, rt)` (Figure \@ref(fig:pyr-proj) a), let $r_x(z)$ and $r_y(z)$ denote the half-widths of the rectangular cross-section at height $z$. That is, $r_x(z) = r_t + (l_x - r_t)z/h$, $r_y(z) = r_t + (l_y - r_t)z/h$. The first three coordinates are then defined as $X_1 \sim U(-r_x(z),\ r_x(z)), \quad X_2 \sim U(-r_y(z),\ r_y(z)),\text{ and }X_3 \sim U(-r_x(z),\ r_x(z)).$


::: {.cell}

```{.r .cell-code}
pyrrect <- gen_pyrrect(n = 1000, p = 4)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


For the triangular based pyramid, `gen_pyrtri(n, p, h, l, rt)` (Figure \@ref(fig:pyr-proj) b), let $r(z)$ denote the scaling factor (distance from the origin to triangle vertices) at height $z$. That is, $r(z) = r_t + (l-r_t)z/h$. A point in the triangle at height $z$ is generated using barycentric coordinates $(u, v)$ to ensure uniform sampling within the triangular cross-section: $u, v \sim U(0, 1), \quad \text{if } u + v > 1: u \leftarrow 1 - u,\ v \leftarrow 1 - v$. The first three coordinates (triangle plane) are then: $X_1 = r(z)(1 - u - v)$, $X_2 = r(z)u$, and $X_3 = r(z)v.$ 


::: {.cell}

```{.r .cell-code}
pyrtri <- gen_pyrtri(n = 1000, p = 4)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


For the star based pyramid, `gen_pyrstar(n, p, h, rb)` (Figure \@ref(fig:pyr-proj) c), let the radius at height $z$, $r(z)$, be such that the radius scales linearly from zero (tip) to the base radius $r_b$. That is, $r(z) = r_b\left(1 - z/h\right)$. Each point is placed within a regular hexagon in the plane $(X_1, X_2)$, using a randomly chosen hexagon sector angle $\theta \in \{0, \pi/3, 2\pi/3, \pi, 4\pi/3, 5\pi/3\}$ and a uniformly random radial scaling factor: $\theta \sim \text{Uniform sample from 6 hexagon angles}$, $r_{\text{point}} \sim \sqrt{U(0, 1)}$. Then, the first two coordinates are: $X_1 = r(z)r_{\text{point}}\cos(\theta)$, and $X_2 = r(z)r_{\text{point}}\sin(\theta)$.


::: {.cell}

```{.r .cell-code}
pyrstar <- gen_pyrstar(n = 1000, p = 4)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


For rectangular and triangular pyramids, the remaining dimensions $X_4$ to $X_{p-1}$, and for star-based pyramids $X_3$ to $X_{p-1}$, are treated as noise.

Finally, for the Sierpinski-like pyramid, `gen_pyrfrac(n, p)` (Figure \@ref(fig:pyr-proj) d), let $X_1, X_2, \dots, X_p$ denote the coordinates of the generated points. The generation process begins with an initial point $T_0 \in [0, 1]^p$ drawn from a uniform distribution: $T_0 \sim U(0, 1)^p$. Let $C_1, C_2, \dots, C_{p+1}$ denote the corner vertices of a $p\text{-}D$ simplex. At each iteration $i = 1, \dots, n$, a new point is computed by taking the midpoint between the previous point $T_{i-1}$ and a randomly selected vertex $C_k$: $T_i = 1/2(T_{i-1} + C_k), \quad C_k \in \{C_1, \dots, C_{p+1}\}$. This recursive midpoint rule generates self-similar patterns with systematic voids (holes) between clusters of points. The points remain bounded inside the convex hull of the simplex. The final output is a $n \times p$ matrix where each row represents a point: $X = \{T_1, T_2, \dots, T_n\}, \quad X \in \mathbb{R}^{n \times p}$.


::: {.cell}

```{.r .cell-code}
pyrholes <- gen_pyrfrac(n = 1000, p = 4)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


Pyramid structures mimic tapering or layered geometries seen in architecture, crystals, and fractal-like natural patterns [@kirkby1983].


::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from $4\text{-}D$, for the `pyrrect` (a1-a3), `pyrtri` (b1-b3), `pyrstar` (c1-c3), and `pyrholes` (d1-d3) data. The `pyrrrect` structure forms a dense rectangular base tapering to a narrow tip, while `pytri` shows a more triangular spread with sharper edges. `Pyrstar` extends into multiple pointed branches radiating from a common core, and `pyrholes` reveals hollow or open regions within an otherwise compact shape. These projections illustrate a range of pyramid-like geometries that vary in density and structure.](04-chap4_files/figure-pdf/pyr-proj-1.pdf){fig-pos='H' width=100%}
:::
:::


### S-curve

The S-curve is a smooth, non-linear manifold in $3\text{-}D$ space. Using `gen_scurve(n)`, it is defined by $X_1 = \sin(\theta), \quad X_2 \sim U(0, 2), \quad X_3 = \text{sign}(\theta)(\cos(\theta) - 1), \quad \theta \sim U(-3\pi/2, 3\pi/2).$

This follows the `s_curve()` function from snedata [@james2025], itself adapted from *scikit-learn*, but differs by returning a tibble with standardized names (`x1`, `x2`, `x3`), excluding the color variable, and omitting built-in noise (which can be added separately). S-curve is commonly used in manifold learning and dimension reduction as benchmarks for unfolding curved structure.


::: {.cell}

```{.r .cell-code}
scurve <- gen_scurve(n = 1000)
```
:::


### Sphere

Sphere-shaped structures are useful for evaluating how dimension reduction and clustering algorithms handle curved, symmetric manifolds in high-dimensional spaces. The functions generate a variety of spherical forms, including simple circles, uniform and hollow spheres, grid-based spheres, and complex arrangements like clustered spheres within a larger sphere. The first few coordinates define the main geometric form (circle, cycle, sphere, or hemisphere), while higher-dimensional embeddings are achieved by adding noise dimensions. Such spherical or hemispherical structures frequently appear in physical and biological systems, for example in models of celestial bodies, molecular shells, or cell membranes [@tinkham2003; @alberts2014].Table \@ref(tab:sphere-tb-pdf) summarizes these functions.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:sphere-tb-pdf}cardinalR sphere data generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_circle & Circle.\\
gen\_curvycycle & Curvy cell cycle.\\
gen\_unifsphere & Uniform sphere.\\
gen\_hollowsphere & Hollow sphere.\\
gen\_gridedsphere & Grided sphere.\\
gen\_clusteredspheres & Multiple small spheres within a big sphere.\\
gen\_hemisphere & Hemisphere.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


The simplest case, `gen_circle(n, p)` creates a unit circle in two dimensions, with the remaining dimensions forming sinusoidal extensions of the angular parameter at progressively smaller scales (Figure \@ref(fig:sphere-proj) a). Let a latent angle variable $\theta$ is uniformly sampled from the interval $[0, 2\pi]$. Coordinates in the first two dimensions represent a perfect circle on the plane: $$X_1 = \cos(\theta), \quad X_2 = \sin(\theta).$$ For dimensions $X_3$ through $X_p$, sinusoidal transformations of the angle $\theta$ are introduced. The first component is a scaling factor that decreases with the dimension index, defined as $\text{scale}_j = \sqrt{(0.5)^{j-2}}$ for $j = 3, \dots, p$. The second component is a phase shift that is proportional to the dimension index, specifically designed to decorrelate the curves, given by the formula $\phi_j = (j - 2)\pi/2p$. Each additional dimension is computed as: $X_j = \text{scale}_{j}\sin(\theta + \phi_j), \quad j = 3, \dots, p$.


::: {.cell}

```{.r .cell-code}
circle <- gen_circle(n = 1000, p = 4)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


For the one-dimensional nonlinear cycle embedded in $p\text{-}D$ space, `gen_curvycycle(n, p)` (Figure \@ref(fig:sphere-proj) b), let a latent angle variable $\theta$ is uniformly sampled from the interval $[0, 2\pi]$. The first three dimensions define a non-circular closed curve, referred to as a "curvy cycle". In this configuration, $X_1 = \cos(\theta)$ represents horizontal oscillation, while $X_2 = \sqrt{3}/3 + \sin(\theta)$ introduces a vertical offset to avoid centering the curve at the origin. Additionally, $X_3 = 1/3\cos(3\theta)$ introduces a third harmonic perturbation that intricately folds the curve three times along its path, creating a unique and complex shape that oscillates in both dimensions while incorporating the effects of the harmonic perturbation.

Together, these define a periodic, non-trivial, closed curve in $3\text{-}D$ with internal folds that produce a more complex geometry than a standard circle or ellipse. For dimensions $X_4$ through $X_p$, additional structured variability is introduced through decreasing amplitude scaling and phase-shifted sine waves. The scaling factor is defined as $\text{scale}_j = \sqrt{(0.5)^{j-3}}$ for $j$ ranging from $4$ to $p$, which means that the amplitude decreases as the dimension increases. Each dimension $X_j$ is then calculated using the formula $X_j = \text{scale}_j\sin(\theta + \phi_j)$, where the phase shift $\phi_j$ is given by $\phi_j = (j - 2)\pi/2p$. 


::: {.cell}

```{.r .cell-code}
curvycycle <- gen_curvycycle(n = 1000, p = 4)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


Building on simple circular structures, the `gen_unifsphere(n, r)` function function extends the idea to three dimensions by generating $n$ observations approximately uniformly distributed on the surface of a sphere of radius $r$.. Each observation is computed from spherical coordinates, with $u \sim U(-1, 1)$ representing $\cos(\phi)$ and $\theta \sim U(0, 2\pi)$ the azimuthal angle. Cartesian coordinates are then defined as $$X_1 = r\sqrt{1 - u^2}\cos(\theta), \quad X_2 = r\sqrt{1 - u^2}\sin(\theta),\text{ and }X_3 = ru,$$ ensuring uniform distribution on the surface (not within) of the sphere. 


::: {.cell}

```{.r .cell-code}
unifsphere <- gen_unifsphere(n = 1000, r = 1)
```
:::


In contrast, the `gen_hollowsphere(n, p)` function, a wrapper around `geozoo::sphere.hollow()`, generates $n$ points uniformly distributed only on the surface of the $(p-1)$-dimensional sphere embedded in $\mathbb{R}^p$. This results in a hollow shell-like structure with no interior points. For example, when $p=3$, `gen_unifsphere()` produces a solid ball in $3\text{-}D$ space, whereas `gen_hollowsphere()` produces only the spherical boundary. These paired structures allow controlled experiments to investigate how algorithms behave when data is concentrated throughout the full volume versus constrained to the boundary.


::: {.cell}

```{.r .cell-code}
hollowsphere <- gen_hollowsphere(n = 1000, p = 4)
```
:::


In addition, the `gen_gridedsphere(n)` function constructs a $p\text{-}D$ dataset consisting of approximately $n$ points that are evenly distributed on the surface of the unit $(p-1)$-sphere embedded in $\mathbb{R}^p$ (Figure \@ref(fig:sphere-proj) d). The method relies on forming a regular grid in spherical coordinates, parameterized by $(p-1)$ angular variables: for dimensions $j = 1, \dots, p-2$ the polar angles are drawn from $[0, \pi]$, while the final angle ($j = p-1$) represents the azimuth and is drawn from $[0, 2\pi]$. The number of grid steps along each angular dimension is chosen by decomposing $n$ into $(p-1)$ approximately equal integer factors using the helper function `gen_nproduct(n, p - 1)`.

Each grid point is subsequently mapped into Cartesian space via the standard hyperspherical-to-Cartesian transformation,

$$
\begin{aligned}
X_1 &= \cos(\theta_1), \\
X_2 &= \sin(\theta_1)\cos(\theta_2), \\
X_3 &= \sin(\theta_1)\sin(\theta_2)\cos(\theta_3), \\
&\;\;\vdots \\
X_{p-1} &= \sin(\theta_1)\sin(\theta_2)\cdots \sin(\theta_{p-2})\cos(\theta_{p-1}), \\
X_p &= \sin(\theta_1)\sin(\theta_2)\cdots \sin(\theta_{p-2})\sin(\theta_{p-1}).
\end{aligned}
$$

The result is a deterministic grid of points lying exactly on the surface of the unit $(p-1)$-sphere, without any additional noise dimensions.

For more heterogeneous structures, the `gen_clusteredspheres(n, k, r, loc)` function generates one large sphere of radius $r_1$ and $k$ smaller spheres of radius $r_2$, each centered at a different random location (Figure \@ref(fig:sphere-proj) e). A large uniform sphere centered at the origin is created by sampling $n_1$ points uniformly on the surface of a $p\text{-}D$ sphere with a radius of $r_1$. The sampling is executed using the function `gen_unifsphere(n_1, r_1)`, which generates the desired points in the specified dimensional space. In generation of $k$ smaller uniform spheres, each sphere contains $n_2$ points that are sampled uniformly on a sphere with a radius of $r_2$. These spheres are positioned at distinct random locations in $p$-space, with the center of each sphere being drawn from a normal distribution $N(0, \texttt{loc}^2 I_p)$. Points on spheres are generated using the standard hyperspherical method, which involves sampling $u \sim U(-1, 1)$ to determine the cosine of the polar angle, and sampling $\theta \sim U(0, 2\pi)$ to determine the azimuthal angle (for $3\text{-}D$). Each observation is classified by cluster, with labels such as "big" for the large central sphere and "small_1" to "small_k" for the smaller spheres.


::: {.cell}

```{.r .cell-code}
clusteredspheres <- gen_clusteredspheres(n = c(1000, 100), k = 3, r = c(15, 3),
                                         loc = 10 / sqrt(3)) |>
  dplyr::select(-cluster)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


Finally, the `gen_hemisphere(n, p)` function restricts sampling to a hemisphere of a $4\text{-}D$ sphere (Figure \@ref(fig:sphere-proj) f). Using spherical coordinates, the azimuthal angle $\theta_1 \sim U(0, \pi)$ in the $(x_1, x_2)$ plane, while the elevation angle $\theta_2 \sim U(0, \pi)$ in the $(x_2, x_3)$ plane. Additionally, $\theta_3 \sim U(0, \pi/2)$ in the $(x_3, x_4)$ plane, ensuring that the points remain restricted to a hemisphere. The coordinates are transformed into $4\text{-}D$ Cartesian space: $$X_1 = \sin(\theta_1)\cos(\theta_2), \quad X_2 = \sin(\theta_1)\sin(\theta_2), \quad X_3 = \cos(\theta_1)\cos(\theta_3), \quad X_4 = \cos(\theta_1)\sin(\theta_3).$$ This produces points on one side of a $4\text{-}D$ unit sphere, effectively generating a $4\text{-}D$ hemisphere. 


::: {.cell}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from $4\text{-}D$, `circle` (a1-a3), `curvycycle` (b1-b3), and, $3\text{-}D$ `clusteredspheres` (c1-c3). The `circle` structure forms a smooth, closed loop, while `curvycycle` shows a wavy, continuous pattern forming a twisted ring. The `clusteredspheres` dataset displays multiple compact spherical groups that are clearly separated in higher dimensions but overlap slightly in some $2\text{-}D$ projections, highlighting how projection can distort spatial relationships. These projections show how simple cyclic, wavy curvilinear, and clustered structures appear in $2\text{-}D$, emphasizing the effects of projection on density, continuity, and separation](04-chap4_files/figure-pdf/sphere-proj-1.pdf){fig-align='center' fig-pos='H' width=100%}
:::
:::


### Swiss Roll 

The Swiss roll is a standard nonlinear manifold, representing a \gD{} plane curled into $3\text{-}D$. The `gen_swissroll(n, w)` generates points as $X_1 = t \cos(t), \quad X_2 = t \sin(t), \quad X_3 \sim U(w_1, w_2), \quad t \sim U(0, 3\pi).$


::: {.cell}

```{.r .cell-code}
swissroll <- gen_swissroll(n = 1000, w = c(-1, 1))
```
:::


Compared with `sndata::swiss_roll()` [@james2025], this implementation (i) samples $t$ over $[0, 3\pi]$ instead of $[1.5\pi, 4.5\pi]$, (ii) allows a flexible vertical range $w = (w_1, w_2)$ rather than fixing $z \in [0, z_{\max}]$, and (iii) returns a tibble with `x1, x2, x3` instead of adding a color variable. 

The Swiss roll is a classic benchmark for manifold learning, illustrating how a curved surface can be “unrolled” into lower dimensions. Similar spiral-like forms appear in galaxies, protein folding, and coiled materials [@dimitris2002].

### Trefoil knots

<!--https://laustep.github.io/stlahblog/posts/TorusKnot4D.html-->

The Trefoil is a closed, nontrivial one-dimensional manifold embedded in $3\text{-}D$ or $4\text{-}D$ space (Figure \@ref(fig:trefoil-proj)). The trefoil features topological complexity in the form of self-overlaps, making it a valuable test case for evaluating the ability of non-linear dimension reduction methods to preserve global structure, loops, and embeddings in high-dimensional data. Table \@ref(tab:trefoil-tb-pdf) summarizes these functions.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:trefoil-tb-pdf}cardinalR trefoil data generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_trefoil4d & Trefoil in 4-D.\\
gen\_trefoil3d & Trefoil in 3-D.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


For the $4\text{-}D$ trefoil knot, the function `gen_trefoil4d(n, steps)` generates the structure on the $3$-sphere ($S^3 \subset \mathbb{R}^4$) using two angular parameters, $\theta$ and $\phi$. A band of thickness around the knot path is controlled by the `steps` argument, while the number of $\theta$ and $\phi$ values is determined by the `steps` and `n` arguments, respectively (Figure \@ref(fig:trefoil-proj) a). The coordinates are defined as $$X_1 = \cos(\theta) \cos(\phi), \quad X_2 = \cos(\theta) \sin(\phi), \quad X_3 = \sin(\theta) \cos(1.5 \phi),\text{ and }X_4 = \sin(\theta) \sin(1.5 \phi),$$ where $\theta$ and $\phi$ trace the knot’s path. 


::: {.cell}

```{.r .cell-code}
trefoil4d <- gen_trefoil4d(n = 500, steps = 5)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


For the $3\text{-}D$ stereographic projection, `gen_trefoil3d(n, steps)` maps each point $(X_1, X_2, X_3, X_4) \in \mathbb{R}^4$ to $(X_1', X_2', X_3') \in \mathbb{R}^3\text{ using }X_1' = X_1 / (1 - X_4), \quad X_2' = X_2 / (1 - X_4),\text{ and }X_3' = X_3 / (1 - X_4),$ excluding points where $X_4 = 1$ to avoid division by zero (Figure \@ref(fig:trefoil-proj) b). 


::: {.cell}

```{.r .cell-code}
trefoil3d <- gen_trefoil3d(n = 500, steps = 5)
```
:::


The trefoil knot appears in molecular biology (DNA/protein knotting), fluid dynamics (knotted vortices), and physics (topological phases), making it a useful benchmark for testing whether dimension reduction preserves global loops and topology [@witten1985; @arsuaga2002].


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from $4\text{-}D$, `trefoil4d` (a1-a3) and $3\text{-}D$ `trefoil3d` (b1-b3) data. The `trefoil4d` structure represents a higher-dimensional extension of the classic trefoil knot, revealing complex twisting and looping patterns that remain continuous across projections. In contrast, the `trefoil3d` dataset maintains a simpler, more compact knot-like form, showing how dimensional extension adds curvature and separation in the embedded space. These projections illustrate a range of looping structures in high-dimensions.](04-chap4_files/figure-pdf/trefoil-proj-1.pdf){fig-pos='H' width=100%}
:::
:::


### Trigonometric

Trigonometric-based structures provide flexible ways to simulate complex curved patterns and spirals that often arise in real-world high-dimensional data, such as in biological trajectories, or physical systems (Figure \@ref(fig:triginometric-proj)). The main geometry is defined by the first few coordinates: crescents ($p=2$), cylinders, spirals, and helices ($p=4$). These structures are particularly valuable for testing how well dimension reduction and clustering algorithms preserve intricate geometric and topological features [@calladine1997; @gershenfeld2000]. Table \@ref(tab:trigonometric-tb-pdf) summarizes these functions.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:trigonometric-tb-pdf}cardinalR trigonometric data generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_crescent & Crescent pattern.\\
gen\_curvycylinder & Curvy cylinder.\\
gen\_sphericalspiral & Spherical spiral.\\
gen\_helicalspiral & Helical spiral.\\
gen\_conicspiral & Conic spiral.\\
gen\_nonlinear & Nonlinear hyperbola.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


First, the `gen_crescent(n, p)` function generates a $p$-dimensional dataset of $n$ observations based on a $2\text{-}D$ crescent-shaped manifold with optional structured high-dimensional noise (Figure \@ref(fig:triginometric-proj) a). Let $\theta \in [\pi/6, 2\pi]$ be a sequence of $n$ evenly spaced angles. The corresponding $2\text{-}D$ coordinates are defined by: $$X_1 = \cos(\theta), \quad X_2 = \sin(\theta).$$


::: {.cell}

```{.r .cell-code}
crescent <- gen_crescent(n = 1000)
```
:::


Second, the `gen_curvycylinder(n, p, h)` function generates a $p$-dimensional dataset of $n$ observations structured as a $3\text{-}D$ cylindrical manifold with an added nonlinear curvy dimension, and optional noise dimensions when $p > 4$ (Figure \@ref(fig:triginometric-proj) b). The core structure consists of a circular base and height values, extended by a nonlinear fourth dimension. Let $\theta \sim U(0, 3\pi)$ represent a random angle on a circular base and $z \sim U(0, h)$ represent the height along the cylinder. The coordinates are defined as: $X_1 = \cos(\theta)$ (Circular base, x-axis), $X_2 = \sin(\theta)$ (Circular base, y-axis), $X_3 = z$ (Linear height), and $X_4 = \sin(z)$ (Nonlinear curvy variation along height).  


::: {.cell}

```{.r .cell-code}
curvycylinder <- gen_curvycylinder(n = 1000, h = 10)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


For a spiraling path on a spherical surface in the first four dimensions, `gen_sphericalspiral(n, p, spins)` (Figure \@ref(fig:triginometric-proj) c), let $\theta \in [0, 2\pi \times \text{spins}]$ be the azimuthal angle (longitude), controls the number of spiral turns and the $\phi \in [0, \pi]$be the polar angle (latitude), controls the vertical sweep from the north to the south pole. Cartesian coordinates from spherical conversion: $X_1 = \sin(\phi)\cos(\theta)$, $X_2 = \sin(\phi)\sin(\theta)$, $X_3 = \cos(\phi) + \varepsilon$, where $\varepsilon \sim U(-0.5, 0.5)$ introduces vertical jitter, and $X_4 = \theta / \max(\theta)$: a normalized progression along the spiral path. This generates a spherical spiral curve embedded in $4\text{-}D$ space, combining both circular and vertical movement, with gentle curvature and non-linear progression.  


::: {.cell}

```{.r .cell-code}
sphericalspiral <- gen_sphericalspiral(n = 1000, spins = 1)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


For a helical spiral in four dimensions, `gen_helicalspiral(n, p)` (Figure \@ref(fig:triginometric-proj) d), let $\theta \in [0, 5\pi/4]$ be a sequence of angles controlling rotation around a circle. Cartesian coordinates; $X_1 = \cos(\theta)$: circular trajectory along the x-axis, $X_2 = \sin(\theta)$: circular trajectory along the y-axis, $X_3 = 0.05\theta + \varepsilon_3$, with $\varepsilon_3 \sim U(-0.5, 0.5)$: linear progression (height) with vertical jitter, simulating a helix, and $X_4 = 0.1\sin(\theta)$: oscillates with $\theta$, representing a periodic "wobble" along the fourth dimension. 


::: {.cell}

```{.r .cell-code}
helicalspiral <- gen_helicalspiral(n = 1000)
```
:::


Similarly, the `gen_conicspiral(n, p, spins)` function generates a dataset of $n$ points forming a conical spiral in the first four dimensions of $p\text{-}D$ (Figure \@ref(fig:triginometric-proj) e). The geometry combines radial expansion, vertical elevation, and spiral deformation, simulating a structure that fans out like a $3\text{-}D$ conic helix. The shape is defined by parameter $\theta \in [0, 2\pi\text{spins}]$, controlling the angular progression of the spiral. The Archimedean spiral in the horizontal plane is represented by; $X_1 = \theta\cos(\theta)$ for radial expansion in x, and $X_2 = \theta\sin(\theta)$ for radial expansion in y. The growth pattern resembles a cone, with the height increasing according to $X_3 = 2\theta / \max(\theta) + \varepsilon_3$, with $\varepsilon_3 \sim U(-0.1, 0.6).$ Spiral modulation in the fourth dimension is represented by $X_4 = \theta\sin(2\theta) + \varepsilon_4$, with $\varepsilon_4 \sim U(-0.1, 0.6)$ which simulates a twisting helical component in a non-radial dimension. 


::: {.cell}

```{.r .cell-code}
conicspiral <- gen_conicspiral(n = 1000, spins = 1)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


Finally, the `gen_nonlinear(n, p, hc, non_fac)` function simulates a non-linear $2\text{-}D$ surface embedded in higher dimensions, constructed using inverse and trigonometric transformations applied to independent variables (Figure \@ref(fig:triginometric-proj) f). The $X_{1} \sim U(0.1, 2)$: base variable (avoids zero to prevent division errors), $X_{3} \sim U(0.1, 0.8)$: independent auxiliary variable, $X_{2} = hc/X_{1} + \text{nonfac}\sin(X_{1})$: non-linear combination of hyperbolic and sinusoidal transformations, creating sharp curvature and oscillation, and $X_{4} = \cos(\pi X_{1}) + \varepsilon$, with $\varepsilon \sim U(-0.1, 0.1)$: additional nonlinear variation based on cosine, simulating more subtle periodic structure. These transformations together result in a non-linear surface warped in multiple ways: sharp vertical shifts due to inverse terms, smooth waves from sine and cosine, and additional jitter. 


::: {.cell}

```{.r .cell-code}
nonlinear <- gen_nonlinear(n = 1000, hc = 1, non_fac = 0.5)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from $4\text{-}D$, for the `curvycylinder` (a1-a3), `sphericalspiral` (b1-b3), `conicspiral` (c1-c3), and `nonlinear` (d1-d3) data. The `curvycylinder` shows a cylindrical manifold with a nonlinear twist along its height, producing smooth, continuous curvature. The `sphericalspiral` forms a spiral path on a spherical surface, combining circular and vertical motion in a helical form. The `conicspiral` spreads radially while ascending, forming a conical helix with twisting variations in a non-radial dimension. The `nonlinear` dataset exhibits a warped $2\text{-}D$ surface with sharp oscillations and smooth waves, reflecting complex nonlinear interactions. Each shows variations in curvature, density, and continuity.](04-chap4_files/figure-pdf/triginometric-proj-1.pdf){fig-align='center' fig-pos='H' width=100%}
:::
:::


## Generate a spherical or hyperspherical hole within a structure

The package provides functionality for generating datasets with spherical hole (in $2\text{-}D$/$3\text{-}D$) or, more generally, hyperspherical hole (in higher dimensions). These structures are valuable for evaluating how dimension reduction methods and clustering algorithms handle incomplete manifolds or missing regions of the data space. A hyperspherical hole introduces topological complexity: the structure remains continuous but contains excluded regions (voids) that algorithms must correctly represent in lower-dimensional embeddings.

The core function `gen_hole(df, anchor, r)` removes points from a dataset that fall within a user-specified hypersphere. Formally, given data points ($x \in \mathbb{R}^p$), a center ($a \in \mathbb{R}^p$), and radius ($r > 0$), only points satisfying $||x - a||_2 > r$ are retained. The anchor point ($a$) can either be user-specified or default to the dataset mean, and radius ($r$) is controlled by the user, with safeguards to avoid trivial or degenerate cases. Because it operates generically on any dataset, spherical or hyperspherical holes can be embedded in a wide range of geometric structures.

Two specialized wrappers illustrate this idea. The function `gen_scurvehole(n, r_hole)` generates an S-curve with a spherical hole by applying `gen_hole()` to the output of `gen_scurve()`. This structure has been used in prior diagnostic studies of NLDR methods, since it tests the ability of algorithms to capture non-linear manifolds that are not simply connected. The second wrapper, `gen_unifcubehole(n, p, r_hole)`, generates uniformly sampled cube data with a hyperspherical hole. By embedding a hyperspherical void inside a convex high-dimensional structure, this creates non-convex regions that challenge algorithms in terms of separability and neighborhood preservation.

## Generate noise dimensions

High-dimensional data structures often benefit from the addition of auxiliary noise dimensions, which can be used to assess the robustness of dimensionality reduction and clustering algorithms. The functions in this section provide flexible ways to generate random noise dimensions, ranging from purely random Gaussian variables to more structured, wavy patterns that mimic non-linear distortions in high-dimensional space. These functions can be applied independently or combined with other geometric structures to create complex simulated datasets. Table \@ref(tab:noise-tb-pdf) details these functions.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:noise-tb-pdf}cardinalR noise dimensions generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{2.5cm}>{\raggedright\arraybackslash}p{10.5cm}}
\toprule
Function & Explanation\\
\midrule
gen\_noisedims & Gaussian noise dimensions with optional mean and standard deviation.\\
gen\_wavydims1 & Wavy noise dimensions based on a user-specified theta sequence with added jitter.\\
gen\_wavydims2 & Wavy noise dimensions using polynomial transformations of an existing dimension vector.\\
gen\_wavydims3 & Wavy noise dimensions using a combination of polynomial and sine transformations based on the first three dimensions of a dataset.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


The `gen_noisedims(n, p, m, s)` function generates $p$ independent Gaussian noise dimensions,

$$
X_j \sim N(m_j, s_j^2), \quad j = 1, \dots, p,
$$

with odd-numbered dimensions multiplied by $-1$ to introduce sign alternation, enhancing variability and decorrelation. 

For scenarios where noise should follow a smooth wavy pattern, `gen_wavydims1(n, p, theta)` generates dimensions as

$$
X_j = \alpha_j \theta + \varepsilon_j, \quad \varepsilon_j \sim N(0, \sigma^2), \quad j = 1, \dots, p,
$$

where each dimension is scaled by a different factor $\alpha_j$, producing structured noise that oscillates along the latent parameter $\theta$, mimicking trends or trajectories observed in real-world data.

The `gen_wavydims2(n, p, x_1)` function extends this approach by applying a non-linear transformation to an existing dimension vector $x_1$:

$$
X_j = \beta_j \, (-1)^{\lfloor j/2 \rfloor} \, x_1^{k_j} + \varepsilon_j, \quad j = 1, \dots, p,
$$

where $k_j$ is a randomly chosen polynomial power, $\beta_j$ is a scaling factor, and $\varepsilon_j$ is small uniform noise.

Finally, `gen_wavydims3(n, p, data)` generates noise for datasets with multiple correlated dimensions. The first three dimensions are small perturbations of the original coordinates $(X_1, X_2, X_3)$, while higher dimensions are constructed via non-linear combinations, including polynomial and trigonometric transformations, e.g.,

$$
X_j = f_j(X_1, X_2, X_3) + \varepsilon_j, \quad j > 3,
$$

producing high-dimensional noise that preserves some geometric correlation with the base structure while introducing additional complexity.

## Multiple cluster examples

By using the shape generators mentioned above, we can create various examples of multiple clusters. The package includes some of these examples, which are described in Table \@ref(tab:odd-shape-tb-pdf).


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:odd-shape-tb-pdf}cardinalR multiple clusters generation functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{3.5cm}>{\raggedright\arraybackslash}p{8.5cm}}
\toprule
Function & Explanation\\
\midrule
make\_mobiusgau & Möbius-like cluster combined with a Gaussian.\\
make\_multigau & Multiple Gaussian clusters in high-dimensional space.\\
make\_curvygau & Curvilinear cluster with a Gaussian cluster.\\
make\_klink\_circles & K-link circular clusters (non-linear circular patterns).\\
make\_chain\_circles & Chain-like circular clusters connected sequentially.\\
make\_klink\_curvycycle & K-link curvy cycle clusters (curvilinear loop structures).\\
make\_chain\_curvycycle & Chain-like curvy cycle clusters connected sequentially.\\
make\_gaucircles & Circular clusters with a Gaussian cluster in the middle.\\
make\_gaucurvycycle & Curvy circular clusters with a Gaussian in the middle.\\
make\_onegrid & Single grid in two dimensions.\\
make\_twogrid\_overlap & Two overlapping grids.\\
make\_twogrid\_shift & Two grids shifted relative to each other.\\
make\_shape\_para & Parallel shaped clusters.\\
make\_three\_clust\_ & Three clusters with different shapes. (eg:- 01, 02, ..., 20)\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


## Additional functions

The package includes various supplementary tools in addition to the shape generating functions mentioned earlier. These tools allow users to create background noise, randomize the rows of the data, relocate clusters, generate a vector whose product and sum are approximately equal to a target value, rotate structures, and normalize the data. Table \@ref(tab:add-tb-pdf) details these functions.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:add-tb-pdf}cardinalR additional functions}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{8cm}}
\toprule
Function & Explanation\\
\midrule
gen\_bkgnoise & Adds background noise.\\
randomize\_rows & Randomizes the rows.\\
relocate\_clusters & Relocates the clusters.\\
gen\_nproduct & Generates a vector of positive integers whose product is approximately equal to a target value.\\
gen\_nsum & Generates a vector of positive integers whose summation is approximately equal to a target value.\\
gen\_rotation & Generates rotations.\\
normalize\_data & Normalizes data.\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


# Application

This section demonstrates how the package can be used to generate complex high-dimensional datasets, apply dimension reduction (DR) techniques, and evaluate clustering performance. The example shows how diverse geometric structures can be simulated and analyzed to assess algorithmic behavior.

## Generating high-dimensional clustered data

To illustrate, we generate a dataset with five clusters in $4\text{-}D$, each representing distinct geometric characteristics: a *helical spiral* (elongated and twisted), a *hemisphere* (curved surface), a *uniform cube* (isotropic distribution), a *cone* (density gradient), and a *Gaussian* cluster (compact and spherical) (Figure \@ref(fig:highd-proj)). Each cluster has a unique number of points and scaling factor, representing variation in cluster size and spread across the $4\text{-}D$ space.


::: {.cell}

```{.r .cell-code}
positions <- geozoo::simplex(p=4)$points
positions <- positions * 0.3

## To generate data
five_clusts <- gen_multicluster(n = c(2250, 1500, 750, 1250, 1750), k = 5,
                       loc = positions,
                       scale = c(0.25, 0.35, 0.3, 1, 0.3),
                       shape = c("helicalspiral", "hemisphere", "unifcube", 
                                 "cone", "gaussian"),
                       rotation = NULL,
                       is_bkg = FALSE)
```
:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from $4\text{-}D$, for the five clusters data. The helical spiral cluster is represented in dark green, the hemisphere cluster in orange, the uniform cube-shaped cluster in purple, the blunted cone cluster in pink, and the Gaussian-shaped cluster in light green.](04-chap4_files/figure-pdf/highd-proj-1.pdf){fig-pos='H' width=100%}
:::
:::


## Evaluating dimension reduction (DR) methods

We applied six popular DR techniques to the generated dataset: Principal Component Analysis (PCA) [@jolliffe2011], t-distributed stochastic neighbor embedding (tSNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) algorithm [@moon2019], large-scale dimensionality reduction Using triplets (TriMAP) [@amid2019], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021]. 


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Assessing which of the 6 NLDR layouts ((a) tSNE, (b) UMAP, (c) PAHTE, (d) TriMAP, (e) PaCMAP, and (f) PCA) of the five clusters data is the better representation using RMSE for varying binwidth ($a_1$). Colour is used for the lines and points in the left plot to match the scatterplots of the NLDR layouts (a-f). Layout f is universally poor. Layouts a and b are universally optimal. Layout b shows six well-separated clusters and latout a shows close clusters, thus layout a is the best choice.](04-chap4_files/figure-pdf/fig-nldr-layouts-1.pdf){#fig-nldr-layouts fig-pos='H' width=100%}
:::
:::


To assess their performance, we computed the root mean squared error (RMSE) between the observed high-dimensional data and the fitted values, defined as the high-dimensional mappings of the bin centroids [@gamage2025c]. A lower RMSE indicates that the method better preserves the high-dimensional structure in its low-dimensional embedding.

As shown in Figure \@ref(fig:fig-nldr-layouts), tSNE (Figure \@ref(fig:fig-nldr-layouts) a) achieved the lowest RMSE across bin widths (mostly tiny), indicating high preservation of both local and global structures. Its layout displays well-separated clusters with minimal inter-cluster distances, making it the most faithful representation of the underlying data structure. UMAP and PaCMAP (Figure \@ref(fig:fig-nldr-layouts) b and e) produced moderately accurate embeddings, although the six clusters appear more well-separated, while PHATE (Figure \@ref(fig:fig-nldr-layouts) c) show non-linear cluster structures irrespective of the original structure. Also, TriMAP (Figure \@ref(fig:fig-nldr-layouts) d) has high RMSE, and show three clusters with small distances. PCA (Figure \@ref(fig:fig-nldr-layouts) f) failed to capture the non-linear geometry, leading to the highest RMSE.

## Benchmarking clustering algorithms

To further evaluate the structure of the generated data, we benchmarked three clustering algorithms: **$k$-means** [Chapter 20 of @boehmke2019], **hierarchical** [@murtagh2012], and **model-based clustering** [@chris2002; @scrucca2023] using the simulated dataset. The model-based clustering was performed with the `"VVV"` covariance structure, allowing each cluster to vary in volume, shape, and orientation. Cluster validity statistics were computed using the `cluster.stats()` function from the `fpc` package [@christian2024].


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
\begin{table}

\caption{\label{tab:summaryclust-tb-pdf}Comparison of clustering performance metrics (within–between ratio (wb.ratio), Dunn index, Corrected Rand index, and variation of information (VI) across $k$-means, hierarchical, and model-based clustering methods.}
\centering
\begin{tabular}[t]{>{\raggedright\arraybackslash}p{2.5cm}>{\raggedleft\arraybackslash}p{2cm}>{\raggedleft\arraybackslash}p{2cm}>{\raggedleft\arraybackslash}p{2.5cm}>{\raggedleft\arraybackslash}p{2cm}}
\toprule
Metric & wb.ratio & Dunn Index & Corrected Rand & VI\\
\midrule
k-means & 0.61 & 0.01 & 0.42 & 1.32\\
Hierarchical & 0.61 & 0.01 & 0.50 & 1.15\\
Model-based & 0.61 & 0.01 & 0.75 & 0.65\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


Overall, all methods produced similar compactness and separation, as reflected by the *within–between cluster ratios (wb.ratio)* and *Dunn indices*. However, the **model-based clustering** achieved the highest *Corrected Rand Index* ($0.75$) and lowest *Variation of Information (VI)* ($0.65$), indicating the best recovery of the true underlying groups (Table \@ref(tab:summaryclust-tb-pdf)). In comparison, $k$-means and hierarchical clustering showed moderate agreement with the true labels. These findings demonstrate that mixture-based approaches can more effectively capture the heterogeneity of clusters in high-dimensional, non-spherical data.

# Conclusion

The `cardinalR` package introduces a flexible framework for generating high-dimensional data structures with well-defined geometric properties. It addresses an important need in the evaluation of clustering, machine learning, and DR methods by enabling the construction of customized datasets with interpretable structures, noise characteristics, and clustering arrangements. In this way, `cardinalR` complements existing packages such as `geozoo`, `snedata`, and `mlbench`, while extending the scope to higher dimensions and more complex shapes.

The motivation for developing this package originated from the need to design a perception–misperception experiment, aimed at investigating how well NLDR methods preserve inter-cluster structure. To conduct this study, we required simulated datasets with carefully controlled geometric and clustering properties. While some existing packages provided useful starting points, none fully supported the creation of flexible, high-dimensional data with the specific structural variations needed for our experiment. Developing these generators for research purposes gradually led to the design of `cardinalR` as a general-purpose package, so that other researchers can benefit from the same tools for simulation, benchmarking, and teaching.

The included structures cover a wide range of diagnostic settings. Branching shapes facilitate the study of continuity and topological preservation, the Scurve with a hole allows investigation of incomplete manifolds, and clustered spheres assess separability on curved surfaces. The Möbius strip introduces challenges from non-orientable geometry, while gridded cubes and pyrholes test spatial regularity and clustering in sparse, non-convex regions.

These structures are designed to support not only algorithm diagnostics, but also teaching high-dimensional concepts, benchmarking reproducibility, and evaluating hyperparameter sensitivity. By allowing users to adjust dimensionality, sample size, noise, and clustering properties, the package promotes transparent experimentation and comparative model evaluation.

Future extensions of `cardinalR` may include biologically inspired or application-driven data structures would further broaden its utility in domains such as bioinformatics, forensic science, and spatial analysis.

<!-- - Branching: These functions create a controlled environment for testing how effectively various algorithms preserve branching topology and continuity in their low-dimensional embeddings. -->

<!-- - Scurve with a hole allowing for evaluation of how well algorithms handle incomplete manifolds or missing local structure. -->

<!-- - clusteredsphere: This structure allows for cluster separation on curved manifolds in high-dimensional space and can be used to test the ability of NLDR methods and clustering algorithms to detect spherical clusters of different sizes and separations. -->

<!-- - Mobius: The core geometric structure is a Mobius strip—a classic one-sided surface with a half-twist—useful for evaluating how well methods capture non-orientability and twisted manifolds. -->

<!-- - Grided cube: This function is useful for assessing how algorithms preserve uniformly spaced data in high-dimensional spaces. -->

<!-- - Pyrholes: This structure is useful for testing clustering and NLDR algorithms on non-convex and sparse high-dimensional shapes. -->

<!-- The application of our high-dimensional data generation package to evaluate the interplay between dimensionality reduction, nuisance variables, and hierarchical clustering yielded several key insights. The ability to generate synthetic datasets with well-defined underlying structures, coupled with the controlled introduction of nuisance variables, provided a valuable platform for assessing the robustness of downstream unsupervised learning techniques. -->

<!-- Our findings demonstrated that the choice of dimensionality reduction method significantly impacted the ability of hierarchical clustering to recover the true underlying clusters. Methods that effectively preserved the global structure of the data, as defined by our generation process, generally led to more accurate and interpretable hierarchical clustering results. However, the presence of nuisance variables often confounded the low-dimensional embeddings, making it more challenging for hierarchical clustering to separate truly distinct groups. This highlights a critical consideration in real-world data analysis, where unmeasured or latent factors can obscure the signal of interest. -->

<!-- The hierarchical clustering analysis itself, and the choice of linkage criteria, also played a crucial role. Different linkage methods revealed varying degrees of sensitivity to the distorted representations caused by the nuisance variables. For instance, methods that prioritize compact clusters might have been more susceptible to being misled by variance introduced by nuisance factors, while others focusing on the distance between clusters might have shown more resilience. The dendrograms generated by hierarchical clustering provided a visual means to explore the relationships between samples and the potential influence of nuisance, although determining the optimal number of clusters remained a challenge in the presence of these confounding factors. -->

<!-- This application underscores the utility of our data generation package as a powerful tool for controlled experimentation in unsupervised learning. By providing the ground truth cluster assignments and the ability to systematically manipulate data characteristics like dimensionality, geometric structure, and the presence of nuisance variables, researchers can gain a deeper understanding of the strengths and limitations of various DR and clustering algorithms. This controlled environment allows for a more objective evaluation than often possible with real-world datasets where the underlying structure is unknown. -->

<!-- One limitation of this particular application was the specific type and magnitude of the nuisance variables introduced. Future work could explore a wider range of nuisance types (e.g., batch effects, technical noise with specific distributions) and their varying degrees of influence on different DR and clustering methodologies. Furthermore, investigating strategies for mitigating the impact of nuisance variables, either during the DR step or within the clustering process itself, would be a valuable extension. -->

<!-- In conclusion, this example demonstrates the critical role of synthetic data generation in dissecting the complex interactions within unsupervised learning pipelines. Our package provides a flexible and controlled means to create such data, enabling researchers to systematically evaluate the performance and robustness of dimensionality reduction and clustering algorithms under well-defined conditions, including the presence of confounding factors. This capability contributes to a more rigorous and informed approach to high-dimensional data analysis. -->

# Acknowledgements

The source material for this paper is available at [github.com/JayaniLakshika/paper-cardinalR](https://github.com/JayaniLakshika/paper-cardinalR). This article is created using \CRANpkg{knitr} [@yihui2015] and \CRANpkg{rmarkdown} [@yihui2018] in R with the `rjtools::rjournal_article` template. These `R` packages were used for this work: `cli` [@gabor2025], `tibble` [@kirill2023], `gtools` [@gregory2023], `dplyr` [@hadley2023], `stats` [@core2025], `tidyr` [@hadley2024], `purrr` [@hadley2025], `mvtnorm` [@alan2009], `geozoo` [@barret2016], and `MASS` [@venables2002]. 




