# Perception and Misperception of Clustering in Nonlinear Dimension Reduction: A User Study {#sec-second-paper}

Nonlinear dimension reduction (NLDR) methods such as tSNE, UMAP, PHATE, TriMAP, and PaCMAP are popular ways to visualize high-dimensional data, yet their effectiveness for conveying structure remains mysterious. Many factors might contribute to perceptual miscommunication, which for cluster structure, may include how their shapes are represented, the degree of separation, or even the number of clusters. This study evaluates how well NLDR methods preserve perceptually meaningful cluster structure using a human subject experiment with simulated data having three clusters with distinct geometries, unequal sizes, and varying inter-cluster separation. Subjects were asked whether a $2\text{-}D$ NLDR layout and a tour of linear projections showed the same high-dimensional data. Cluster separation was controlled for the study to be the distance between means, but for analyzing the results, two additional measures, the between-within (BW) ratio and the exponentially scaled minimum inter-cluster distance, were used to account for highly nonlinear shapes. The results suggest interesting differences across methods. For example, UMAP and tSNE represent the distance between clusters distinctly differently, resulting in data being interpreted differently. These findings highlight the need for more studies to assess NLDR methods based on how effectively their visualizations support human perception of high-dimensional structure.




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

Nonlinear transformations allow for multiple shape-varying clusters to be represented in a single $2\text{-}D$ layout. In contrast, classical linear projection will often require multiple projections to show multiple clusters. @fig-nldr-layouts illustrates this: a1-a4 show linear projections revealing three well-separated clusters, one spherical, one ribbon-like, and one like a star-shaped pyramid. The NLDR layout (left) is generated using tSNE and has a mostly reasonable display of the three clusters in a single view, although it struggles with the star pyramid. It does place the clusters very close to each other, which does not reflect the large separation in the high-dimensional space.  


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
![A $2\text{-}D$ tSNE layout (left) and four $2\text{-}D$ projections (a1–a4) of the same $4\text{-}D$ data. The data consist of three main structures: a star-shaped pyramid, a curvilinear cluster, and a Gaussian-shaped cluster. While the tour consistently shows the star-shaped cluster as a single coherent group, the $2\text{-}D$ tSNE layout fragments this structure into several smaller clusters. This illustrates how NLDR may distort global structure, making the same $4\text{-}D$ cluster appear as multiple clusters in the $2\text{-}D$ layout.](05-chap5_files/figure-html/fig-nldr-layouts-1.png){#fig-nldr-layouts fig-align='center' fig-pos='!ht' fig-alt='Multi-panel figure comparing a 2-D NLDR layout with multiple linear projections of the same 4-D data. The left panel shows a 2-D t-SNE layout with abstract horizontal and vertical axes representing embedding dimensions, each spanning a roughly symmetric range around zero. Points are colored or symbol-coded to indicate three underlying data structures. One group forms a compact, approximately spherical cluster. A second group forms a long, curved, ribbon-like band. A third group forms a star-shaped, pyramid-like structure with multiple arms radiating outward from a central region; in the tSNE layout, this structure appears split into several smaller, spatially separated point groups. The four right-hand panels (labeled a1–a4) show different 2-D linear projections of the same 4-D data, as produced by a tour. Each panel uses horizontal and vertical axes corresponding to different linear combinations of the original four variables, with numeric scales varying across projections but remaining continuous. In each projection, the same three data structures are visible: the spherical cluster appears compact, the curvilinear structure appears as a bent or elongated band whose orientation changes across projections, and the star-shaped pyramid appears as a single connected structure whose shape and orientation vary but remain coherent across all four views.' width=100%}
:::
:::


In general, the dilemma for the analyst is to make the conceptual leap from the structure displayed in the NLDR layout to what exists in high dimensions. From @fig-nldr-layouts we might find that the analyst correctly conceptualizes the existence of the spherical and ribbon clusters, but mistakenly considers them close in high dimensions. The star-shaped pyramid might be incorrectly conceptualized as a lot of small clusters, possibly triangular in shape. This is what the work presented here is attempting to assess: whether the conceptualization from the NLDR reasonably matches that gained by viewing the same data using a tour of linear projections. 

<!-- from Paul: Ideally we would be able to say that XX% of readers would accurately report YY -->

The chapter is organized as follows. @sec-background provides a summary of the literature on NLDR, high-dimensional data, and visualization methods. @sec-experiment describes the experiment designed to examine people's perception to assess how viewers recognize structure differently from a $2\text{-}D$ NLDR layout and the tour view. @sec-results discusses the collected data, results, and reasons for misperception. Limitations are provided in @sec-limitations. A discussion of the presented work and ideas for future directions is described in @sec-exp-conclusion.

## Background {#sec-background}

Historically, $2\text{-}D$ nonlinear representations of $p\text{-}D$ data have been obtained through versions of multidimensional scaling (MDS) (originally defined by @kruskal1964, and see @borg2005 for a modern overview) and linear representations using principal component analysis (PCA) (for an overview see @jolliffe2011). MDS aims to construct a low-dimensional (usually $2\text{-}D$) layout that preserves pairwise distances between observations in the original space by minimizing a stress function. <!-- Variants such as non-metric scaling [@saeed2018] and isomap [@silva2002] extend this approach to capture nonlinear relationships.--> Challenges such as distance concentration that lead to difficulties for interpretation have been documented by @johnstone2009.

NLDR methods have been developed to improve on MDS with varying degrees of preserving local and/or global structures of $p\text{-}D$ data, with some modern methods being tSNE, UMAP, PHATE, TriMAP, and PaCMAP. Each method uses different underlying principles. For example, tSNE and PHATE emphasize local relationships, while TriMAP and PaCMAP are designed to better capture global structure. As a result, these methods can produce very different $2\text{-}D$ layouts of the same data, potentially leading to misinterpretation of structures such as cluster separation. 

An alternative to NLDR for visualizing $p\text{-}D$ data is to use linear projections. PCA is the classical approach, producing new variables as linear combinations of the original dimensions. While PCA provides a single static projection that maximizes variance, tours introduced by @As85 extend this idea by generating smooth sequences of linear projections, effectively creating a movie of the data viewed from multiple directions. Tours can reveal structures that may be hidden in any single projection by continuously changing the viewing angle through high-dimensional space. Many tour algorithms have since been developed and are implemented in the R package `tourr` [@wickham2011], with interactive variants available in `langevitour` [@harisson2024] and `detourr` [@casper2025]. Tours are valuable because they preserve the geometry of the data, unlike NLDR methods - they do not warp distances or angles. This makes them faithful but sometimes visually cluttered representations: global structure can obscure local detail, and the phenomenon of piling [@laa2022], where high-dimensional points project toward the center, can make clusters harder to distinguish.

Quantifying clusters in shape and separation is not simple. For this experiment, a variety of shapes were generated using the functions in the `cardinalR` package [@jayani2025b]. Cluster separation can be summarised using measures such as the between–within (BW) ratio, which captures global separability under assumptions of approximately spherical cluster structure. A variety of distance-based metrics have been proposed in the clustering and visualization literature [@tadeusz1974; @peter1987; @david1979], including minimum, maximum, and average distances between clusters, centroid distances, and ratios that combine between- and within-cluster variation. Although the data sets were created with a fixed process, the results will be examined with a variety of distance metrics to capture NLDR behavior using different lenses of separation.

<!-- To assess how well NLDR methods preserve structures such as cluster separation, it is important to quantify inter-cluster distances. A variety of distance-based metrics have been proposed in the clustering and visualization literature [@tadeusz1974; @peter1987; @david1979], including minimum, maximum, and average distances between clusters, centroid distances, and ratios that combine between- and within-cluster variation. In this study, we focus on two distance measures: the between-to-within (BW) ratio, which captures global separability, and the minimum distance between clusters, which reflects the closest approach of any two clusters. Together, these provide interpretable summaries of both overall and local cluster separation while accounting for within-cluster variability.-->

The objective of this research is to study analyst perception of  clustering structure in a $2\text{-}D$ NLDR layout comparison with that from a tour of the same high-dimensional data. The tour is generated using `langevitour`. The primary factor of interest is how the perception changes when cluster separation increases. <!--These findings will help identify common misperceptions that can arise when analysts rely solely on $2\text{-}D$ NLDR layouts, highlighting the need for careful diagnostics to verify whether perceived structures reflect the true high-dimensional patterns. This can help guide better ways to interpret and report what these visualizations are showing.-->

## Methods {#sec-experiment}

<!--
### What is a $2\text{-}D$ NLDR plot?

The $2\text{-}D$ representation of the $p\text{-}D$ data constructed to preserve as much information, like clustering and nonlinear relationships, as possible. There are various commonly used techniques for creating this $2\text{-}D$ representation, including tSNE, and UMAP. These methods aim to identify a low-dimensional structure that captures the most important patterns or relationships in the data, allowing for visualization and easier interpretation. However, it is important to note that $2\text{-}D$ embeddings can lose some information from the $p\text{-}D$ data, as they necessarily involve a loss of dimensionality.

### What is a tour?

The tour shows a sequence of two-dimensional linear projections of the $p\text{-}D$ data. It is similar to looking at shadows of a $3\text{-}D$ object, and trying to infer the shape of the $3\text{-}D$ object. Looking at linear projections of $p\text{-}D$ data is like looking at the shadows, and one hopes to gain a sense of what shapes exist in the data. For example, if the data separates into clusters in any of the projections, it means that there are clusters in the data in the high dimensions. If the data shows a nonlinear or curvilinear shape it means that there are nonlinear associations between some variables. If the data collapses to roughly a line it means that it lives in a lower dimensional space than the number of high dimensions. If the points moving differently from others, there are outliers or unusual observations in the high dimensions.
-->

Although there are many aspects of NLDR and perception of data structure to assess, for this work, we restrict attention to the distance between clusters. For a range of cluster shapes, the distance between clusters is varied, and NLDR layouts are generated by the commonly used methods with default settings. The conceptualization of clustering is tested by showing subjects two views (one NLDR layout and the tour of linear projections) and asking whether both show the same data. When the response is that they are the same, it is interpreted as that they conceptualize the clustering in both similarly. Conversely, if the response is that the two are different, it is interpreted as a different conceptualization.

It is worth noting that a "same" response reflects perceived visual similarity rather than logical certainty. A given $2\text{-}D$ NLDR layout is not uniquely determined by a single dataset, so participants can judge whether the two views appear consistent, but cannot rule this out with certainty.

<!-- We are generally interested in testing whether "The two plots displays the same data" ($H_0$) against the broad alternative "The two plots do not display the same data" ($H_a$).

Testing this broad null hypothesis ($H_0$) is practically challenging due to the variety of data structures involved. It can be both time-consuming and computationally intensive. Therefore, we focused on one data structure that is particularly useful for investigation: three clusters where two clusters are close together, while one is more distant. Three clusters have different shapes and each cluster contain different number of points. The sample size is $7500$.

Our hypothesis is as follows:

$H_{0m1}$: The distance between the clusters has no effect on the probability of correctly identifying the $2\text{-}D$ NLDR plot generated by NLDR method $m$ and the tour from the same data. Vs $H_{1m1}$: The distance between the clusters does have an effect on the probability of correctly identifying the $2\text{-}D$ NLDR plot generated by NLDR method $m$ and the tour from the same data.

This study aims to answer which NLDR methods are more accurate in identifying the same data structure in the $2\text{-}D$ NLDR plot and the tour, as the distance increases, and to identify which types of data structure components are more prone to misidentification across methods.
-->

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!-- Need to work on adding these info: -->

<!-- - In data generation:  -->
<!--     - Why three clusters? How they positioned? Why the data in 4-D? Why different number of points in each cluster? (Done) -->

<!--     - Why different shaped clusters? Why always a combination of nonlinear shaped cluster (capture nonlinear shape), pyramid shapes cluster (capture density), and other shape (hemisphere/cube/Gaussian)? (added what each dataset consist of in appendix, done) -->

<!-- - Why do we choose these specific distance scale factors? (done) -->

<!-- - Why did we scale the data sets before showing in the tour? (added as a comment) -->

<!-- - In the discussion, may add how to expand the study? (done) -->

<!-- - Why did we chose BW ratio and minimum distance? (already added to appendix but have ro think that it's necessary adding something in the main paper as well) -->


<!-- - Why these number of participants enough? (may be good to add in appendix) -->

<!-- - Why do we scaled BW ratio and minimum distance? -->

<!-- - Why do we used exponential minimum scaled distance? -->

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

### Data generation

A total of $30$ $4\text{-}D$ data sets are generated. Two are reserved as an attention check used to determine if the subject conscientiously attempted the task. All data sets were standardized prior to NLDR and are shown in the tour. <!--to ensure comparable variable scales and to prevent any single dimension from disproportionately influencing the resulting visualizations.-->

#### Non-attention check data

<!--originally the clusters are positioned in tips of a triangle in 4-D. But the things is, for each data set (sample), when computing the distances, it varies. So, used target distance between clusters. That's why the distances are approximate.-->

For the experiment, three cluster data sets are generated. The three clusters contain different numbers of points and shapes. Let $C_1, C_2,$ and $C_3$ denote the centroids of three clusters. The pairwise distances between these centroids are calculated as: $d(C_1, C_2) = c_{12},~d(C_1, C_3) = c_{13}, \text{ and } d(C_2, C_3) = c_{23}$. At the original distance scale (scale factor $1$, referred to as medium-large), clusters $C_1$ and $C_2$ are in close proximity, while cluster $C_3$ is positioned farther away, creating an asymmetric separation pattern. Centroid distances were used because they provide a simple and controllable way to adjust overall cluster separation.

The experiment consists of two types of trials: SAME trials and DIFFERENT trials. In SAME trials, two visualizations (one NLDR layout and the tour) are generated from the same underlying dataset, but with controlled variations in cluster separation. In DIFFERENT trials, the two visualizations are generated from different datasets.

In the SAME trials, the degree of separation between clusters was varied by multiplying the original centroid distances by four scale factors: $0.1$ (small), $0.6$ (small-medium), $0.9$ (medium), and $1.1$ (large). These values were chosen to span a range of perceptual difficulty from cases where clusters are expected to overlap strongly and be hard to distinguish ($0.1$), through intermediate levels where separation is visible but ambiguous ($0.6$ and $0.9$), to cases where clusters are clearly separated ($1.1$). Using proportional scaling ensures that the relative geometry of the data is preserved while systematically controlling how strongly separation cues are expressed.

In contrast, data structures used for the DIFFERENT trials retained the original centroid distances (scale factor $1$) without modification. This allows the DIFFERENT trials to serve as stable reference cases while ensuring that variation in separation is introduced only in trials where participants are asked to judge whether two displays show the same data.

Shapes for each cluster were selected randomly from a predefined set of curved, linear, and volumetric structures, including S-curves, crescents, spirals, hyperbolic and cylindrical shapes, as well as geometric solids such as cubes, hemispheres, pyramids, cones, and Gaussian clusters.

<!-- The specific shape combinations used for each data structure are listed in Appendix X. -->

<!-- In total, there are $28$ data structures used for the experiment. Out of these, $18$ data structures show the same structure in both the $2\text{-}D$ NLDR plot and tour for each experiment, while the remaining $10$ data structures display different structures in the $2\text{-}D$ NLDR plot and tour. This means that when data structure $19$ is displayed in the NLDR plot, data structure $20$ appears in the tour.  -->

<!-- The degree of separation between centroids is changed using four scale factors: $0.1$ (small), $0.6$ (small-medium), $0.9$ (medium), and $1.1$ (large),  in the SAME trials. In contrast, data structures used for the DIFFERENT trials retained the original centroid distances (called medium-large). -->

#### Attention check data

<!-- There are two sets of attention check data: one consisting of three Gaussian clusters and the other consisting of four Gaussian clusters. Each cluster is generated using a multivariate normal distribution where the mean vectors and variances were predefined. Specifically, for the three-cluster case, the mean vectors were set as $[1, 0, 0, 0]$, $[0, 1, 0, 0]$, and $[0, 0, 1, 1]$, with a common variance of $0.1$ for all clusters. For the four-cluster case, the mean vectors were defined as $[1, 0, 0, 1]$, $[0, 1, 1, 0]$, $[1, 0, 1, 0]$, and $[0, 1, 0, 1]$, also using a variance of $0.1$. This approach ensures that data points are normally distributed around the specified centroids, with the spread controlled by the variance parameter. Each Gaussian cluster dataset consists of $4\text{-}D$ data with a sample size of $7500$, and each cluster contains an equal number of data points. -->


The attention-check datasets were designed to be simple and easily interpretable, with clearly separated cluster structures that should be consistently recognized across visualizations. These datasets serve as a basic validation to ensure participants are attentive and understand the task.

Each cluster was generated from a multivariate normal distribution with predefined mean vectors and a common isotropic covariance structure. Specifically, the covariance matrix for each cluster was taken as ($\sigma^2 I$), where ($\sigma^2 = 0.1$) and ($I$) is the identity matrix, implying equal variance in all dimensions and no correlation between variables.

For the three-cluster case, the mean vectors were $[1,0,0,0]$, $[0,1,0,0]$, and $[0,0,1,1]$. For the four-cluster case, the means were $[1,0,0,1]$, $[0,1,1,0]$, $[1,0,1,0]$, and $[0,1,0,1]$. Each dataset consists of ($4\text{-}D$) observations with a total sample size of $7500$, equally divided among clusters.

### Organization of SAME and DIFFERENT trials

Although the main analysis focuses on trials where the same data are shown in both displays, it is essential to include DIFFERENT trials in the experiment. Without them, participants could rely on a trivial strategy—such as always responding "SAME" and still achieve high accuracy. DIFFERENT trials, therefore, act as a necessary control, ensuring that correct responses in SAME trials reflect genuine perceptual agreement between the NLDR layout and the tour rather than response bias or guessing.

Therefore, the experiment was designed to include a mixture of SAME, DIFFERENT, and attention check trials. In total, $28$ non–attention check data structures were used. Of these, $18$ data structures were assigned to SAME trials, where the same high-dimensional data structure was used to generate both the $2\text{-}D$ NLDR plot and the tour. These trials are the primary focus of the analysis.

The remaining $10$ data structures were used to create DIFFERENT trials. In these cases, the NLDR plot and the tour were generated from two distinct but related data structures. For example, when data structure `three_clust_19` appeared in the NLDR plot, `three_clust_20` was shown in the tour. Although these DIFFERENT trials are not analyzed directly, they play a crucial role in maintaining the integrity of the task by preventing systematic response strategies.

In addition, two clearly separable Gaussian cluster data sets were included as attention checks. These appear as both SAME and DIFFERENT trials and are used to verify that participants are paying attention and are able to perform the task under easy conditions.

To avoid learning and familiarity effects, each participant sees each data structure only once. Data sets were therefore assigned to subjects randomly but without replacement at the subject level. This ensures that participants cannot rely on memory from earlier trials and that each judgment is based solely on the visual information presented.

### Experiment design

The visual layout of the experiment for five subjects is shown in @fig-exp-design. Each subject completed $20$ trials: $15$ SAME trials, in which the same data structure was shown in both the $2\text{-}D$ NLDR plot and the tour; $4$ DIFFERENT trials, showing DIFFERENT data structures; and one attention check trial that could be either SAME or DIFFERENT. The purpose of the DIFFERENT trials was to ensure that subjects didn't get too familiar with the task, which might happen if the data were always the same in both graphics.  For the SAME, five NLDR methods (*tSNE, UMAP, PHATE, PaCMAP, and TriMAP*) were each paired with three of five distance scale factors (*small, small-medium, medium, medium-large, and large*), giving $15$ balanced combinations. In the DIFFERENT, four NLDR methods were randomly selected, with the remaining method assigned to the attention check trial. All DIFFERENT and attention check trials used a distance scale factor of *medium-large*.



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Experimental design for ten subjects. Shapes represent NLDR methods, and fill colors denote distance scale factors, ranging from low to high separability and mapped from light to dark. The figure shows only the SAME trials, making it easier to see the balanced design: for each subject, all five NLDR methods (tSNE, UMAP, PHATE, TriMAP, and PaCMAP) are equally represented, and each method appears with three of the five distance scale factors (small, small–medium, medium, medium–large, and large), distributed across subjects. The order of trials is randomized within each subject. In the full experiment (not shown), DIFFERENT trials and attention checks were inserted at random positions. Each subject completed $20$ trials in total: $15$ SAME trials, $4$ DIFFERENT trials comparing different data structures, and $1$ attention check (SAME or DIFFERENT). All DIFFERENT and attention-check trials used a medium–large distance scale factor.](05-chap5_files/figure-html/fig-exp-design-1.png){#fig-exp-design fig-align='center' fig-pos='H' fig-alt='A design shows the visual layout of an experiment for ten subjects, arranged in ten rows (one per subject) and 15 columns (one per trial). Each object represents a single trial. Along the horizontal axis, trials are ordered from 1 to 20; the vertical axis lists subjects 1 through 5. Most cells (15 per subject) are coded as SAME trials, where the same data structure is shown in both the 2‑D NLDR plot and the tour. SAME trials are further distinguished by combinations of five NLDR methods (tSNE, UMAP, PHATE, PaCMAP, TriMAP) and five distance scale factors (small to large), with 15 balanced method–scale combinations per subject. The grid visually emphasizes that each subject has the same number of trials and a consistent pattern of many SAME trials.' width=100%}
:::
:::


### Experimental factors

Two factors of interest were considered in the experiment: the NLDR method and the distance scale factor.

The first factor consisted of five NLDR methods: *tSNE, UMAP, PHATE, PaCMAP, and TriMAP*, each producing a $2\text{-}D$ representation.

The second factor, the distance scale factor, controlled the degree of cluster separation in the high-dimensional space. Five categorical levels: *small, small–medium, medium, medium–large, and large* were defined to represent increasing degrees of separability. This categorical design enhances interpretability and perceptual distinctness, allowing subjects to discern meaningful structural differences while maintaining robustness against minor data variations.

In our analysis of the results, we decided to quantify the distances between clusters numerically rather than using the distance scale factor levels directly. Cluster separability was quantified using two complementary measures: the *between-to-within (BW) ratio* and the *minimum inter-cluster distance*. A higher value of either metric indicates greater separation among clusters (@fig-dist-metrics). To ensure comparability across datasets with different underlying structures, all distance-based metrics were min–max scaled prior to analysis.  

The BW ratio, defined as

$$
  \text{BW ratio}
  =
  \frac{\bar{d}_{\text{between}}}{\bar{d}_{\text{within}}},
$$

where $\bar{d}_{\text{between}}$ denotes the average between-cluster distance and $\bar{d}_{\text{within}}$ denotes the average within-cluster distance. The within-cluster distance is computed as the weighted mean of pairwise distances within each cluster, while the between-cluster distance is the mean of all pairwise distances between observations from different clusters. 

In addition, the minimum distance was used as a complementary measure of global separation:

$$
  \text{minimum distance} =
  \min_{k \neq \ell}\min_{\mathbf{x}_i \in C_k,\mathbf{x}_j \in C_l}
  d(\mathbf{x}_i, \mathbf{x}_j),
$$

where $d(\cdot,\cdot)$ denotes the Euclidean distance, $C_i$ is the $i^{th}$ cluster with $n_i$ observations, $\bar{\mathbf{x}}_i$ is the centroid of cluster $C_i$. This metric captures the closest proximity between any two clusters. The scaled minimum distance was exponentiated so that, where it agrees with the BW ratio, the relationship between the two measures is approximately linear. The transformation increases separation among larger distance values while leaving small distances largely unchanged, facilitating more comparable variation across datasets.


<!-- The BW ratio and minimum inter-cluster distance capture complementary aspects of cluster separation: global dispersion and local boundary proximity, respectively. To make these measures comparable across data structures, all distance-based metrics were first rescaled to the unit interval using min–max normalization. -->

<!-- The scaled BW ratio was used as a global measure of separation, with larger values indicating clearer overall structure. For the minimum inter-cluster distance, we applied an exponential transformation to the scaled values. This transformation was chosen intentionally to emphasize differences at small separations, where clusters are close to touching and perceptual ambiguity is highest. -->

<!-- In this setting, small increases in minimum distance can lead to disproportionately large improvements in visual distinguishability, whereas similar increases at already large separations have relatively little perceptual effect. The exponential transformation accentuates this nonlinearity, allowing the metric to better reflect perceptual sensitivity to local cluster boundaries rather than treating all changes in distance as equally meaningful. -->


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Distribution of distance metric values across distance scale factors used as treatments in the experiment. (a) scaled between-to-within (BW) ratio and (b) exp(scaled minimum inter-cluster distance), each plotted against five categorical distance scale factors: small (S), small–medium (SM), medium (M), medium–large (ML), and large (L). Both metrics increase systematically with the scale factor, confirming that the distance scale treatment effectively controls cluster separability in the high-dimensional space.](05-chap5_files/figure-html/fig-dist-metrics-1.png){#fig-dist-metrics fig-align='center' fig-alt='Two-panel figure showing the distribution of cluster separation metrics across categorical distance scale factors. Panel (a) displays a quasi-random scatter plot of the scaled between-to-within (BW) ratio. The horizontal axis lists five categorical distance scale factors—small (S), small–medium (SM), medium (M), medium–large (ML), and large (L), arranged from left to right. The vertical axis shows BW ratio values on a continuous numeric scale increasing upward. For each scale factor, multiple points are plotted with slight horizontal jitter, forming vertical bands that represent the distribution of BW ratios under that condition. The point clouds shift progressively upward from S to L, indicating larger BW ratios at higher distance scales. Panel (b) shows a similar quasi-random scatter plot for the exponentially scaled minimum inter-cluster distance. The horizontal axis again displays the five distance scale factors (S to L), and the vertical axis shows minimum distance values on a continuous scale. Points are jittered horizontally within each category, producing vertical distributions whose central tendency increases from left to right.' width=100%}
:::
:::


### Subject recruitment

Subjects were recruited from the Prolific crowd-sourcing platform [@palan2018]. The study expects that the subjects are uninvolved judges with no prior knowledge of the data to avoid inadvertently affecting results. Pre-screening procedures were applied the recruitment: potential subjects needed with fluent in English and have completed at least $10$ Prolific studies with a $98\%$ approval rate.

### Data collection

The survey web application, [Match-a-roo](https://ebsmonash.shinyapps.io/web_game/), was used for data collection. Subjects provided the introduction and instructions for the survey. Before starting the survey, the subjects can be led to the “example” page, which allows them to experiment with the data collection interface and practice deciding whether the two displays show the same data or not. The main purpose of using the "example" was merely to familiarize the subjects with the questions that would be asked, as well as the process of deciding whether the two displays showed the same data or not. The interface did not provide any numeric feedback as to subject correctness.

The subjects were asked to provide their Prolific ID and their consent to the responses being used for analysis. After giving consent, the subject can start the trials. Two visual displays of data were shown, where the data may be the SAME or DIFFERENT. One of the visual displays is a $2\text{-}D$ NLDR plot, and the other is a tour. The subjects were asked to decide whether the data was the same in both displays and to report their confidence about their choice and any comments about the answer.

After completing $20$ evaluations, they were asked for their demographics, which included preferred pronoun, the highest level of education achieved, their age category, whether they used principal component analysis in their work, and whether they applied NLDR techniques such as tSNE and UMAP.

### Generalized linear mixed-effects models

Two generalized linear mixed effects models [@mcculloch2001] were fitted to model the likelihood of detecting the data structure in both the $2\text{-}D$ NLDR layout and the tour (@eq-glmm1). Both models accounted for subject-level variability and the effect of distance measures under different NLDR methods. The general form of the model is given by:

$$
\text{logit}(P(y_{ijm} = 1)) = \mu_{m} + \beta_{m} d_{i} + \gamma_{j},
$$ {#eq-glmm1}

where $\mu_{m}$ is the intercept, $d_i$ is the distance measure for the data structure $i = 1, \dots, 18$, $\beta_m$ is the fixed effect of distance metric under NLDR method $m$, $\gamma_j$ is the random effect of the subject $j = 1, 2, \dots, 127$, where $\gamma_j \sim N(0, \sigma_\gamma^2)$. Separate models were fitted using $d_i$ as either the scaled BW ratio or the exp(scaled minimum distance). The NLDR methods denoted by $m$ can include TriMAP, UMAP, PaCMAP, tSNE, and PHATE. The models were fitted using the `lme4` package [@douglas2015] and examined with the `emmeans` package [@russell2025].

## Results {#sec-results}

The data was collected from $127$ subjects, resulting in $127 \times 15 = 1905$ evaluations, excluding the attention check trials and the trials showing the different data in two displays.

While we expected correct identification to improve as cluster separation increases, this was not consistently observed across all methods. The range of estimated probabilities throughout this chapter should therefore be interpreted as an informative signal of how different NLDR methods convey cluster separation to human observers, rather than an indication of poor model fit.

### Effect of method and distance between clusters

The proportion of correct identifications across the NLDR methods and distance conditions was analysed to evaluate how effectively each method preserves cluster separation. Results are summarized using two generalized linear mixed-effects models, with either the scaled BW ratio (@fig-glmm, @tbl-glmm) or the exp(scaled minimum distance) (@fig-glmm-min, @tbl-glmm-min) as the distance predictor. Both models accounted for subject-level variability through random effects and included the NLDR method as a fixed factor interacting with the distance measure.

Results from the model using the scaled BW ratio (@tbl-glmm) indicate that cluster separability positively influences correct identification for some NLDR methods. As shown in @fig-glmm, UMAP exhibits a clear increase in accuracy as the scaled BW ratio increases, suggesting that this method benefits from greater between-cluster separation. PaCMAP shows a positive but weaker trend, while TriMAP maintains stable performance across the range of separations. In contrast, tSNE and PHATE display declining accuracy at higher BW ratios, indicating that increased separation may distort or obscure structural cues for these methods.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {#tbl-glmm .cell layout-align="center" tbl-cap='Estimated trends of correct identification probability with respect to scaled BW ratio by NLDR method. The table shows method-specific slope estimates (log-odds scale) for the effect of the scaled BW ratio on the probability of correct identification, obtained from a generalized linear mixed-effects model. Estimates represent the change in log-odds of correct identification per unit increase in scaled BW ratio for each NLDR method, along with standard errors (SE), 95\% confidence intervals, Wald z-statistics, and corresponding p-values. p-values and Confidence Intervals are calculated assuming normally distributed errors in the estimates. Positive estimates indicate improved identification accuracy with increasing cluster separation, while negative estimates indicate declining accuracy. Significance codes: ($\emph{p}\leq 0.001$ \'`***`\', $\emph{p}\leq 0.01$ \'`**`\', $\emph{p}\leq 0.05$ \'`*`\', $\emph{p}\leq 0.1$ \'`.`\').'}
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
![Estimated probability of correct identification as a function of the scaled BW ratio for five NLDR methods. The left panel shows model-based estimated probabilities with 95\% confidence intervals across values of the scaled BW ratio. The right panels show observed proportions of correct identification (black points) and fitted logistic regression curves for each method. Each black point represents the proportion of SAME responses from a distinct combination of data structure, distance scale factor, and NLDR method. The scaled BW ratio measures relative cluster separation, with larger values indicating greater separability. Performance trends differ across methods, with UMAP showing increasing accuracy, tSNE and PHATE decreasing accuracy, and TriMAP exhibiting relatively stable performance.](05-chap5_files/figure-html/fig-glmm-1.png){#fig-glmm fig-align='center' fig-pos='!ht' fig-alt='Multi-panel figure showing the relationship between cluster separation and identification accuracy for five NLDR methods. In the left panel, a line plot displays model-based estimated probabilities of correct identification as a function of the scaled between–within (BW) ratio. The horizontal axis represents the scaled BW ratio, increasing from low to high cluster separability, and the vertical axis shows the predicted probability of correct identification, ranging from 0 to 1. Five colored lines correspond to UMAP, PaCMAP, TriMAP, tSNE, and PHATE. Each line is surrounded by a shaded band indicating a 95% confidence interval around the estimate. The right side of the figure contains separate panels for each NLDR method. In each panel, the horizontal axis again shows the scaled BW ratio, and the vertical axis shows the proportion of correct identifications. Black points represent observed proportions at different BW ratio values, and a smooth colored curve overlays the points, representing the fitted logistic regression model for that method.' width=100%}
:::
:::


To assess whether these patterns depend on how separation is quantified, we fitted a second model using the exp(scaled minimum distance) as an alternative measure of cluster separability (@tbl-glmm-min). The results closely mirror those obtained with the BW ratio (@fig-glmm-min). In particular, UMAP again shows a significant positive association between separation and correct identification probability, confirming that greater spatial distance between clusters enhances its ability to reveal the underlying structure. Conversely, tSNE demonstrates a strong negative association, with performance deteriorating as minimum distance increases, while PHATE exhibits a weaker but consistent negative trend. The effects for PaCMAP and TriMAP are not statistically significant, indicating comparatively stable performance across varying levels of separation.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {#tbl-glmm-min .cell layout-align="center" tbl-cap='Estimated trends of correct identification probability with respect to exp(scaled minimum distance) by the NLDR method. The table shows method-specific slope estimates (log-odds scale) for the effect of the exp(scaled minimum distance) on the probability of correct identification, obtained from a generalized linear mixed-effects model. Estimates represent the change in log-odds of correct identification per unit increase in exp(scaled minimum distance) for each NLDR method, along with standard errors (SE), 95\% confidence intervals, Wald z-statistics, and corresponding p-values. p-values and Confidence Intervals are calculated assuming normally distributed errors in the estimates. Positive estimates indicate improved identification accuracy with increasing cluster separation, while negative estimates indicate declining accuracy. Significance codes: ($\emph{p}\leq 0.001$ \'`***`\', $\emph{p}\leq 0.01$ \'`**`\', $\emph{p}\leq 0.05$ \'`*`\', $\emph{p}\leq 0.1$ \'`.`\').'}
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

### Patterns conceptualization

The difference between tSNE and UMAP embeddings is curious: the further apart clusters are in high dimensions, the more often subjects reported that the data between the views was different when the embedding was tSNE. The UMAP results are more as expected, that the further apart the clusters, the more likely the subject is to report that they are the same data. @fig-three07-miss shows the results for one data set called `three_clust_07`. Plots on the left (a1, a2, b1, b2) show linear projections from a tour, and plots on the right show embeddings by tSNE and UMAP. Rows correspond to small and large distances, respectively. The proportion of correct responses is shown in each embedding plot. (The total number of evaluations for each was $3$, $4$, $4$, and $4$, respectively. While there are relatively few evaluations for any single example like this one, this example serves to illustrate the general pattern.) 

The reason for the difference in conceptualization from the different embeddings here is quite clear. Firstly, UMAP represents the data with large separation as three unusually shaped clusters that are well-separated. On the other hand, tSNE de-emphasizes the separation, and also does something worse - splits one cluster into two to make four clusters. It is understandable that a different conceptualization would be made from this embedding relative to that from the tour of linear projections, which clearly shows three clusters. 

<!-- To better understand the patterns of misidentification, we examine tSNE and UMAP layouts for data structures that are commonly confused by participants. Rather than treating errors as random noise, this analysis shows that misidentification often arises from a combination of the underlying structure of the data and the way NLDR methods transform that structure. In particular, several recurring visual patterns appear to drive perceptual confusion.

One common pattern is that, regardless of the distance between clusters in high-dimensional space, tSNE often places clusters very close together in the NLDR layout. This compression reduces visual separation and makes distinct clusters appear really close or overlapping, even when they are well separated in the original space. For example, in both `three_clust_12` and `three_clust_07` (@fig-three12-miss and @fig-three07-miss), increasing the distance between clusters does not consistently improve separation in tSNE. As a result, subjects may perceive these clusters as belonging to a single cluster or as weakly separated clusters, leading to confusion between clearly distinct high-dimensional configurations.

Another strong source of misidentification is the tendency of NLDR methods to break a single cluster into multiple small clusters. This is especially common for nonlinear and star-shaped structures. In tSNE layouts, continuous shapes such as S-curves, hyperbolic structures (@fig-three07-miss), and star-shaped clusters are frequently fragmented into disconnected pieces, creating the impression of several separate clusters where only one exists in high dimensions. For example, star-shaped clusters in particular (@fig-three12-miss), the individual arms are often pulled far apart, making them appear as independent clusters and obscuring the fact that they belong to a single structure. UMAP shows a similar tendency to split star-shaped clusters into multiple groups; however, compared to tSNE, the overall star-like arrangement is often still visible. This partial preservation of global structure makes the cluster more identifiable in UMAP, even though misinterpretation can still occur.

Linear or smoothly varying structures in high dimensions often appear nonlinear after dimension reduction. This change can strongly affect how a structure is perceived. In our examples, the hemispherical cluster provides a clear case: although it varies smoothly and has a relatively simple structure in high dimensions, both tSNE and UMAP frequently bend or warp it into curved or irregular shapes in the NLDR layout (@fig-three12-miss and @fig-three07-miss). As a result, the hemisphere can resemble a curved manifold rather than a smooth surface, making it harder to distinguish from genuinely nonlinear structures. This effect becomes more pronounced when the hemisphere appears alongside strongly curved components, as the projected shapes start to look visually similar.

Across multiple examples, including `three_clust_12` and `three_clust_07` (@fig-three12-miss and @fig-three07-miss), increasing high-dimensional separation does not reliably lead to more interpretable layouts. UMAP often benefits more from increased separation, preserving overall geometry and making components easier to distinguish. However, partial proximity between clusters can still remain, allowing perceptual ambiguity to persist. For tSNE, greater separation may even worsen interpretability by increasing fragmentation or compressing global structure, weakening the participants rely on to identify cluster relationships.

Another common source of misidentification comes from uneven point density. In some of our data structures, density is an important feature of the shape in high dimensions, but it is not reliably preserved in the NLDR layouts. For example, in the nonlinear hyperbolic structure (@fig-three12-miss), one corner is clearly denser in high dimensions, yet this feature is not easy to identify in either tSNE or UMAP layouts. Similarly, the tip of the star-shaped pyramid is densely populated in high dimensions (@fig-three07-miss), but this density cue is often lost in the projections; especially in tSNE, where the structure is further distorted or fragmented. When these density cues are weakened or misplaced, participants lose important visual signals needed to recognize the underlying structure, increasing the chance of misidentification.-->


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
![tSNE and UMAP layouts and $2\text{-}D$ projections for the data structure `three_clust_07`, composed of a nonlinear hyperbola, a hemisphere, and a triangular pyramid, shown under small and large cluster separation. Panels (a1–a2) show two fixed $2\text{-}D$ projections at small separation, and panels (b1–b2) show the same projections at large separation; the corresponding tSNE and UMAP layouts are shown in the right panels. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is reported in the top-right corner of the plot. At a small separation, curved and rounded components overlap substantially in both methods, making the structure difficult to distinguish. With increased separation, UMAP yields smoother, more continuous representations that retain the curvature of the hyperbolic component and improve spacing between clusters. In contrast, tSNE bends and breaks the hyperbolic structure and introduces irregular gaps between points, weakening global shape cues.](05-chap5_files/figure-html/fig-three07-miss-1.png){#fig-three07-miss fig-align='center' fig-alt='A multi-panel figure comparing NLDR layouts and linear projections of the same 4-D dataset, labelled three_clust_07. The data consist of three geometric structures: a curved hyperbolic band, a rounded hemispherical cluster, and a triangular pyramid-shaped cluster. The left half of the figure shows four 2-D linear projections arranged in two rows. Panels (a1) and (a2) display two fixed 2-D projections under small cluster separation, while panels (b1) and (b2) show the same projections under large cluster separation. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is reported in the top-right corner of the plot. In the small-separation projections, points from the three structures overlap substantially, with the curved and rounded components intermingling. In the large-separation projections, the three structures are more spatially separated, making the curved hyperbolic band, hemispherical cluster, and pyramid-shaped cluster more distinguishable. The right side of the figure shows corresponding 2-D NLDR layouts produced by tSNE and UMAP for the same small and large separation settings. In the small-separation layouts, both methods display overlapping point clouds with limited visual separation between structures. In the large-separation layouts, UMAP produces smoother, more continuous point arrangements that follow the curved shape of the hyperbolic structure and increase spacing between clusters, while tSNE shows a more fragmented layout with bends, breaks, and irregular gaps in the curved structure.' width=100%}
:::
:::


A different pattern is seen for the data set `three_clust_13`, which consists of a curvy cylinder, a cube, and a blunted cone, shown under small and large separation. (The total number of evaluations for each case was $3$, $5$, $6$, and $6$, respectively. While there are relatively few evaluations for any single example like this one, the figure is intended to illustrate a general pattern observed across multiple data sets.) Here, tSNE aligns more closely with the tour, particularly under small separation, where the proportion of correct responses is higher for tSNE ($0.67$) than for UMAP ($0.00$). In these layouts, tSNE preserves the overall grouping without introducing artificial splits, making it easier to reconcile the embedding with the linear projections. UMAP, on the other hand, emphasizes shape and density in ways that depart from the tour, especially when clusters are close together, leading to lower accuracy. Even at large separation, where UMAP improves ($0.60$), the visual cues remain less consistent with the tour than those produced by tSNE. This example highlights that which method leads to better conceptual alignment can depend strongly on the underlying data structure, and that neither embedding consistently dominates across all cases.


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
![tSNE and UMAP layouts and $2\text{-}D$ projections for the data structure `three_clust_13`, composed of a curvy cylinder, a cube, and a blunted cone, shown under small and large cluster separation. Panels (a1–a2) show two fixed $2\text{-}D$ projections at small separation, and panels (b1–b2) show the same projections at large separation; the corresponding tSNE and UMAP layouts are shown in the right panels. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is reported in the top-right corner of the plot. At small separation, the cube and blunted cone partially overlap in the linear projections, but tSNE preserves their separation more clearly than UMAP, leading to a higher proportion of correct responses. With increased separation, both methods improve in interpretability; however, UMAP still compresses the curvy cylinder toward the other components, while tSNE maintains clearer boundaries between the three clusters, supporting more consistent identification across separation levels.](05-chap5_files/figure-html/fig-three13-miss-1.png){#fig-three13-miss fig-align='center' fig-alt='A multi-panel figure comparing linear projections and nonlinear dimension reduction (NLDR) layouts of the same 4-D dataset, labelled three_clust_13. The data consist of three geometric structures: a curvy cylindrical cluster, a cubic cluster, and a blunted cone. The left portion of the figure shows four fixed 2-D linear projections arranged in two rows. Panels (a1) and (a2) display two projections under small cluster separation, where the cube and blunted cone partially overlap, and the curvy cylinder is visible but not clearly isolated. Panels (b1) and (b2) show the same projections under large cluster separation, where all three structures are more clearly separated, and their distinct shapes are easier to recognize. The right portion of the figure shows the corresponding 2-D NLDR layouts produced by tSNE and UMAP for the same small and large separation settings. For each NLDR layout, the proportion of correct identifications for the corresponding method and distance factor is shown in the top-right corner. At a small separation, the tSNE layout maintains clearer boundaries between the cube, blunted cone, and curvy cylinder than UMAP, which compresses the structures and increases overlap. At large separation, both methods show improved separation; however, UMAP still pulls the curvy cylinder closer to the other clusters, while tSNE preserves more distinct cluster boundaries, supporting higher identification accuracy.' width=100%}
:::
:::


## Limitations {#sec-limitations}

One of the main drawbacks of visual experiments is their reliance on human judgments. In this context, the effectiveness of identifying the $2\text{-}D$ NLDR plot and the tour from the same data can be dependent on the perceptual ability and visual skills of the individual. However, when the results from multiple individuals are combined, the overall quality and robustness of the outcome are considerably higher.

<!-- It is important to remove HTML widget elements such as controls, interactivity, and $2\text{-}D$ plot elements such as axis labels and text that might introduce bias. We recommend using a crowd-sourcing service like Prolific [@palan2018] to access high-quality data, as it is a time- and cost-effective way. NOT RELEVANT-->

A further limitation is that NLDR methods are typically designed for users with some understanding of their underlying principles. This study examines purely intuitive, visual use without any such training, so the findings reflect how these layouts are perceived visually rather than how they would be interpreted by a trained expert.

In this study, we chose to use only three clusters, each with unique shapes, and placed two close together with the third located farther away. We also used different sample sizes for each cluster. The purpose was to ensure a manageable experiment as an initial project. Using $4\text{-}D$ data allows tours to convey structural information effectively without imposing excessive cognitive or visual load on viewers. Some of the results should hold for more clusters, different arrangements, and higher dimensions, but it would be interesting to expand the scope to check these factors in the future.

<!-- To keep the experiment fair and consistent across trials, we approximately fixed the distance between the clusters in each data structure. We also used five distance scale factors to gradually change how far apart the clusters were. While this controlled setup makes it easier to interpret the results, it does limit how well the findings apply to more complex data structures with uneven or irregular cluster arrangements.-->

## Conclusions {#sec-exp-conclusion}

This study examined whether people can correctly identify that a static $2\text{-}D$ NLDR layout and a dynamic tour represent the same high-dimensional data, and how this ability depends on both cluster separation and the NLDR method used. Using three clusters with different shapes, numbers of points, and unequal separation, we were able to directly test whether increasing high-dimensional separation improves perceptual identification, and whether this effect varies across methods.

The results show that cluster separation does matter, but its impact is strongly method-dependent. The results show that UMAP and tSNE lead to  significantly different conceptualizations as the distance between clusters increases. There is a hint that PaCMAP behaves like UMAP, and PHATE behaves like tSNE, and TriMAP conceptualization is not affected by distance, but these are not statistically significant patterns. <!-- TriMAP showed a weaker but generally consistent trend. In contrast, tSNE often showed the opposite pattern: greater separation did not improve, and in some cases reduced, correct identification, suggesting that its emphasis on local structure can distort global relationships in ways that hinder perceptual alignment. PHATE showed little systematic relationship between separation and identification accuracy, consistent with its focus on smooth manifold structure rather than discrete cluster separation.--> 

<!-- Importantly, misidentification was not random. Some data structure components, particularly curved or dense shapes were consistently more difficult to recognize across methods, even at larger separations. XXX your analysis dod not study this so it is not valid to make this statement. XXX This indicates that perceptual errors arise from systematic interactions between data structure and method-specific distortions, rather than from subject variability alone. These findings support the need to evaluate NLDR layouts not only by algorithmic criteria, but also by how well they function as visual models in high-dimension space.-->

This experiment is best viewed as a template for further studies on how people interpret NLDR layouts. Future work could extend the factors studied by considering different numbers of clusters, sample size,  varying noise levels, and dimensionality. The current statistical model did not include a dataset-level random effect, as the number of repeated observations per dataset was insufficient to reliably estimate this additional variance component; future studies with a larger number of trials per dataset could explicitly model dependence between responses on the same data. For three clusters, including PCA (a linear method) as an embedding is not necessary because almost always it makes a useful display of three clusters in $2\text{-}D$ that is easily recognized as the same data when viewed with a tour. PCA is not needed to reveal three clusters; we included it as a positive control. PCA provides a case where the embedding is expected to closely match the tour, helping confirm that participants can correctly identify the same data when distortions are minimal. This makes it easier to interpret errors observed for nonlinear methods, where mismatches are more likely. For more than three clusters, this would not be true, and it would be important to include PCA as a comparison method.

Overall, this work highlights the need for more experiments that systematically assess the perception of structure in $2\text{-}D$ NLDR layouts with respect to structure present in high-dimensional data. With results from more human subject experiments, it may be possible to develop better metrics that could be used to automate the assessment of  visual similarity measures. These would be helpful to use alongside NLDR layouts to assist with providing more faithful representations.

## Supplementary materials

<!-- All the materials to reproduce the chapter can be found at [github.com/JayaniLakshika/paper-vis-experiment](https://github.com/JayaniLakshika/paper-vis-experiment). -->

The appendix provides additional details on the experimental materials and process, including the three-cluster data structures, $2\text{-}D$ NLDR layouts, inter-cluster distance metrics, and the data collection and analysis processes, along with links to videos and scripts.

## Acknowledgments

A pilot study was conducted with sample subjects from the working group of the Department of Econometrics and Business Statistics, Monash University. This pilot study allowed us to estimate the study's completion time and the effect size and fine-tune the application.

These R packages were used for the work: `tidyverse` [@hadley2019], `lme4` [@douglas2015], `broom.mixed` [@ben2024], `ggbeeswarm` [@erik2023], `emmeans` [@russell2025], `patchwork` [@thomas2024], `colorspace` [@achim2020], `kableExtra` [@hao2024], `conflicted` [@hadley2023], `Rtsne` [@jesse2015], `umap` [@tomasz2023], `phateR`[@moon2019], `reticulate` [@kevin2024], `langevitour` [@harisson2024], `binom` [@sundar2022], `gridExtra` [@baptiste2017], `shiny` [@winston2025a], `shinydashboard` [@winston2025b], `shinythemes` [@winston2021], `bslib` [@carson2025], `shinyjs` [@dean2021], `DT` [@yihui2016], `googledrive` [@lucy2025], `googleAuthR` [@mark2024], `googlesheets4` [@jennifer2025], `shinyalert` [@dean2024a], `shinypop` [@fanny2024], `randomNames` [@damian2024], `shinyfullscreen` [@etienne2021], `shinyWidgets` [@victor2025], `hms` [@kirill2025], `shinythemes` [@winston2021], and `shinycssloaders` [@dean2024]. These Python packages were used for the work: `trimap` [@amid2022] and `pacmap` [@yingfan2021]. 
