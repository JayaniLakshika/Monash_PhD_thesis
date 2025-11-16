# Choosing Better NLDR Layouts by Evaluating the Model in the High-dimensional Data Space {#sec-first-paper}

Nonlinear dimension reduction (NLDR) techniques such as tSNE, and UMAP provide a low-dimensional representation of high-dimensional data (\pD{}) by applying a nonlinear transformation. NLDR often exaggerates random patterns. But NLDR views have an important role in data analysis because, if done well, they provide a concise visual (and conceptual) summary of \pD{} distributions. The NLDR methods and hyper-parameter choices can create wildly different representations, making it difficult to decide which is best, or whether any or all are accurate or misleading. To help assess the NLDR and decide on which, if any, is the most reasonable representation of the structure(s) present in the \pD{} data, we have developed an algorithm to show the \gD{} NLDR model in the \pD{} space, viewed with a tour, a movie of linear projections. From this, one can see if the model fits everywhere, or better in some subspaces, or completely mismatches the data. Also, we can see how different methods may have similar summaries or quirks.



<!--This paper is build with quollr 0.3.15-->




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


## Introduction

Nonlinear dimension reduction (NLDR) is popular for making a convenient low-dimensional (\kD{}) representation of high-dimensional (\pD{}) data ($k < p$). Recently developed methods include t-distributed stochastic neighbor embedding (tSNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) algorithm [@moon2019], large-scale dimensionality reduction using triplets (TriMAP) [@amid2019], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021]. 

However, the representation generated can vary dramatically from method to method, choice of hyper-parameter or even random seed, as illustrate by @fig-NLDR-variety. The specific method and hyper-parameters used to produce each layout (see Appendix) is not essential for the discussion. The dilemma for the analyst is which representation to use. The choice might result in different procedures used in the downstream analysis, or different inferential conclusions. Various academics have expressed concerns with current practices and procedures for choosing (e.g.  @irizarry2024, @chari2023). The research described here provides new numerical and visual tools to aid with this decision. 


