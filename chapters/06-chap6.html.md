# menuraR: An R Shiny App to Help Select the Best Nonlinear Dimension Reduction Representation {#sec-fifth-paper}



Nonlinear dimension reduction (NLDR) methods such as tSNE and UMAP are widely used to visualize high-dimensional biological data, including single-cell RNA-seq and genomics datasets in two dimensions. However, choosing an appropriate method and tuning hyper-parameters typically requires iterative experimentation and expert knowledge. Existing tools offer limited support for systematically comparing multiple NLDR layouts or diagnosing how well each layout reflects underlying high-dimensional structure. We present `menuraR`, an interactive Shiny web application for evaluating and comparing multiple NLDR layouts quantitatively and qualitatively. Built on the `quollr` package, `menuraR` provides a graphical user interface for generating, visualizing, and diagnosing NLDR representations without programming. Users can compare multiple layouts, assess representation using a diagnostic metric, hexbin error (HBE), and the model fitted in high-dimensions. Also, linked brushing helps to investigate whether the model fits the points everywhere or fits better in some places, or simply mismatches the pattern. An example workflow using a PBMC single-cell dataset demonstrates how `menuraR` supports more informed, transparent, and reproducible analysis of high-dimensional biological data.

## Introduction 

Nonlinear dimensionality reduction (NLDR) methods such as tSNE [@laurens2008] and UMAP [@leland2018] have become essential tools for exploring and visualizing high-dimensional data across diverse scientific disciplines. These techniques enable researchers to uncover structures, clusters, and patterns that are not immediately visible in the original feature space. However, the flexibility and power of these methods come with challenges: the quality and interpretability of low-dimensional embeddings are often highly sensitive to hyper-parameter choices, random initialization, and characteristics of the underlying data. As a result, identifying the most meaningful and faithful representation typically requires iterative experimentation, systematic evaluation, and domain expertise.

