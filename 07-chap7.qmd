# Conclusion and future plans {#sec-conclusion}

The five pieces of work assembled in this thesis share a common theme of advancing Non-linear dimension reduction (NLDR) diagnostics, with a focus on improving the NLDR methods, visual inference, and developing innovative solutions to automate diagnostic processes.

## Contributions

The primary contributions of this research are fivefold. Firstly, we develop an algorithm. Secondly, we develop a package. Next, package for high-dimensional data structures. Then, a user study to explore perception and misperception in NLDR representations. Lastly, we share a user-focused R package and Shiny app, making the automated diagnostic tools accessible to a broad range of analysts and practitioners.

The aforementioned R package (and its dependency) is available on CRAN with the latest development versions in the links below:

- `quollr` (<https://github.com/jayanilakshika/quollr>), and
- `cardinalR` (<https://github.com/jayanilakshika/cardinalR>).

The Shiny app for `quollr` is available at one of the mirror sites listed at <https://vimror.netlify.app/> with the source code available at <https://github.com/jayanilakshika/ViMRoR>.

Principles of transparency and reproducible research have guided the work with all materials related to the thesis at <https://github.com/JayaniLakshika/Monash_PhD_thesis>. The thesis is written using Quarto [@Allaire_Quarto_2024] and is available online at <https://jayani-lakshika-phd-thesis.netlify.app>. 

The R packages used throughout the thesis include `tidyverse` [@tidyverse], `lmtest` [@lmtest], `kableExtra` [@kableextra], `patchwork` [@patchwork], `glue` [@glue], `ggpcp` [@ggpcp], `here` [@here], and `knitr` [@knitr]. (Need to finalize at the end of writing)

<!--add about Match-a-roo as well-->

## Future work

There are several directions that this work can be developed.

- Scagnostics to evaluate NLDR
- 3D NLDR investigation
- Prediction with model built
- More diagnostics for NLDR (diadem app)
- Visualizations to validate experiment design/results
- Investigate perception and misperception happening with background noise, number of clusters, noise dimensions, sample size, seed.
- lineup for NLDR 

### Diagnostics

When dealing with clustering problems, it is important to assess NLDR methods. Different NLDR techniques with varying parameters can lead to different representations, sometimes resulting in misclassification. Understanding the reasons for such misclassifications can be challenging. The main objective of this work is to introduce a platform called [diadim](https://ebsmonash.shinyapps.io/diadim/) that enables users to evaluate their NLDR representations for clustering problems.

Users are required to upload the 2D and high-dimensional Euclidean distances, as well as the NLDR embeddings along with the results of their spin-and-brush analysis [@cook2000, @wilhelm1999]. Spin-and-brush is a useful technique for exploring clustering in numerical data containing well-separated clusters. It is effective in addressing issues that may negatively impact numerical techniques, such as nuisance variables, differences in variances or shapes between clusters, or cases. Additionally, spin-and-brush is helpful in scenarios where the data contains connected low-dimensional clusters in high dimensions. The `detourr` package [@casper2024] is used to implement spin-and-brush, and the results can be saved for further analysis.

Users have the flexibility to select a specific cluster and data point for assessment. The left side of the application presents the cluster and the selected data point, while the right side displays the distribution of distances. In the right panel, the points illustrate the distances from the selected point to all other points within the chosen cluster. Users can select points from both panels for evaluation.

<!-- ::: {#fig-fritillaR_sc layout-ncol="1"} -->
<!-- ![](Figures/diadem.png) -->

<!-- Screenshots of the **diadim** web application. The [video](https://drive.google.com/file/d/1SBcvBrYQtuRlcRrhfKFQXPgaP_TEpldY/view?usp=sharing) shows the implementation. -->
<!-- ::: -->

### Visualising experimental designs

The main objective of this tool (`fritillaR`) is to visualise and validate results from experiments. It includes a web application that allows users to easily upload their experiment design data and results data for visualisation. Additionally, I plan to incorporate interactive features such as linked selections and filters. While the tool primarily visualises categorical data, transforming continuous data into intervals can provide a useful way to visualise continuous data as well. 

The initial workflow includes importing the experimental design and results, data preprocessing, 2D static visualization, 2D interactive visualization, and dynamic visualization. The data preprocessing steps involve mapping the design data and finding missing responses in the results, transforming the data to a wide format to compute the number of responses for each factor level combination (missing combinations are recorded as $0$), and converting the data into a long format suitable for visualization. For 2D static plots, `ggplot2` [@hadley2016] is used to provide a clear view of the distribution of counts across various factor levels. `plotly` [@carson2020] is used to add interactivity, and hovering over the tiles reveals additional information, enhancing the user's ability to interact with and understand the data. The dynamic visualization will show each vertex as a factor level combination, with jittered points representing the number of responses for each factor combination and edges connected with one level change in a factor. Currently, the `detourr` [@casper2024] package is used for the implementation.

<!-- ::: {#fig-fritillaR_sc layout-ncol="1"} -->
<!-- ![](Figures/fritillaR_vis.png) -->

<!-- Screenshots of the (a) 2D, and (b) dynamic visualisations of **fritillaR**. The [video](https://drive.google.com/file/d/1P1kNR_3aQEC5XXM8IWJCMlDhYz52pK3y/view?usp=sharing) shows the implementation of the `fritillaR`. -->
<!-- ::: -->

