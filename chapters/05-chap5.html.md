# Perception and Misperception of Clustering in Nonlinear Dimension Reduction: A User Study {#sec-second-paper}

Nonlinear dimension reduction (NLDR) methods such as tSNE, UMAP, PHATE, TriMAP, and PaCMAP are popular ways to visualize high-dimensional data, yet their effectiveness for conveying structure remains mysterious. Many factors might contribute to perceptual miscommunication, which for cluster structure may include how their shapes are represented, or the degree of separation, or even number of clusters. This study evaluates how well NLDR methods preserve perceptually meaningful cluster structure using a human subject experiment with simulated data having three clusters with distinct geometries, unequal sizes, and varying inter-cluster separation. Subjects were asked whether a $2\text{-}D$ NLDR layout and a tour of linear projections showed the same high-dimensional data. Cluster separation was controlled for the study to be distance between means, but for analysing the results two additional measures, between-to-within (BW) ratio and the exponential scaled minimum inter-cluster distance, were used to account for highly nonlinear shapes. The results suggest interesting differences across methods. For example, UMAP and tSNE represent distance between clusters distinctly differently resulting in data being interpreted differently. These findings highlight the need for more studies to assess NLDR methods based on how effectively their visualizations support human perception of high-dimensional structure.




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


## Introduction

Nonlinear dimension reduction (NLDR) is popular for making a suitable $2\text{-}D$ representation of high-dimensional ($p\text{-}D$) data by applying nonlinear transformations. Recently developed methods include t-distributed stochastic neighbor embedding (tSNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) algorithm [@moon2019], large-scale dimensionality reduction using triplets (TriMAP) [@amid2022], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021]. 