To address these challenges, we introduce `menuraR` (**m**onitoring **e**mbeddings of **n**onlinear **u**nfoldings for **r**epresentation and **a**nalysis in **R**), an interactive Shiny application created to facilitate the evaluation of NLDR layouts. Building on the functionality of the `quollr` package [@jayani2025a], `menuraR` provides a graphical user interface that enables users to compare multiple NLDR layouts, explore the effects of different hyper-parameter settings, and apply diagnostic tools for evaluating NLDR layout(s). The `quollr` package is useful for understanding how NLDR warps high-dimensional space and fits the data. Starting from a two-dimensional NLDR layout, `quollr` constructs a wireframe representation that is lifted back into the high dimensions (see @gamage2025c for algorithmic details) and viewed using a tour (@As85, a continuous sequence of linear projections. This model-based view helps reveal how NLDR methods warp high-dimensional geometry, where the embedding fits the data well, and where distortions or mismatches occur.

These capabilities are delivered through an intuitive interface that eliminates the need for programming, thereby lowering the technical barrier for researchers and students.

A key advantage of `menuraR` is its accessibility. The application is fully web-based, and does not require a local installation of R or package management. Centralized hosting ensures that users always access the most up-to-date version, while reproducibility is supported through logging and open availability of the underlying code. In this way, `menuraR` enhances transparency in NLDR evaluation and fosters broader adoption of rigorous visualization practices.

This chapter introduces the version $1.0.2$ of `menuraR`, describing its implementation, core features, and intended use cases. We demonstrate how the application can inform NLDR choices, highlight key visual diagnostics, and support exploratory data analysis and teaching.

## User-Informed design

We conducted a usability survey with the NUMBATs research group at Monash University to inform decisions regarding the app's design. Participants were asked to complete a series of tasks within the application, including uploading data, generating new NLDR layouts, comparing embeddings, and interpreting model diagnostics. Their interactions, feedback, and suggestions were used to refine the interface, improve documentation, and identify features that enhance usability or require redesign.

## Methods

The `menuraR` application is implemented in R using the `shiny` package [@winston2025a], which provides the reactive framework required for interactive web applications. Supporting packages, including `shinycssloaders` [@dean2024], are used to indicate progress during computationally intensive tasks.

The application enables users to generate and compare two-dimensional NLDR layouts, currently supporting tSNE [@jesse2015] and UMAP [@james2025] through implementations available in the R ecosystem. Core computations, including layout generation, model fitting, and diagnostic evaluation, are handled by the `quollr` package [@jayani2025a]. This includes construction of two-dimensional wireframe representations, lifting these structures into the original high-dimensional space, and computing the hexbin error (HBE) across a range of binwidths.

`menuraR` is deployed on the [shinyapps.io](https://shinyapps.io) platform, allowing users to access the application through a web browser without local installation or dependency management. A centralized server environment ensures consistent computational settings across sessions, supporting reproducible evaluation of NLDR layouts.

The combination of an interactive Shiny interface with the `quollr` back end allows users to explore multiple embeddings, assess hyper-parameter effects, and examine diagnostic measures within a single workflow, without requiring programming expertise.

## The Shiny application

The `menuraR` app contains four main three tabs: (1) Data Upload, (2) Compare NLDR Layouts, and (3) Model diagnostics. Each tab includes numbered steps and clear instructions that guide users from data input to interpretation of results.

### Data upload

Analysis in \texttt{menuraR} begins in two ways: by uploading user-provided high-dimensional data or by using one of the built-in example datasets (@fig-menuraR_ui1). Two datasets are provided within the application: C-shaped Clusters, a synthetic dataset illustrating nonlinear structure, and PBMC, a biological single-cell dataset for real-world exploration [@rahul2025]. If the user uploads their own high-dimensional data, the file should be a CSV and the CSV must have a unique ID column, with data columns prefixed by the letter `x` (e.g., `x1`, `x2`, etc.).

Once the high-dimensional data uploaded, under "Choose the source of NLDR layouts", users select an NLDR layout source: "Upload your own NLDR data", or "Generate default tSNE and UMAP layouts".
Selecting "Upload your own NLDR data" activates the uploaded NLDR layouts and metadata for comparison. Precomputed NLDR layouts are uploaded as a CSV file. For each layout, the two embedding dimensions are labeled `emb1` and `emb2`. If multiple layouts are included, embedding columns are prefixed with the layout number (e.g., `1_emb1`, `1_emb2`). Also, the meta data CSV file includes the NLDR layout name (e.g., 1, 2, etc.), the method used (like UMAP or tSNE), and any hyper-parameters formatted with the parameter name followed by its value, separated by a dash (e.g., perplexity-30 for tSNE). All uploaded files must be under $100$ MB in size, and it is essential that each dataset follows the variable naming conventions required by the web application. Alternatively, users may choose \emph{Generate default tSNE and UMAP layouts}, in which case the application automatically computes two embeddings using default hyper-parameter settings for tSNE and UMAP.

Once loaded, all available NLDR layouts appear in the "Your Loaded NLDR Layouts" box. Users can select or deselect specific layouts to include in the comparison.

#### Adding additional layouts

The application also allows users to generate additional layouts directly within the interface. Users select the NLDR method (tSNE or UMAP), specify hyper-parameters, and click "Show Layout" to generate the embedding. If satisfied, they can add it to the comparison using "Add Layout"; otherwise, they may adjust the parameters and regenerate the layout. Multiple additional layouts can be created and compared in this manner.

Once the desired layouts are finalized, users click "Start Analysis" to proceed automatically to the next tab, Compare NLDR Layouts, where the evaluation and comparison of embeddings take place.


::: {.cell layout-align="center"}
::: {.cell-output-display}
![Data Upload and NLDR layout Configuration in `menuraR`. The *Data Input* tab enables users to upload high-dimensional datasets or use built-in examples, and generate or upload NLDR layouts. Users can create additional layouts with custom hyper-parameters, and manage loaded embeddings for downstream comparison.](../figures/menuraR/menuraR_ui1.png){#fig-menuraR_ui1 fig-align='center' fig-alt='A screenshot of the Data Input tab in the menuraR Shiny application. The interface shows controls for uploading a high-dimensional dataset or selecting a built-in example, along with options to generate new nonlinear dimensionality reduction (NLDR) layouts or upload precomputed embeddings. A panel lists the currently loaded layouts, with buttons or controls to adjust hyper-parameters, add new layouts, and manage which embeddings are available for later comparison.' width=100%}
:::
:::


### Compare NLDR Layouts

The comparison begins by selecting the binwidth ($a_1$), which controls the width of the hexagons in the hexagonal grid (@fig-menuraR_ui2). For the chosen $a_1$, the Shiny application visualizes hexagonal grids overlaid on each selected $2\text{-}D$ NLDR layout. Also, the app constructs a $2\text{-}D$ wireframe representation for each layout, which forms the basis for subsequent lifting the model into high-dimensional space. The app also generates a plot showing the Hexbin Error (HBE) against the binwidth parameter ($a_1$) and identifies the "best" representation that yields the lowest HBE for that specific $a_1$. Users can modify the $a_1$ value to see what layout performs best for the chosen bandwidth.

Furthermore, users have the option to download the $2\text{-}D$ layouts, corresponding data, the HBE versus binwidth plot, and the summary table, which contains error, HBE, the number of bins along the x-axis ($b_1$), the number of bins along the y-axis ($b_2$), the total number of bins ($b$), the number of non-empty bins ($m$), the bin width ($a_1$), the bin height ($a_2$), standardized bin counts ($w_h$), and NLDR method id.


::: {.cell layout-align="center"}
::: {.cell-output-display}
![NLDR Layout Comparison and Hexbin Error Evaluation in \texttt{menuraR}. The \textit{Compare NLDR Layouts} tab allows users to visualize selected $2\text{-}D$ NLDR embeddings overlaid with hexagonal grids and wireframe representations. Users can explore the effect of the binwidth parameter ($a_1$) on Hexbin Error (HBE), identify the most reasonable layout, and download layouts, HBE plots, and summary tables for further analysis.](../figures/menuraR/menuraR_ui2.png){#fig-menuraR_ui2 fig-align='center' fig-alt='A screenshot of the Compare NLDR Layouts tab in menuraR. Multiple 2D NLDR embeddings are displayed side by side, each shown as a scatterplot overlaid with a hexagonal grid and a wireframe representation. Control panels allow the user to adjust the binwidth parameter ($a_1$), and adjacent plots or tables show Hexbin Error (HBE) values corresponding to the selected layouts. Download buttons for layouts, HBE plots, and summary tables are visible.' width=100%}
:::
:::


### Model diagnostics

Once the best representation is selected, interactive plots are generated to display the high-dimensional model error, the best $2\text{-}D$ layout, and a tour view of the model overlaying the high-dimensional data (@fig-menuraR_ui3). This interactivity allows users to identify where the model fits well, where it is better in some subspaces, and where it fails to match the data. Additionally, users can explore the mapping between the $2\text{-}D$ layout and the high-dimensional data. Importantly, model diagnostics are not limited to the best NLDR layout; other layouts can also be selected and examined for comparison.


::: {.cell layout-align="center"}
::: {.cell-output-display}
![Interactive Model Diagnostics in \texttt{menuraR}. The interface provides interactivity between the distribution of model error, the NLDR layout, and the model overlaid on the high-dimensional data. The best $2\text{-}D$ layout is automatically selected, but users can explore other layouts as well. This helps to identify regions where the model fits well or exhibits distortions and some quirks.](../figures/menuraR/menuraR_ui3.png){#fig-menuraR_ui3 fig-align='center' fig-alt='A screenshot of the Model Diagnostics interface in menuraR. The display includes linked views showing the distribution of model error, a selected 2D NLDR layout, and the fitted model overlaid on projections of the high-dimensional data. Interactions such as selection or brushing link the plots, allowing users to explore how model fit and distortions vary across regions of the layout. Controls indicate which 2D layout is currently selected, with options to switch to alternative embeddings.' width=100%}
:::
:::


## Results

We evaluated `menuraR` using the PBMC3k single-cell RNA-seq dataset [@rahul2025], a widely used benchmark for assessing dimensionality-reduction methods in single-cell analysis. This dataset contains $2622$ human peripheral blood mononuclear cells (PBMCs) measured across $1000$ gene expression variables and is commonly used to study cellular heterogeneity and population structure at the single-cell level.

In single-cell RNA-seq analysis, clustering is typically used to identify groups of cells with similar expression profiles, while nonlinear dimension reduction (NLDR) methods are employed to summarize and visualize this structure in two dimensions. Importantly, NLDR methods do not use cluster labels to compute embeddings; labels are instead used post hoc for interpretation and visualization. 

We applied NLDR methods to the first nine principal components of the gene expression matrix. Using the *Compare NLDR Layouts* tab of `menuraR`, we generated four embeddings commonly used in practice: tSNE with perplexity values of $30$ (default) and $18$, and UMAP with $({\text{n\_neighbors}}, \text{min\_dist})$ set to $(15, 0.1)$ (default) and $(41, 0.43)$. Visual comparison showed consistent separation of major immune cell populations across all layouts, with clear differences in cluster separation and neighborhood continuity. Overall, tSNE produced smaller inter-cluster separation, while UMAP yielded more distinct clusters. For both methods, hyper-parameter choices controlled the local–global trade-off: smaller neighborhood sizes or lower perplexity emphasized tight local groupings, whereas larger neighborhood sizes or higher perplexity produced smoother global transitions (@fig-menuraR_ui2).

The *Comparison* panel enabled a quantitative comparison of these layouts using the hexbin error (HBE). At a binwidth of $a_1 = 0.06$, the tSNE layout with $\text{perplexity} = 18$ achieved the lowest HBE, indicating the best agreement between the two-dimensional embedding and the fitted high-dimensional model at this binwidth.

Linked brushing in the *Model Diagnostics* tab showed that the model fits the data well and highlighted filled-out and dense clusters that are not visible from the NLDR layout (@fig-menuraR_ui3).

## Conclusions

This chapter introduces `menuraR`, a web-based interface designed to assist in the evaluation and selection of the most reasonable NLDR layout(s). Although NLDR methods such as tSNE, and, UMAP are widely used for visualizing high-dimensional data, interpreting and selecting the most representative layout can be complex. `menuraR` addresses this challenge by providing an accessible, intuitive, and interactive environment that encapsulates the diagnostic features of the `quollr` package, making assistant in NLDR selection feasible for users with varying levels of technical expertise.

Currently, `menuraR` supports two NLDR methods tSNE and UMAP executed within the R environment on shinyapps.io. Performance may vary depending on dataset size and browser memory limits, as computations are handled server-side.

Developed using the R Shiny framework, `menuraR` eliminates many of the technical barriers traditionally associated with advanced statistical software. Users do not need to install additional packages or configure language-specific environments, which is particularly valuable for interdisciplinary research teams and educational settings. The platform helps users to compare NLDR layouts, select the ones that most accurately represent the high-dimensional data structure, and assess NLDR results.”

## Supplementary Materials

The data used in the survey are available at [github.com/JayaniLakshika/paper-menuraR/data](https://github.com/JayaniLakshika/paper-menuraR/tree/main/data), and the example data used in the app are available at [github.com/JayaniLakshika/menuraR/data](https://github.com/JayaniLakshika/menuraR/tree/main/data).

The run sheets used to guide the study are openly available at: [github.com/JayaniLakshika/paper-menuraR/run\_sheets](https://github.com/JayaniLakshika/paper-menuraR/tree/main/run_sheets).

## Acknowledgments

We thank members of NUMBATs, the working group of the Department of Econometrics and Business Statistics, Monash University, Australia, for their participation in the usability survey and for providing valuable feedback that helped improve this research.
