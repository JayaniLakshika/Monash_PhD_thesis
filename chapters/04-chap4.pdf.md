# quollr: An R Package for Visualizing $2\text{-}D$ Models from Non-linear Dimension Reductions in High Dimensional Space {#sec-third-paper}






::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


## Introduction

<!-- research gap: add about hexbin pkg, and emphasize that in our package provide regular hexagons-->
<!-- objective: introduce a new tool to help to determine which method, which parameter choice provide the most useful representation of high-D data.--> 
<!--intro with S-curve with 5 methods-->

Non-linear dimension reduction (NLDR) techniques, such as t-distributed stochastic neighbor embedding (tSNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) algorithm [@moon2019], large-scale dimensionality reduction Using triplets (TriMAP) [@amid2019], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021], can create hugely different representations depending on the selected method and hyper-parameter choices. It is difficult to determine whether any of these representations are accurate, which one is the best, or whether they have missed important structures. 

This paper presents the R package, `quollr`, which is useful for understanding how NLDR warps high-dimensional space and fits the data. Starting with an NLDR layout, our approach is to create a \twoD wireframe model representation, that can be lifted and displayed in the high-dimensional (\pD{}) space (Figure \@ref(fig:overview)).


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Wireframe model representation of the NLDR layout, lifted and displayed in high-dimensional space. The left panel shows the NLDR layout with a triangular mesh overlay, forming the wireframe structure. This mesh can be lifted into higher dimensions and projected to examine how the geometric structure of the data is preserved. Panels (a1–a4) display different \twoD projections of the lifted wireframe, where the underlying curved sheet structure of the data is more clearly visible. The triangulated mesh highlights how local neighborhoods in the layout correspond to relationships in the high-dimensional space, enabling diagnostics of distortion and preservation across dimensions.](04-chap4_files/figure-pdf/overview-1.pdf){fig-pos='H' width=100%}
:::
:::


The paper is organized as follows. The next section introduces the implementation of the `quollr` package on CRAN, including a demonstration of the package's key functions and visualization capabilities. In the application section, we illustrate the algorithm's functionality for studying a clustering data structure. Finally, we conclude the paper with a brief summary and discuss potential opportunities for using our algorithm.

## Implementation

The implementation of `quollr` is designed to be efficient, and easy to extend. The package is organized into a series of logical components that reflect the main stages of the workflow: data preprocessing, model fitting, low-density bin removal, prediction, visualization, and interactive exploration (Figure \@ref(fig:workflow)). This package structure makes the code easier to maintain and allows new features to be added without changing the existing functionality.


::: {.cell}
::: {.cell-output-display}
![Overview of the `quollr` workflow and software architecture. The process begins with NLDR and $p\text{-}D$ data inputs, followed by data preprocessing and hexagonal binning. Centroids are computed and triangulated to form the $2\text{-}D$ mesh, which is then lifted into the $p\text{-}D$ space. Predictions and error computations are performed on new data, while interactive functions enable dynamic linking between the $p\text{-}D$ and $2\text{-}D$ representations.](../figures/quollr/quollr_workflow.png){fig-pos='H' width=100%}
:::
:::


### Software architecture

The package is organized into seven core modules corresponding to stages of the analysis workflow: preprocessing, \twoD model construction, lifting into \pD, prediction, error computation, visualization, and interactivity. Each module performs a distinct task and communicates through data objects.

1. Data preprocessing: The function `gen_scaled_data()` standardizes the embedding data, manage variable naming, and ensure consistent identifiers across high-dimensional and embedded datasets.

2. Construct \twoD model: A series of functions `hex_binning()`, `merge_hexbin_centroids()`, `tri_bin_centroids()`, `gen_edges()`, and `update_trimesh_index()` generate the hexagonal grid, compute bin centroids, and connect the triangular mesh that defines local neighborhoods in the \twoD space.

3. Lift the model into \pD: The function `avg_highd_data()` computes the average of the high-dimensional variables for each bin, linking the \twoD representation back to the original data space.

4. Prediction: The function `predict_emb()` estimates the embedding of new high-dimensional observations based on the fitted model.

5. Error computation: The `glance()` and `augment()` function summarizes model performance by comparing the predicted and original embeddings.

6. Visualization: Functions such as `geom_hexgrid()`, `geom_trimesh()`, and `show_langevitour()` provide tools for exploring the fitted models through static and dynamic visualizations.

7. Interactivity: The functions `comb_all_data_model()` and `show_link_plots()` generate interactive linked visualizations that connect the \twoD NLDR layout, the corresponding tour view, and the fitted model. Similarly, `comb_all_data_model_error()` and `show_error_link_plots()` integrate the error distribution with the \twoD embedding and dynamic high-dimensional view, enabling interactivity across multiple visual components.

Each module is internally independent but connected through data objects (see next section). This modular design simplifies maintenance and allows developers to extend individual components such as substituting different binning approaches, extracting centroids, or visualization tools without altering the overall workflow.

### Data objects

The internal data objects follow the tidy data principle: each variable is stored in a column, each observation in a row, and each type of information in its own table. This structure makes the package easy to use with the `tidyverse` and other R visualization tools.

#### Input objects

- `highd_data`: a tibble containing the original high-dimensional observations with a unique identifier (`ID`) and variable columns prefixed with `"x"` (e.g., `x1`, `x2`, …).

- `nldr_data`: a tibble containing two-dimensional embeddings, labeled as `emb1` and `emb2`, matched to the same `ID`s.

#### Generated objects

- `scaled_nldr_obj`: the output of `gen_scaled_data()`, which rescales the embedding to the range $[0, 1] \times [0, y_{2,\text{max}}]$, where $y_{2,\text{max}} = r_2 / r_1$ is the ratio of the embedding ranges. It includes the scaled coordinates (`scaled_nldr`) and the original limits (`lim1`, `lim2`).

- `hex_bin_obj`: the object created by `hex_binning()`, which defines the structure of the two-dimensional hexagonal grid used in modeling. It includes the grid spacing (`a1`, `a2`), the number of bins along each axis, the centroids of all hexagons, polygon coordinates for plotting, and the mapping of each data point to its assigned hexagon.

- `highd_vis_model`: the main model object returned by `fit_highd_model()`. It stores all components of the fitted visualization model, including the scaled NLDR data (`nldr_scaled_obj`), the hexagonal bin structure (`hb_obj`), the averaged \pD summaries for each bin (`model_highd`), the corresponding \twoD bin centroids (`model_2d`), and the triangulated mesh connecting neighboring bins (`trimesh_data`). 

### Computational efficiency and optimization

