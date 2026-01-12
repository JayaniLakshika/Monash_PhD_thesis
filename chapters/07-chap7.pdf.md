
::: {.cell}

:::



::: {.cell}

:::


# Conclusion and Future Plans {#sec-conclusion}

This thesis presents five key contributions that collectively advance the understanding and evaluation of NLDR methods. The work introduces a new method and software for NLDR diagnostics, providing insights into how people identify data structures when NLDR layouts and tour views are displayed together. It develops methods for generating clustering data structures and implements user-friendly tools that support exploratory analysis and visualization.

## Contributions

The primary contributions of this research are fivefold. First, we introduce a novel method for visualizing how NLDR warps data, thereby improving the diagnostics of NLDR techniques. Second, we develop an R package, `quollr`, which implements the proposed diagnostic method. Third, we create `cardinalR`, a package that generates high-dimensional clustering data structures with enhanced features such as added noise dimensions and background noise. Fourth, we conduct a human-subject experiment to investigate the perception and misperception of NLDR representations, providing evidence on how data structures are identified in NLDR layouts compared to tours. Finally, we develop a Shiny application that offers analysts a user-friendly interface for selecting the most accurate NLDR representation.

## Using a published $2\text{-}D$ NLDR layout as a case study

In the Introduction, a published UMAP layout (*n_neighbors = 30* and *min_dist = 0.3*) of a human PBMC CITE-seq dataset [@hao2021] is used as a motivating example. The UMAP layout shows several visually distinct clusters with different shapes. Some clusters appear compact and well separated, while others are elongated, curved, or partially overlapping. In total, six clusters can be seen, including three with nonlinear shapes, two roughly Gaussian clusters, and one elliptical cluster, along with a small amount of background noise scattered between clusters. At first glance, it looks convincing. But this immediately raises an important question: *is this really the best way to represent the structure in the $10\text{-}D$ PBMC CITE-seq data?*