::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}
::: {.cell-output-display}
![Eight different NLDR representations of the same data, produced by tSNE, UMAP, PHATE, TriMAP and PaCMAP with a variety of hyper-parameter choices. The variety in layouts makes it difficult to choose which best represents the data distribution.](02-chap2_files/figure-pdf/fig-NLDR-variety-1.pdf){#fig-NLDR-variety fig-align='center' width=80%}
:::
:::


The paper is organized as follows. @sec-background provides a summary of the literature on NLDR, and high-dimensional data visualization methods. @sec-method contains the details of the new methodology, including simulated data examples. In @sec-bestfit, we describe how to assess the best fit and identify the most accurate \gD{} layout based on the proposed model diagnostics. <!--Curiosities and unexpected patterns discovered in NLDR results by examining the model in the data space are discussed in @sec-curiosities.--> Two applications illustrating the use of the new methodology for bioinformatics and image classification are in @sec-applications. Limitations and future directions are provided in @sec-discussion. 

## Background {#sec-background}

<!-- - Connection between NLDR and MDS-->
Historically, low-dimensional (\kD{}) representations of high-dimensional (\pD{}) data have been computed using multidimensional scaling (MDS) [@kruskal1964], which includes principal components analysis (PCA) (for an overview see @jolliffe2011). (A contemporary comprehensive guide to MDS can be found in @borg2005.) The \kD{} representation can be considered to be a layout of points in \kD{}   produced by an embedding procedure that maps the data from \pD{}. In MDS, the \kD{} layout is constructed by minimizing a stress function that differences distances between points in \pD{} with potential distances between points in \kD{}. Various formulations of the stress function result in non-metric scaling [@saeed2018] and isomap [@silva2002]. Challenges in working with high-dimensional data, including visualization, are outlined in @johnstone2009. 

Many new methods for NLDR have emerged in recent years, all designed to better capture specific structures potentially existing in \pD{}. Here we focus on five currently popular techniques: tSNE, UMAP, PHATE, TriMAP and PaCMAP. The methods tSNE, UMAP, TriMAP and PaCMAP can be considered for producing the \kD{} representation by minimizing the divergence between two inter-point distance distributions. PHATE is an example of a diffusion process spreading to capture geometric shapes, that include both global and local structure. (See @coifman2005 for an explanation of diffusion processes.)  

The array of layouts in @fig-NLDR-variety illustrate what can emerge from the choices of method and hyper-parameters, and the random seed that initiates the computation. Key structures interpreted from these views suggest: (1) highly **separated clusters** (a, b, e, g, h) with the number ranging from 3-6; (2) **stringy branches** (f), and (3) **barely separated clusters** (c, d) which would **contradict** the other representations. These contradictions arise because these methods and hyper-parameter choices provide different lenses on the interpoint distances in the data.

The alternative approach to visualizing the high-dimensional data is to use linear projections. PCA is the classical approach, resulting in a set of new variables which are linear combinations of the original variables. Tours, defined by @As85, broaden the scope by providing movies of linear projections, that provide views the data from all directions. (See @lee2021 for a review of tour methods.) There are many tour algorithms implemented, with many available in the R package `tourr` [@wickham2011], and versions enabling better interactivity in `langevitour` [@harisson2024] and `detourr` [@hart2022]. Linear projections are a safe way to view high-dimensional data, because they do not warp the space, so they are more faithful representations of the structure. However, linear projections can be cluttered, and global patterns can obscure local structure. The simple activity of projecting data from \pD{}   suffers from piling [@laa2022], where data concentrates in the center of projections. NLDR is designed to escape these issues, to exaggerate structure so that it can be observed. But as a result NLDR can hallucinate wildly, to suggest patterns that are not actually present in the data. 

Our proposed solution is to use the tour to examine how the NLDR is warping the space. It follows what @wickham2015 describes as *model-in-the-data-space*. The fitted model should be overlaid on the data, to examine the fit relative the spread of the observations. While this is straightforward, and commonly done when data is \gD{}, it is also possible in \pD{}, for many models, when a tour is used. 

@wickham2015 provides several examples of models overlaid on the data in \pD{}. In hierarchical clustering, a representation of the dendrogrom using points and lines can be constructed by augmenting the data with points marking merging of clusters. Showing the movie of linear projections reveals shows how the algorithm sequentially fitted the cluster model to the data. For linear discriminant analysis or model-based clustering the model can be indicated by $(p-1)\text{-}D$ ellipses. It is possible to see whether the elliptical shapes appropriately matches the variance of the relevant clusters, and to compare and contrast different fits. For PCA, one can display the model (a \kD{} plane of the reduced dimension) using wireframes of transformed cubes. Using a wireframe is the approach we take here, to represent the NLDR model in \pD{}.

## Method {#sec-method}

### What is the NLDR model?

At first glance, thinking of NLDR as a modeling technique might seem strange. It is a simplified representation or abstraction of a system, process, or phenomenon in the real world. The \pD{}   observations are the realization of the phenomenon, and the \kD{} NLDR layout is the simplified representation. Typically, $k=2$, which is used for the rest of this paper. From a statistical perspective we can consider the distances between points in the \gD{}   layout to be variance that the model explains, and the (relative) difference with their distances in \pD{}   is the error, or unexplained variance. We can also imagine that the positioning of points in \gD{}    represent the fitted values, that will have some prescribed position in \pD{}   that can be compared with their observed values. This is the conceptual framework underlying the more formal versions of factor analysis [@joreskog1969] and MDS. (Note that, for this thinking the full \pD{}   data needs to be available, not just the interpoint distances.)

We define the NLDR as a function $g\text{:}~ \mathbb{R}^{n\times p} \rightarrow \mathbb{R}^{n\times 2}$, with hyper-parameters $\mathbfit{\theta}$. These parameters, $\mathbfit{\theta}$, depend on the choice of $g$, and can be considered part of model fitting in the traditional sense. Common choices for $g$ include functions used in tSNE, UMAP, PHATE, TriMAP, PaCMAP, or MDS, although in theory any function that does this mapping is suitable. 

With our goal being to make a representation of this \gD{} layout that can be lifted into high-dimensional space, the layout needs to be augmented to include neighbor information. A simple approach would be to triangulate the points and add edges. A more stable approach is to first bin the data, reducing it from $n$ to $m\leq n$ observations, and connect the bin centroids. We recommend using a hexagon grid because it better reflects the data distribution and has less artifacts than a rectangular grid. This process serves to reduce some noisiness in the resulting surface shown in \pD{}. The steps in this process are shown in @fig-NLDR-two-curvy, and documented below.

<!--two_nonlinear/06_gen_model_with_tSNE.R-->

::: {.cell layout-align="center"}

:::


<!--Full hexagon grid with UMAP data-->


::: {.cell layout-align="center"}

:::


<!--Non-empty bins with bin centroids-->


::: {.cell layout-align="center"}

:::


<!--2D model-->

::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



To illustrate the method and how to use it to choose a reasonable layout, we use \sD{} simulated data, which we call the "2NC7" data. It has two separated nonlinear clusters, one forming a \gD{} curved shape, and the other a \tD{} curved shape, each consisting of $1000$ observations. The first four variables hold this cluster structure, and the remaining three are purely noise. We would consider $T=(X_1, X_2, X_3, X_4)$ to be the geometric structure (true model) that we hope to capture. This data is sufficiently simple, with just two complexities (two separated curvilinear clusters, and two different implicit dimensions), to adequately explain the new method. The applications section contains two practical examples where NLDR has been used in published work. This data has both global and local structure. The two separated clusters would be considered to be global structure, and the nonlinear low-dimensional shapes could be considered to be local structure, one being \gD{} and the other \tD{}. An ideal NLDR layout would reveal the two clusters with moderate separation, and flatten the curvilinear forms while preserving the proximity of points.

<!-- The remaining variables $X_4, X_5, X_6, X_7$ are all uniform error, with small variance.  -->


::: {.cell layout-align="center"}
::: {.cell-output-display}
![Key steps for constructing the model on the tSNE layout ($k=2$) of 2NC7: (a) data, (b) hexagon bins, (c) bin centroids, and (d) triangulated centroids. The 2NC7 data is shown.](02-chap2_files/figure-pdf/fig-NLDR-two-curvy-1.pdf){#fig-NLDR-two-curvy fig-align='center' width=100%}
:::
:::


### Algorithm to represent the model in \gD{}  

#### Scale the data

Because we are working with distances between points, starting with data having a standard scale, e.g. [0, 1], is recommended. The default should take the aspect ratio produced by the NLDR $(r_1, r_2, ..., r_k)$ into account. When $k=2$, as in hexagon binning, the default range is $[0, y_{i,\text{max}}], i=1,2$, where $y_{1,\text{max}}=1$ and $y_{2,\text{max}} = r_2/r_1$ (@fig-NLDR-two-curvy). If the NLDR aspect ratio is ignored then set $y_ {2,\text{max}} = 1.$ 

#### Hexagon grid configuration

Although there are several implementations of hexagon binning [@carr1987], and a published paper [@dan2023], surprisingly, none has sufficient detail or components that produce everything needed for this project. So we described the process used here. @fig-hex-param illustrates the notation used. 

The \gD{} hexagon grid is defined by its bin centroids. Each hexagon, $H_h$ ($h = 1, \dots, b$) is uniquely described by centroid, $C_{h}^{(2)} = (c_{h1}, c_{h2})$. The number of bins in each direction is denoted as $(b_1, b_2)$, with  $b = b_1 \times b_2$ being the total number of bins. We expect the user to provide just $b_1$ and we calculate $b_2$ using the NLDR ratio, to compute the grid. 

To ensure that the grid covers the range of data values a buffer parameter ($q$) is set as a proportion of the range. By default,  $q=0.1$. The buffer should be extending a full hexagon width ($a_1$) and height ($a_2$) beyond the data, in all directions. The lower left position where the grid starts is defined as $(s_1, s_2)$, and corresponds to the centroid of the lowest left hexagon, $C_{1}^{(2)} = (c_{11}, c_{12})$. This must be smaller than the minimum data value. Because it is one buffer unit, $q$ below the minimum data values, $s_1 = -q$ and $s_2 = -qr_2$. 

The value for $b_2$ is computed by fixing $b_1$. Considering the upper bound of the first NLDR component, $a_1 > (1+2q)/(b_1 -1)$. Similarly, for the second NLDR component, 

$$
a_2 \geq \frac{r_2 + q(1 + r_2)}{(b_2 - 1)}.
$$

Since $a_2 = \sqrt{3}a_1/2$ for regular hexagons,

$$
a_1 \geq \frac{2[r_2 + q(1 + r_2)]}{\sqrt{3}(b_2 - 1)}.
$$

This is a linear optimization problem. Therefore, the optimal solution must occur on a vertex. Therefore,

$$
b_2 = \Big\lceil1 +\frac{2[r_2 + q(1 + r_2)](b_1 - 1)}{\sqrt{3}(1 + 2q)}\Big\rceil.
$${#eq-bin2}


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The components of the hexagon grid illustrating notation.](02-chap2_files/figure-pdf/fig-hex-param-1.pdf){#fig-hex-param fig-align='center' fig-pos='H' width=30%}
:::
:::


#### Binning the data

Observations are grouped into bins based on their nearest centroid. This produces a reduction in size of the data from $n$ to $m$, where $m\leq b$ (total number of bins). This can be defined using the function $u: \mathbb{R}^{n\times 2} \rightarrow \mathbb{R}^{m\times 2}$, where
$$u(i) = \arg\min_{j = 1, \dots, b} \sqrt{(y_{i1} - C^{(2)}_{j1})^2 + (y_{i2} - C^{(2)}_{j2})^2},$$ maps observation $i$ into $H_h = \{i| u(i) = h\}$. 

By default, the bin centroid is used for describing a hexagon (as done in @fig-NLDR-two-curvy (c)), but any measure of center, such as a mean or weighted mean of the points within each hexagon, could be used. The bin centers, and the binned data, are the two important components needed to render the model representation in high dimensions.  

#### Indicating neighborhood

Delaunay triangulation [@lee1980;@alb2024] is used to connect points so that edges indicate neighboring observations, in both the NLDR layout (@fig-NLDR-two-curvy (d)) and the \pD{} model representation. When the data has been binned the triangulation connects centroids. The edges preserve the neighborhood information from the \gD{} representation when the model is lifted into \pD{}. 

### Rendering the model in \pD{}

The last step is to lift the \gD{} model into \pD{} by computing \pD{} vectors that represent bin centroids. We use the \pD{} mean of the points in a given hexagon, $H_h$, denoted $C_{h}^{(p)}$, to map the centroid $C_{h}^{(2)} = (c_{h1}, c_{h2})$ to a point in \pD{}. Let the $j^{th}$ component of the \pD{} mean be

$$C_{hj}^{(p)} = \frac{1}{n_h}\sum_{i =1}^{n_h} x_{hij}, ~~~h = 1, \dots, b;~ j=1, \dots, p; ~ n_h > 0.$$


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Lifting the \gD{} fitted model into \pD{}. Two projections of the \pD{} fitted model overlaying the data are shown in b, c. The fit is reasonably tight with the data in one cluster (top one in b), but slightly less so in the other cluster probably because it is $3\text{-}D$. Notice also that, in the \gD{} layout the two clusters have internal gaps which creates a model with some holes. This lacy pattern happens regardless of the hyper-parameter choice, but this doesn't severely impact the \pD{} model representation.](02-chap2_files/figure-pdf/best-fit-tsne-1.pdf){fig-align='center' width=100%}
:::
:::



### Measuring the fit {#sec-summary}

<!-- Existing approaches -->

All NLDR methods internally optimize a quantity to produce a layout for any particular hyper-parameter set. These are not always made available in the model output, and may not be universally comparable between hyper-parameter choices and methods. 

Several common metrics are often used to assess the quality of any NLDR layout, based on preservation of global and local structure of the data. The $RNX$ curve quantifies the neighborhood agreement between \pD{} and \kD{} spaces, by computing the area under the curve ($ARNX$) across a range of neighborhood scales [@john2015]. A high value indicates better preservation of a balance of global and local structure. Random Triplet Accuracy (RTA) and Centroid Triplet Accuracy compare the order of \gD{} and \pD{} distances of random triplets of points [@yingfan2021]. High values indicate preservation of the geometry, suggesting both local and global structure preservation. The Shepard diagram [@shepard1962] and its associated Spearman correlation (SC) [@spearman1961] between \pD{} and \kD{} distances. High values indicate preservation of global structure. The Global Score (GS) measures how well an embedding retains the overall geometry of the data relative to a PCA baseline [@amid2019]. Higher values indicate better preservation of global structure. <!-- KNN Accuracy evaluates neighborhood consistency using leave-one-out classification, and SVM Accuracy assesses neighborhood cohesion with a nonlinear decision boundary [@yingfan2021]. Because these two require a response variable XXX not correct!), they can't be applied for our purposes.--> <!-- Since PCA serves as the optimal linear method, we report $RGS = 1 − GS$ in our comparisons to align the direction of the metric with NLDR methods. As our analysis focuses on unlabeled data, we use ARNX, RTA, sc, and RGS for comparison with our proposed measure.-->

 <!-- Fitted values,  Error calculation-->

None of the above measures is particularly well-suited to assessing our model fit, as we will show later. Thus, we need to different approach to measuring model fit. Because the model here is similar to a confirmatory factor analysis model (see a general explanation in @brown2015), $\widehat{T} + \epsilon$, our approach is similar to the ones used in this area. it is based on "residuals" computed as the difference between the fitted model and observed values in \pD{}. Observations are associated with their bin center, $C_{h}^{(p)}$, which are also considered to be the *fitted values*. In factor analysis language, these fitted values might also be denoted as $\widehat{X}$. The error is computed by taking the squared \pD{} Euclidean distance, of points from their bin centroid, which we will call hexbin error (HBE):

$$ HBE = \sqrt{\frac{1}{n}\sum_{h = 1}^{m}\sum_{i = 1}^{n_h}\sum_{j = 1}^{p} (\mathbfit{x}_{hij} - C^{(p)}_{hj})^2}$${#eq-equation1} 

where $n$ is the number of observations, $m$ is the number of non-empty bins, $n_h$ is the number of observations in $h^{th}$ bin, $p$ is the number of variables and $\mathbfit{x}_{hij}$ is the $j^{th}$ dimensional data of $i^{th}$ observation in $h^{th}$ hexagon. We can consider $e_{hi} = \sqrt{\sum_{j = 1}^{p} (\mathbfit{x}_{hij} - C^{(p)}_{hj})^2}$ to be the residual for each observation. @fig-p-d-error-in-2d-two-curvy shows plots of $e$ as a density (a), coloring the points in the NLDR layout (b) and the points in a tour (c). It can be see that the biggest residuals are in one cluster, which occurs due the intentional design that one cluster is slightly \tD{} and perfectly captured by a \gD{} layout. 


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Examining the distribution of residuals in a jittered dotplot (a), \gD{} NLDR layout (b) and a tour of \fD{} data space (c). Color indicates residual ($e_{hi}$), dark color indicating high value. Most large residuals are distributed in one cluster (bottom one in c) and most small residuals are distributed in the other cluster.](02-chap2_files/figure-pdf/fig-p-d-error-in-2d-two-curvy-1.pdf){#fig-p-d-error-in-2d-two-curvy fig-align='center' fig-pos='H' width=100%}
:::
:::


<!-- #### Other evaluation metrics -->


### Prediction into \gD{}

<!-- Does this really need an entire subsection? It's only 3 sentences long. -->

NLDR methods are primarily designed for visualization and exploration rather than reconstruction, and do not explicitly provide out-of-sample prediction. Of the five methods studied here, only UMAP provides a `predict()` function for embedding new data points based on the learned manifold [@tomasz2023]. Several other approaches, not used here, PCA, neural network autoencoders [@hinton2006] and parametric tSNE [@van2009] support prediction. 

A benefit of our approach is that for any NLDR method, it provides a way to predict the layout position of a new observation, $x'$. The steps are (1) determine the closest bin centroid in \pD{}, $C^{(p)}_{h}$ and (2) predict the embedding to be the bin centroid in \gD{}, $C^{(2)}_{h}$. 

### Tuning

The model fitting is based on these parameters: 

- hexagon bin parameters
    - bottom left bin position $(s_1, \ s_2)$, 
    - the number of bins in the horizontal direction ($b_1$), which controls the number of bins the vertical direction ($b_2$), total number of bins ($b$), and total number of non-empty bins ($m$).
- low count bin removal using standardized bin counts ($w_h = n_h/n, ~~h=1, \dots m$).

Default values are provided for each of these, but deciding on the best model fit is assisted by examining a range of values. The default number of bins $b=b_1\times b_2$ is computed based on the sample size, by setting $b_1=n^{1/3}$, consistent with the Diaconis-Freedman rule [@freedman1981]. The value of $b_2$ is determined analytically by $b_1, q, r_2$ (@eq-bin2). Values of $b_1$ between $2$ and $b_1 = \sqrt{n/r_2}$ are recommended, where the dependence on $r_2$ reflects the preservation of aspect ratio in the NLDR layout.

@fig-bins-two-curvy shows the hexbin grids for three choices of $b_1$. While the number of bins is the common parameter to modify, bin start positions $(s_1, \ s_2)$ can be worth experimenting with also because  it can also change bin counts. 

<!--Choosing these parameters according to HBE can be automated but it is recommended that the user examine the resulting model representation by overlaying it on the data in \pD{}. The next few subsections describe the calculation of default values, and the effect that different choices have on the model fit.-->

<!-- #### Hexagon bin parameters -->

<!-- The values $(s_1, \ s_2)$ define the position of the centroid of the bottom left hexagon. By default, this is at $s_1 = -q, s_2 = -qr_2$, where $q$ is the buffer bound the data. The choice of these values can have some effect on the distribution of bin counts which is seen in @fig-bins-two-curvy. The distribution of bin counts for $s_1$ varying between $\text{-}0.1\,\text{--}\,0.0$.-->


::: {.cell layout-align="center"}
::: {.cell-output-display}
![Hexbin density plots of tSNE layout of the 2NC7 data, using three different $b_1$ specifications yielding different $b_2, b, m$: (a) **15**, 18, 270, 98, (b) **24**, 29, 696, 209, and (c) **35**, 42, 1470, 386. Color indicates standardized counts, dark indicating high count and light indicates low count. At the smallest bin size, the data structure is discontinuous, suggesting that there are too many bins.](02-chap2_files/figure-pdf/fig-bins-two-curvy-1.pdf){#fig-bins-two-curvy fig-align='center' fig-pos='H' width=100%}
:::
:::


<!-- #### Handling of low density bins-->

It is worthwhile to consider what are desirable aspects of a hexbin result, that maps to summarizing the \pD{} fit well. The binning should capture the underlying data distribution closely, with minimum number of necessary bins. An ideal binning might be indicated by a more uniform distribution of bin counts, or having few relatively empty bins. To help with this assessment average bin count ($\bar{n} = \sum{n_h}/m$), average standardized bin count ($\bar{w} = \sum{w_h}/m$) and proportion of non-empty bins ($m/b$), are also computed. @fig-param-two-curvy shows some choices of plots of these quantities for a single NLDR layout, with three choices of $a_1$ indicated. Some expectations and reasoning for these plots is:

- HBE will increase as $a_1$ increases, so good choices will be just before a big increase. In plot a, HBE changes fairly steadily so there is no easy choice to make.
- HBE can also be examined against average standardized bin count or average bin count (plot b). This is similar to the comparison with $a_1$ but to use when comparing different NLDR layouts. Different layouts might produce different density of points, which will not be captured well by a comparison of HBE vs $a_1$.
- The proportion of non-empty bins is interesting to examine across different binwidths (plot c). A good binning should have just the right amount of bins to neatly cover the shape of the data, and no more or less. As binwidth gets smaller, $m/b$ should roughly get bigger.
- Bins with a small number of observations might be removed to sharpen the wireframe model. This can have adverse effects, though - failing to extend the wireframe into sparse areas, or resulting in holes in the wireframe. Plot d shows the relationship between HBE (computed for all observations despite some bin removal) and the standardized bin count cutoff used to remove bins. For all three chosen bin widths a small number of bins can be removed without affecting HBE.
<!-- - Lastly, an ideal distribution of the density of a grid is uniform, in the sense that if each bin captures a similar number of observations, then it has just the right number of bins to neatly cover the shape of the data. To examine this, the average bin density, $\bar{d}$, is compared against the range of binwidths (@fig-param-two-curvy d), relative to that of the hexgrid with the smallest binwidth. -->


<!-- 
To make comparisons between hexagon configurations made from different parameter choices we use the number of **non-empty** bins ($m$) rather than the total number of bins. 

By default, when assessing the choice of horizontal bins, $b_1$, the total number of bins is measured by the number of **non-empty** bins ($m$). This more accurately reflects the hexagon grid relative to the HBE than the full number of bins in the grid. It may also be beneficial to remove low count bins also, in the situation where data is clustered or stringy, where the observed data is sparse. In order to decide if this is necessary, you would examine the distribution of bin counts, or the density which puts the counts on a standard scale. If there is something of a gap at low values, this would suggest a potential value to use as a cutoff. Alternatively, one could choose to remove based on a percentile, the bins with density in the lowest $5\%$ of all bins, for example. @fig-param-two-curvy (c) illustrates the effect on the model representation of removing bins below different percentages. 

The benchmark value for removing low-density hexagons ranges between $0$ and $1$. When analyzing how these benchmark values influence model performance, it's essential to observe the change in HBE as the benchmark value increases (@fig-param-two-curvy (c)). The HBE shows a gradual decrease as the benchmark value goes from $1$ to $0$. Evaluating this rate of increase is important. If the increment is not considerable, the decision might lean towards retaining low-density hexagons.
-->

<!-- I'll be honest I've no idea what this section is 
The area of a hexagon is defined as $A = 3\sqrt{3}l^2/2$ where $l$ is the side length of the hexagon. If we know $a_1$ and $a_2$, $l$ can be computed (see appendix). The density of a hexagon grid is calculated as $\sum^{h}_{i=1}n_h/A$ and the proportion is $\sum^{h}_{i=1}n_h/Ab$. The baseline proportion is the proportion density at the smallest possible value of $a_1$. The relative proportion density is the ratio of the observed proportion density to the baseline proportion density.-->

<!--two_nonlinear/05_gen_rm_lwd_mse.R-->

::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}
::: {.cell-output-display}
![Various plots to help tune the model fit: (a) HBE vs $a_1$, (b) HBE vs $\bar{n}_h$, (c) proportion of non-empty bins ($m/b$) vs $a_1$, (d) HBE vs $w_h$ cutoff used for removing low count bins. Color indicates the three binwidths show in Figure 6: $0.03$ (orange dashed), $0.05$ (blue solid), and $0.08$ (green dotted). The better model fit will have low HBE, but reasonably sized bins that capture the data sufficiently. Proportion of non-empty bins tends to increase with $a_1$ (c). Removing a few low count bins doesn't substantially change HBE, for all three binwidths (d).](02-chap2_files/figure-pdf/fig-param-two-curvy-1.pdf){#fig-param-two-curvy fig-align='center' fig-pos='H' width=100%}
:::
:::


### Interactive graphics

Matching points in the \gD{} layout with their positions in \pD{} is useful when tuning the fit. This can be used to examine the fitted model in some subspaces in \pD{}, in particular in association with residual plots. 

The interactive \gD{} layout [@chapman2020] and the langevitour [@harisson2024] view with the fitted model overlaid can be linked using a browsable HTML widget (@joe2025, @joe2024). A rectangular "brush" is used to select points in one plot, which will highlight the corresponding points in the other plot(s). Because the langevitour is dynamic, brush events that become active will pause the animation, so that a user can interrogate the current view. This approach will be illustrated on the examples, to show how it can help to understand how the NLDR has organised the observations, and learn where it does not do well.

## Choosing the best \gD{} layout {#sec-bestfit} 

@fig-toy-rmse illustrates the approach to compare the fits for different representations and assess the strength of any fit. What does it mean to be a best fit for this problem? Analysts use an NLDR layout to display the structure present in high-dimensional data in a convenient \gD{} display. It is a competitor to linear dimension reduction that can better represent nonlinear associations such as clusters. However, these methods can hallucinate, suggesting patterns that don't exist, and grossly exaggerate other patterns. Having a layout that best fits the high-dimensional structure is desirable but more important is to identify bad representations so they can be avoided. The goal is to help users decide on a the most useful and appropriate low-dimensional representation of the high-dimensional data. 

A particular pattern that we commonly see is that analysts tend to pick layouts with clusters that have big separations between them. When you examine their data in a tour, it is almost always that we see there are no big separations, and actually often the suggested clusters are not even present. While we don't expect that analysts include animated gifs of tours in their papers, we should expect that any \gD{} representation adequately indicates the clustering that is present, and honestly show lack of separation or lack of clustering when it doesn't exist. It is important for analysts to have tools to select the accurate representation not the pretty but wrong representation.

To decide on a layout an analyst needs:

- a selection of NLDR representations made with a range of hyper-parameter choices and possibly different methods (tSNE, UMAP, ...).
- a range of model fits made by varying bin size and low density bin removal.
- calculated HBE for each layout, when it is transformed into the \pD{} space. 
- and the ability to examine the fit in the data space.

Comparing the HBE to obtain the best fit is appropriate if the same NLDR method is used. However, because the HBE is computed on \pD{} data it measures the fit between model and data so it can also be used to compare the fit of different NLDR methods. A lower HBE indicates a better NLDR representation.


::: {.cell layout-align="center"}

:::


<!--two_nonlinear/04_gen_mse_for_diff_methods.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


<!--two_nonlinear/07_example_evaluation_metrics.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Assessing which of the 6 NLDR layouts (a-f) on the 2NC7 data is the better representation using HBE for varying binwidth ($a_1$) and average bin count ($\bar{n}_h$). Color represents NLDR layout. Layout d is universally poor. Layouts a, b, e that show two close clusters are universally suboptimal. Layout b with little separation performs well at tiny binwidth (where most points are in their own bin) and poorly as binwidth increases. Layout e has small separation with oddly shaped clusters. Layout a is the best choice. Comparison of scaled evaluation metrics (rRTA, rSC, rGS, rARNX, and HBE using $a_1=0.05$) for the six NLDR layouts computed on the 2NC7 data using a parallel coordinate plot. Color of the line indicates NLDR layout. RTA, SC, GS, and ARNX is reversed so that lower is best. ](02-chap2_files/figure-pdf/fig-toy-rmse-1.pdf){#fig-toy-rmse fig-align='center' fig-pos='H' width=100%}
:::
:::


<!-- Current metrics like ARNX, RTA, and SC focus on how well local or global structures are preserved, but their suggestions best layout can be very different. In contrast, HBE gives a more direct and easy-to-understand link between the \pD{} data space and the \gD{} space, showing how well the NLDR method capture the high-dimensional data structure.-->

@fig-toy-rmse compares the metrics ARNX, RTA, SC, GS, along with HBE computed on $a_1=0.05$ for the six layouts shown in @fig-toy-rmse. This is a parallel coordinate plot where the y-axis shows a normalized score to ensure the metrics are on the same scale. Each line corresponds to one layout. The metric ARNX has been reversed so that it aligns with HBE - the lower the value the better the layout. 

There is some agreement between the metrics. All, except ARNX agree that layout d is worst. All agree that layout f is best or very close to best. Layout a is best according to HBE and ARNX but considered to be much less optimal by RTA, SC and GS. Layout c is considered favorably by RTA, SC and GS but to be very poor by ARNX. This illustrates how difficult it is to use the numerical metrics alone to decide on the best layout. 

Ironically, RTA, GS and SC should be interpreted as "the higher the better", but here they agree with HBE and ARNX when interpreted in reverse! The problem with SC is that correlation is not a good measure in the presence of clusters - the further the clusters are apart in the layout produces a Shepard plot with two clusters of distances which will produce a high correlation value. Similar reasoning would explain why RTA and GS behave similarly: they put too much emphasis on the global structure. Thus, for the 2NC7 data further apart clusters score better, overly emphasizing that there are two clusters, even though this separation is not accurately reflecting the difference in \pD{}.

When the metrics disagree is causes confusion for the analyst, and thus provides a temptation to choose the nicest looking layout (very separated clusters), even though it may be a hallucination. Because HBE is accompanied with a representation of the layout in \pD{} to compare with the observed data, it can help to add more clarity in making decisions. @fig-fit-tsne-phate shows the fitted models for layouts a (rated high by HBE and ARNX) and c (rated poorly). These are \gD{} projectiosn from the tour, with black indicating the fitted model overlaid on the blue points of the data. The reason for the poor fit is that the PHATE layout (c) twists extremely along the 2- and \tD{} manifolds where the data lies. We have learned that all the NLDR methods tend to have twists in the fit in \pD{} but this is extreme. This is likely why layout c has poor metrics relative to the other layouts, and it suggests that it does not adequately capture the local structure in the 2NC7 data.

<!-- The variation across metrics highlights that they capture different aspects of structure preservation, and none behave exactly like HBE. While HBE provides a unique perspective on how well the high-dimensional structure is represented, only the RTA and SC metrics show a somewhat similar ordering across methods.-->

<!--two_nonlinear/06_gen_model_with_tSNE.R-->

::: {.cell layout-align="center"}

:::


<!--two_nonlinear/08_gen_model_with_PHATE.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Three $2\text{-}D$ projections from a tour showing the fitted models (black lines) for layouts a (top row) and c (bottom row) of the 2NC7 data (blue points). Layout c, which was poorly rated by ARNX and HBE covers less of the width of the data than a. The triangular gridding is less visible in c than a, and actually corresponds to extreme twisting.](02-chap2_files/figure-pdf/fig-fit-tsne-phate-1.pdf){#fig-fit-tsne-phate fig-align='center' width=100%}
:::
:::


## Applications {#sec-applications}

To illustrate the approach we use two examples: PBMC3k data (single cell gene expression) where an NLDR layout is used to represent cluster structure present in the \pD{} data, and MNIST hand-written digits where NLDR is used to represent essentially a low-dimensional nonlinear manifold in \pD{}.

### PBMC3k {#sec-pbmc}

This is a benchmark single-cell RNA-Seq data set collected on Human Peripheral Blood Mononuclear Cells (PBMC3k) as used in @pbmc2019. Single-cell data measures the gene expression of individual cells in a sample of tissue (see  for example, @haque2017). This type of data is used to obtain an understanding of cellular level behavior and heterogeneity in their activity. Clustering of single-cell data is used to identify groups of cells with similar expression profiles. NLDR is often used to summarize the cluster structure. Usually, NLDR does not use the cluster labels to compute the layout, but uses color to represent the cluster labels when it is plotted. 

In this data there are $2622$ single cells and $1000$ gene expressions (variables). Following the same pre-processing as @chen2024, different NLDR techniques were performed on the first nine principal components. @fig-NLDR-variety shows this data using a variety of methods, and different hyper-parameters. You can see that the result is wildly different depending on the choices. Layout a is a reproduction of the layout that was published in @chen2024. This layout suggests that the data has three very well separated clusters, each with an odd shape. The question is whether this accurately represents the cluster structure in the data, or whether they should have chosen b or c or d or e or f or g or h. This is what our new method can help with -- to decide which is the more accurate \gD{} representation of the cluster structure in the \pD{} data. 

@fig-pbmc-rmse shows HBE across a range of binwidths ($a_1$) for each of the layouts in @fig-NLDR-variety. The layouts were generated using tSNE and UMAP with various hyper-parameter settings, while PHATE, PaCMAP, and TriMAP were applied using their default settings. Lines are color coded to match the color of the layouts shown on the right. Lower HBE indicates the better fit. Using a range of binwidths shows how the model changes, with possibly the best model being one that is universally low HBE across all binwidths. It can be seen that layout f is sub-optimal with universally higher HBE. Layout a, the published one, is better but it is not as good as layouts b, d, or e. With some imagination layout d perhaps shows three barely distinguishable clusters. Layout e shows three, possibly four, clusters that are more separated. The choice reduces from eight to these two. Layout d has slightly better HBE when the $a_1$ is small, but layout e beats it at larger values. Thus we could argue that layout e is the most accurate representation of the cluster structure, of these eight.

To further assess the choices, we need to look at the model in the data space, by using a tour to show the wireframe model overlaid on the data in the $9\text{-}D$ space (@fig-model-pbmc-author-proj). Here we compare the published layout (a) versus what we argue is the best layout (e). The top row (a1, a2, a3) correspond to the published layout and the bottom row (e1, e2, e3) correspond to the optimal choice according to our procedure. The middle and right plots show two projections. The primary difference between the two models is that the model of layout e does not fill out to the extent of the data but concentrates in the center of each point cloud. Both suggest that three clusters is a reasonable interpretation of the structure, but layout e more accurately reflects the separation between them, which is small.

<!--Fit the best model for author suggestion and compute error-->
<!--pbmc3k/13_gen_model_with_UMAP.R-->

::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}

:::


<!--pbmc3k/08_gen_mse_for_diff_methods.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Assessing which of the 8 NLDR layouts on the PBMC3k data  (shown in @fig-NLDR-variety) is the better representation using HBE for varying binwidth ($a_1$). Color used for the lines and points in the left plot and in the scatterplots represents NLDR layout (a-h). Layout f is universally poor. Layouts a, c, g, h that show large separations between clusters are universally suboptimal. Layout d with little separation performs well at tiny binwidth (where most points are in their own bin) and poorly as binwidth increases. The choice of best is between layouts b and e, that have small separations between oddly shaped clusters. Layout e is chosen as the best.](02-chap2_files/figure-pdf/fig-pbmc-rmse-1.pdf){#fig-pbmc-rmse fig-align='center' fig-pos='H' width=100%}
:::
:::


<!--best choice-->
<!--Fit the best model and compute error-->
<!--pbmc3k/14_gen_model_with_tSNE.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Compare the published \gD{} layout (a) made with UMAP and the \gD{} layout selected by HBE plot (e) made by tSNE. The two plots on the right show  projections from a tour, with the models overlaid. The published layout a suggested three very separated clusters, but this is not present in the data. While there may be three clusters they are not well-separated. The difference in model fit also indicates this: the published layout a does not spread out fully into the point cloud like the model generated from layout e. This supports the choice that layout e is the better representation of the data, because it does not exaggerate separation between clusters.](02-chap2_files/figure-pdf/fig-model-pbmc-author-proj-1.pdf){#fig-model-pbmc-author-proj fig-align='center' fig-pos='H' width=90%}
:::
:::


### MNIST hand-written digits {#sec-mnist}

The digit "1" of the MNIST dataset [@lecun1998] consists of $7877$ grayscale images of handwritten "1"s. Each image is $28 \times 28$ pixels which corresponds to $784$ variables. The first $10$ principal components, explaining $83\%$ of the total variation, are used. This data essentially lies on a nonlinear manifold in the high dimensions, defined by the shapes that "1"s make when sketched. We expect that the best layout captures this type of structure and does not exhibit distinct clusters. 


::: {.cell layout-align="center"}

:::


<!--mnist/03_gen_mse_for_diff_methods.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}
::: {.cell-output-display}
![Assessing which of the 6 NLDR layouts of the MNIST digit 1 data is the better representation using HBE for varying binwidth ($a_1$). Colour is used for the lines and points in the left plot to match the scatterplots of the NLDR layouts (a-f). Layout c is universally poor. Layouts a, f that show a big cluster and a small circular cluster are universally optimal. Layout a performs well at tiny binwidth (where most points are in their own bin) and not as well as f with larger binwidth, thus layout f is the best choice.](02-chap2_files/figure-pdf/fig-mnist-rmse-1.pdf){#fig-mnist-rmse fig-align='center' fig-pos='H' width=92%}
:::
:::


@fig-mnist-rmse compares the fit of six layouts computed using UMAP (b), PHATE (c), TriMAP (d), PaCMAP (e) with default hyper-parameter setting and two tSNE runs, one with default hyper-parameter setting (a) and the other changing perplexity to $89$ (f). The layouts are reasonably similar in that they all have the observations in a single blob. Some (b, c) have a more curved shape than others. Layout e is the most different having a linear shape, and a single very large outlier. Both a and f have a small clump of points perhaps slightly disconnected from the other points, in the lower to middle right. 

The layout plots are colored to match the lines in the HBE vs binwidth ($a_1$) plot. Layouts a, b and f fit the data better than c, d, e, and layout f appears to be the best fit. @fig-clust-mnist shows this model in the data space in two projections from a tour. The data is curved in the $10\text{-}D$ space, and the fitted model captures this curve. The small clump of points in the \gD{} layout is highlighted in both displays. These are almost all inside the curve of the bulk of points and are sparsely located. The fact that they are packed together in the \gD{} layout is likely due to the handling of density differences by the NLDR. 

An interesting aside is that the rather strange layout e, which has what looks like a single point far from the remaining observations is actually similar to this one. That point is actually a clump of points corresponding to some of the diffuse points interior to the curve of the bulk of points. This is easy to see using the linked brushing tool.

The next step is to investigate the \gD{} layout to understand what information is learned from this representation. @fig-model-error-mnist summarizes this investigation. Plot a shows the layout with points colored by their residual value - darker color indicates larger residual and poor fit. The plots b, c, d, e show samples of hand-written digits taken from inside the colored boxes. Going from top to bottom around the curve shape we can see that the "1"s are drawn with from right slant to a left slant. The "1"s in d (black box) tend to have the extra up stroke but are quite varied in appearance. The "1"s shown in the plots labelled e correspond to points with big residuals. They can be seen to be more strangely drawn than the others. Overall, this \gD{} layout shows a useful way to summarize the variation in way "1"s are drawn.

<!--PaCMAP param: n_components=2, n_neighbors=10, init=random, MN_ratio=0.9, FP_ratio=2.0-->

<!-- Fit the model and compute error-->
<!--mnist/04_gen_model_with_tSNE.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Summary from exploring tSNE layout of the MNIST digit 1 data (a in Figure 12) using linked brushing. There is a big nonlinear cluster (grey) and a small cluster (orange) located very close to the one corner of the big cluster in \gD{} (a). The MNIST digit 1 data has a nonlinear structure in $10\text{-}D$. Two \gD{} projections from a tour on $10\text{-}D$ reveal that the small orange cluster is actually a diffuse set of points wrapped within the grey cluster, which is C-shaped in the high dimensions.](02-chap2_files/figure-pdf/fig-clust-mnist-1.pdf){#fig-clust-mnist fig-align='center' fig-pos='H' width=100%}
:::
:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Summary of the layout structure, and large errors, relative to the MNIST digit 1 shape: (a) layout colored by residual value, and at right (b-e) are images of samples of observations taken at locations around the layout, showing similarity in how the 1's were drawn. Set (f) are images corresponding to large residuals in the big cluster (darker orange in plot a). Along the big cluster, the angle of digit 1 changes (b-d). The small cluster has larger residuals, and the images show that these tend to be European style with a flag at the top, and a base at the bottom. The set in (f) show various poorly written digits.](02-chap2_files/figure-pdf/fig-model-error-mnist-1.pdf){#fig-model-error-mnist fig-align='center' fig-pos='H' width=100%}
:::
:::


## Discussion {#sec-discussion}

We have developed an approach to help assess and compare NLDR layouts, generated by different methods and hyper-parameter choice(s). It depends on conceptualizing the \gD{} layout as a model, allowing for the creation of a wireframe representation of the model that can be lifted into \pD{}. The fit is assessed by viewing the model in the data space, computing residuals and HBE. Different layouts can be compared using the HBE, providing quantitative and objective metrics to decide on the most suitable NLDR layout to represent the \pD{} data. Global and local preservation of structure is assessed by examining the HBE across a range of binwidths. It also provides a way to predict the values of new \pD{} observations in the \gD{}, which could be useful for implementing uncertainty checks such as using training and testing samples.

Two examples illustrating usage are provided: the PBMC3k data where the NLDR is summarizing clustering in \pD{} and hand-written digits illustrating how NLDR represents an intrinsically lower dimensional nonlinear manifold. We examined a typical published usage of UMAP with the PBMC3k dataset (Chen, 2024). As is typical of UMAP layout with default settings, the separation between clusters is grossly exaggerated. The layout even suggests separation where there is none. <!--This is common when layouts are chosen subjectively -- often a preference for the "prettiest".--> Our approach provides a way to objectively choose the layout and hopefully avoids the use of misleading layouts in the future. In the hand-written digits we illustrate how our model fit statistics show that a flat disc layout is superior to the curved shaped layouts, and how to identify oddly written "1"s using the residuals of the fitted model.

This work can be applied with existing metrics for evaluating NLDR layout, such as ARNX, RTA, sc, and RGS. It provides an additional evaluation metric, and allows any layout to viewed the in the \pD{} data space. This latter aspect can help to disentangle conflicting suggestions by the different metrics. Additional exploration of metrics to summarize the fit could be a new direction for the work. The difficulty is capturing nonlinear fits, for which Euclidean distance can be sub-optimal. We have used a very simple approach based on clustering methods, Euclidean distances to nearest centroid, which can approximate nonlinear patterns. Other cluster metrics would be natural choices to explore.

This work has also revealed some interesting curiosities about NLDR procedures. They almost all twist to fit data in \pD{}. Sometimes the fitted model appears as a "pancake" in some data where clusters are regularly shaped and high-dimensional, for some methods but not others, which is odd. One can imagine that if algorithms are initiated using principal components then some ordering of points along the major axes might generate this pattern. Alternatively, if local distances dominate the algorithm then is might be possible to see this pattern with well-separated regular clusters. We also demonstrated that there is a tendency for NLDR algorithms to be confused by different density in the data space, and some patterns in the layout are due to density differences rather than nonlinear associations between variables. 

Most NLDR methods only provide a \gD{} but if a \kD{} ($k>2$) layout is provided the approach developed here could be extended. Binning into cubes could be done in $3\text{-}D$ or higher, relatively easily, and used as a the basis for a wireframe of the fitted model. @barber1996 (and the associated software @stephane2023) has an algorithm for a convex hull in \pD{} which serves as an inspiration. A simpler approach using $k$-means clustering to provide centroids could also be possible, but the complication would be to determine how to connect the centroids into an appropriate wireframe.

<!--XXX Better tools to compare two layouts in \pD{} would be nice.

XXX global vs local AND using density on x axis-->

The new methodology is accompanied by an R package called quollr, so that it is readily usable and broadly accessible. The package has methods to fit the model, compute diagnostics and also visualize the results, with interactivity. We have primarily used the langevitour software [@harisson2024] to view the model in the data space, but other tour software such as tourr [@wickham2011] and detourr [@hart2022] could be also used.

## Supplementary Materials {#sec-supplementary}

All the materials to reproduce the paper can be found at [https://github.com/JayaniLakshika/paper-nldr-vis-algorithm](https://github.com/JayaniLakshika/paper-nldr-vis-algorithm). The Appendix includes many more details.

The R package `quollr`, available on CRAN and at [https://jayanilakshika.github.io/quollr/](https://jayanilakshika.github.io/quollr/), provides software accompaying this paper to fit the wireframe model representation, compute diagnostics, visualize the model in the data with langevitour and link multiple plots interactively. 


## Acknowledgments

These `R` packages were used for the work: `tidyverse` [@hadley2019], `Rtsne` [@jesse2015], `umap` [@tomasz2023], `patchwork` [@thomas2024], `colorspace` [@achim2020], `langevitour` [@harisson2024], `conflicted` [@hadley2023], `reticulate` [@kevin2024], `kableExtra` [@hao2024]. These `python` packages were used for the work: `trimap` [@amid2019] and `pacmap` [@yingfan2021]. The article was created with `R` packages `quarto` [@jjallaire2024]. 