Several core computations within `quollr` are optimized using compiled C++ code via the `Rcpp` and `RcppArmadillo` packages. While the user interacts with high-level R functions, performance-critical steps such as nearest-neighbor searches (`compute_highd_dist()`), error metrics (`compute_errors()`), \twoD distance calculations (`calc_2d_dist_cpp()`), and generation of hexagon coordinates (`gen_hex_coord_cpp()`) are handled internally in C++. This design provides significant speedups when analyzing large datasets while maintaining a user-friendly R interface. These C++ functions are not exported but are bundled within the package and fully accessible for inspection in the source code.

## Usage

The package is available on CRAN, and the development version is available at https://jayanilakshika.github.io/quollr/.

Our algorithm includes the following steps: (1) scaling the NLDR data, (2) computing configurations of a hexagon grid, (3) binning the data, (4) obtaining the centroids of each bin, (5) indicating neighboring bins with line segments that connect the centroids, and (6) lifting the model into high dimensions (Figure \@ref(fig:algo-steps)). A detailed description of the algorithm can be found in @gamage2025c.


::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Key steps for constructing the model on the UMAP layout: (a) hexagon bins, (b) bin centroids, (c) triangulated centroids, and (d) lifting the model into high dimensions. The `Scurve` data is shown.](04-chap4_files/figure-pdf/algo-steps-1.pdf){fig-pos='H' width=100%}
:::
:::


The following demonstration of the package's functionality assumes `quollr` has been loaded. To begin the workflow, users need two inputs: the high-dimensional dataset and the corresponding nonlinear dimensionality reduction (NLDR) layout. The high-dimensional data must contain a unique `ID` column, with data columns prefixed by the letter `"x"` (e.g., `x1`, `x2`, etc.). The NLDR dataset should include embedding coordinates labeled as `emb1` and `emb2`, ensuring one-to-one correspondence with the high-dimensional data through the shared `ID`. 

To illustrate the workflow, we use the built-in example dataset `scurve`, a $7\text{-}D$ simulated dataset consisting of $1000$ observations. The first three variables define a $3\text{-}D$ S-shaped manifold, while the remaining four variables introduce low-magnitude uniform noise, yielding a structured yet noisy high-dimensional dataset.


::: {.cell}

```{.r .cell-code}
data("scurve")
```
:::


For this example, we use the UMAP layout, which is produced using `n_neighbors =` $46$ and `min_dist =` $0.9$.


::: {.cell}

```{.r .cell-code}
library(umap)
library(dplyr)

scurve_umap <- umap(
  scurve |> select(-ID),
  config = modifyList(umap.defaults, list(
    n_neighbors = 46,
    n_components = 2,
    min_dist = 0.9
  ))
)$layout |>
  as_tibble(.name_repair = ~ paste0("emb", 1:2)) |>
  mutate(ID = scurve$ID)
```
:::


### Main function

The mains steps for the algorithm can be executed by the main function `fit_highd_model()`, or can be run separately for more flexibility. 

This function requires several parameters: the high-dimensional data (`highd_data`), the emdedding data (`nldr_data`), the number of bins along the x-axis (`b1`), the buffer amount as a proportion of data (`q`), and benchmark value to extract high density hexagons (`hd_thresh`). The function returns an object of class `highd_vis_model` containing the scaled NLDR object (`nldr_scaled_obj`) with three elements: the first is the scaled NLDR data (`scaled_nldr`), and the second and third are the limits of the original NLDR data (`lim1` and `lim2`); the hexagonal object (`hb_obj`), the fitted model in both \twoD (`model_2d`), and \pD (`model_highd`), and triangular mesh (`trimesh_data`).  


::: {.cell}

```{.r .cell-code}
fit_highd_model(
  highd_data = scurve, 
  nldr_data = scurve_umap, 
  b1 = 21, 
  q = 0.1, 
  hd_thresh = 0)
```
:::


### Constructing the $2\text{-}D$ Model

Constructing the \twoD model primarily involves (i) scaling the NLDR data, (ii) binning the data, (iii) obtaining bin centroids, (iv) connecting centroids with line segments to indicate neighbors, and (v) removing low-density hexagons.

#### Scaling the data

The algorithm starts by scaling the NLDR data to to the range $[0, 1] \times [0, y_{2,max}]$, where $y_{2,max} = r_2/r_1$ is the ratio of ranges of embedding components. The output includes the scaled NLDR data (`scaled_nldr`) along with the original limits of the embeddings (`lim1`, `lim2`).


::: {.cell}

```{.r .cell-code}
scurve_umap_obj <- gen_scaled_data(nldr_data = scurve_umap)
```
:::


#### Computing hexagon grid configuration

The function `calc_bins_y()` determines the configuration of the hexagonal grid by computing the number of bins along the y-axis (`b2`), the hexagon width (`a1`), and height (`a2`). This function accepts (1) an object (`nldr_scaled_obj`) containing three elements: the first is the scaled NLDR data (`scaled_nldr`), and the second and third are the limits of the original NLDR data (`lim1` and `lim2`); (2) the number of bins along the x-axis (`b1`), and (3) the buffer amount as a proportion (`q`). The buffer ensures that the grid fully covers the data space by extending one hexagon width ($a_1$) and height ($a_2$) beyond the observed data in all directions. By default, $q = 0.1$, but it must be set to a value smaller than the minimum data value to avoid exceeding the data range.


::: {.cell}

```{.r .cell-code}
bin_configs <- calc_bins_y(
  nldr_scaled_obj = scurve_umap_obj, 
  b1 = 21, 
  q = 0.1)

bin_configs
```

::: {.cell-output .cell-output-stdout}

```
> $b2
> [1] 28
> 
> $a1
> [1] 0.05869649
> 
> $a2
> [1] 0.05083265
```


:::
:::


#### Binning the data

Points are allocated to bins based on the nearest centroid of the hexagonal bins. The hexagonal binning algorithm can be executed using the `hex_binning()` function, or its individual components can be run separately for added flexibility. While running the process step by step would involve generating centroids, constructing hexagon coordinates, assigning points to bins, standardizing counts, and mapping the data back to hexagons, the `hex_binning()` function automates this entire workflow. The parameters used within `hex_binning()` are the object output from `gen_scaled_data` (`nldr_scaled_obj`); the number of bins along the x-axis (`b1`), and the buffer amount as a proportion of the data (`q`). The output is an object of the `hex_bin_obj` class, which contains the bin widths in each direction (`a1`, `a2`), the number of bins in each direction (`bins`), the coordinates of the hexagonal grid starting point (`start_point`), the details of bin centroids (`centroids`), the coordinates of bins (`hex_poly`), NLDR components with their corresponding hexagon IDs (`data_hb_id`), hex bins with their corresponding standardized counts (`std_cts`), the total number of bins (`b`), the number of non-empty bins (`m`), and the points within each hexagon (`pts_bins`).  


