# Appendix: Choosing Better NLDR Layouts by Evaluating the Model in the High-dimensional Data Space {#sec-appendix-a}






::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


## Methods and hyper-parameters used to generate layouts

@tbl-fig-param contains the list of methods and hyper-parameters used for each of the layouts shown in the paper. 


::: {#tbl-fig-param .cell layout-align="center" tbl-pos='H' tbl-cap='NLDR methods and hyper-parameters used for each Figure in the main paper.'}
::: {.cell-output-display}
`````{=html}
<table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;font-weight: bold;"> Figure </th>
   <th style="text-align:left;font-weight: bold;"> NLDR method </th>
   <th style="text-align:left;font-weight: bold;"> Hyper-parameter(s) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1a </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, min_dist = 0.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1b </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 5, min_dist = 0.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1c </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 5, min_dist = 0.01 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1d </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1e </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1f </td>
   <td style="text-align:left;"> PHATE </td>
   <td style="text-align:left;"> knn = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1g </td>
   <td style="text-align:left;"> TriMAP </td>
   <td style="text-align:left;"> n_inliers = 12, n_outliers = 4, n_random = 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1h </td>
   <td style="text-align:left;"> PaCMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, init = random, MN_ratio = 0.9, FP_ratio = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 47 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4a </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 47 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5b </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 47 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 47 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8a </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 47 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8b </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 62 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8c </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 15, min_dist = 0.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8d </td>
   <td style="text-align:left;"> PHATE </td>
   <td style="text-align:left;"> knn = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8e </td>
   <td style="text-align:left;"> TriMAP </td>
   <td style="text-align:left;"> n_inliers = 12, n_outliers = 4, n_random = 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8f </td>
   <td style="text-align:left;"> PaCMAP </td>
   <td style="text-align:left;"> n_neighbors = 10, init = random, MN_ratio = 0.5, FP_ratio = 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10a </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, min_dist = 0.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10b </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 5, min_dist = 0.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10c </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 5, min_dist = 0.01 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10d </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10e </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10f </td>
   <td style="text-align:left;"> PHATE </td>
   <td style="text-align:left;"> knn = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10g </td>
   <td style="text-align:left;"> TriMAP </td>
   <td style="text-align:left;"> n_inliers = 12, n_outliers = 4, n_random = 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10h </td>
   <td style="text-align:left;"> PaCMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, init = random, MN_ratio = 0.9, FP_ratio = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11a </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, min_dist = 0.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11e </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12a </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12b </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 89 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12c </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 15, min_dist = 0.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12d </td>
   <td style="text-align:left;"> PHATE </td>
   <td style="text-align:left;"> knn = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12e </td>
   <td style="text-align:left;"> TriMAP </td>
   <td style="text-align:left;"> n_inliers = 12, n_outliers = 4, n_random = 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12f </td>
   <td style="text-align:left;"> PaCMAP </td>
   <td style="text-align:left;"> n_neighbors = 10, init = random, MN_ratio = 0.5, FP_ratio = 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13a </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14a </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A4a </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 71 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A4b </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 15, min_dist = 0.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A4c </td>
   <td style="text-align:left;"> PaCMAP </td>
   <td style="text-align:left;"> n_neighbors = 10, init = random, MN_ratio = 0.5, FP_ratio = 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A5 </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 52 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A6a </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, min_dist = 0.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A6b </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A7a </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, min_dist = 0.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A7b </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A8a </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, min_dist = 0.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A8b </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9a </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, min_dist = 0.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9b </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 5, min_dist = 0.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9c </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 5, min_dist = 0.01 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9d </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9e </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9f </td>
   <td style="text-align:left;"> PHATE </td>
   <td style="text-align:left;"> knn = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9g </td>
   <td style="text-align:left;"> TriMAP </td>
   <td style="text-align:left;"> n_inliers = 12, n_outliers = 4, n_random = 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A9h </td>
   <td style="text-align:left;"> PaCMAP </td>
   <td style="text-align:left;"> n_neighbors = 30, init = random, MN_ratio = 0.9, FP_ratio = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A10a </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A10b </td>
   <td style="text-align:left;"> tSNE </td>
   <td style="text-align:left;"> perplexity = 89 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A10c </td>
   <td style="text-align:left;"> UMAP </td>
   <td style="text-align:left;"> n_neighbors = 15, min_dist = 0.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A10d </td>
   <td style="text-align:left;"> PHATE </td>
   <td style="text-align:left;"> knn = 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A10e </td>
   <td style="text-align:left;"> TriMAP </td>
   <td style="text-align:left;"> n_inliers = 12, n_outliers = 4, n_random = 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A10f </td>
   <td style="text-align:left;"> PaCMAP </td>
   <td style="text-align:left;"> n_neighbors = 10, init = random, MN_ratio = 0.5, FP_ratio = 2 </td>
  </tr>
</tbody>
</table>

`````
:::
:::


## Videos links

Animations of the \pD{} tours that produced specific projections shown in some figures in the main paper are available on YouTube at the links given in @tbl-links.


::: {#tbl-links .cell layout-align="center" tbl-pos='H' tbl-cap='Videos of the langevitour animations and the linked plots.'}
::: {.cell-output-display}
`````{=html}
<table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;font-weight: bold;"> Figure </th>
   <th style="text-align:left;font-weight: bold;"> URL </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> <a href="https://youtu.be/yHKTHK4UBiU">youtu.be/yHKTHK4UBiU</a> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> <a href="https://youtu.be/FukiminrO90">youtu.be/FukiminrO90</a> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> <a href="https://youtu.be/3VfK3M2gnZM">youtu.be/3VfK3M2gnZM</a>, <a href="https://youtu.be/Es84bwQcndU">youtu.be/Es84bwQcndU</a> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> <a href="https://youtu.be/sUcGd57Swdg">youtu.be/sUcGd57Swdg</a>, <a href="https://youtu.be/QiklCjELUxo">youtu.be/QiklCjELUxo</a> </td>
  </tr>
</tbody>
</table>

`````
:::
:::


## Notation


::: {#tbl-notation .cell layout-align="center" tbl-pos='H' tbl-cap='Summary of notation for describing new methodology.'}
::: {.cell-output-display}
`````{=html}
<table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;font-weight: bold;"> Notation </th>
   <th style="text-align:left;font-weight: bold;"> Description </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> $n, p, k$ </td>
   <td style="text-align:left;"> number of observations, variables, embedding dimension, respectively </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $\mathbfit{X}, \mathbfit{x}$ </td>
   <td style="text-align:left;"> $p$-dimensional data (population, sample) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $\mathbfit{y}$ </td>
   <td style="text-align:left;"> $k$-dimensional layout </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $P$ </td>
   <td style="text-align:left;"> orthonormal basis, generating a $d\text{-}dimensional$ linear projection of $p$-dimensional data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $T$ </td>
   <td style="text-align:left;"> true  model </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $g$ </td>
   <td style="text-align:left;"> functional mapping from \pD{} to \kD{}, especially as prescribed by NLDR </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $\mathbfit{\theta}$ </td>
   <td style="text-align:left;"> (Hyper-) parameters for NLDR method </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $r$ </td>
   <td style="text-align:left;"> ranges of the embedding components </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $C^{(j)}$ </td>
   <td style="text-align:left;"> $j$-dimensional bin centers </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $(b_1, b_2)$ </td>
   <td style="text-align:left;"> number of bins in each direction </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $(a_1, a_2)$ </td>
   <td style="text-align:left;"> binwidths, distance between centroids in each direction </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $(s_1, \ s_2)$ </td>
   <td style="text-align:left;"> starting coordinates of the hexagonal grid </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $q$ </td>
   <td style="text-align:left;"> buffer to ensure hexgrid covers data, proportion of data range, 0-1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $m$ </td>
   <td style="text-align:left;"> number of non-empty bins </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $b$ </td>
   <td style="text-align:left;"> number of  hexagons in the grid </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $h$ </td>
   <td style="text-align:left;"> hexagonal id </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $l$ </td>
   <td style="text-align:left;"> side length </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $A$ </td>
   <td style="text-align:left;"> area </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $n_h$ </td>
   <td style="text-align:left;"> number of points in hexagon $h$ (bin count) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $w_h$ </td>
   <td style="text-align:left;"> standardized number of points in hexagon $h$ (standardized bin counts) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> $d_h$ </td>
   <td style="text-align:left;"> density of hexagon $h$ (bin density) </td>
  </tr>
</tbody>
</table>

`````
:::
:::


## Scripts


::: {#tbl-script-desc .cell layout-align="center" tbl-pos='H' tbl-cap='R and Python script files used to generate outputs in the main paper.'}
::: {.cell-output-display}
`````{=html}
<table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;font-weight: bold;"> Folder </th>
   <th style="text-align:left;font-weight: bold;"> Script </th>
   <th style="text-align:left;font-weight: bold;"> Description </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> script </td>
   <td style="text-align:left;"> additional_functions.R </td>
   <td style="text-align:left;"> Helper functions to render the main paper. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> script </td>
   <td style="text-align:left;"> evaluation.py </td>
   <td style="text-align:left;"> Python script implementing additional evaluation metrics such as RTA and GS. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> script </td>
   <td style="text-align:left;"> nldr_code.R </td>
   <td style="text-align:left;"> Wrapper functions for running multiple NLDR methods (UMAP, tSNE, PHATE, PaCMAP, TriMAP) with different parameters. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 01_gen_data.R </td>
   <td style="text-align:left;"> Generates the 2NC7 dataset. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 02_gen_true_model.R </td>
   <td style="text-align:left;"> Creates the true structure of 2NC7 data. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 03_gen_embeddings.R </td>
   <td style="text-align:left;"> Computes multiple NLDR embeddings for the 2NC7 data. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 04_gen_mse_for_diff_methods.R </td>
   <td style="text-align:left;"> Computes HBE with varying bin widths ($a_1$) for all NLDR embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 05_gen_rm_lwd_mse.R </td>
   <td style="text-align:left;"> Computes HBE with varying low density bin cutoff for all three binwidth ($a_1$) choices. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 06_gen_model_with_tSNE.R </td>
   <td style="text-align:left;"> Fits the model for the layout a. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 07_example_evaluation_metrics.R </td>
   <td style="text-align:left;"> Calculates evaluation metrics for all NLDR layouts. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> two_nonlinear </td>
   <td style="text-align:left;"> 08_gen_model_with_PHATE.R </td>
   <td style="text-align:left;"> Fits the model for the layout c. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> five_gau_clusters </td>
   <td style="text-align:left;"> 01_five_gaussian_cluster_data_emb.R </td>
   <td style="text-align:left;"> Generates data and multiple NLDR embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> five_gau_clusters </td>
   <td style="text-align:left;"> 02_gen_model_with_tSNE.R </td>
   <td style="text-align:left;"> Fits the model for the layout a. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> five_gau_clusters </td>
   <td style="text-align:left;"> 03_gen_model_with_UMAP.R </td>
   <td style="text-align:left;"> Fits the model for the layout b. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> five_gau_clusters </td>
   <td style="text-align:left;"> 04_gen_model_with_PaCMAP.R </td>
   <td style="text-align:left;"> Fits the model for the layout c. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> c_shaped_dens_str </td>
   <td style="text-align:left;"> 01_gen_data.R </td>
   <td style="text-align:left;"> Generates the $2\text{-}D$ curved sheet dataset. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> c_shaped_dens_str </td>
   <td style="text-align:left;"> 02_gen_embeddings_uni_dens.R </td>
   <td style="text-align:left;"> Generates multiple NLDR embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> c_shaped_dens_str </td>
   <td style="text-align:left;"> 03_gen_model_with_tSNE.R </td>
   <td style="text-align:left;"> Fits the model for the tSNE layout. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 01_obtain_pca_author.R </td>
   <td style="text-align:left;"> Obtains  author's PCA results. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 02_obtain_umap_authors.R </td>
   <td style="text-align:left;"> Obtains  author's UMAP embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 03_gen_umap_diff_param.R </td>
   <td style="text-align:left;"> Generates multiple UMAP embeddings with different hyper-parameter values. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 04_gen_tsne_diff_param.R </td>
   <td style="text-align:left;"> Generates multiple tSNE embeddings with different hyper-parameter values. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 05_gen_phate.R </td>
   <td style="text-align:left;"> Generates a PHATE embeddings with default hyper-parameters. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 06_gen_trimap.R </td>
   <td style="text-align:left;"> Generates a TriMAP embeddings with default hyper-parameters. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 07_gen_pacmap.R </td>
   <td style="text-align:left;"> Generates a PaCMAP embeddings with default hyper-parameters. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 08_gen_mse_for_diff_methods.R </td>
   <td style="text-align:left;"> Computes HBE with varying bin widths ($a_1$) for all NLDR embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 09_gen_scDEED.R </td>
   <td style="text-align:left;"> Generates UMAP embeddings from scDEED results. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 10_pre_process_for_embedding.R </td>
   <td style="text-align:left;"> Generates PBMC3k data used for scDEED results. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 11_gen_mse_for_diff_tsne_scD.R </td>
   <td style="text-align:left;"> Computes HBE with varying bin widths ($a_1$) for tSNE embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 12_gen_mse_for_diff_umap_scD.R </td>
   <td style="text-align:left;"> Computes HBE with varying bin widths ($a_1$) for UMAP embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 13_gen_model_with_UMAP.R </td>
   <td style="text-align:left;"> Fits the model for the layout a. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 14_gen_model_with_tSNE.R </td>
   <td style="text-align:left;"> Fits the model for the layout e. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 15_gen_model_with_UMAP_scD.R </td>
   <td style="text-align:left;"> Fits the model for the layout a. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 16_gen_model_with_tSNE_scD.R </td>
   <td style="text-align:left;"> Fits the model for the layout b. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 17_evaluation_metrics.R </td>
   <td style="text-align:left;"> Calculates evaluation metrics for all NLDR layouts. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pbmc3k </td>
   <td style="text-align:left;"> 18_evaluation_metrics_scD.R </td>
   <td style="text-align:left;"> Calculates evaluation metrics for all NLDR layouts. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mnist </td>
   <td style="text-align:left;"> 01_data_preprocessing.R </td>
   <td style="text-align:left;"> Computes first $10$ principal components and save data. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mnist </td>
   <td style="text-align:left;"> 02_gen_diff_embeddings.R </td>
   <td style="text-align:left;"> Generates multiple NLDR embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mnist </td>
   <td style="text-align:left;"> 03_gen_mse_for_diff_methods.R </td>
   <td style="text-align:left;"> Computes HBE with varying bin widths ($a_1$) for all NLDR embeddings. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mnist </td>
   <td style="text-align:left;"> 04_gen_model_with_tSNE.R </td>
   <td style="text-align:left;"> Fits the model for the layout a. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mnist </td>
   <td style="text-align:left;"> 05_evaluation_metrics.R </td>
   <td style="text-align:left;"> Calculates evaluation metrics for all NLDR layouts. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mnist </td>
   <td style="text-align:left;"> 06_link_brush_layout_e.R </td>
   <td style="text-align:left;"> Creates interactive linked brushing with layout e. </td>
  </tr>
</tbody>
</table>

`````
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
`````{=html}
<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Parameter </th>
   <th style="text-align:left;"> Value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> \(n_{neighbors}\) </td>
   <td style="text-align:left;"> 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> \(\theta\) </td>
   <td style="text-align:left;"> 0.5 </td>
  </tr>
</tbody>
</table>

`````
:::
:::


## Generating the 2NC7 data

This data is constructed by simulating two clusters, each consisting of $1000$ observations. The C-shaped cluster is generated from $\theta \sim U(\text{-}3\pi/2, 0)$, $X_1 = \sin(\theta)$, $X_2 \sim U(0, 2)$ (adding thickness to the C), $X_3 = \text{sign}(\theta) \times (\cos(\theta) - 1)$, $X_4 = \cos(\theta)$. Observations lie on a \gD{} manifold in \sD{}. The other cluster is from $X_1 \sim U(0, 2)$, $X_2 \sim U(0, 3)$, $X_3 = \text{-}(X_1^3 + X_2)$, and $X_4 \sim U(0, 2)$. It is also curved, but observations lie on a \tD{} manifold in \sD{}. Three more variables, $X_5, X_6, X_7$, that are small amounts of pure noise are added. We would consider $T=(X_1, X_2, X_3, X_4)$ to be the geometric structure (true model) that we hope to capture (@fig-true-data).


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Two projections of the \pD{} true model overlaying the data are shown in a, b. Video of the langevitour animations is available at <https://youtu.be/35TrnYJsUUI>.](B-appB_files/figure-html/fig-true-data-1.png){#fig-true-data fig-align='center' width=100%}
:::
:::


## Computing hexagon grid configurations

Given range of embedding component, $r_2$, number of bins along the x-axis, $b_1$, and buffer proportion, $q$, hexagonal starting point coordinates, $s_1 = \text{-}q$, and $s_2 = \text{-}qr_2$. The purpose is to find width of the hexagon, $a_1$ and number of bins along the y-axis, $b_2$.

Geometric arguments give rise to the following constraints.

$\text{min }a_1 \text{ s.t.}$

$$
s_1 - \frac{a_1}{2} < 0,
$$ {#eq-equation1}

$$
s_1 + (b_1 - 1) \times a_1 \geq 1,
$$ {#eq-equation2}

$$
s_2 - \frac{a_2}{2} < 0,
$$ {#eq-equation4}

$$
s_2 + (b_2 - 1) \times a_2 \geq r_2.
$$ {#eq-equation5}





::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


Since $a_1$ and $a_2$ are distances,

$$
a_1, a_2 > 0.
$$ Also, $(s_1, s_2) \in (\text{-}0.1, \text{-}0.05)$ as these are multiplicative offsets in the negative direction.

@eq-equation1 can be rearranged as,

$$
a_1 > 2s_1
$$

which given $s_1 < 0$ and $a_1 > 0$ will *always* be true. The same logic follows for @eq-equation4 and substituting $a_2 = \sqrt{3}a_1/{2}$, and $s_2 = \text{-}qr_2$ to @eq-equation4 can be written as,

$$
a_1 > -\frac{4}{\sqrt{3}}qr_2
$$

Also, substituting $a_2 = \sqrt{3}a_1/{2}$, $s_2 = \text{-}qr_2$ and rearranging @eq-equation5 gives:

$$
a_1 \geq \frac{2(r_2 + qr_2)}{\sqrt{3}(b_2 - 1)}.
$$ {#eq-equation6}

Similarly, substituting $s_1 = \text{-}q$ @eq-equation2 becomes,

$$
a_1 \geq \frac{(1 + q)}{(b_1 - 1)}.
$$ {#eq-equation7}

This is a linear optimization problem. Therefore, the optimal solution must occur on a vertex. So, by setting @eq-equation6 equals to @eq-equation7 gives,

$$
\frac{2(r_2 + qr_2)}{\sqrt{3}(b_2 - 1)} = \frac{(1 + q)}{(b_1 - 1)}.
$$ 

After rearranging this,

$$
b_2 = 1 + \frac{2r_2(b_1 - 1)}{\sqrt{3}}
$$

and since $b_2$ should be an integer,

$$
b_2 = \Big\lceil1 +\frac{2r_2(b_1 - 1)}{\sqrt{3}}\Big\rceil.
$$ {#eq-equation8}

Furthermore, with known $b_1$ and $b_2$, by considering @eq-equation2 or @eq-equation5 as the *binding* or *active constraint*, can compute $a_1$.

If @eq-equation2 is active, then,

$$
\frac{(1 + q)}{(b_1 - 1)} < \frac{2(r_2 + qr_2)}{\sqrt{3}(b_2 - 1)}.
$$

Rearranging this gives,

$$
r_2 > \frac{\sqrt{3}(b_2 - 1)}{2(b_1 - 1)}.
$$

Therefore, if this equality is true, then 
$$
a_1 = \frac{(1+q)}{(b_1 - 1)},
$$
otherwise, 
$$
a_1 = \frac{2r_2(1+q)}{\sqrt{3}(b_2 - 1)}.
$$

## Binning the data

Points are assigned to the bin they fall into based on the nearest centroid. If a point is equidistant from multiple centroids, it is assigned to the centroid with the smallest bin ID.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Binning the data. Points are assigned to the nearest centroid. If a point is equidistant from multiple centroids, assigned to the centroid with the smallest bin ID.](B-appB_files/figure-html/fig-assign-data-1.png){#fig-assign-data fig-align='center' fig-pos='!ht' width=100%}
:::
:::


## Area of a hexagon

The area of a hexagon is defined as $A = 3\sqrt{3}l^2/2$, where $l$ is the side length of the hexagon. $l$ can be computed using $a_1$ and $a_2$.



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The components of the right triangle illustrating notation.](B-appB_files/figure-html/fig-tri-param-1.png){#fig-tri-param fig-align='center' fig-pos='!ht' width=30%}
:::
:::


By applying the Pythagorean theorem, we obtain,

$$
l^2 = \left(\frac{a_1}{2}\right)^2 + \left(\frac{a_2 - l}{2}\right)^2.
$$
Next, rearranging the terms, we get,

$$
l^2 - \left(\frac{a_2 - l}{2}\right)^2 = \left(\frac{a_1}{2}\right)^2,
$$

$$
\left[l - \left(\frac{a_2 - l}{2}\right)\right]\left[l + \left(\frac{a_2 - l}{2}\right)\right] = \left(\frac{a_1}{2}\right)^2,
$$

$$
3l^2 + 2a_2l - (a_1^2 + a_2^2) = 0.
$$

Finally, by solving the quadratic equation, we compute,

$$
l = \frac{-2a_2 \pm \sqrt{4a_2^2 - 24[-(a_1^2 + a_2^2)]}}{6},
$$

$$
l = \frac{-a_2 \pm \sqrt{a_2^2 - 6[-(a_1^2 + a_2^2)]}}{3},
$$

where $l > 0$.

## Curiosities about NLDR results discovered by examining the model in the data space {#sec-curiosities}

With the drawing of the model in the data, several interesting differences between NLDR methods can be observed.

### Some methods appear to order points in the layout

The \gD{} model representations generated from some NLDR methods, especially PaCMAP, are unreasonably flat or like a pancake. A simple example of this can be seen with data simulated to contain five \fD{} Gaussian clusters. Each cluster is essentially a ball in \fD{}, so there is no \gD{} representation, rather the model in each cluster should resemble a crumpled sheet of paper that fills out \fD{}.

@fig-five-gau-projs a1, b1, c1 show the \gD{} layouts for (a) tSNE, (b) UMAP, and (c) PaCMAP, respectively. The default hyper-parameters for each method are used. In each layout we can see an accurate representation where all five clusters are visible, although with varying degrees of separation.

The models are fitted to each these layouts. @fig-five-gau-projs a2, b2, c2 show the fitted models in a projection of the \fD{} space, taken from a tour. These clusters are fully \fD{} in nature, so we would expect the model to be a *crumpled sheet* that stretches in all four dimensions. This is what is mostly observed for tSNE and UMAP. The curious detail is that the model for PaCMAP is closer to a *pancake* in shape in every cluster! This single projection only shows this in three of the five clusters but if we examine a different projection the other clusters exhibit the pancake also. While we don't know what exactly causes this, it is likely due to some ordering of points in the \gD{} PaCMAP layout that induces the flat model. One could imagine that if the method used principal components on all the data, that it might induce some ordering that would produce the flat model. If this were the reason, the pancaking would be the same in all clusters, but it is not: The pancake is visible in some clusters in some projections but in other clusters it is visible in different projections. It might be due to some ordering by nearest neighbors in a cluster. The PaCMAP documentation doesn't provide any helpful clues. That this happens, though, makes the PaCMAP layout inadequate for representing the high-dimensional data. 

<!--Projections-->
<!--five_gau_clusters/02_gen_model_with_tSNE.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


<!--five_gau_clusters/03_gen_model_with_UMAP.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


<!--five_gau_clusters/04_gen_model_with_PaCMAP.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![NLDR's organize points in the \gD{} layout in different ways, possibly misleadingly, illustrated using three layouts: (a) tSNE, (b) UMAP, (c) PaCMAP. The data has five Gaussian clusters in \fD{}. The bottom row of plots shows a \gD{} projection from a tour on \fD{} revealing the differences generated by the layouts on the model fits.  We would expect the model fit to be like that in (a2) where it is distinctly is separate for each cluster but like a hairball in each. This would indicate the distinct clusters, each being fully \fD{}. With (c2), the curiousity is that the model is a \gD{} pancake shape in \fD{}, indicating that there is some ordering of points done by PaCMAP, posisbly along some principal component axes. Videos of the langevitour animations are available at <https://youtu.be/I-kxCwVfqiQ>, <https://youtu.be/gD1P01FUPyU>, and <https://youtu.be/MxJ_srOFQNk> respectively.](B-appB_files/figure-html/fig-five-gau-projs-1.png){#fig-five-gau-projs fig-align='center' fig-pos='!ht' width=100%}
:::
:::


### Sparseness creates a contracted \gD{} layout {#sec-effect-dens}

Differences in density can arise by sampling at different rates in different subspaces of \pD{}. For example, the data shown in @fig-one-dens_clust-error all lies on a \gD{} curved sheet in \fD{}, but one end of the sheet is sampled densely and the other very sparsely. It was simulated to illustrate the effect of the density difference on layout generated by an NLDR, illustrated using the tSNE results, but it happens with all methods. 

@fig-one-dens_clust-error (a2, b2) shows a \gD{} layout for tSNE created using the default hyper-parameters. One would expect to see a rectangular shape if the curved sheet is flattened, but the layout is triangular. The other two displays show the residuals as a dot density plot (a1, b1), and a \gD{} projection of the data and the model from \fD{} (a3, b3). Using linked brushing between the plots, we can highlight points in the tSNE layout, and examine where they fall in the original \fD{}. The darker (maroon) points indicate points that have been highlighted by linking. In row a, the points at the top of the triangle are highlighted, and we can see these correspond to higher residuals, and also to all points at the low density end of the curved sheet. In row b, points at the lower left side of the triangle are highlighted which corresponds to smaller residuals and one corner of the sheet at the high density end of the curved sheet. 

The tSNE behaviour is to squeeze the low density area of the data together into the layout. This is common in other NLDR methods also, which means analysts need to be aware that if their data is not sampled relatively uniformly, apparent closeness in the \gD{} may correspond to sparseness in \pD{}.

<!--c_shaped_dens_str/03_gen_model_with_tSNE.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Exploring the effect of density on the NLDR layout using a \gD{} curved sheet in \fD{} with different density at each end. Three plots are linked: density plot of residuals (a1, b1), NLDR layout (a2, b2), projection of \fD{} model and data (a3, b3). The brown points indicate the selected set, which are different in each row. In (a2), the top part of the triangular shape is selected which corresponds to higher residuals (a1) and the sparse end of the structure (a3). In (b2) one of other corners is highlighted, which can be seen to correspond to low residuals (b1) and one side of the dense end of the data (b3). While the tSNE layout represents the dense end of the sheet correctly as two corners in the layout, it contracts the sparse end of the sheet into a single corner. Video of the langevitour animation is available at <https://youtu.be/-KsQH0rII2A>.](B-appB_files/figure-html/fig-one-dens_clust-error-1.png){#fig-one-dens_clust-error fig-align='center' fig-pos='!ht' width=100%}
:::
:::



## PBMC3k: comparison with results of scDEED recommendations

<!-- ### Comparison with results of scDEED recommendations -->

<!-- XXX What this section needs: -->

<!-- - connect this with previous section, not make it seem like a completely new. connections are: nldr used to show clustering, scDEED provides a different approach to decide which is best. -->
<!-- - why these two? assume one is the published figure, and second is one recommended by scDEED, which our results confirm is better. -->
<!-- - Refer to figure in text -->
<!-- - Fig 16 not necessary -->

<!-- CHANGES WERE MADE BASED ON THIS THINKING -->



<!-- <!-- In the field of single-cell studies, clustering is a common analytical task used to identify groups of cells with similar expression profiles. Non-linear dimensional reduction (NLDR) methods are frequently employed to visualize these clusters and help validate the results. However, it is well known that the 2D embeddings produced by t-SNE and UMAP may not accurately reflect the similarities among cell clusters. ALREADY STATED IN PREVIOUS SECTION -->  

As we were writing this paper @xia2023 appeared proposing a new method called scDEED helping to assess the validity of a \gD{} embedding. scDEED calculates a reliability score for each cell embedding based on the similarity between the cell’s \gD{} embedding neighbors and its neighbors prior to embedding. A low reliability score suggests a dubious embedding. It can help in the deciding on optimal hyper-parameters. Here we illustrate how our method compares with the results from scDEED.

Note that @xia2023 uses a different PBMC dataset than that used by @chen2024, shown by us in the main paper example, which is why this comparison is shown here and not in the main paper. Their data contains $31,021$ cells including cell type labels, and the gene expression levels were in the unit of log-transformed UMI count per $10,000$. They focused on three sequencing methods (inDrops, DropSeq, and SeqWell) and four common cell types Cytotoxic T cell, CD4+T cell, CD14+ Monocyte, and B cell. Pre-processing follows the process in @xia2023 again using the Human Peripheral Blood Mononuclear Cells (PBMC) data. 

For illustration purposes, we only selected cells generated with inDrops ($n=5858$ cells). Also, @xia2023 used first $9$ principal components to generate the UMAP and tSNE with default hyper-parameters. The objective is to what scDEED suggests is the best layout with what HBE would choose. Layout a (@fig-pbmc-mse-umap) is generated from the hyper-parameters suggested by @chen2024, and layout b (@fig-pbmc-mse-umap) is with suggested hyper-parameters by scDEED to be more accurate. <!--Layouts a and b contain $46$ and $83$ dubious cells respectively.--> The HBE vs binwidth ($a_1$) plot (@fig-pbmc-mse-umap) illustrates that our approach would suggest that scDEED is correct here, that layout b is more accurately reflecting the cluster structure in the PBMC data. This is also supported by examining the models in the data space as shown in @fig-model-pbmc-author-proj.

<!-- @fig-pbmc-mse-umap compares the metrics rARNX, rRTA, rSC, rGS, along with HBE computed on $a_1=0.04$. This is a parallel coordinate plot where the y-axis shows a normalized score to ensure the metrics are on the same scale. Each line corresponds to one layout. Most metrics (rSC, rARNX, and HBE) consistently indicate that the optimized layout (b) provides a better representation, while rRTA, and rGS slightly favor the published layout. -->


::: {.cell layout-align="center"}

:::


<!--pbmc3k/11_gen_mse_for_diff_tsne_scD.R-->
<!--pbmc3k/11_gen_mse_for_diff_umap_scD.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Comparing the published layout (a) with what would be suggested to be optimal by scDEED (b), using HBE for varying (i) binwidth ($a_1$), and (ii) average bin count ($\bar{n}_h$), on a subset of PBMC3k data. Color represents NLDR layouts. HBE would corroborate that the scDEED optimized layout is better than what was originally published. Plot (ii), which accounts for the density within clusters by using average bin count, shows reduced differences between layouts, indicating that part of the variation in (i) is driven by cluster density rather than true structural differences. Comparison of scaled evaluation metrics (iii) (rRTA, rSC, rGS, rARNX, and HBE using $a_1=0.04$) for two NLDR layouts of the PBMC3k data the originally published layout (a) and the scDEED optimized layout (b). Each line represents a layout, with color matching the corresponding scatterplots. Most metrics (rSC, rARNX, and HBE) consistently indicate that the optimized layout (b) provides a better representation, while rRTA, and rGS slightly favor the published layout.](B-appB_files/figure-html/fig-pbmc-mse-umap-1.png){#fig-pbmc-mse-umap fig-align='center' fig-pos='!ht' width=100%}
:::
:::


<!--pbmc3k/15_gen_model_with_UMAP_scD.R-->

::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}

:::


<!--pbmc3k/16_gen_model_with_tSNE_scD.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Compare the published \gD{} layout (@fig-pbmc-mse-umap a) made with UMAP and the \gD{} layout made with tSNE selected as optimal by scDEED (@fig-pbmc-mse-umap b) and also HBE (@fig-pbmc-mse-umap). The two plots on the right show projections from a tour, with the models overlaid. The published layout a suggested three separated clusters with two of them are close, but this is not present in the data. While there may be three clusters they are not well-separated. The difference in model fit also indicates this: the published layout a does not capture the nonlinear structure of the clusters like the model generated from layout b. This supports the choice that layout b is the better representation of the data, because it shows close clusters. Videos of the langevitour animations are available at <https://youtu.be/ffiB4MGWyn8> and <https://youtu.be/e7XNL18co1c> respectively.](B-appB_files/figure-html/fig-model-pbmc-author-proj-1.png){#fig-model-pbmc-author-proj fig-align='center' fig-pos='!ht' width=90%}
:::
:::


## Compare HBE with existing evaluation metrics

@fig-comp-metric-pbmc and @fig-comp-metric-mnist compare HBE with commonly used evaluation metrics such as rRTA, rARNX, rSC, and rGS across multiple NLDR layouts. These visual comparisons highlight that HBE behaves differently from these existing metrics due to the different settings involved.


::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Comparison of scaled evaluation metrics (rRTA, rSC, rGS, rARNX, and HBE with $a_1 = 0.06$) for the eight NLDR layouts computed on the PBMC3k data, shown as a parallel coordinate plot. The color of each line corresponds to a NLDR layout. All, except rGS and rARNX agree that layout e is best or very close to best. Layout d is best according to HBE and rARNX but considered to be much less optimal by rRTA, rSC and rGS. Layout f is considered poor by rARNX and HBE. Layout a is cosidered close to the best by rGS and rSC.](B-appB_files/figure-html/fig-comp-metric-pbmc-1.png){#fig-comp-metric-pbmc fig-align='center' fig-pos='!ht' width=100%}
:::
:::




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Comparison of scaled evaluation metrics (rARNX, rRTA, rSC, rGS, and HBE using $a_1=0.04$) for six NLDR layouts computed on the MNIST digit 1 data using a parallel coordinate plot. Each line represents a layout (a–f), with colors corresponding to the scatterplots shown on the right. The metrics display different ranking patterns, indicating that no single measure fully captures embedding quality. Layout a is identified as the best according to HBE and rRTA, but is considered much less optimal by rARNX, rSC, and rGS. Layout e is considered the worst, or close to the poorest, by all metrics. Layouts a and f show similar patterns of agreement across metrics, except for rRTA, where layout a performs the best and layout f the worst. Layout c is the worst in rARNX, rSC, and HBE.](B-appB_files/figure-html/fig-comp-metric-mnist-1.png){#fig-comp-metric-mnist fig-align='center' fig-pos='!ht' width=100%}
:::
:::