Looking more closely, the data contain six clusters that are fairly close to one another (@fig-dt-prj-pbmc). Three of them have clearly nonlinear shapes, two Gaussian blobs, and one is closer to an ellipse, with a bit of background noise scattered around. These kinds of data structures are common in bioinformatics data. Using the `cardinalR` package, data with these different cluster shapes and background noise can be generated (@fig-dt-prj-sim).


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
![Three $2\text{-}D$ projections of the $10\text{-}D$ PBMC CITE-seq data. The dataset shows six well-separated yet closely positioned clusters, including three with nonlinear geometric structures and three approximately Gaussian clusters, along with a small amount of background noise.](07-chap7_files/figure-pdf/fig-dt-prj-pbmc-1.pdf){#fig-dt-prj-pbmc fig-alt='A three-panel figure shows three two-dimensional projections of the PBMC CITE-seq ten-dimensional datasets, each using abstract horizontal and vertical projection axes. Across these projections, six clusters are visible: three clusters exhibit nonlinear geometric shapes such as curved arcs or bent ribbons, while three appear approximately Gaussian and compact. The clusters are well separated but positioned relatively close to one another, with a small number of scattered points representing background noise.'}
:::
:::



::: {.cell}
::: {.cell-output-display}
![Three $2\text{-}D$ projections of a $10\text{-}D$ simulated dataset generated using `cardinalR`. To create a synthetic dataset comparable to PBMC CITE-seq data, `cardinalR` first generated a $4\text{-}D$ structure comprising three Gaussian clusters, one quadratic cluster, one spherical spiral, and one conic spiral, with added background noise. Six additional noise dimensions were then added to produce a $10\text{-}D$ dataset retaining similar structural characteristics.](07-chap7_files/figure-pdf/fig-dt-prj-sim-1.pdf){#fig-dt-prj-sim fig-alt='A three-panel figure shows three two-dimensional projections of a simulated dataset generated using cardinalR. These projections display six clusters with analogous structural diversity: three approximately Gaussian clusters, one quadratic-shaped cluster, one spherical spiral, and one conic spiral, again with sparse background noise. Although the exact shapes and relative positions vary across projections, the simulated data reproduces the mixture of nonlinear and Gaussian cluster structures observed in the PBMC CITE-seq data, illustrating structural similarity between the real and synthetic high-dimensional datasets.'}
:::
:::


To assess how well the UMAP layout reflects the structure of the $10\text{-}D$ PBMC CITE-seq data, we use the `quollr` framework (@fig-model-pdf). With a model fitted using a binwidth of $0.03$, the layout appears reasonable overall, but some limitations become clear. In particular, the roughly Gaussian clusters look more squeezed than expected, and background noise seems to form a separate cluster that likely does not represent a true group in the data. In addition, the nonlinear shaped clusters could benefit from being more spread out to better reflect their underlying structure. Also, clusters should be more close. These observations suggest that, while the current layout is informative, there is good potential to find an alternative layout that represents the data structure even more clearly.

<!--scripts/CITE-seq/04_gen_model_umap.R-->

::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![$2\text{-}D$ wireframe model representation of the UMAP layout, lifted and displayed in $10\text{-}D$ space. The left panel shows the UMAP layout with a triangular mesh overlay forming the wireframe structure. This mesh is lifted into higher dimensions and projected to examine how the geometric structure of the data is preserved. Panels (a1–a4) show different $2\text{-}D$ projections of the lifted wireframe. The model fits well, and varying densities along the nonlinear-shaped clusters are also observable.](07-chap7_files/figure-pdf/fig-model-pdf-1.pdf){#fig-model-pdf fig-pos='!ht' fig-alt='A multi-panel figure illustrates a wireframe model constructed from a UMAP layout and examined in higher-dimensional space. In the left panel, a two-dimensional UMAP embedding of the PBMC CITE-seq data is shown with a triangular mesh overlaid on the points, forming a wireframe representation of the local neighborhood structure. The axes represent abstract UMAP dimensions. The mesh connects nearby points, outlining the geometric shape of clusters rather than emphasizing individual observations. Panels (a1–a4) show different two-dimensional linear projections of this wireframe after it has been lifted into the original ten-dimensional space. Across these projections, the mesh remains coherent and closely follows the data, indicating that the lifted model fits the high-dimensional structure well. Nonlinear clusters appear as curved or twisted mesh surfaces whose orientation changes across projections, and variations in mesh density reveal differences in point density along these nonlinear structures.'}
:::
:::


This leads to the idea of comparing several NLDR layouts rather than relying on just one. The Shiny app `menuraR` makes this comparison easier by allowing different layouts and parameter settings.

Rather than computing embeddings on the fly, it is also helpful to precompute the NLDR layouts. In this case, four layouts are of interest:

- the published UMAP layout (*n-neighbors = 30, min_dist = 0.3*),
- a tSNE layout (*perplexity = 84*),
- a TriMAP layout (*n-inliers = 12, n-outliers = 4, n-random = 3*), and
- a PaCMAP layout (*n-neighbors = 10, init = random, MN-ratio = 0.5, FP-ratio = 2*).

These layouts can be saved as a single CSV file, following `menuraR`’s naming conventions (`emb1`, `emb2`, or prefixed versions for multiple layouts), along with a small metadata file describing the method and hyper-parameters used. Uploading precomputed layouts avoids long computation times and makes it easy to focus on comparison rather than setup.

Once the data and layouts are loaded in the *Data Upload* tab, all three embeddings appear in the "Your Loaded NLDR Layouts" panel (@fig-menuraR_ui1). From there, they can be selected together and passed into the *Compare NLDR Layouts* tab.


::: {.cell}
::: {.cell-output-display}
![Data upload and NLDR layout configuration in `menuraR`. The *Data Upload* tab shows the PBMC CITE-seq dataset together with several precomputed NLDR layouts, including the published UMAP layout and alternative embeddings generated using tSNE, TriMAP, and PaCMAP with different hyper-parameter settings. Uploaded layouts appear in the *Your Loaded NLDR Layouts* panel.](../figures/CITE-seq/menuraR_ui1_CITE-seq.png){#fig-menuraR_ui1 fig-alt='A screenshot of the Data Upload tab in the menuraR interface. The main panel displays the PBMC CITE-seq dataset alongside a list or grid of available nonlinear dimensionality reduction (NLDR) layouts. These include a published UMAP layout and several alternative embeddings generated using tSNE, TriMAP, and PaCMAP with different hyper-parameter settings. A side panel titled Your Loaded NLDR Layouts shows the layouts that have been uploaded or selected by the user. The interface allows users to view, compare, and manage multiple NLDR layouts for the same dataset within a single workspace.' width=100%}
:::
:::


This allows the layouts to be viewed side by side, overlaid with hexagonal grids, and evaluated using the hexbin error across different bin widths. With `menuraR`, at binwidth of $0.03$, the most reasonable layout is tSNE with *perplexity = 84* (@fig-menuraR_ui2).

The TriMAP layout is universally poor. The tSNE layout with little separation performs well at tiny binwidth (where most points are in their own bin) and poorly as binwidth increases. Also, the layout shows more clusters than it should. Both UMAP and PaCMAP perform better in this case because they produce more clearly separated clusters. However, PaCMAP spreads the Gaussian clusters too far apart, with some clusters even overlapping, which makes the structure harder to interpret. In contrast, UMAP provides well-separated clusters without introducing these issues, making it the most reasonable choice here.


::: {.cell}
::: {.cell-output-display}
![NLDR layout comparison and hexbin error evaluation in `menuraR`. The *Compare NLDR Layouts* tab displays multiple $2\text{-}D$ NLDR embeddings side by side, overlaid with hexagonal grids and corresponding wireframe representations. Users can explore how the hexbin error (HBE) changes with the binwidth parameter ($a_1$) and compare layouts directly. For this example, at a binwidth of $0.03$, the tSNE layout with *perplexity = 84* is identified as the most reasonable representation. Layouts, HBE plots, and summary tables can be downloaded for further analysis.](../figures/CITE-seq/menuraR_ui2_CITE-seq.png){#fig-menuraR_ui2 fig-alt='A screenshot of the Compare NLDR Layouts tab in the menuraR interface. Multiple two-dimensional NLDR embeddings are shown side by side, allowing direct visual comparison of different layouts. Each embedding is overlaid with a hexagonal binning grid and an associated wireframe representation, highlighting local neighborhood structure. Adjacent plots display how the hexbin error (HBE) varies as the binwidth parameter a1 hanges. Controls allow the user to adjust the binwidth and explore its effect on each layout. In this example, at a binwidth of 0.03, the tSNE layout with perplexity set to 84 shows the lowest HBE and is identified as the most reasonable representation. Options are provided to download the layouts, HBE plots, and summary tables for further analysis.' width=100%}
:::
:::


<!-- Finally, the *Model Diagnostics* tab can be used to dig deeper into where each layout works well and where it struggles. Linked views between the 2D layout and the high-dimensional model make it easier to see, for example, whether squeezed Gaussian clusters, stretched nonlinear clusters, or background noise are being handled differently across UMAP, TriMAP, and PaCMAP. -->

## Future work

There are several directions in which this work can be developed.

<!--add section on Do you have any plans/ideas to extend this to NDR results that project into more than 2D / do you think that would even be possible (say, for up to 5D projections or so)?. You’ve got one bullet point for your thesis future work section now! You could point Fabian to your paper conclusions where some ideas are suggested.-->

### Extending our algorithm to NLDR representations beyond $2\text{-}D$

A potential direction for future work is extending the current algorithm to NLDR results that project into more than two dimensions. While most existing tools, including those developed in this thesis, focus on $2\text{-}D$ embeddings, exploring projections into higher dimensions like $3\text{-}D$ or $5\text{-}D$ spaces could provide richer structural information in some settings.

Binning into cubes ($3\text{-}D$ or higher) could be performed relatively easily and used as the basis for constructing a wireframe representation of the fitted model. The algorithm for convex hull computation in $p$-dimensions, as described by @barber1996 and implemented in related software [@stephane2023], serves as inspiration for this approach. Alternatively, a simpler method using $k$-means clustering to obtain centroids in higher-dimensional embeddings might be feasible; however, the challenge would lie in determining how to connect these centroids to form an appropriate wireframe structure.

### Scagnostics to evaluate NLDR

One promising direction for future work is the integration of scagnostics [@leland2008; @dang2014] as an additional tool for evaluating NLDR results. Scagnostics provide a set of quantitative shape-based metrics (e.g., convexity, skewness, stringiness, clumpiness) that describe the geometric characteristics of scatterplots. By applying these metrics to $2\text{-}D$ scatterplots generated by NLDR methods, we could obtain an objective assessment of how well these methods preserve or distort data structures, particularly in relation to their characteristics (eg: nonlinearity).

Moreover, investigating how scagnostic profiles vary with different sample sizes for specific underlying data structures would provide valuable insight into the stability and robustness of NLDR methods. This could help identify which methods are more resilient to changes in sample size and which structures are more prone to distortion under small sample sizes.

### Compare prediction approaches

Future work includes evaluating and comparing the prediction capabilities of different NLDR methods. Only some methods, such as UMAP provide built-in functionality [@tomasz2023] to project new high-dimensional observations into an existing low-dimensional embedding. Our approach introduces a general prediction framework that can be applied to any NLDR method. It works by identifying the nearest high-dimensional bin centroid for a new observation and assigning its corresponding $2\text{-}D$ centroid from the fitted model.

Having predictions from both the built-in functions (when available) and our centroid-based method allows for direct performance comparisons. This enables a systematic evaluation of how well different approaches preserve structure when projecting new observations into an existing NLDR space.

### Interactive diagnostic tool for NLDR evaluation

A promising direction for future work is to extend the interactive capabilities developed in this thesis into a more comprehensive diagnostic tool for evaluating NLDR methods, particularly in the context of clustering. In this work, we have already demonstrated the value of interactive visualization—through tours, linked views, and brushing—for understanding how different NLDR layouts align with structure in the original high-dimensional data. Building on these ideas, a natural next step is the development of an interactive diagnostic tool that supports more targeted exploration of where and why NLDR methods succeed or fail.

This functionality could be developed as an extension of the existing menuraR Shiny application, which already provides a framework for exploring NLDR layouts alongside high-dimensional structure. The proposed tool would allow users to upload $2\text{-}D$ embeddings, high-dimensional data or distance matrices, and results from spin-and-brush analysis [@cook2000; @wilhelm1999], enabling deeper inspection of discrepancies between representations.

Spin-and-brush is a dynamic visual method for exploring clustering structure in high-dimensional numerical data and has proven effective for identifying the influence of nuisance variables, differences in cluster shape or variance, and the presence of low-dimensional manifolds. Support for recording and replaying brushing sequences, as implemented in the `detourr` package [@casper2025], aligns closely with the interactive strategies used throughout this thesis and would integrate naturally into the proposed diagnostic workflow.

The envisioned interface would build on linked-view concepts already explored here. For example, users could select a cluster and a specific data point within a $2\text{-}D$ NLDR layout and examine how that point relates to others in the same cluster through linked distance-based views. One panel could display the selected cluster and point in the embedding, while a second panel shows the distribution of high-dimensional distances from that point to other cluster members.

Linked brushing between these panels would allow users to directly investigate where NLDR methods preserve local and global structure and where distortions occur. By extending the interactive ideas developed in this thesis, such a tool would support more intuitive diagnosis of NLDR performance and provide a foundation for developing automated evaluation measures that are better aligned with human interpretation.

### Visualizing experimental designs

The main objective of this tool is to visualize and validate results from experiments. It includes a web application that allows users to easily upload their experiment design data and results data for  visualization. Additionally, we plan to incorporate interactive features such as linked selections and filters. While the tool primarily visualizes categorical data, transforming continuous data into intervals can provide a useful way to visualize continuous data as well. 

The initial workflow includes importing the experimental design and results, data preprocessing, $2\text{-}D$ static visualization, $2\text{-}D$ interactive visualization, and dynamic visualization. The data preprocessing steps involve mapping the design data and finding missing responses in the results, transforming the data to a wide format to compute the number of responses for each factor level combination (missing combinations are recorded as $0$), and converting the data into a long format suitable for visualization. For $2\text{-}D$ static plots, `ggplot2` [@hadley2016] is used to provide a clear view of the distribution of counts across various factor levels. `plotly` [@chapman2020] is used to add interactivity, and hovering over the tiles reveals additional information, enhancing the user's ability to interact with and understand the data. The dynamic visualization will show each vertex as a factor level combination, with jittered points representing the number of responses for each factor combination and edges connected with one level change in a factor. Currently, the `detourr` [@casper2025] package is used for the implementation.

<!-- ::: {#fig-fritillaR_sc layout-ncol="1"} -->
<!-- ![](Figures/fritillaR_vis.png) -->

<!-- Screenshots of the (a) 2D, and (b) dynamic  visualizations of **fritillaR**. The [video](https://drive.google.com/file/d/1P1kNR_3aQEC5XXM8IWJCMlDhYz52pK3y/view?usp=sharing) shows the implementation of the `fritillaR`. -->
<!-- ::: -->

### Investigating perception and misperception in NLDR with additional factors

One of the contributions of this thesis is the development of a controlled experimental framework for studying how people perceive and interpret NLDR layouts. With this framework in place and shown to work well for measuring perceptual accuracy and misperception, many additional experimental questions can now be explored systematically.

While the current user study focused primarily on how cluster separation influences human perception of NLDR layouts, many additional factors are likely to affect how users conceptualize and interpret low-dimensional embeddings. An important direction for future work is therefore to extend this experimental paradigm to investigate how variations in data characteristics and algorithmic choices influence perception and misperception.

Specifically, we propose extending the perceptual study to consider:

- Background noise: Adding uniformly or normally distributed noise to the data can obscure true structure, and it is important to understand how different NLDR methods handle such interference and how users respond to it visually.

- Number of clusters: As the number of clusters increases, distinguishing them in $2\text{-}D$ may become more challenging, particularly if the separation is subtle or overlaps occur.

- Noise dimensions: Including additional high-dimensional features that contain no signal (i.e., noise variables) can affect NLDR outcomes. We aim to evaluate how this impacts perceived structure.

- Sample size: Varying the number of observations may change both the visual density and the stability of the NLDR projection, influencing the interpretability of patterns.

- Random seed: Since many NLDR methods are stochastic (e.g., tSNE, UMAP), different seeds can lead to different embeddings. It is valuable to understand whether these differences are perceptible to users and how they affect interpretability.

- NLDR hyper-parameters: Algorithm-specific hyper-parameters (such as perplexity in tSNE or the number of neighbors and minimum distance in UMAP) have a strong influence on the resulting embedding. By systematically varying these settings within the experimental framework developed in this thesis, future studies could examine how hyper-parameter choices change the visual appearance of layouts and whether these changes are noticeable or misleading to users.

By extending the study to incorporate these data-driven variables, we can build a more comprehensive understanding of when and why human misperception occurs in NLDR layouts, and which methods are more resilient to such distortions. This work will support the development of more robust diagnostics and improve the practical use of NLDR.

### Lineup protocols to evaluate NLDR sensitivity and structure preservation

In this thesis, particularly in [Chapter 5](#sec-second-paper), we developed and applied a controlled experimental framework to study how people judge whether a static $2\text{-}D$ NLDR layout represents the same underlying high-dimensional data as a tour of linear projections. This task enabled us to quantify perceptual accuracy and misperception, and to examine how these outcomes depend on factors such as cluster separation and the choice of NLDR method.

As discussed in the previous section, this framework can be extended by introducing additional data- and algorithm-related factors that may influence perception. A complementary direction is to modify the experimental task itself, with the goal of probing different aspects of how NLDR layouts are perceived and potentially increasing statistical power. One promising approach in this regard is the use of lineup-based evaluation protocols [@andreas2009].

Lineups were originally introduced as a graphical inference tool for assessing whether visual structure in a plot is stronger than what would be expected under a null model. In a lineup, a plot generated from the true data is randomly embedded among a set of null plots, and observers are asked to identify the plot that appears most different. Successful identification provides evidence that the visual structure is perceptually salient and not attributable to chance.

When combined with the experimental framework developed in this thesis, lineups could be used to evaluate how well a $2\text{-}D$ NLDR layout preserves structure from the original high-dimensional data. For example, a lineup could include one NLDR layout computed from the true data alongside several null layouts generated from shuffled data or noise-perturbed versions. If participants consistently identify the true layout, this would suggest that the NLDR method preserves meaningful structure in a way that is perceptually accessible to human viewers.

Lineups could also be used to study the sensitivity of NLDR methods to hyper-parameter choices. Layouts generated under different hyper-parameter settings—such as perplexity in tSNE or the number of neighbors and minimum distance in UMAP—could be embedded within a lineup to assess whether small parameter changes lead to perceptually distinguishable differences. This would allow the robustness and stability of NLDR methods to be evaluated from a human-centered perspective and could help guide more reliable parameter selection.

### Comparative perceptual study of PCA and NLDR methods

Another valuable direction for future work is to investigate how PCA compares to NLDR methods in terms of human perception and interpretability. PCA is a linear method widely used for its simplicity and mathematical transparency, whereas NLDR methods often involve nonlinear transformations and hyper-parameter tuning.

By comparing how users interpret and misinterpret PCA layouts versus NLDR generated layouts, we can gain insights into whether linear techniques are inherently easier to understand or whether they may lead to different types of visual distortions. This work would help clarify when PCA is sufficient for visual analysis and when the added complexity of NLDR is warranted, particularly for exploratory tasks that rely on visual intuition.

### Extension for `quollr`

A useful extension to `quollr` would be to link cluster selections between the tour view and the $2\text{-}D$ NLDR layout. This would let users select a cluster in one view and immediately see how it appears in the other, making it easier to compare cluster structure across views.

## Reproducibility and availability

All materials associated with this thesis are openly available to support transparency and reproducible research. The thesis is written in Quarto [@jjallaire2024] and is available in both **HTML** and **PDF** formats. The **HTML version**, which includes interactive figures and linked visualizations, is published at
[jayani-lakshika-phd-thesis.netlify](https://jayani-lakshika-phd-thesis.netlify.app). The **PDF version** of the thesis is available at
[github.com/JayaniLakshika/Monash_PhD_thesis/_book/New-Interactive-Visual-Tools-and-Statistical-Methodology-for-Selecting-and-Evaluating-Non-linear-Dimension-Reduction-Layouts-of-High-Dimensional-Data.pdf](https://github.com/JayaniLakshika/Monash_PhD_thesis/blob/main/_book/New-Interactive-Visual-Tools-and-Statistical-Methodology-for-Selecting-and-Evaluating-Non-linear-Dimension-Reduction-Layouts-of-High-Dimensional-Data.pdf). All source code, data, and software used to generate the analyses, figures, and results are maintained in a public GitHub repository at
[github.com/JayaniLakshika/Monash_PhD_thesis](https://github.com/JayaniLakshika/Monash_PhD_thesis), enabling full reproduction of this work.

For accessibility, all figures include alt-text. The [autoAlt](https://github.com/numbats/autoAlt) package was used as a starting point for generating these descriptions, which were then reviewed and adjusted to better reflect the content of each figure and its caption.

<!--scripts/pkg_cran_info.R-->
The software outputs of this research have been made publicly available to support transparency and reproducibility. The R package `quollr` has been on CRAN since March $2024$ and has received $5175$ downloads from the CRAN mirror; its development version is hosted on GitHub at [github.com/jayanilakshika/quollr](https://github.com/jayanilakshika/quollr). The R package `cardinalR` has been available on CRAN since April $2024$ and has received $4407$ downloads from the CRAN mirror, with the latest development version at [github.com/jayanilakshika/cardinalR](https://github.com/jayanilakshika/cardinalR). @fig-pkg-commit gives an overview of my Git commits to these repositories.

A Shiny application for `quollr` is accessible via one of the mirror sites at [menurar.netlify.app/](https://menurar.netlify.app/), with its source code available at [github.com/JayaniLakshika/menuraR](https://github.com/JayaniLakshika/menuraR). The survey web application, **Match-a-roo** ([https://ebsmonash.shinyapps.io/Match-a-roo/](https://ebsmonash.shinyapps.io/Match-a-roo/)), was designed and implemented in Shiny to collect participant responses and demographic information. Each subject accessed the survey through the [shinyapps.io](https://www.shinyapps.io/) server.

<!--scripts/git_commits.R-->

::: {.cell}
::: {.cell-output-display}
![Weekly commit activity for the `cardinalR` and `quollr` packages.](07-chap7_files/figure-pdf/fig-pkg-commit-1.pdf){#fig-pkg-commit fig-alt='Two vertically stacked panels show weekly Git commit activity for the R packages cardinalR and quollr. The horizontal axis in each panel represents calendar time, aggregated by week, progressing from earlier to later dates. The vertical axis shows the number of commits made in each week, with scales allowed to differ between panels. Each week is represented by a point, indicating the observed commit count, and a smooth curve overlays the points to show the overall trend in activity over time. Both packages exhibit fluctuating but sustained development, with periods of increased and decreased weekly commits rather than a constant rate. The faceted layout allows comparison of temporal development patterns between the two repositories while preserving their different activity magnitudes.'}
:::
:::


## Supporting R packages

<!--need to update at the end of writing-->
In addition, a number of R packages were essential in the development of this work, including `tidyverse` [@hadley2019], `ggbeeswarm` [@erik2023], `ggrepel` [@kamil2024], `GGally` [@barret2025], `colorspace` [@achim2020], `scales` [@hadley2025], `patchwork` [@thomas2024], `plotly` [@chapman2020], `crosstalk` [@joe2025], `htmltools` [@joe2024], `quollr` [@jayani2025a], `cardinalR` [@jayani2025b], `detourr` [@casper2025], `geozoo` [@barret2016], `knitr` [@yihui2015], `kableExtra` [@hao2024], `lme4` [@douglas2015], `broom.mixed` [@ben2024], `emmeans` [@russell2025], `mclust` [@scrucca2023], `fpc` [@christian2024], `binom` [@sundar2022], `conflicted` [@hadley2023], `ggforce` [@thomas2025], `here` [@kirill2025], `grid` [@core2025], `gridExtra` [@baptiste2017], and `png` [@simon2022].

## Research workflow and project organization

Presentations, package development, and writing are the three primary types of activities that shape this thesis. I have developed a habit of using Git and GitHub to track and synchronize my academic work since I started the PhD program. All commits are grouped by the activity types, with annotations of important milestones, shown in @fig-task-commit. It has been a fruitful program.

<!--scripts/git_commits.R-->

::: {.cell}
::: {.cell-output-display}
![Plots of my Git commits split by the activity types during my PhD years, labeled with some milestones.](07-chap7_files/figure-pdf/fig-task-commit-1.pdf){#fig-task-commit fig-alt='A single-panel quasirandom scatterplot shows Git commits over time during the PhD, grouped by activity type. The horizontal axis represents time (date of commit), progressing from earlier to later PhD years. The vertical axis lists four categorical activity types: Presentation, Analysis & Writing, Package, and Shiny App. Each commit is shown as a small point, with points horizontally jittered using a quasirandom layout to reduce overlap. Points are coloured by activity type, but no legend is shown. Periods of dense point clusters indicate bursts of commits for a given activity, while sparse regions indicate lower activity. Commit timing varies across activity types, showing that different kinds of work peak at different times rather than occurring uniformly. Selected commits are annotated with text labels and arrows, marking key milestones within each activity category.' width=100%}
:::
:::


## Final thoughts

This journey has been as much about exploring the unknown as it has been about developing resilience and insight along the way. I am deeply grateful for the people, places, and lessons that have shaped both this work and the path forward.


::: {.cell layout-align="center"}
::: {.cell-output-display}
![Geographic footprint of the PhD journey, highlighting research visits, conferences, and academic engagements across Australia, Austria, and the United States. Locations include Salzburg and Vienna (Austria), Nebraska and Tennessee (USA), and Melbourne, Sydney, Canberra, and Perth (Australia), alongside moments from conferences, collaborations, and software dissemination.](07-chap7_files/figure-pdf/fig-mem-1.pdf){#fig-mem fig-align='center' fig-alt='A world map highlighting locations associated with the PhD journey. Markers indicate research visits, conferences, and academic engagements across Australia, Austria, and the United States, including Melbourne, Sydney, Canberra, and Perth; Salzburg and Vienna; and sites in Nebraska and Tennessee. Additional images or insets show moments from conferences, collaborations, and software dissemination activities at these locations.' width=98%}
:::
:::