::: {.cell}

```{.r .cell-code}
hb_obj <- hex_binning(
  nldr_scaled_obj = scurve_umap_obj, 
  b1 = 21, 
  q = 0.1)
```
:::


<!--add each step separately-->
<!--add hexbin notation image-->


::: {.cell}

:::



::: {.cell layout-align="center"}

:::


##### Generating all possible centroids in a hexagonal grid

The `gen_centroids()` function calculates the centroids of a hexagonal grid. 

The coordinate limits of the embedding (`lim1` and `lim2`) are used to compute the aspect ratio between the two axes, which informs vertical spacing. The function then calls `calc_bins_y()`, a helper function that determines the appropriate number of hexagons along y-axis (`b2`) and the width of each hexagon (`a1`) given the specified number of bins along the x-axis (`b1`) and buffer (`q`).

Then, the centroids are computed iteratively. The x-coordinates for centroids in odd-numbered rows are initialized as a sequence spaced by the hexagon width. Even-numbered rows are staggered by half this width to achieve a hexagonal tiling effect. Vertical spacing (`vs`) is given by $\sqrt{3}/2 \times a_1$.

The y-coordinates for each row are similarly calculated, and paired with the x-coordinates based on whether the total number of rows is even or odd. In the case of an odd number of rows, the final row uses only the odd-row x-coordinates to maintain the alternating pattern.

Finally, a tibble is returned containing a unique hexagon ID (`h`) along with the corresponding x and y centroid coordinates (`c_x`, `c_y`), which define the layout of the hexagonal grid over the \twoD space.


::: {.cell}

```{.r .cell-code}
all_centroids_df <- gen_centroids(
  nldr_scaled_obj = scurve_umap_obj, 
  b1 = 21, 
  q = 0.1
  )

head(all_centroids_df, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 3
>       h     c_x    c_y
>   <int>   <dbl>  <dbl>
> 1     1 -0.1    -0.116
> 2     2 -0.0413 -0.116
> 3     3  0.0174 -0.116
> 4     4  0.0761 -0.116
> 5     5  0.135  -0.116
```


:::
:::


##### Creating the coordinates of the hexagons

Following the generation of hexagonal centroids, the `gen_hex_coord()` function constructs the coordinates of each hexagonal bin by defining its six polygonal vertices. These coordinates are used to visualize the hexagonal tessellation.

Each hexagon is defined relative to its centroid $(C_x, C_y)$, with six vertices positioned equidistantly around the center. The function first verifies the presence of the required hexagon width parameter `a1`. This width determines the horizontal spacing (`hs`).

Two derived constants are calculated to define the relative distances to the vertices. The horizontal and vertical offset is defined as $dx = a_1/2$, and $dy = a_1/\sqrt{3}$ repectively. A vertical spacing factor $vf = a_1/2\sqrt{3}$ refines vertical placement in staggered rows.

With these values, the function determines fixed offsets in the x and y directions for all six vertices relative to the centroid. These offsets form two vectors corresponding to the six compass directions used to define the polygon shape: top, top-left, bottom-left, bottom, bottom-right, and top-right.

For each centroid, six vertices are computed and assigned a polygon ID as the centroid. These vertices are then combined into a tibble that records the polygon ID (`h`) and the respective x (`x`) and y (`y`) coordinates for all hexagon corners.

To reduce computational overhead, the geometry calculations are implemented in C++ using `gen_hex_coord_cpp()`, which returns a `tibble` of vertex coordinates.


::: {.cell}

```{.r .cell-code}
all_hex_coord <- gen_hex_coord(
  centroids_data = all_centroids_df, 
  a1 = bin_configs$a1
  )

head(all_hex_coord, 5)
```

::: {.cell-output .cell-output-stdout}

```
>   h           x           y
> 1 1 -0.10000000 -0.08179171
> 2 1 -0.12934824 -0.09873593
> 3 1 -0.12934824 -0.13262436
> 4 1 -0.10000000 -0.14956858
> 5 1 -0.07065176 -0.13262436
```


:::
:::


##### Assigning data points to their respective hexagons

After generating the centroids that define the hexagonal grid, the next step is to assign each point in the NLDR embedding to its nearest hexagonal bin. The `assign_data()` function performs this assignment by calculating the \twoD Euclidean distance between each point in the \twoD embedding and all hexagon centroids.

First, the function extracts the first two dimensions of the scaled NLDR embedding, which represent the \twoD layout. It then selects the corresponding x and y coordinates of each hexagon’s centroid.

Both the embedding coordinates and the centroid coordinates are converted to matrices to facilitate distance computations. The function uses the `proxy::dist()` method to compute a pairwise Euclidean distance matrix between all NLDR points and all centroids. For each NLDR point, the function identifies the index of the centroid with the smallest distance representing the closest hexagon—and assigns the corresponding hexagon ID (`h`) to the point.

The result is a `tibble` of the scaled \twoD embedding with an additional `h` column, indicating the hexagonal bin to which each point belongs. 


::: {.cell}

```{.r .cell-code}
umap_hex_id <- assign_data(
  nldr_scaled_obj = scurve_umap_obj, 
  centroids_data = all_centroids_df
  )

head(umap_hex_id, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 4
>    emb1  emb2    ID     h
>   <dbl> <dbl> <int> <int>
> 1 0.277 0.913     1   427
> 2 0.697 0.538     2   287
> 3 0.779 0.399     3   226
> 4 0.173 0.953     4   446
> 5 0.218 0.983     5   468
```


:::
:::


##### Computing the standardized number of points within each hexagon

The `compute_std_counts()` function calculates both the raw and standardized counts of points inside each hexagon.

The function begins by grouping the data by hexagon ID (`h`) and counting the number of NLDR points falling within each bin. These raw counts are stored as `n_h`. To enable comparisons across bins with varying densities, the function then standardizes these counts by dividing each bin’s count by the maximum count across all bins. This yields a standardized bin counts, `w_h`, ranging from $0$ to $1$.


::: {.cell}

```{.r .cell-code}
std_df <- compute_std_counts(
  scaled_nldr_h = umap_hex_id
  )

head(std_df, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 3
>       h   n_h   w_h
>   <int> <int> <dbl>
> 1    58     4 0.004
> 2    68     1 0.001
> 3    69     5 0.005
> 4    70     6 0.006
> 5    71     9 0.009
```


:::
:::


##### Mapping the points to their corresponding hexagonal bins