Nonlinear transformations allow for multiple shape-varying clusters to be represented in a single $2\text{-}D$ layout. In contrast, classical linear projection will often require multiple projections to show multiple clusters. @fig-nldr-layouts illustrates this: a1-a4 show linear projections revealing three well-separated clusters, one spherical, one ribbon-like and one like a star-shaped pyramid. The NLDR layout (left) is generated using tSNE has a mostly reasonable display of the three clusters in a single view, although it struggles with the star pyramid. It does place the clusters very close to each other which does not reflect the large separation in the high-dimensional space.  


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



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![A $2\text{-}D$ tSNE layout (left) and four $2\text{-}D$ projections (a1–a4) of the same $4\text{-}D$ data. The data consist of three main structures: a star-shaped pyramid, a curvilinear, and a Gaussian-shaped cluster. While the tour consistently shows the star-shaped cluster as a single coherent group, the $2\text{-}D$ tSNE layout fragments this structure into several smaller clusters. This illustrates how NLDR may distort global structure, making the same $4\text{-}D$ cluster appear as multiple clusters in the $2\text{-}D$ layout.](05-chap5_files/figure-html/fig-nldr-layouts-1.png){#fig-nldr-layouts fig-align='center' fig-pos='!ht' fig-alt='Multi-panel figure comparing a 2-D NLDR layout with multiple linear projections of the same 4-D data. The left panel shows a 2-D t-SNE layout with abstract horizontal and vertical axes representing embedding dimensions, each spanning a roughly symmetric range around zero. Points are colored or symbol-coded to indicate three underlying data structures. One group forms a compact, approximately spherical cluster. A second group forms a long, curved, ribbon-like band. A third group forms a star-shaped, pyramid-like structure with multiple arms radiating outward from a central region; in the tSNE layout, this structure appears split into several smaller, spatially separated point groups. The four right-hand panels (labeled a1–a4) show different 2-D linear projections of the same 4-D data, as produced by a tour. Each panel uses horizontal and vertical axes corresponding to different linear combinations of the original four variables, with numeric scales varying across projections but remaining continuous. In each projection, the same three data structures are visible: the spherical cluster appears compact, the curvilinear structure appears as a bent or elongated band whose orientation changes across projections, and the star-shaped pyramid appears as a single connected structure whose shape and orientation vary but remain coherent across all four views.' width=100%}
:::
:::


In general, the dilemma for the analyst is to make the conceptual leap from the structure displayed in the NLDR layout to what exists in high dimensions. From @fig-nldr-layouts we might find that that the analyst correctly conceptualizes the existence of the spherical and ribbon clusters, but mistakenly considers them close in high dimensions. The star-shaped pyramid might be incorrectly conceptualized as a lot of small clusters, possibly triangular in shape. This is what the work presented here is attempting to assess, whether the conceptualization from the NLDR reasonably matches that gained by viewing the same data using a tour of linear projections. 

<!-- from Paul: Ideally we would be able to say that XX% of readers would accurately report YY -->

The chapter is organized as follows. @sec-background provides a summary of the literature on NLDR, high-dimensional data, and visualization methods. @sec-experiment describes the experiment designed to examine people's perception to assess how viewers recognize structure differently from a $2\text{-}D$ NLDR layout and the tour view. @sec-results discusses the collected data, results, and reasons for misperception. Limitations are provided in @sec-limitations. A discussion of the presented work, and ideas for future directions are described in @sec-exp-conclusion.

## Background {#sec-background}

Historically, $2\text{-}D$ nonlinear representations of $p\text{-}D$ data have been obtained through versions of multidimensional scaling (MDS) (originally defined by @kruskal1964, and see @borg2005 for a modern overview) and linear representations using principal component analysis (PCA) (for an overview see @jolliffe2011). MDS aims to construct a low dimensional (usually $2\text{-}D$) layout that preserves pairwise distances between observations in the original space by minimizing a stress function. <!-- Variants such as non-metric scaling [@saeed2018] and isomap [@silva2002] extend this approach to capture nonlinear relationships.--> Challenges such as distance concentration that lead to difficulties for interpretation have been documented by @johnstone2009.

NLDR methods have developed to improve on MDS with varying degrees of preserving local and/or global structures of $p\text{-}D$ data, with some modern methods being tSNE, UMAP, PHATE, TriMAP, and PaCMAP. Each method uses different underlying principles. For example, tSNE and PHATE emphasize local relationships, while TriMAP and PaCMAP are designed to better capture global structure. As a result, these methods can produce very different $2\text{-}D$ layouts of the same data, potentially leading to misinterpretation of structures such as cluster separation. 

An alternative to NLDR for visualizing $p\text{-}D$ data is to use linear projections. PCA is the classical approach, producing new variables as linear combinations of the original dimensions. While PCA provides a single static projection that maximizes variance, tours introduced by @As85 extend this idea by generating smooth sequences of linear projections, effectively creating a movie of the data viewed from multiple directions. Tours can reveal structure that may be hidden in any single projection by continuously changing the viewing angle through high-dimensional space. Many tour algorithms have since been developed and are implemented in the R package `tourr` [@wickham2011], with interactive variants available in `langevitour` [@harisson2024] and `detourr` [@casper2025]. Tours are valuable because they preserve the geometry of the data unlike NLDR methods - they do not warp distances or angles. This makes them faithful but sometimes visually cluttered representations: global structure can obscure local detail, and the phenomenon of piling [@laa2022], where high-dimensional points project toward the center, can make clusters harder to distinguish.

Quantifying clusters in shape and separation is not simple. For this experiment a variety of shapes were generated using the functions in the `cardinalR` package [@jayani2025b]. Measuring distance between clusters is classically done using between-to-within (BW) ratio, which captures global separability if the cluster shape is elliptical. A variety of distance-based metrics have been proposed in the clustering and visualization literature [@tadeusz1974; @peter1987; @david1979], including minimum, maximum, and average distances between clusters, centroid distances, and ratios that combine between- and within-cluster variation. Although the data sets were created with a fixed process, the results will be examined with a variety of distance metrics to capture NLDR behavior using different lenses of separation.

<!-- To assess how well NLDR methods preserve structures such as cluster separation, it is important to quantify inter-cluster distances. A variety of distance-based metrics have been proposed in the clustering and visualization literature [@tadeusz1974; @peter1987; @david1979], including minimum, maximum, and average distances between clusters, centroid distances, and ratios that combine between- and within-cluster variation. In this study, we focus on two distance measures: the between-to-within (BW) ratio, which captures global separability, and the minimum distance between clusters, which reflects the closest approach of any two clusters. Together, these provide interpretable summaries of both overall and local cluster separation while accounting for within-cluster variability.-->

The objective of this research is to study analyst perception of  clustering structure in a $2\text{-}D$ NLDR layout comparison with that from a tour of the same high-dimensional data. The tour is generated using `langevitour`. The primary factor of interest is how the perception changes when cluster separation increases. <!--These findings will help identify common misperceptions that can arise when analysts rely solely on $2\text{-}D$ NLDR layouts, highlighting the need for careful diagnostics to verify whether perceived structures reflect the true high-dimensional patterns. This can help guide better ways to interpret and report what these visualizations are showing.-->

## Methods {#sec-experiment}

<!--
### What is a $2\text{-}D$ NLDR plot?

The $2\text{-}D$ representation of the $p\text{-}D$ data constructed to preserve as much information, like clustering and nonlinear relationships, as possible. There are various commonly used techniques for creating this $2\text{-}D$ representation, including tSNE, and UMAP. These methods aim to identify a low-dimensional structure that captures the most important patterns or relationships in the data, allowing for visualization and easier interpretation. However, it is important to note that $2\text{-}D$ embeddings can lose some information from the $p\text{-}D$ data, as they necessarily involve a loss of dimensionality.

### What is a tour?

The tour shows a sequence of two-dimensional linear projections of the $p\text{-}D$ data. It is similar to looking at shadows of a $3\text{-}D$ object, and trying to infer the shape of the $3\text{-}D$ object. Looking at linear projections of $p\text{-}D$ data is like looking at the shadows, and one hopes to gain a sense of what shapes exist in the data. For example, if the data separates into clusters in any of the projections, it means that there are clusters in the data in the high dimensions. If the data shows a nonlinear or curvilinear shape it means that there are nonlinear associations between some variables. If the data collapses to roughly a line it means that it lives in a lower dimensional space than the number of high dimensions. If the points moving differently from others, there are outliers or unusual observations in the high dimensions.
-->

Although, there are many aspects of NLDR and perception of data structure to assess, for this work we restrict attention to distance between clusters. For a range of cluster shapes, the distance between clusters is varied, and NLDR layouts are generated by the commonly used methods with default settings. The conceptualization of clustering is tested by showing subjects two views (one NLDR layout and the tour of linear projections) and asked whether both show the same data. When the response is that they are the same it is interpreted as that they conceptualize the clustering in both similarly. Conversely, if the response is that the two are different it is interpreted as a different conceptualization.

<!-- We are generally interested in testing whether "The two plots displays the same data" ($H_0$) against the broad alternative "The two plots do not display the same data" ($H_a$).

Testing this broad null hypothesis ($H_0$) is practically challenging due to the variety of data structures involved. It can be both time-consuming and computationally intensive. Therefore, we focused on one data structure that is particularly useful for investigation: three clusters where two clusters are close together, while one is more distant. Three clusters have different shapes and each cluster contain different number of points. The sample size is $7500$.

Our hypothesis is as follows:

$H_{0m1}$: The distance between the clusters has no effect on the probability of correctly identifying the $2\text{-}D$ NLDR plot generated by NLDR method $m$ and the tour from the same data. Vs $H_{1m1}$: The distance between the clusters does have an effect on the probability of correctly identifying the $2\text{-}D$ NLDR plot generated by NLDR method $m$ and the tour from the same data.

This study aims to answer which NLDR methods are more accurate in identifying the same data structure in the $2\text{-}D$ NLDR plot and the tour, as the distance increases, and to identify which types of data structure components are more prone to misidentification across methods.
-->

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Need to work on adding these info:

- In data generation: 
    - Why three clusters? How they positioned? Why the data in 4-D? Why different number of points in each cluster? 
    
    - Why different shaped clusters? Why always a combination of nonlinear shaped cluster (capture nonlinear shape), pyramid shapes cluster (capture density), and other shape (hemisphere/cube/Gaussian)? (added what each dataset consist of in appendix)

- Why do we choose these specific distance scale factors?

- Why did we scale the data sets before showing in the tour?

- Why these number of participants enough? (may be good to add in appendix)

- Why did we chose BW ratio and minimum distance? (already added to appendix but have ro think that it's necessary adding something in the main paper as well)

- Why do we scaled BW ratio and minimum distance?

- Why do we used exponential minimum scaled distance?

- In the discussion, may add how to expand the study?

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### Data generation

A total of $30$ $4\text{-}D$ data sets are generated. Two are reserved as attention check used to determine if the subject conscientiously attempted the task. All data sets were standardized prior to NLDR and showing in the tour. 

#### Non-attention check data

For the experiment, three cluster data are generated. The three clusters contain different number of points and shapes. Let $C_1, C_2,$ and $C_3$ denote the centroids of three clusters. The pairwise distances between these centroids are calculated as: $d(C_1, C_2) = c_{12}, \quad d(C_1, C_3) = c_{13}, \quad d(C_2, C_3) = c_{23}$, where clusters $C_1$ and $C_2$ are in close proximity, whereas cluster $C_3$ is positioned further away from the other two clusters, suggesting a spatial separation within the data. The reason for using the distance between centroids is that it can be easily controlled. 

XXX Shapes for each cluster were selected randomly from a set of XXX. 

<!-- In total, there are $28$ data structures used for the experiment. Out of these, $18$ data structures show the same structure in both the $2\text{-}D$ NLDR plot and tour for each experiment, while the remaining $10$ data structures display different structures in the $2\text{-}D$ NLDR plot and tour. This means that when data structure $19$ is displayed in the NLDR plot, data structure $20$ appears in the tour.  -->

The degree of separation between centroids is changed using four scale factors: $0.1$ (small), $0.6$ (small-medium), $0.9$ (medium), and $1.1$ (large),  in the SAME trials. In contrast, data structures used for the DIFFERENT trials retained the original centroid distances (called medium-large).

#### Attention check data

There are two sets of attention check data; one consisting of three Gaussian clusters and the other consisting of four Gaussian clusters. Each cluster is generated using a multivariate normal distribution where the mean vectors and variances were predefined. Specifically, for the three-cluster case, the mean vectors were set as $[1, 0, 0, 0]$, $[0, 1, 0, 0]$, and $[0, 0, 1, 1]$, with a common variance of $0.1$ for all clusters. For the four-cluster case, the mean vectors were defined as $[1, 0, 0, 1]$, $[0, 1, 1, 0]$, $[1, 0, 1, 0]$, and $[0, 1, 0, 1]$, also using a variance of $0.1$. This approach ensures that data points are normally distributed around the specified centroids, with the spread controlled by the variance parameter. Each Gaussian cluster dataset consists of $4\text{-}D$ data with a sample size of $7500$, and each cluster contains an equal number of data points.

### Organization of SAME and DIFFERENT trials

Although the main analysis focuses on trials where the same data are shown in both displays, it is essential to include DIFFERENT trials in the experiment. Without them, participants could rely on a trivial strategy—such as always responding "SAME" and still achieve high accuracy. DIFFERENT trials therefore act as a necessary control, ensuring that correct responses in SAME trials reflect genuine perceptual agreement between the NLDR layout and the tour rather than response bias or guessing.

Therefore, the experiment was designed to include a mixture of SAME, DIFFERENT, and attention check trials. In total, $28$ non–attention-check data structures were used. Of these, $18$ data structures were assigned to SAME trials, where the same high-dimensional data structure was used to generate both the $2\text{-}D$ NLDR plot and the tour. These trials are the primary focus of the analysis.

The remaining $10$ data structures were used to create DIFFERENT trials. In these cases, the NLDR plot and the tour were generated from two distinct but related data structures. For example, when data structure `three_clust_19` appeared in the NLDR plot, `three_clust_20` was shown in the tour. Although these DIFFERENT trials are not analysed directly, they play a crucial role in maintaining the integrity of the task by preventing systematic response strategies.

In addition, two clearly separable Gaussian cluster data sets were included as attention checks. These appear as both SAME and DIFFERENT trials and are used to verify that participants are paying attention and are able to perform the task under easy conditions.

To avoid learning and familiarity effects, each participant sees each data structure only once. Data sets were therefore assigned to subjects randomly but without replacement at the subject level. This ensures that participants cannot rely on memory from earlier trials and that each judgment is based solely on the visual information presented.

### Experiment design

The visual layout of the experiment for five subjects is shown in @fig-exp-design. Each subject completed $20$ trials: $15$ SAME trials, in which the same data structure was shown in both the $2\text{-}D$ NLDR plot and the tour; $4$ DIFFERENT trials, showing DIFFERENT data structures; and one attention check trial that could be either SAME or DIFFERENT. The purpose of the DIFFERENT trials was to ensure that subjects didn't get too familiar with the task, which might happen if the data is always the same in both graphics.  For the SAME, five NLDR methods (*tSNE, UMAP, PHATE, PaCMAP, and TriMAP*) were each paired with three of five distance scale factors (*small, small-medium, medium, medium-large, and large*), giving $15$ balanced combinations. In the DIFFERENT, four NLDR methods were randomly selected, with the remaining method assigned to the attention check trial. All DIFFERENT and attention check trials used a distance scale factor of *medium-large*.



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Experimental design for ten subjects. Shapes represent NLDR methods, and fill colors denote distance scale factors, ranging from low to high separability and mapped from light to dark. The figure shows only the SAME trials, making it easier to see the balanced design: for each subject, all five NLDR methods (tSNE, UMAP, PHATE, TriMAP, and PaCMAP) are equally represented, and each method appears with three of the five distance scale factors (small, small–medium, medium, medium–large, and large), distributed across subjects. The order of trials is randomized within each subject. In the full experiment (not shown), DIFFERENT trials and attention checks were inserted at random positions. Each subject completed $20$ trials in total: $15$ SAME trials, $4$ DIFFERENT trials comparing different data structures, and $1$ attention check (SAME or DIFFERENT). All DIFFERENT and attention-check trials used a medium–large distance scale factor.](05-chap5_files/figure-html/fig-exp-design-1.png){#fig-exp-design fig-align='center' fig-pos='H' fig-alt='A design shows the visual layout of an experiment for ten subjects, arranged in ten rows (one per subject) and 15 columns (one per trial). Each object represents a single trial. Along the horizontal axis, trials are ordered from 1 to 20; the vertical axis lists subjects 1 through 5. Most cells (15 per subject) are coded as SAME trials, where the same data structure is shown in both the 2‑D NLDR plot and the tour. SAME trials are further distinguished by combinations of five NLDR methods (tSNE, UMAP, PHATE, PaCMAP, TriMAP) and five distance scale factors (small to large), with 15 balanced method–scale combinations per subject. The grid visually emphasizes that each subject has the same number of trials and a consistent pattern of many SAME trials.' width=100%}
:::
:::


### Experimental factors

Two factors of interest were considered in the experiment: the NLDR method and the distance scale factor.

The first factor consisted of five NLDR methods: *tSNE, UMAP, PHATE, PaCMAP, and TriMAP* each producing a $2\text{-}D$ representation.

The second factor, the distance scale factor, controlled the degree of cluster separation in the high-dimensional space. Five categorical levels: *small, small–medium, medium, medium–large, and large* were defined to represent increasing degrees of separability. This categorical design enhances interpretability and perceptual distinctness, allowing subjects to discern meaningful structural differences while maintaining robustness against minor data variations.

In our analysis of the results, we decided to quantify the distances between clusters numerically rather than using the distance scale factor levels directly. Cluster separability was quantified using two complementary measures: the *between-to-within (BW) ratio* and the *minimum inter-cluster distance*. A higher value of either metric indicates greater separation among clusters (@fig-dist-metrics). 

The BW ratio, defined as

$$
  \text{BW ratio}
  =
  \frac{
      \sum_{i=1}^{K} n_i~d(\bar{\mathbf{x}}_i, \bar{\mathbf{x}})
  }{
      \sum_{i=1}^{K} \sum_{\mathbf{x}_j \in C_i}
      d(\mathbf{x}_j, \bar{\mathbf{x}}_i)
  },
$$

where $d(\cdot,\cdot)$ denotes the Euclidean distance, $C_i$ is the $i^{th}$ cluster with $n_i$ observations, $\bar{\mathbf{x}}_i$ is the centroid of cluster $C_i$, and $\bar{\mathbf{x}}$ is the overall centroid of the dataset.

In addition, the minimum distance was used as a complementary measure of global separation:

$$
  \text{minimum distance} =
  \min_{k \neq \ell}\min_{\mathbf{x}_i \in C_k,\mathbf{x}_j \in C_l}
  d(\mathbf{x}_i, \mathbf{x}_j),
$$

which captures the closest proximity between any two clusters.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Distribution of distance metric values across distance scale factors used as treatments in the experiment. (a) scaled between-to-within (BW) ratio and (b) exp(scaled minimum inter-cluster distance), each plotted against five categorical distance scale factors: small (S), small–medium (SM), medium (M), medium–large (ML), and large (L). Both metrics increase systematically with the scale factor, confirming that the distance scale treatment effectively controls cluster separability in the high-dimensional space.](05-chap5_files/figure-html/fig-dist-metrics-1.png){#fig-dist-metrics fig-align='center' fig-alt='Two-panel figure showing the distribution of cluster separation metrics across categorical distance scale factors. Panel (a) displays a quasi-random scatter plot of the scaled between-to-within (BW) ratio. The horizontal axis lists five categorical distance scale factors—small (S), small–medium (SM), medium (M), medium–large (ML), and large (L) arranged from left to right. The vertical axis shows BW ratio values on a continuous numeric scale increasing upward. For each scale factor, multiple points are plotted with slight horizontal jitter, forming vertical bands that represent the distribution of BW ratios under that condition. The point clouds shift progressively upward from S to L, indicating larger BW ratios at higher distance scales. Panel (b) shows a similar quasi-random scatter plot for the exponential scaled minimum inter-cluster distance. The horizontal axis again displays the five distance scale factors (S to L), and the vertical axis shows minimum distance values on a continuous scale. Points are jittered horizontally within each category, producing vertical distributions whose central tendency increases from left to right.' width=100%}
:::
:::


### Subject recruitment

Subjects were recruited from the Prolific crowd-sourcing platform [@palan2018]. The study expects that the subjects are uninvolved judges with no prior knowledge of the data to avoid inadvertently affecting results. Pre-screening procedures were applied the recruitment: potential subjects needed with fluent in English and have completed at least $10$ Prolific studies with a $98\%$ approval rate.

### Data collection

The survey web application, [Match-a-roo](https://ebsmonash.shinyapps.io/web_game/) was used for data collection. Subjects provided introduction and instructions for the survey. Before start the survey, the subjects can lead to the "example" page which allow them to experiment with the data collection interface and practice deciding whether the two displays shown the same data or not. The main purpose of using the "example" was merely intended to familiarize the subjects with the questions which would be asked as well as the process of deciding whether the two displays shown the same data or not. The interface did not provide any numeric feedback as to subject correctness.

The subjects were asked to provide their Prolific ID and their consent to the responses being used for analysis. After giving consent, the subject can start the trials. Two visual displays of data were shown where the data may be the SAME or DIFFERENT. One of the visual displays is a $2\text{-}D$ NLDR plot, and the other is a tour. The subjects were asked to decide whether that data was the same in both displays and to report their confidence about their choice and any comments about the answer.

After completing $20$ evaluations, they were asked for their demographics which included preferred pronoun, the highest level of education achieved, their age category, whether they used principal component analysis in their work, and whether they applied NLDR techniques such as tSNE and UMAP.

### Generalized Linear Mixed-Effects Models

Two generalized linear mixed effects models [@mcculloch2001] were fitted to model the likelihood of detecting the data structure in both the $2\text{-}D$ NLDR layout and the tour (@eq-glmm1). Both models accounted for subject-level variability and the effect of distance measures under different NLDR methods. The general form of the model is given by:

$$
\text{logit}(P(y_{ijm} = 1)) = \mu_{m} + \beta_{m} d_{i} + \gamma_{j},
$$ {#eq-glmm1}

where $\mu_{m}$ is the intercept, $d_i$ is the distance measure for the data structure $i = 1, \dots, 18$, $\beta_m$ is the fixed effect of distance metric under NLDR method $m$, $\gamma_j$ is the random effect of the subject $j = 1, 2, \dots, 127$, where $\gamma_j \sim N(0, \sigma_\gamma^2)$. Separate models were fitted using $d_i$ as either the scaled BW ratio or the exp(scaled minimum distance). The NLDR methods denoted by $m$ can include TriMAP, UMAP, PaCMAP, tSNE, and PHATE. The models were fitted using the `lme4` package [@douglas2015] and examined with the `emmeans` package [@russell2025].

## Results {#sec-results}

The data was collected from $127$ subjects, resulting in $127 \times 15 = 1905$ evaluations, excluding the attention check trials and the trials showing the different data in two displays.

### Effect of method and distance between clusters

The proportion of correct identifications across NLDR methods and distance conditions was analysed to evaluate how effectively each method preserves cluster separation. Results are summarized using two generalized linear mixed-effects models, with either the scaled BW ratio (@fig-glmm, @tbl-glmm) or the exp(scaled minimum distance) (@fig-glmm-min, @tbl-glmm-min) as the distance predictor. Both models accounted for subject-level variability through random effects and included NLDR method as a fixed factor interacting with the distance measure.

Results from the model using the scaled BW ratio (@tbl-glmm) indicate that cluster separability positively influences correct identification for some NLDR methods. As shown in @fig-glmm, UMAP exhibits a clear increase in accuracy as the scaled BW ratio increases, suggesting that this method benefits from greater between-cluster separation. PaCMAP shows a positive but weaker trend, while TriMAP maintains stable performance across the range of separations. In contrast, tSNE and PHATE display declining accuracy at higher BW ratios, indicating that increased separation may distort or obscure structural cues for these methods.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {#tbl-glmm .cell layout-align="center" tbl-cap='Estimated trends of correct identification probability with respect to scaled BW ratio by NLDR method.The table shows method-specific slope estimates (log-odds scale) for the effect of the scaled BW ratio on the probability of correct identification, obtained from a generalized linear mixed-effects model. Estimates represent the change in log-odds of correct identification per unit increase in scaled BW ratio for each NLDR method, along with standard errors (SE), 95\% confidence intervals, Wald z-statistics, and corresponding p-values. p-values and Confidence Intervals are calculated assuming normally distributed errors in the estimates. Positive estimates indicate improved identification accuracy with increasing cluster separation, while negative estimates indicate declining accuracy. Significance codes: ($\emph{p}\leq 0.001$ \'`***`\', $\emph{p}\leq 0.01$ \'`**`\', $\emph{p}\leq 0.05$ \'`*`\', $\emph{p}\leq 0.1$ \'`.`\').'}
::: {.cell-output-display}


|Method | Slope|   SE|95% CI        |     z|p          |
|:------|-----:|----:|:-------------|-----:|:----------|
|TriMAP |  0.03| 0.49|[-0.92, 0.99] |  0.07|0.95       |
|UMAP   |  1.15| 0.49|[0.19, 2.11]  |  2.35|0.02 *     |
|PaCMAP |  0.51| 0.48|[-0.43, 1.45] |  1.06|0.29       |
|tSNE   | -2.61| 0.62|[-3.83, -1.4] | -4.20|<0.001 *** |
|PHATE  | -0.92| 0.54|[-1.97, 0.13] | -1.71|0.09 .     |


:::
:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Estimated probability of correct identification as a function of the scaled BW ratio for five NLDR methods. The left panel shows model-based estimated probabilities with 95\% confidence intervals across values of the scaled BW ratio. The right panels show observed proportions of correct identification (black points) and fitted logistic regression curves for each method. Each black point represents the proportion of SAME responses from a distinct combination of data structure, distance scale factor, and NLDR method. The scaled BW ratio measures relative cluster separation, with larger values indicating greater separability. Performance trends differ across methods, with UMAP showing increasing accuracy, tSNE and PHATE decreasing accuracy, and TriMAP exhibiting relatively stable performance.](05-chap5_files/figure-html/fig-glmm-1.png){#fig-glmm fig-align='center' fig-pos='!ht' fig-alt='Multi-panel figure showing the relationship between cluster separation and identification accuracy for five NLDR methods. In the left panel, a line plot displays model-based estimated probabilities of correct identification as a function of the scaled between–within (BW) ratio. The horizontal axis represents the scaled BW ratio, increasing from low to high cluster separability, and the vertical axis shows predicted probability of correct identification, ranging from 0 to 1. Five colored lines correspond to UMAP, PaCMAP, TriMAP, tSNE, and PHATE. Each line is surrounded by a shaded band indicating a 95% confidence interval around the estimate. The right side of the figure contains separate panels for each NLDR method. In each panel, the horizontal axis again shows the scaled BW ratio and the vertical axis shows the proportion of correct identifications. Black points represent observed proportions at different BW ratio values, and a smooth colored curve overlays the points, representing the fitted logistic regression model for that method.' width=100%}
:::
:::


To assess whether these patterns depend on how separation is quantified, we fitted a second model using the exp(scaled minimum distance) as an alternative measure of cluster separability (@tbl-glmm-min). The results closely mirror those obtained with the BW ratio (@fig-glmm-min). In particular, UMAP again shows a significant positive association between separation and correct identification probability, confirming that greater spatial distance between clusters enhances its ability to reveal the underlying structure. Conversely, tSNE demonstrates a strong negative association, with performance deteriorating as minimum distance increases, while PHATE exhibits a weaker but consistent negative trend. The effects for PaCMAP and TriMAP are not statistically significant, indicating comparatively stable performance across varying levels of separation.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {#tbl-glmm-min .cell layout-align="center" tbl-cap='Estimated trends of correct identification probability with respect to exp(scaled minimum distance) by NLDR method.The table shows method-specific slope estimates (log-odds scale) for the effect of the exp(scaled minimum distance) on the probability of correct identification, obtained from a generalized linear mixed-effects model. Estimates represent the change in log-odds of correct identification per unit increase in exp(scaled minimum distance) for each NLDR method, along with standard errors (SE), 95\% confidence intervals, Wald z-statistics, and corresponding p-values. p-values and Confidence Intervals are calculated assuming normally distributed errors in the estimates. Positive estimates indicate improved identification accuracy with increasing cluster separation, while negative estimates indicate declining accuracy. Significance codes: ($\emph{p}\leq 0.001$ \'`***`\', $\emph{p}\leq 0.01$ \'`**`\', $\emph{p}\leq 0.05$ \'`*`\', $\emph{p}\leq 0.1$ \'`.`\').'}
::: {.cell-output-display}


|Method | Slope|   SE|95% CI        |     z|p          |
|:------|-----:|----:|:-------------|-----:|:----------|
|TriMAP |  0.20| 0.20|[-0.2, 0.59]  |  0.97|0.33       |
|UMAP   |  0.59| 0.20|[0.2, 0.98]   |  2.99|0.00 **    |
|PaCMAP |  0.22| 0.19|[-0.16, 0.6]  |  1.12|0.26       |
|tSNE   | -0.78| 0.22|[-1.2, -0.35] | -3.60|<0.001 *** |
|PHATE  | -0.35| 0.21|[-0.76, 0.06] | -1.68|0.09 .     |


:::
:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Estimated probability of correct identification as a function of the exp(scaled minimum distance) for five NLDR methods. The left panel shows model-based estimated probabilities with 95% confidence intervals across values of the exp(scaled minimum distance). The right panels show observed proportions of correct identification (black points) and fitted logistic regression curves for each method. Each black point represents the proportion of SAME responses from a distinct combination of data structure, distance scale factor, and NLDR method. Larger values correspond to greater spatial separation between clusters. UMAP shows increasing accuracy with increasing separation, whereas tSNE and PHATE show declining trends, and TriMAP exhibits relatively stable performance.](05-chap5_files/figure-html/fig-glmm-min-1.png){#fig-glmm-min fig-align='center' fig-pos='!ht' fig-alt='A multi-panel figure showing the relationship between cluster separation and identification accuracy for five NLDR methods. The left panel is a line plot of model-based estimated probabilities of correct cluster identification. The horizontal axis represents exp(scaled minimum distance), increasing from low to high cluster separation, and the vertical axis shows predicted probability of correct identification, ranging from 0 to 1. Five colored curves correspond to UMAP, tSNE, PHATE, PaCMAP, and TriMAP, each surrounded by a shaded 95% confidence interval band. The right side of the figure contains separate panels for each NLDR method. In each panel, the horizontal axis again shows exp(scaled minimum distance) and the vertical axis shows the proportion of correct identifications. Black points represent observed proportions at different separation levels, and a smooth colored curve overlays the points, showing the fitted logistic regression model for that method.' width=100%}
:::
:::


Taken together, these results demonstrate that the impact of cluster separability on correct identification is robust to the choice of distance measure but varies substantially across NLDR methods. Methods such as UMAP benefit from increased separation, whereas tSNE and PHATE appear sensitive to over-separation, potentially leading to distortions in the low-dimensional representation. TriMAP, by contrast, shows little sensitivity to changes in separation, suggesting robustness across a wide range of cluster configurations.

### Patterns for misidentification

To better understand the patterns of misidentification, we examine tSNE and UMAP layouts for data structures that are commonly confused by participants. Rather than treating errors as random noise, this analysis shows that misidentification often arises from a combination of the underlying structure of the data and the way NLDR methods transform that structure. In particular, several recurring visual patterns appear to drive perceptual confusion.

One common pattern is that, regardless of the distance between clusters in high-dimensional space, tSNE often places clusters very close together in the NLDR layout. This compression reduces visual separation and makes distinct clusters appear really close or overlapping, even when they are well separated in the original space. For example, in both `three_clust_12` and `three_clust_07` (@fig-three12-miss and @fig-three07-miss), increasing the distance between clusters does not consistently improve separation in tSNE. As a result, subjects may perceive these clusters as belonging to a single cluster or as weakly separated clusters, leading to confusion between clearly distinct high-dimensional configurations.

Another strong source of misidentification is the tendency of NLDR methods to break a single cluster into multiple small clusters. This is especially common for nonlinear and star-shaped structures. In tSNE layouts, continuous shapes such as S-curves, hyperbolic structures (@fig-three07-miss), and star-shaped clusters are frequently fragmented into disconnected pieces, creating the impression of several separate clusters where only one exists in high dimensions. For example, star-shaped clusters in particular (@fig-three12-miss), the individual arms are often pulled far apart, making them appear as independent clusters and obscuring the fact that they belong to a single structure. UMAP shows a similar tendency to split star-shaped clusters into multiple groups; however, compared to tSNE, the overall star-like arrangement is often still visible. This partial preservation of global structure makes the cluster more identifiable in UMAP, even though misinterpretation can still occur.

Linear or smoothly varying structures in high dimensions often appear nonlinear after dimension reduction. This change can strongly affect how a structure is perceived. In our examples, the hemispherical cluster provides a clear case: although it varies smoothly and has a relatively simple structure in high dimensions, both tSNE and UMAP frequently bend or warp it into curved or irregular shapes in the NLDR layout (@fig-three12-miss and @fig-three07-miss). As a result, the hemisphere can resemble a curved manifold rather than a smooth surface, making it harder to distinguish from genuinely nonlinear structures. This effect becomes more pronounced when the hemisphere appears alongside strongly curved components, as the projected shapes start to look visually similar.

Across multiple examples, including `three_clust_12` and `three_clust_07` (@fig-three12-miss and @fig-three07-miss), increasing high-dimensional separation does not reliably lead to more interpretable layouts. UMAP often benefits more from increased separation, preserving overall geometry and making components easier to distinguish. However, partial proximity between clusters can still remain, allowing perceptual ambiguity to persist. For tSNE, greater separation may even worsen interpretability by increasing fragmentation or compressing global structure, weakening the participants rely on to identify cluster relationships.

Another common source of misidentification comes from uneven point density. In some of our data structures, density is an important feature of the shape in high dimensions, but it is not reliably preserved in the NLDR layouts. For example, in the nonlinear hyperbolic structure (@fig-three12-miss), one corner is clearly denser in high dimensions, yet this feature is not easy to identify in either tSNE or UMAP layouts. Similarly, the tip of the star-shaped pyramid is densely populated in high dimensions (@fig-three07-miss), but this density cue is often lost in the projections; especially in tSNE, where the structure is further distorted or fragmented. When these density cues are weakened or misplaced, participants lose important visual signals needed to recognize the underlying structure, increasing the chance of misidentification.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![tSNE and UMAP layouts and $2\text{-}D$ projections for the data structure `three_clust_07`, composed of a nonlinear hyperbola, a hemisphere, and a triangular pyramid, shown under small and large cluster separation. Panels (a1–a2) show two fixed $2\text{-}D$ projections at small separation, and panels (b1–b2) show the same projections at large separation; the corresponding tSNE and UMAP layouts are shown in the right panels. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is reported in the top-right corner of the plot. At small separation, curved and rounded components overlap substantially in both methods, making the structure difficult to distinguish. With increased separation, UMAP yields smoother, more continuous representations that retain the curvature of the hyperbolic component and improve spacing between clusters. In contrast, tSNE bends and breaks the hyperbolic structure and introduces irregular gaps between points, weakening global shape cues.](05-chap5_files/figure-html/fig-three07-miss-1.png){#fig-three07-miss fig-align='center' fig-alt='A multi-panel figure comparing NLDR layouts and linear projections of the same 4-D dataset, labelled three_clust_07. The data consist of three geometric structures: a curved hyperbolic band, a rounded hemispherical cluster, and a triangular pyramid-shaped cluster. The left half of the figure shows four 2-D linear projections arranged in two rows. Panels (a1) and (a2) display two fixed 2-D projections under small cluster separation, while panels (b1) and (b2) show the same projections under large cluster separation. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is reported in the top-right corner of the plot. In the small-separation projections, points from the three structures overlap substantially, with the curved and rounded components intermingling. In the large-separation projections, the three structures are more spatially separated, making the curved hyperbolic band, hemispherical cluster, and pyramid-shaped cluster more distinguishable. The right side of the figure shows corresponding 2-D NLDR layouts produced by tSNE and UMAP for the same small and large separation settings. In the small-separation layouts, both methods display overlapping point clouds with limited visual separation between structures. In the large-separation layouts, UMAP produces smoother, more continuous point arrangements that follow the curved shape of the hyperbolic structure and increase spacing between clusters, while tSNE shows a more fragmented layout with bends, breaks, and irregular gaps in the curved structure.' width=100%}
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
![tSNE and UMAP layouts and $2\text{-}D$ projections for the data structure `three_clust_12`, composed of an S-curve, a hemisphere, and a filled hexagonal pyramid, shown under small and large cluster separation. Panels (a1–a2) show two fixed $2\text{-}D$ projections at small separation, and panels (b1–b2) show the same projections at large separation; the corresponding tSNE and UMAP layouts are shown in the right panels. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is reported in the top-right corner of the plot. At small separation, curved and rounded components overlap substantially in both methods, making the structure difficult to distinguish. With increased separation, UMAP preserves the distinct geometric character of each component, maintaining an elongated S-curve, a compact hemisphere, and a coherent pyramidal structure. In contrast, tSNE fragments curved and volumetric components into irregular, disconnected pieces, obscuring global shape cues.](05-chap5_files/figure-html/fig-three12-miss-1.png){#fig-three12-miss fig-align='center' fig-alt='A multi-panel figure comparing linear projections and NLDR layouts of the same 4-D dataset, labelled three_clust_12. The data consist of three geometric structures: an elongated S-curve, a rounded hemispherical cluster, and a filled hexagonal pyramid. The left portion of the figure shows four fixed 2-D linear projections arranged in two rows. Panels (a1) and (a2) display two projections under small cluster separation, where points from the three structures overlap substantially and the curved and rounded components are difficult to distinguish. Panels (b1) and (b2) show the same projections under large cluster separation, where the S-curve, hemisphere, and pyramid become more spatially separated and visually distinct. The right portion of the figure shows the corresponding 2-D NLDR layouts produced by tSNE and UMAP for the same small and large separation settings. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is reported in the top-right corner of the plot. At small separation, both methods show overlapping point clouds with limited separation between structures. At large separation, the UMAP layout displays a smooth, elongated S-shaped structure alongside a compact hemispherical cluster and a coherent pyramidal cluster. In contrast, the tSNE layout shows these structures broken into multiple disconnected or irregularly shaped groups.' width=100%}
:::
:::


## Limitations {#sec-limitations}

One of the main drawbacks of visual experiments is their reliance on human judgments. In this context, the effectiveness of identifying the $2\text{-}D$ NLDR plot and the tour from the same data can be dependent on the perceptual ability and visual skills of the individual. However, when the results from multiple individuals are combined, the overall quality and robustness of the outcome is considerably high.

It is important to remove HTML widget elements such as controls, interactivity, and $2\text{-}D$ plot elements such as axis labels and text that might introduce bias. We recommend using a crowd-sourcing service like Prolific [@palan2018] to access high-quality data, as it is a time- and cost-effective way.

In this study, we used a specific data structure consisting of three distinct clusters, each with unique shapes. Two of the clusters are in close proximity to one another, while the third cluster is located farther away. Each cluster varies in the number of points it contains. We selected this data structure because it is simple.

To keep the experiment fair and consistent across trials, we approximately fixed the distance between the clusters in each data structure. We also used five distance scale factors to gradually change how far apart the clusters were. While this controlled setup makes it easier to interpret the results, it does limit how well the findings apply to more complex data structures with uneven or irregular cluster arrangements.

## Conclusions {#sec-exp-conclusion}

This study examined whether people can correctly identify that a static $2\text{-}D$ NLDR layout and a dynamic tour represent the same high-dimensional data, and how this ability depends on both cluster separation and the NLDR method used. Using three clusters with different shapes, number of points, and unequal separation, we were able to directly test whether increasing high-dimensional separation improves perceptual identification, and whether this effect varies across methods.

The results show that cluster separation does matter, but its impact is strongly method dependent. For UMAP and PaCMAP, increasing separation led to higher probabilities of correct identification, indicating that these methods more reliably preserve data structures that support visual matching between the NLDR layout and the tour. TriMAP showed a weaker but generally consistent trend. In contrast, tSNE often showed the opposite pattern: greater separation did not improve, and in some cases reduced, correct identification, suggesting that its emphasis on local structure can distort global relationships in ways that hinder perceptual alignment. PHATE showed little systematic relationship between separation and identification accuracy, consistent with its focus on smooth manifold structure rather than discrete cluster separation.

Importantly, misidentification was not random. Some data structure components, particularly curved or dense shapes were consistently more difficult to recognize across methods, even at larger separations. This indicates that perceptual errors arise from systematic interactions between data structure and method-specific distortions, rather than from subject variability alone. These findings support the need to evaluate NLDR layouts not only by algorithmic criteria, but also by how well they function as visual models in high-dimension space.

Future work could extend this framework by considering additional data structures, including overlapping clusters, hierarchical manifolds, and continuous gradients, as well as varying noise levels, dimensionality, and sample size. Comparisons with linear methods such as PCA, or with supervised embeddings, would help clarify whether the observed effects are specific to nonlinear techniques. Incorporating automated visual similarity measures alongside human judgments, and exploring interactive or user-centered evaluations, could further strengthen this approach. Overall, this work highlights the need for systematic, perceptually grounded methods to assess $2\text{-}D$ NLDR layouts as representations of high-dimensional data space.

## Supplementary Materials

<!-- All the materials to reproduce the chapter can be found at [github.com/JayaniLakshika/paper-vis-experiment](https://github.com/JayaniLakshika/paper-vis-experiment). -->

The appendix provides additional details on the experimental materials and process, including the three-cluster data structures, $2\text{-}D$ NLDR layouts, inter-cluster distance metrics, and the data collection and analysis processes, along with links to videos, and scripts.

## Acknowledgments

A pilot study was conducted with sample subjects from the working group of the Department of Econometrics and Business Statistics, Monash University. This pilot study allowed us to estimate the study's completion time and the effect size and fine-tune the application.

These R packages were used for the work: `tidyverse` [@hadley2019], `lme4` [@douglas2015], `broom.mixed` [@ben2024], `ggbeeswarm` [@erik2023], `emmeans` [@russell2025], `patchwork` [@thomas2024], `colorspace` [@achim2020], `kableExtra` [@hao2024], `conflicted` [@hadley2023], `Rtsne` [@jesse2015], `umap` [@tomasz2023], `phateR`[@moon2019], `reticulate` [@kevin2024], `langevitour` [@harisson2024], `binom` [@sundar2022], `gridExtra` [@baptiste2017], `shiny` [@winston2025a], `shinydashboard` [@winston2025b], `shinythemes` [@winston2021], `bslib` [@carson2025], `shinyjs` [@dean2021], `DT` [@yihui2016], `googledrive` [@lucy2025], `googleAuthR` [@mark2024], `googlesheets4` [@jennifer2025], `shinyalert` [@dean2024a], `shinypop` [@fanny2024], `randomNames` [@damian2024], `shinyfullscreen` [@etienne2021], `shinyWidgets` [@victor2025], `hms` [@kirill2025], `shinythemes` [@winston2021], and `shinycssloaders` [@dean2024]. These `python` packages were used for the work: `trimap` [@amid2022] and `pacmap` [@yingfan2021]. 