The `group_hex_pts()` function extracts the list of data point identifiers (`ID`) assigned to each hexagon in the NLDR space.

The function first groups the input data by `h`, which represents the hexagon ID associated with each point in the \twoD layout. Within each group, it collects the `ID`s into a list, resulting in a summary where each row corresponds to a single hexagon. The resulting column, `pts_list`, contains all point identifiers associated with that hexagon. 


::: {.cell}

```{.r .cell-code}
pts_df <- group_hex_pts(
  scaled_nldr_hexid = umap_hex_id
  )

head(pts_df, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 2
>       h pts_list 
>   <int> <list>   
> 1    58 <int [4]>
> 2    68 <int [1]>
> 3    69 <int [5]>
> 4    70 <int [6]>
> 5    71 <int [9]>
```


:::
:::


#### Obtaining bin centroids

The `merge_hexbin_centroids()` function combines hexagonal bin coordinates, raw and standardized counts within each hexagons.

This function begins by arranging the `counts_data` by `h` to ensure consistent ordering. It then performs a full join with `centroids_data`, aligning hexagon IDs (`h`) between the two datasets to incorporate both hexagonal bin centroids (`h`) and count metrics. After merging, the function handles missing values in the count columns: any `NA` values in `w_h` or `n_h` are replaced with zeros. This ensures that hexagons with no assigned data points are retained in the output, with zero values for count-related fields. The resulting data contains the full set of hexagon centroids along with associated bin counts (`n_h`) and standardized counts (`w_h`).


::: {.cell}

```{.r .cell-code}
df_bin_centroids <- merge_hexbin_centroids(
  centroids_data = all_centroids_df, 
  counts_data = hb_obj$std_cts
  )

head(df_bin_centroids, 5)
```

::: {.cell-output .cell-output-stdout}

```
>   h         c_x        c_y n_h w_h
> 1 1 -0.10000000 -0.1156801   0   0
> 2 2 -0.04130351 -0.1156801   0   0
> 3 3  0.01739298 -0.1156801   0   0
> 4 4  0.07608947 -0.1156801   0   0
> 5 5  0.13478596 -0.1156801   0   0
```


:::
:::


#### Indicating neighbors by line segments connecting centroids

To represent the neighborhood structure of hexagonal bins in a \twoD layout, we employ Delaunay triangulation [@lee1980;@albrecht2024] on the centroids of hexagons. This geometric approach is used to infer which bins are considered neighbors.

The `tri_bin_centroids()` function generates a triangulation object from the x and y coordinates of hexagon centroids using the `interp::tri.mesh()` function [@albrecht2024]. This triangulation forms the structural basis for identifying adjacent bins.


::: {.cell}

```{.r .cell-code}
tr_object <- tri_bin_centroids(
  centroids_data = df_bin_centroids
  )
```
:::


The `gen_edges()` function uses this triangulation object to extract line segments between neighboring bins. It constructs a unique set of bin-to-bin connections by identifying the triangle edges and filtering duplicate or reversed links. Each edge is then annotated with its start and end coordinates, and a Euclidean distance is computed using the helper function `calc_2d_dist()`. 


::: {.cell}

```{.r .cell-code}
trimesh <- gen_edges(tri_object = tr_object, a1 = hb_obj$a1)

head(trimesh, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 8
>    from    to  x_from  y_from    x_to    y_to from_count to_count
>   <int> <int>   <dbl>   <dbl>   <dbl>   <dbl>      <dbl>    <dbl>
> 1     1     2 -0.1    -0.116  -0.0413 -0.116           0        0
> 2    22    23 -0.0707 -0.0648 -0.0120 -0.0648          0        0
> 3    22    44 -0.0707 -0.0648 -0.0413 -0.0140          0        0
> 4     3    23  0.0174 -0.116  -0.0120 -0.0648          0        0
> 5    44    45 -0.0413 -0.0140  0.0174 -0.0140          0        0
```


:::
:::


The `update_trimesh_index()` function re-indexes the node IDs to ensure that edge identifiers are sequentially numbered and consistent with downstream analysis.


::: {.cell}

```{.r .cell-code}
trimesh <- update_trimesh_index(trimesh_data = trimesh)

head(trimesh, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 10
>    from    to  x_from  y_from    x_to    y_to from_count to_count from_reindexed
>   <int> <int>   <dbl>   <dbl>   <dbl>   <dbl>      <dbl>    <dbl>          <int>
> 1     1     2 -0.1    -0.116  -0.0413 -0.116           0        0              1
> 2    22    23 -0.0707 -0.0648 -0.0120 -0.0648          0        0             22
> 3    22    44 -0.0707 -0.0648 -0.0413 -0.0140          0        0             22
> 4     3    23  0.0174 -0.116  -0.0120 -0.0648          0        0              3
> 5    44    45 -0.0413 -0.0140  0.0174 -0.0140          0        0             44
> # i 1 more variable: to_reindexed <int>
```


:::
:::


#### Identifying and removing low-density hexagons

Not all hexagons contain meaningful information. Some may have very few or no data points due to the sparsity or shape of the underlying structure. Simply removing hexagons with low counts (e.g., fewer than a fixed threshold) can lead to gaps or "holes" in the \twoD structure, potentially disrupting the continuity of the representation.

To address this, we propose a more nuanced method that evaluates each hexagon not only based on its own density, but also in the context of its immediate neighbors. The `find_low_dens_hex()` function identifies hexagonal bins with insufficient local support by calculating the average standardized count across their six neighboring bins. If this mean neighborhood density is below a user-defined threshold (e.g., $0.05$), the hexagon is flagged for removal.

The `find_low_dens_hex()` function relies on a helper, `compute_mean_density_hex()`, which iterates over all hexagons and computes the average density across neighbors based on their hexagon ID (`h`) and a defined number of bins along the x-axis (`b1`). The hexagonal layout assumes a fixed grid structure, so neighbor IDs are computed by positional offsets.


::: {.cell}

```{.r .cell-code}
low_density_hex <- find_low_dens_hex(
  model_2d = df_bin_centroids, 
  b1 = 21, 
  md_thresh = 0.05
)
```
:::


For simplicity, we remove low-density hexagons using a threshold of $0$.


::: {.cell}

```{.r .cell-code}
df_bin_centroids <- df_bin_centroids |>
  dplyr::filter(n_h > 0)

trimesh <- trimesh |>
  dplyr::filter(from_count > 0,
                to_count > 0)

trimesh <- update_trimesh_index(trimesh)
```
:::


### Lifting the model into high dimensions

The final step involves lifting the fitted \twoD model into \pD. This is done by modelling a point in \pD as the  \pD mean of data points in the \twoD centroid. This is performed using the `avg_highd_data()` function, which takes \pD data (`highd_data`) and embedding data with their corresponding hexagonal bin IDs as inputs (`scaled_nldr_hexid`).


::: {.cell}

```{.r .cell-code}
df_bin <- avg_highd_data(
  highd_data = scurve, 
  scaled_nldr_hexid = hb_obj$data_hb_id
)

head(df_bin, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 8
>       h     x1     x2    x3       x4       x5       x6       x7
>   <int>  <dbl>  <dbl> <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
> 1    58 -0.371 1.91    1.92 -0.00827 0.00189   0.0170   0.00281
> 2    68  0.958 0.0854  1.29  0.00265 0.0171    0.0876  -0.00249
> 3    69  0.855 0.0917  1.51  0.00512 0.000325 -0.0130  -0.00395
> 4    70  0.731 0.129   1.68 -0.00433 0.00211  -0.0356  -0.00240
> 5    71  0.474 0.108   1.88 -0.00260 0.000128  0.00785  0.00170
```


:::
:::


### Prediction

The `predict_emb()` function is used to predict a point in a \twoD embedding for a new \pD data point using the fitted model. This function is useful to predict \twoD embedding irrespective of the NLDR technique.

In the prediction process, first, the nearest \pD model point is identified for the new \pD data point by computing \pD Euclidean distance. Then, the corresponding \twoD bin centroid mapping for the identified \pD model point is determined. Finally, the coordinates of the identified \twoD bin centroid is used as the predicted NLDR embedding for the new \pD data point. 

To accelerate this process, the nearest-neighbor search is implemented in C++ using `Rcpp` via the internal function `compute_highd_dist()`.


::: {.cell}

```{.r .cell-code}
predict_data <- predict_emb(
  highd_data = scurve, 
  model_2d = df_bin_centroids, 
  model_highd = df_bin
  )

head(predict_data, 5)
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 5 x 4
>   pred_emb_1 pred_emb_2    ID pred_h
>        <dbl>      <dbl> <int>  <int>
> 1      0.252      0.901     1    427
> 2      0.692      0.545     2    287
> 3      0.780      0.393     3    226
> 4      0.164      0.952     4    446
> 5      0.193      1.00      5    468
```


:::
:::


It is worth noting that while `predict_emb()` provides a general approach that works across methods, some NLDR techniques have their own built-in prediction mechanisms. For example, UMAP [@tomasz2023] supports direct prediction of embeddings for new data once a model is fitted.

### Compute residuals and Root Within Bin Sum of Square (RWBSS)

Root Within Bin Sum of Square (RWBSS) are used as goodness of fit metrics for the model. These metrics can be computed using the  `glance()` function, which provides a tidy output for evaluation.

The function requires both the fitted model object returned by `fit_highd_model()` and \pD data to begin. The \pD model output (`model_highd`) is first renamed to avoid naming conflicts during subsequent data joins. It then uses the `predict_emb()` function to assign each point in the \pD dataset to a corresponding hexagon bin in the \twoD model, producing a prediction data frame that contains both the predicted bin assignment (`pred_h`) and the original observation `ID`.

The function joins this prediction output with both the \pD model and the \pD data (to retrieve true coordinates). It then calculates squared differences between the original and predicted \pD coordinates for each dimension, storing these as `error_square_x1`, `error_square_x2`, ..., up to the dimensionality of the data.

From these per-dimension errors, the function computes absolute error which is the sum of absolute differences across all dimensions and observations and the RWBSS which is the average of the total squared error per point.

These metrics are returned in a tibble as `Error` (absolute error) and `RWBSS` (root mean squared error). The computation of total absolute error and RWBSS is performed in C++ for efficiency using the internal `compute_errors()` function.


::: {.cell}

```{.r .cell-code}
glance(
  x = scurve_model_obj,
  highd_data = scurve
  )
```

::: {.cell-output .cell-output-stdout}

```
> # A tibble: 1 x 2
>   Error   HBE
>   <dbl> <dbl>
> 1  196. 0.116
```


:::
:::


Furthermore, `augment()` requires both the fitted model object returned by `fit_highd_model()` and \pD data to begin. It extends the fitted model by adding prediction results and error diagnostics to the original \pD data.

The function starts with the same process as is used in the `glance()` function to produce a predicted point in \pD for each point in the \pD dataset.

Next, the function computes residuals between each original coordinate (`x1`, `x2`, ..., `xp`) and the corresponding modeled coordinate (`model_high_d_x1`, ..., `model_high_d_xp`) across all dimensions. It calculates both squared errors and absolute errors per dimension. These are used to compute two aggregate diagnostic measures per point. First, the `row_wise_total_error` which is the total squared error across all dimensions, and the `row_wise_abs_error` which is the total absolute error across all dimensions.

The final output is a data frame that combines the original IDs, high-dimensional data, predicted bin IDs, modeled coordinates, residuals, row wise total error, absolute error for the fitted values, and row wise total absolute error for each observation. The augmented dataset is always returned as a `tibble::tibble` with the same number of rows as the passed dataset.


::: {.cell}

```{.r .cell-code}
model_error <- augment(
  x = scurve_model_obj,
  highd_data = scurve
  )
```
:::


### Visualizations

The package offers several \twoD visualizations, including:

- A full hexagonal grid,
- A hexagonal grid that matches the data,
- A full grid based on centroid triangulation,
- A centroid triangulation grid that aligns with the data, 
- A triangular mesh for any provided set of points.

The generated \pD model, overlaid with the data, can also be visualized using `show_langevitour`. Additionally, it features a function for visualizing the \twoD projection of the fitted model overlaid on the data, called `plot_proj`. 

Furthermore, there are two interactive plots, `show_link_plots` and `show_error_link_plots`, which are designed to help diagnose the model.

Each visualization can be generated using its respective function, as described in this section.

#### Hexagonal grid

The `geom_hexgrid()` function introduces a custom `ggplot2` layer designed for visualizing hexagonal grid on a provided set of bin centroids.

To display the complete grid, users should supply all available bin centroids. 


::: {.cell}

```{.r .cell-code}
full_hexgrid <- ggplot() + 
  geom_hexgrid(
    data = hb_obj$centroids, 
    aes(x = c_x, y = c_y)
    ) 
```
:::


If the goal is to plot only the subset of hexagons that correspond to bins containing data points, then only the centroids associated with those bins should be passed.


::: {.cell}

```{.r .cell-code}
data_hexgrid <- ggplot() + 
  geom_hexgrid(
    data = df_bin_centroids, 
    aes(x = c_x, y = c_y)
    ) 
```
:::


#### Triangular mesh

The `geom_trimesh()` function introduces a custom `ggplot2` layer designed for visualizing \twoD wireframe on a provided set of bin centroids.

To display the complete wireframe, users should supply all available bin centroids. 


::: {.cell}

```{.r .cell-code}
full_triangulation_grid <- ggplot() + 
  geom_trimesh(
    data = hb_obj$centroids, 
    aes(x = c_x, y = c_y)
    ) 
```
:::


If the goal is to plot only the subset of hexagons that correspond to bins containing data points, then only the centroids associated with those bins should be passed.


::: {.cell}

```{.r .cell-code}
data_triangulation_grid <- ggplot() + 
  geom_trimesh(
    data = df_bin_centroids, 
    aes(x = c_x, y = c_y)
    ) 
```
:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The outputs of `geom\_hexgrid` and `geom\_trimesh` include: (a) a complete hexagonal grid, (b) a hexagonal grid that corresponds with the data, (c) a full grid based on centroid triangulation, and (d) a centroid triangulation grid that aligns with the data.](04-chap4_files/figure-pdf/geom-outputs-pdf-1.pdf){fig-align='center' fig-pos='H' width=100%}
:::
:::


#### \pD model visualization

To visualize how well the \pD model captures the underlying structure of the high-dimensional data, we provide a tour of the model in \pD using the `show_langevitour()` function. This function renders a dynamic projection of both the high-dimensional data and the model using the `langevitour` R package [@paul2023].

Before plotting, the data needs to be organized into a combined format through the `comb_data_model()` function. This function takes three inputs: `highd_data` (the high-dimensional observations), `model_highd` (high-dimensional summaries for each bin), and `model_2d` (the hexagonal bin centroids of the model). It returns a tidy data frame combining both the data and the model.

In this structure, the `type` variable distinguishes between original observations (`"data"`) and the bin-averaged model representation (`"model"`).


::: {.cell}

```{.r .cell-code}
df_exe <- comb_data_model(
  highd_data = scurve, 
  model_highd = df_bin, 
  model_2d = df_bin_centroids
  )
```
:::


The `show_langevitour()` function then renders the visualization using the `langevitour` interface, displaying both types of points in a dynamic tour. The `edge_data` input defines connections between neighboring bins (i.e., the hexagonal edges) to visualize the model’s structure.


::: {.cell}

```{.r .cell-code}
show_langevitour(
  point_data = df_exe, 
  edge_data = trimesh
  )
```
:::



::: {.cell}
::: {.cell-output-display}
![$2\text{-}D$ projections of the lifted high-dimensional wireframe model from the `Scurve` UMAP layout. Each panel (a1–a4) shows the model (black) overlaid on `Scurve` data (blue) in different projections. These views illustrate how the lifted wireframe model captures the structure of the `Scurve` data. Regions with sparse or no data in the UMAP layout are also visible in the lifted model.](04-chap4_files/figure-pdf/unnamed-chunk-29-1.pdf){fig-pos='H' width=100%}
:::
:::


As an alternative to `langevitour`, users can explore the fitted \pD model using the `detourr` [@casper2025]. The combined data object from `comb_data_model()` can be passed directly to the `detour()` function, where `tour_aes()` defines the projection variables and color mapping. The visualization is rendered using `show_scatter()`, which can display both data points and the model’s structural edges via the `edges` argument.


::: {.cell}
::: {.cell-output-display}
![Screenshots of the lifted high-dimensional wireframe model from the `Scurve` UMAP layout using `detourr`. Regions with sparse or no data in the UMAP layout are also visible in the lifted model.](../figures/quollr/model_proj1_detourr.png){fig-pos='H' width=50%}
:::

::: {.cell-output-display}
![Screenshots of the lifted high-dimensional wireframe model from the `Scurve` UMAP layout using `detourr`. Regions with sparse or no data in the UMAP layout are also visible in the lifted model.](../figures/quollr/model_proj2_detourr.png){fig-pos='H' width=50%}
:::
:::



::: {.cell}

```{.r .cell-code}
detour(
  df_exe,
  tour_aes(
    projection = starts_with("x"),
    colour = type
  )
) |>
  tour_path(grand_tour(2), 
                    max_bases=50, fps = 60) |>
  show_scatter(axes = TRUE, size = 0.5, alpha = 0.5, 
               edges = as.matrix(trimesh[, c("from_reindexed", "to_reindexed")]),
               palette = c("#66B2CC", "#FF7755"),
               width = "600px", height = "600px")
```
:::


In the resulting interactive visualization, blue points represent the high-dimensional data, orange points represent the model centroids from each bin, and the lines between model points reflect the \twoD wireframe structure mapped to high-dimensional space.

#### Link plots

There are mainly two interactive link plots can be generated. 

To support interactive evaluation of how well the \pD model captures the structure of the high-dimensional data, we introduce `show_link_plots()`. This visualization combines two complementary views: the nonlinear dimension reduction (NLDR) representation and a dynamic tour of the model ovelaid the data in the high-dimensional space. Both views are interactively linked, enabling users to explore.

Before visualization, the input data must be prepared using the `comb_all_data_model()` function. This function combines the high-dimensional data (`highd_data`), the NLDR data (`nldr_data`), and the bin-averaged high-dimensional model representation (`model_highd`) aligned to the \twoD bin layout (`model_2d`):

This combined dataset includes both the original observations and the bin-level model averages, labeled with a `type` variable for distinguishing between them.


::: {.cell}

```{.r .cell-code}
df_exe <- comb_all_data_model(
  highd_data = scurve, 
  nldr_data = scurve_umap, 
  model_highd = df_bin, 
  model_2d = df_bin_centroids
  )
```
:::


The function `show_link_plots()` generates two side-by-side, interactively linked plots; a \twoD NLDR representation, and a dynamic projection tour in the original high-dimensional space (using the `langevitour` package), displaying both the data and the model. The function takes the output from `comb_all_data_model()` (`point_data`) and `edge_data` which defines connections between neighboring bins.

These two views are linked using `crosstalk`, allowing interactive selection of points in the NLDR plot to highlight corresponding structures in the `langevitour` output. 


::: {.cell}

```{.r .cell-code}
nldrdt_link <- show_link_plots(
  point_data = df_exe, 
  edge_data = trimesh, 
  point_colour = clr_choice
  )

class(nldrdt_link) <- c(class(nldrdt_link), "htmlwidget")

nldrdt_link
```
:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Exploring the correspondence between UMAP layout and `Scurve` structure in $7\text{-}D$. Two sets of plots are linked: UMAP layout (a1, b1) and projection of $7\text{-}D$ model and data (a2, b2). The purple points indicate the selected subsets, which differ between rows. In (a1), the lower bridge of the `Scurve` is highlighted, which corresponds in (a2) to points spanning across both arms of the high-dimensional structure. In (b1), a different region near the upper arm of the `Scurve` is selected, and in (b2) these points map onto one side of the curved manifold in $7\text{-}D$ projection. While the UMAP layout suggests distinct local clusters, the linked tour views reveal how these selections trace continuous structures in the $7\text{-}D$ space, highlighting distortions introduced by UMAP.](04-chap4_files/figure-pdf/unnamed-chunk-34-1.pdf){fig-pos='H' width=100%}
:::
:::


`show_error_link_plots()` helps to see investigate whether the model fits the points everywhere or fits better in some places, or simply mismatches the pattern. 

Before visualization, the input data must be prepared using the `comb_all_data_model_error()` function. The function requires several arguments: points data which contain high-dimensional data (`highd_data`), NLDR data (`nldr_data`), high-dimensional model data (`model_highd`), \twoD model data (`model_2d`), and model error (`error_data`).

This combined dataset includes both the original observations and the bin-level model averages, labeled with a `type` variable for distinguishing between them.


::: {.cell}

```{.r .cell-code}
df_exe <- comb_all_data_model_error(
  highd_data = scurve, 
  nldr_data = scurve_umap, 
  model_highd = df_bin, 
  model_2d = df_bin_centroids, 
  error_data = model_error
  )
```
:::


The function `show_error_link_plots()` generates three side-by-side, interactively linked plots; a error distribution, a \twoD NLDR representation, and a dynamic projection tour in the original high-dimensional space (using the `langevitour` package), displaying both the data and the model. The function takes the output from `comb_all_data_model_error()` (`point_data`) and `edge_data` which defines connections between neighboring bins.

These two views are linked using `crosstalk`, allowing interactive selection of points in the NLDR plot to highlight corresponding structures in the high-dimensional projection. This setup facilitates the diagnosis of local distortion, structural artifacts, and model fit quality.

These three views are linked using `crosstalk`, allowing interactive selection of points in error plot and the NLDR plot to highlight corresponding structures in the `langevitour` output. 


::: {.cell}

```{.r .cell-code}
errornldrdt_link <- show_error_link_plots(
  point_data = df_exe, 
  edge_data = trimesh, 
  point_colour = clr_choice
)

class(errornldrdt_link) <- c(class(errornldrdt_link), "htmlwidget")

errornldrdt_link
```
:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![Exploring residuals in relation to UMAP layouts using a $7\text{-}D$ `Scurve` model. Three views are linked: distribution of residuals (a1, b1), UMAP layout (a2, b2), and projection of the $7\text{-}D$ model with data (a3, b3). The purple points highlight selected subsets of the data, which differ across rows. In the top row (a1–a3), points with higher residuals (a1) are selected, corresponding to the sparse bridging region in the UMAP layout (a2) and the less dense end of the `Scurve` in the high-dimensional projection (a3). In the bottom row (b1–b3), points with lower residuals (b1) are highlighted, which map to one side of the dense region in the NLDR layout (b2) and to a thicker band of the `Scurve` in the projection (b3). This comparison illustrates how residuals can help diagnose distortions in UMAP, with high-residual points often concentrated in sparse or stretched regions of the structure.](04-chap4_files/figure-pdf/unnamed-chunk-38-1.pdf){fig-pos='H' width=100%}
:::
:::


As an alternative to using `langevitour`, link plots can also be generated with the `detourr` package. In this setup, users can manually construct the linked visualization using the `crosstalk` [@joe2023] and `htmltools` [@joe2024] packages. The interactive layout is created by arranging the \twoD NLDR plot (`nldr_plt`), the optional error distribution plot (`error_plt`), and the tour view produced with `detourr`, side by side within a flexible grid. The NLDR and error plots are rendered with `ggplotly()` [@chapman2020] to enable interactive linking. The `bscols()` function from `crosstalk` manages synchronization across these panels, allowing for linked brushing and coordinated selection between these interactive plots.

A two-panel linked plot combining the NLDR view and the tour from `detourr` can be created as follows:


::: {.cell}

:::



::: {.cell}

```{.r .cell-code}
detourr_output <- detour(
  shared_df,
  tour_aes(
    projection = starts_with("x"),
    colour = type
  )
) |>
  tour_path(grand_tour(2), 
                    max_bases=50, fps = 60) |>
  show_scatter(axes = TRUE, size = 1, alpha = 0.8, 
               edges = as.matrix(trimesh[, c("from_reindexed", "to_reindexed")]),
               palette = c("#66B2CC", "#FF7755"),
                width = "600px", height = "600px")
```
:::



::: {.cell}

```{.r .cell-code}
lndet_link <- crosstalk::bscols(
    htmltools::div(style="display: grid; grid-template-columns: 1fr 1fr;",
                   nldr_plt,
                   htmltools::div(style = "margin-top: 20px;", detourr_output)
    ),
    device = "xs"
  )


class(lndet_link) <- c(class(lndet_link), "htmlwidget")

lndet_link
```
:::



::: {.cell}
::: {.cell-output-display}
![Screenshots of the link plots showing the relationship between the NLDR layout (left) and the fitted model overlaid with the data in $7\text{-}D$ (right) using `detourr`.](../figures/quollr/model_link_proj1_detourr.png){fig-pos='H' width=100%}
:::

::: {.cell-output-display}
![Screenshots of the link plots showing the relationship between the NLDR layout (left) and the fitted model overlaid with the data in $7\text{-}D$ (right) using `detourr`.](../figures/quollr/model_link_proj2_detourr.png){fig-pos='H' width=100%}
:::
:::


For analyses that include model error visualization, a three-panel view can be constructed by adding the error distribution plot (`error_plt`):


::: {.cell}

:::



::: {.cell}

```{.r .cell-code}
detourr_output <- detour(
  shared_df,
  tour_aes(
    projection = starts_with("x"),
    colour = type
  )
) |>
  tour_path(grand_tour(2), 
                    max_bases=50, fps = 60) |>
  show_scatter(axes = TRUE, size = 1, alpha = 0.8, 
               edges = as.matrix(trimesh[, c("from_reindexed", "to_reindexed")]),
               palette = c("#66B2CC", "#FF7755"),
                width = "500px", height = "500px")

erlndet_link <- crosstalk::bscols(
  htmltools::div(
    style = "display: grid; grid-template-columns: 1fr 1fr 1fr;",
    error_plt, 
    nldr_plt,
    htmltools::div(style = "margin-top: 20px;", detourr_output)
  ),
  device = "xs"
)

class(erlndet_link) <- c(class(erlndet_link), "htmlwidget")

erlndet_link
```
:::



::: {.cell}
::: {.cell-output-display}
![Screenshots of the link plots showing the relationship between the distribution of residuals (left), NLDR layout (middle) and the fitted model overlaid with the data in $7\text{-}D$ (right) using `detourr`.](../figures/quollr/model_link_error_proj1_detourr.png){fig-pos='H' width=100%}
:::

::: {.cell-output-display}
![Screenshots of the link plots showing the relationship between the distribution of residuals (left), NLDR layout (middle) and the fitted model overlaid with the data in $7\text{-}D$ (right) using `detourr`.](../figures/quollr/model_link_error_proj2_detourr.png){fig-pos='H' width=100%}
:::
:::


## Application

Single-cell RNA sequencing (scRNA-seq) is a popular and powerful technology that allows you to profile the whole transcriptome of a large number of individual cells [@andrews2021]. 

Clustering of single-cell data is used to identify groups of cells with similar expression profiles. NLDR often used to summarise the discovered clusters, and help to understand the results. The purpose of this example is to *illustrate how to use our method to help decide on an appropriate NLDR layout that accurately represents the data*.

Limb muscle cells of mice in @tabula2018 are examined. There are $1067$ single cells, with $14997$ gene expressions. Following their pre-processing, different NLDR methods were performed using ten principal components. Figure \@ref(fig:limb-rwbss) (b) is the reproduction of the published plot. The question is whether this accurately represents the cluster structure in the data. Our method help to provide a better \twoD layout. 

<!-- add function to generate 2D trimesh and the projections (PDF) and langevitour (HTML)-->

<!-- https://www.nature.com/articles/s41586-018-0590-4#data-availability -->
<!-- https://figshare.com/articles/dataset/Robject_files_for_tissues_processed_by_Seurat/5821263/1 -->


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

```{.r .cell-code}
design <- gen_design(n_right = 6, ncol_right = 2)

plot_hbe_layouts(plots = list(error_plot_limb, nldr1, 
                               nldr2, nldr3, nldr4, 
                               nldr5, nldr6), design = design)
```

::: {.cell-output-display}
![Assessing which of the 6 NLDR layouts on the limb muscle data is the better representation using RWBSS for varying binwidth ($a_1$). Colour  used for the lines and points in the left plot and in the scatterplots represents NLDR layout (a-f). Layout d is perform well at large binwidth (where the binwidth is not enough to capture the data struture) and poorly as bin width decreases. Layout f is the best choice.\label{fig:limb-rwbss}](04-chap4_files/figure-pdf/limb-rwbss-1.pdf){fig-pos='H' width=100%}
:::
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
![Compare the published $2\text{-}D$ layout (Figure \ref{fig:limb-rwbss}b) and the $2\text{-}D$ layout selected (Figure \ref{fig:limb-rwbss}f) by RWBSS plot (Figure \ref{fig:limb-rwbss}) from the tSNE, UMAP, PHATE, TriMAP, and PaCMAP with different hyper-parameters. The Limb muscle data ($n =  1067$) has seven close different shaped clusters in $10\text{-}D$.](04-chap4_files/figure-pdf/model-limb-1.pdf){fig-pos='H' width=100%}
:::
:::



::: {.cell}

:::



::: {.cell}

:::


## Discussion

The `quollr` package introduces a new framework for interpreting NLDR outputs by fitting a geometric wireframe model in \twoD and lifting it into high-dimensional space. This lifted model provides a direct way to assess how well a \twoD layout, produced by methods such as tSNE, UMAP, PHATE, TriMAP, or PaCMAP, preserves the structure of the original high-dimensional data. The approach offers both numerical and visual diagnostics to support the selection of NLDR methods and tuning hyper-parameters that produce the most accurate \twoD representations.

In contrast to the common practice of visually inspecting scatterplots for clusters or patterns, `quollr` provides a quantitative route for evaluation. It enables the computation of RWBSS and residuals between the original high-dimensional data and the lifted model, offering interpretable diagnostics. These diagnostics are complemented by interactive linked plots and high-dimensional dynamic visualizations using the `langevitour` package, allowing users to inspect where the model fits well and where it does not.

To support efficient computation, particularly for large-scale datasets, several core functions in `quollr` are implemented in C++ using `Rcpp` and `RcppArmadillo`. These include functions for computing Euclidean distances in high-dimensional and \twoD space, identifying nearest centroids, calculating residual errors, and generating polygonal coordinates of hexagons. For instance, `compute_highd_dist()` accelerates nearest neighbor lookup in high-dimensional space, `compute_errors()` calculates RWBSS and total absolute error efficiently, and `calc_2d_dist_cpp()` speeds up distance calculations in \twoD. Additionally, `gen_hex_coord_cpp()` constructs the coordinates for hexagonal bins based on their centroids with minimal overhead. These optimizations result in substantial performance gains compared to native R implementations, making the package responsive even when used in interactive contexts or on large datasets such as single-cell transcriptomic profiles.

The modular structure of the package is designed to support both flexibility and reproducibility. Users can access individual functions to control each step of the pipeline such as scaling, binning, and triangulation or use the main function `fit_highd_model()` for end-to-end model construction. The diagnostics can be used not only to compare NLDR methods but also to tune binning parameters, assess layout stability, and detect local distortions in the embedding.

There are several avenues for future development. While hexagonal binning provides a regular structure conducive to modeling, alternative spatial discretizations (e.g., adaptive binning or density-aware tessellations) could be explored to better capture varying data densities. Expanding support for additional distance metrics in the lifting and prediction steps may improve performance across different domains. Additionally, statistical inference tools could be introduced to assess the stability and robustness of the fitted model, which would enhance interpretability and confidence in the outcomes. 

## Acknowledgements

The source code for reproducing this paper can be found at: [https://github.com/JayaniLakshika/paper-quollr](https://github.com/JayaniLakshika/paper-quollr). This article is created using \CRANpkg{knitr} [@yihui2015] and \CRANpkg{rmarkdown} [@yihui2018] in R with the `rjtools::rjournal_article` template. These `R` packages were used for this work: `cli` [@gabor2025], `dplyr` [@hadley2023], `ggplot2` [@hadley2016], `interp` (>= 1.1-6) [@albrecht2024], `langevitour` [@paul2023], `proxy`[@david2022], `stats` [@core2025], `tibble` [@kirill2023], `tidyselect` [@lionel2024], `crosstalk` [@joe2023], `plotly` [@chapman2020], `htmltools` [@joe2024], `kableExtra` [@hao2024], `patchwork` [@thomas2024], and `readr` [@hadley2024].
