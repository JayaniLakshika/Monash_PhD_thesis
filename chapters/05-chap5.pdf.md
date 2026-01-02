# Perception and Misperception of Clustering in Nonlinear Dimension Reduction: A User Study {#sec-second-paper}




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


## Introduction

Nonlinear dimension reduction (NLDR) is popular for making a suitable $2\text{-}D$ representation of high-dimensional ($p\text{-}D$) data by applying nonlinear transformations. Recently developed methods include t-distributed stochastic neighbor embedding (tSNE) [@laurens2008], uniform manifold approximation and projection (UMAP) [@leland2018], potential of heat-diffusion for affinity-based trajectory embedding (PHATE) algorithm [@moon2019], large-scale dimensionality reduction Using triplets (TriMAP) [@amid2022], and pairwise controlled manifold approximation (PaCMAP) [@yingfan2021]. However, in different data structures, the $2\text{-}D$ representation generated can vary dramatically from what is observed in $p\text{-}D$ (@fig-nldr-layouts). 


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
![A $2\text{-}D$ tSNE layout (left) and four $2\text{-}D$ projections (a1–a4) of the same $4\text{-}D$ data. The data consist of three main structures: a star-shaped, a curvilinear, and a Gaussian-shaped clusters. While the tour consistently show the star-shaped cluster as a single coherent group, the $2\text{-}D$ tSNE layout fragments this structure into several smaller clusters. This illustrates how NLDR may distort global structure, making the same $4\text{-}D$ cluster appear as multiple clusters in the $2\text{-}D$ layout.](05-chap5_files/figure-pdf/fig-nldr-layouts-1.pdf){#fig-nldr-layouts fig-align='center' fig-pos='!ht' width=100%}
:::
:::


The dilemma for the analyst is then understanding **why viewers misidentify the data displayed in the $2\text{-}D$ NLDR layout and high-dimensional view when the inter-cluster distance vary**. The research described here provides evidence through a cognitive perception experiment.

The paper is organized as follows. @sec-background provides a summary of the literature on NLDR, high-dimensional data, and visualization methods. @sec-experiment describes the experiment designed to examine people's perception to assess how viewers recognize structure differently from a $2\text{-}D$ NLDR layout and the tour view. @sec-results discusses the collected data, results, and reasons for misperception. Limitations are provided in @sec-limitations. A discussion of the presented work, and ideas for future directions are described in @sec-exp-conclusion.

## Background {#sec-background}

Historically, $2\text{-}D$ representations of $p\text{-}D$ data have been obtained through techniques based on multidimensional scaling (MDS) [@kruskal1964], including principal component analysis (PCA) (for an overview see @jolliffe2011). These methods aim to construct a $2\text{-}D$ layout that preserves pairwise distances between observations in the original space by minimizing a stress function. Variants such as non-metric scaling [@saeed2018] and isomap [@silva2002] extend this approach to capture nonlinear relationships. Challenges inherent to high-dimensional data visualization such as distance concentration and interpretability are well recognized [@johnstone2009].

Several NLDR methods have since become popular for generating $2\text{-}D$ representations that aim to preserve either local or global structures of $p\text{-}D$ data. Examples include tSNE, UMAP, PHATE, TriMAP, and PaCMAP. Each method uses different underlying principles. For example, tSNE and PHATE emphasize local relationships, while TriMAP and PaCMAP are designed to better capture global structure. As a result, these methods can produce very different $2\text{-}D$ layouts of the same data, potentially leading to misinterpretation of structures such as cluster separation.

An alternative to NLDR for visualizing $p\text{-}D$ data is to use linear projections. PCA is the classical approach, producing new variables as linear combinations of the original dimensions. While PCA provides a single static projection that maximizes variance, tours introduced by @As85 extend this idea by generating smooth sequences of linear projections, effectively creating a movie of the data viewed from multiple directions. Tours can reveal structure that may be hidden in any single projection by continuously changing the viewing angle through high-dimensional space. Many tour algorithms have since been developed and are implemented in the R package `tourr` [@wickham2011], with interactive variants available in `langevitour` [@harisson2024] and `detourr` [@casper2025]. Tours are valuable because they preserve the true linear geometry of the data unlike NLDR methods, they do not warp distances or angles. This makes them faithful but sometimes visually cluttered representations: global structure can obscure local detail, and the phenomenon of piling [@laa2022], where high-dimensional points project toward the center, can make clusters harder to distinguish.

To assess how well NLDR methods preserve structures such as cluster separation, it is important to quantify inter-cluster distances. A variety of distance-based metrics have been proposed in the clustering and visualization literature [@tadeusz1974; @peter1987; @david1979], including minimum, maximum, and average distances between clusters, centroid distances, and ratios that combine between- and within-cluster variation. In this study, we focus on two distance measures: the between-to-within (BW) ratio, which captures global separability, and the minimum distance between clusters, which reflects the closest approach of any two clusters. Together, these provide interpretable summaries of both overall and local cluster separation while accounting for within-cluster variability.

The objective of this research is to study how users perceive and sometimes misperceive clustering structure when viewing a $2\text{-}D$ NLDR layout alongside a tour of the same high-dimensional data, generated using `langevitour`. We focus on how perceived structure changes as cluster separation increases, quantified through the BW ratio and the minimum inter-cluster distance. These findings will help identify common misperceptions that can arise when analysts rely solely on $2\text{-}D$ NLDR layouts, highlighting the need for careful diagnostics to verify whether perceived structures reflect the true high-dimensional patterns. This can help guide better ways to interpret and report what these visualizations are showing.

## Method {#sec-experiment}

### What is a $2\text{-}D$ NLDR plot?

The $2\text{-}D$ representation of the $p\text{-}D$ data constructed to preserve as much information, like clustering and nonlinear relationships, as possible. There are various commonly used techniques for creating this $2\text{-}D$ representation, including tSNE, and UMAP. These methods aim to identify a low-dimensional structure that captures the most important patterns or relationships in the data, allowing for visualization and easier interpretation. However, it is important to note that $2\text{-}D$ embeddings can lose some information from the $p\text{-}D$ data, as they necessarily involve a loss of dimensionality.

### What is a tour?

The tour shows a sequence of two-dimensional linear projections of the $p\text{-}D$ data. It is similar to looking at shadows of a $3\text{-}D$ object, and trying to infer the shape of the $3\text{-}D$ object. Looking at linear projections of $p\text{-}D$ data is like looking at the shadows, and one hopes to gain a sense of what shapes exist in the data. For example, if the data separates into clusters in any of the projections, it means that there are clusters in the data in the high dimensions. If the data shows a nonlinear or curvilinear shape it means that there are nonlinear associations between some variables. If the data collapses to roughly a line it means that it lives in a lower dimensional space than the number of high dimensions. If the points moving differently from others, there are outliers or unusual observations in the high dimensions.

### What is being tested?

We are generally interested in testing whether "The two plots displays the same data" ($H_0$) against the broad alternative "The two plots do not display the same data" ($H_a$).

Testing this broad null hypothesis ($H_0$) is practically challenging due to the variety of data structures involved. It can be both time-consuming and computationally intensive. Therefore, we focused on one data structure that is particularly useful for investigation: three clusters where two clusters are close together, while one is more distant. Three clusters have different shapes and each cluster contain different number of points. The sample size is $7500$.

Our hypothesis is as follows:

$H_{0m1}$: The distance between the clusters has no effect on the probability of correctly identifying the $2\text{-}D$ NLDR plot generated by NLDR method $m$ and the tour from the same data. Vs $H_{1m1}$: The distance between the clusters does have an effect on the probability of correctly identifying the $2\text{-}D$ NLDR plot generated by NLDR method $m$ and the tour from the same data.

This study aims to answer which NLDR methods are more accurate in identifying the same data structure in the $2\text{-}D$ NLDR plot and the tour, as the distance increases, and to identify which types of data structure components are more prone to misidentification across methods.

### Data generation

For non-attention check attempts, $28$ data structures are generated, while only two data structures are generated for attention check attempts. Before being presented to participants, the data is *scaled*. 

#### Non-attention check data

For the experiment, three cluster data are generated. The three clusters contain different number of points and shapes. Let $C_1, C_2,$ and $C_3$ denote the centroids of three clusters. The pairwise distances between these centroids are calculated as: $d(C_1, C_2) = c_{12} \approx 2.17, \quad d(C_1, C_3) = c_{13} \approx 4, \quad d(C_2, C_3) \approx c_{23} = 3.6$. These results indicate that clusters $C_1$ and $C_2$ are in close proximity, whereas cluster $C_3$ is positioned further away from the other two clusters, suggesting a spatial separation within the data. The reason for using the distance between centroids is that it can be easily controlled. 

In total, there are $28$ data structures used for the experiment. Out of these, $18$ data structures show the same structure in both the $2\text{-}D$ NLDR plot and tour for each experiment, while the remaining $10$ data structures display different structures in the $2\text{-}D$ NLDR plot and tour. This means that when data structure $19$ is displayed in the NLDR plot, data structure $20$ appears in the tour. 

To systematically vary the degree of separation in the SAME trials, the original (medium large) centroid distances are scaled by four different factors: $0.1$ (small), $0.6$ (small-medium), $0.9$ (medium), and $1.1$ (large). In contrast, data structures used for the DIFFERENT trials retained the original (medium-large) centroid distances.

#### Attention check data

There are two sets of attention check data; one consisting of three Gaussian clusters and the other consisting of four Gaussian clusters. Each cluster is generated using a multivariate normal distribution where the mean vectors and variances were predefined. Specifically, for the three-cluster case, the mean vectors were set as $[1, 0, 0, 0]$, $[0, 1, 0, 0]$, and $[0, 0, 1, 1]$, with a common variance of $0.1$ for all clusters. For the four-cluster case, the mean vectors were defined as $[1, 0, 0, 1]$, $[0, 1, 1, 0]$, $[1, 0, 1, 0]$, and $[0, 1, 0, 1]$, also using a variance of $0.1$. This approach ensures that data points are normally distributed around the specified centroids, with the spread controlled by the variance parameter. Each Gaussian cluster dataset consists of $4\text{-}D$ data with a sample size of $7500$, and each cluster contains an equal number of data points.

### Experiment design

The visual layout of the experiment for one participant is shown in @fig-exp-design. Each participant completed $20$ trials: $15$ SAME trials, in which the same data structure was shown in both the $2\text{-}D$ NLDR plot and the tour; $4$ DIFFERENT trials, showing DIFFERENT data structures; and one attention check trial that could be either SAME or DIFFERENT. For the SAME, five NLDR methods (*tSNE, UMAP, PHATE, PaCMAP, and TriMAP*) were each paired with three of five distance scale factors (*small, small-medium, medium, medium-large, and large*), giving $15$ balanced combinations. In the DIFFERENT, four NLDR methods were randomly selected, with the remaining method assigned to the attention check trial. All DIFFERENT and attention check trials used a distance scale factor of *medium-large*.



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Experiment design for one participant. Shapes represent distance scale factors, and fill colors denote NLDR methods. Each participant completed $20$ trials: $15$ SAME trials showing the same data structure in both the $2\text{-}D$ plot and tour (purple), $4$ DIFFERENT trials showing different structures (light blue), and one attention check (SAME or DIFFERENT) (red). In SAME trials, five NLDR methods (tSNE, UMAP, PHATE, TriMAP, and PaCMAP) were combined with three of five distance scale factors (small, small-medium, medium, medium-large, and large). For DIFFERENT trials, four NLDR methods were randomly selected, and the remaining method was used in the attention check. All DIFFERENT and attention check trials used a distance scale factor of *medium-large*.](../figures/vis-exp/exp_design.png){#fig-exp-design fig-align='center' fig-pos='!ht' width=50%}
:::
:::


### Treatments

Two primary treatments were considered in the experiment: the NLDR method and the distance scale factor.

The first treatment consisted of five NLDR methods: *tSNE, UMAP, PHATE, PaCMAP, and TriMAP* each producing a $2\text{-}D$ representation.

The second treatment, the distance scale factor, controlled the degree of cluster separation in the high-dimensional space. Five categorical levels: *small, small–medium, medium, medium–large, and large* were defined to represent increasing degrees of separability. This categorical design enhances interpretability and perceptual distinctness, allowing participants to discern meaningful structural differences while maintaining robustness against minor data variations.

Cluster separability was quantified using two complementary measures: the *between-to-within (BW) ratio* and the *minimum inter-cluster distance*. A higher value of either metric indicates greater separation among clusters (@fig-dist-metrics). 

The BW ratio, defined as

$$
\text{BW Ratio} = \frac{B}{W} = \frac{ \sum_{i=1}^{3} n_i \cdot \|\bar{\mathbf{x}}_i - \bar{\mathbf{x}}\|^2 }{ \sum_{i=1}^{3} \sum_{\mathbf{x}_j \in C_i} \|\mathbf{x}_j - \bar{\mathbf{x}}_i\|^2 }.
$$

where (B) and (W) denote between- and within-cluster dispersion, respectively; $\bar{\mathbf{x}}_i$ is the centroid of cluster $C_i$; $\bar{\mathbf{x}}$ is the overall centroid; and $n_i$ is the number of observations in cluster $C_i$. 

In addition, the minimum distance was used as a complementary measure of global separation:

$$
\text{minimum distance} = \min_{k \neq \ell} \min_{x \in C_k, , y \in C_\ell} d(x, y),
$$

which captures the closest proximity between any two clusters.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Distribution of distance metric values across distance scale factors used as treatments in the experiment. (a) Between-to-within (BW) ratio and (b) minimum inter-cluster distance, each plotted against five categorical distance scale factors: small (S), small–medium (SM), medium (M), medium–large (ML), and large (L). Both metrics increase systematically with the scale factor, confirming that the distance scale treatment effectively controls cluster separability in the high-dimensional space.](05-chap5_files/figure-pdf/fig-dist-metrics-1.pdf){#fig-dist-metrics fig-align='center' width=100%}
:::
:::


### Participant recruitment

Participants were recruited from the Prolific crowd-sourcing platform [@palan2018]. The study expects that the participants are uninvolved judges with no prior knowledge of the data to avoid inadvertently affecting results. Pre-screening procedures were applied the recruitment: potential participants needed with fluent in English and have completed at least $10$ Prolific studies with a $98\%$ approval rate.

### Data collection

The survey web application, [Match-a-roo](https://ebsmonash.shinyapps.io/web_game/) was used for data collection. Participants provided introduction and instructions for the survey. Before start the survey, the participants can lead to the "example" page which allow them to experiment with the data collection interface and practice deciding whether the two displays shown the same data or not. The main purpose of using the "example" was merely intended to familiarize the participants with the questions which would be asked as well as the process of deciding whether the two displays shown the same data or not. The interface did not provide any numeric feedback as to participant correctness.

The participants were asked to provide their Prolific ID and their consent to the responses being used for analysis. After giving consent, the participant can start the trials. Two visual displays of data were shown where the data may be the SAME or DIFFERENT. One of the visual displays is a $2\text{-}D$ NLDR plot, and the other is a tour. The participants were asked to decide whether that data was the same in both displays and to report their confidence about their choice and any comments about the answer.

After completing $20$ evaluations, they were asked for their demographics which included preferred pronoun, the highest level of education achieved, their age category, whether they used principal component analysis in their work, and whether they applied NLDR techniques such as tSNE and UMAP.

### Generalized Linear Mixed-Effects Models

Two generalized linear mixed effects models [@mcculloch2001] were fitted to model the likelihood of detecting the data structure in both the $2\text{-}D$ NLDR layout and the tour (@eq-equation1). Both models accounted for participant-level variability and the effect of distance measures under different NLDR methods. The general form of the model is given by:

$$\text{logit}(P(y_{ijm} = 1)) = \mu_{m} + \beta_{m} d_{i} + \gamma_{j}$$ {#eq-equation1}

where $\mu_{m}$ is the overall mean for NLDR method $m$, $d_i$ is the distance measure for the data structure $i = 1, \dots, 18$, $\beta_m$ is the fixed effect of BW ratio under NLDR method $m$, $\gamma_j$ is the random effect of the participant $j = 1, 2, \dots, 127$, where $\gamma_j \sim N(0, \sigma_\gamma^2)$. Separate models were fitted using $d_i$ as either the scaled BW ratio or the exp(scaled minimum distance). The NLDR methods denoted by $m$ can include TriMAP, UMAP, PaCMAP, tSNE, and PHATE.

## Results {#sec-results}

The data was collected from $127$ participants, resulting in $127 \times 15 = 1905$ evaluations, excluding the attention check trials and the trials shows the different data in two displays.

### Correct proportions

The proportion of correct identifications across NLDR methods and distance conditions was analysed to evaluate how effectively each method preserves cluster separation. Results are summarized using two generalized linear mixed-effects models, with either the scaled BW ratio (@fig-glmm, @tbl-glmm) or the exp(scaled minimum distance) (@fig-glmm-min, @tbl-glmm-min) as the distance predictor. Both models accounted for participant-level variability through random effects and included NLDR method as a fixed factor interacting with the distance measure.

Results from the model using the scaled BW ratio (@tbl-glmm) indicate that cluster separability positively influences correct identification for some NLDR methods. As shown in @fig-glmm, UMAP exhibits a clear increase in accuracy as the scaled BW ratio increases, suggesting that this method benefits from greater between-cluster separation. PaCMAP shows a positive but weaker trend, while TriMAP maintains stable performance across the range of separations. In contrast, tSNE and PHATE display declining accuracy at higher BW ratios, indicating that increased separation may distort or obscure structural cues for these methods.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {#tbl-glmm .cell layout-align="center" tbl-cap='Estimated trends of correct identification probability with respect to scaled BW ratio by NLDR method.The table shows method-specific slope estimates (log-odds scale) for the effect of the scaled BW ratio on the probability of correct identification, obtained from a generalized linear mixed-effects model. Estimates represent the change in log-odds of correct identification per unit increase in scaled BW ratio for each NLDR method, along with standard errors (SE), asymptotic 95\% confidence intervals (LCL, UCL), Wald z-statistics, and corresponding p-values. Positive estimates indicate improved identification accuracy with increasing cluster separation, while negative estimates indicate declining accuracy. Significance codes: ($\emph{p}\leq 0.001$ \'`***`\', $\emph{p}\leq 0.01$ \'`**`\', $\emph{p}\leq 0.05$ \'`*`\', $\emph{p}\leq 0.1$ \'`.`\').'}
::: {.cell-output-display}
\begin{table}
\centering
\resizebox{\ifdim\width>\linewidth\linewidth\else\width\fi}{!}{
\begin{tabular}{lrrrrrrl}
\toprule
method & estimate & SE & asymp.LCL & asymp.UCL & z.ratio & p.value & p\_val\_sig\\
\midrule
TriMAP & 0.03 & 0.49 & -0.92 & 0.99 & 0.07 & 0.95 & \\
UMAP & 1.15 & 0.49 & 0.19 & 2.11 & 2.35 & 0.02 & *\\
PaCMAP & 0.51 & 0.48 & -0.43 & 1.45 & 1.06 & 0.29 & \\
tSNE & -2.61 & 0.62 & -3.83 & -1.40 & -4.20 & 0.00 & ***\\
PHATE & -0.92 & 0.54 & -1.97 & 0.13 & -1.71 & 0.09 & .\\
\bottomrule
\end{tabular}}
\end{table}


:::
:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Estimated probability of correct identification as a function of the scaled BW ratio for five NLDR methods. The left panel shows model-based estimated probabilities with 95\% confidence intervals across values of the scaled BW ratio. The right panels show observed proportions of correct identification (black points) and fitted logistic regression curves for each method. The scaled BW ratio measures relative cluster separation, with larger values indicating greater separability. Performance trends differ across methods, with UMAP showing increasing accuracy, tSNE and PHATE decreasing accuracy, and TriMAP exhibiting relatively stable performance.](05-chap5_files/figure-pdf/fig-glmm-1.pdf){#fig-glmm fig-align='center' fig-pos='!ht' width=100%}
:::
:::


To assess whether these patterns depend on how separation is quantified, we fitted a second model using the exp(scaled minimum distance) as an alternative measure of cluster separability (@tbl-glmm-min). The results closely mirror those obtained with the BW ratio (@fig-glmm-min). In particular, UMAP again shows a significant positive association between separation and correct identification probability, confirming that greater spatial distance between clusters enhances its ability to reveal the underlying structure. Conversely, tSNE demonstrates a strong negative association, with performance deteriorating as minimum distance increases, while PHATE exhibits a weaker but consistent negative trend. The effects for PaCMAP and TriMAP are not statistically significant, indicating comparatively stable performance across varying levels of separation.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {#tbl-glmm-min .cell layout-align="center" tbl-cap='Estimated trends of correct identification probability with respect to exp(scaled minimum distance) by NLDR method.The table shows method-specific slope estimates (log-odds scale) for the effect of the exp(scaled minimum distance) on the probability of correct identification, obtained from a generalized linear mixed-effects model. Estimates represent the change in log-odds of correct identification per unit increase in exp(scaled minimum distance) for each NLDR method, along with standard errors (SE), asymptotic 95\% confidence intervals (LCL, UCL), Wald z-statistics, and corresponding p-values. Positive estimates indicate improved identification accuracy with increasing cluster separation, while negative estimates indicate declining accuracy. Significance codes: ($\emph{p}\leq 0.001$ \'`***`\', $\emph{p}\leq 0.01$ \'`**`\', $\emph{p}\leq 0.05$ \'`*`\', $\emph{p}\leq 0.1$ \'`.`\').'}
::: {.cell-output-display}
\begin{table}
\centering
\resizebox{\ifdim\width>\linewidth\linewidth\else\width\fi}{!}{
\begin{tabular}{lrrrrrrl}
\toprule
method & estimate & SE & asymp.LCL & asymp.UCL & z.ratio & p.value & p\_val\_sig\\
\midrule
TriMAP & 0.20 & 0.20 & -0.20 & 0.59 & 0.97 & 0.33 & \\
UMAP & 0.59 & 0.20 & 0.20 & 0.98 & 2.99 & 0.00 & ***\\
PaCMAP & 0.22 & 0.19 & -0.16 & 0.60 & 1.12 & 0.26 & \\
tSNE & -0.78 & 0.22 & -1.20 & -0.35 & -3.60 & 0.00 & ***\\
PHATE & -0.35 & 0.21 & -0.76 & 0.06 & -1.68 & 0.09 & .\\
\bottomrule
\end{tabular}}
\end{table}


:::
:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Estimated probability of correct identification as a function of the exp(scaled minimum distance) for five NLDR methods. The left panel shows model-based estimated probabilities with 95% confidence intervals across values of the exp(scaled minimum distance). The right panels show observed proportions of correct identification (black points) and fitted logistic regression curves for each method. Larger values correspond to greater spatial separation between clusters. UMAP shows increasing accuracy with increasing separation, whereas tSNE and PHATE show declining trends, and TriMAP exhibits relatively stable performance.](05-chap5_files/figure-pdf/fig-glmm-min-1.pdf){#fig-glmm-min fig-align='center' fig-pos='!ht' width=100%}
:::
:::


Taken together, these results demonstrate that the impact of cluster separability on correct identification is robust to the choice of distance measure but varies substantially across NLDR methods. Methods such as UMAP benefit from increased separation, whereas tSNE and PHATE appear sensitive to over-separation, potentially leading to distortions in the low-dimensional representation. TriMAP, by contrast, shows little sensitivity to changes in separation, suggesting robustness across a wide range of cluster configurations.

### Patterns for misidentification

To better understand why misidentification occurs, we examine patterns of correct identification across different high-dimensional data structures and across subjects. Rather than viewing errors as random noise, this analysis highlights how the geometry of the data and the behavior of the dimension reduction methods together lead to systematic confusion between structures.

@fig-var-sum shows correct identification proportions summarized by high-dimensional data structure (@fig-var-sum a) and by participant (@fig-var-sum b). There is clear variability at both levels. Across data structures, the proportion of correct identification ranges from about $0.31$ to approximately $0.70$, indicating large differences in how easily different geometric configurations can be recognized from their NLDR representations. Some structures are identified reliably, while others remain difficult even when cluster separation increases. This suggests that misidentification is largely driven by the underlying geometry of the data and by how well those features are represented in $2\text{-}D$ layouts.

The participant-level distribution of correct identification proportions (@fig-var-sum b) shows clear variability in performance, with most participants achieving moderate accuracy rather than clustering at chance or near-perfect levels. This pattern suggests that misidentification is not driven by a small number of poorly performing individuals, but reflects broader differences in how participants interpret and identify structure from the $2\text{-}D$ NLDR layouts and the corresponding tour views generated from the same $p\text{-}D$ data.


<!-- #### Summary -->
<!-- data structure wise analysis-->


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Correct identification proportions by (a) data structure and (b) participant. The plot a shows aggregated proportions with $95\%$ Wilson binomial confidence intervals, illustrating differences in identification difficulty across three-cluster structures. The plot b displays participant-level proportions and highlight between-subject variability.](05-chap5_files/figure-pdf/fig-var-sum-1.pdf){#fig-var-sum fig-align='center' width=100%}
:::
:::


To better understand the visual sources of these misidentifications, we examine tSNE and UMAP layouts for data structures that are commonly confused. @fig-three07-miss and @fig-three12-miss present $2\text{-}D$ projections alongside tSNE and UMAP layouts for `three_clust_12` and `three_clust_07` under both small and large cluster separation. These examples demonstrate that increasing separation does not necessarily lead to clearer or more interpretable low-dimensional representations.

For three_clust_12 (@fig-three12-miss), increased separation leads to improved visual clarity in UMAP, which more effectively preserves the distinct geometric characteristics of the S-curve, hemisphere, and pyramidal component. Nevertheless, even at larger separations, residual distortions and partial proximity between components remain, allowing perceptual ambiguity to persist. In contrast, tSNE introduces fragmentation and compression of curved and volumetric components, disrupting global shape cues and causing visually distinct structures to appear more similar.

A similar pattern is observed for three_clust_07 (@fig-three07-miss). While greater separation improves cluster spacing in UMAP and supports a smoother representation of the hyperbolic component, some ambiguity remains. For tSNE, increasing separation does not consistently enhance interpretability: the hyperbolic structure is distorted and fragmented, and irregular gaps are introduced, weakening global geometric cues essential for recognition.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![tSNE and UMAP layouts and $2\text{-}D$ projections for the data structure `three_clust_07`, composed of a nonlinear hyperbola, a hemisphere, and a triangular pyramid, shown under small and large cluster separation. Panels (a1–a2) show two fixed $2\text{-}D$ projections at small separation, and panels (b1–b2) show the same projections at large separation; the corresponding tSNE and UMAP layouts are shown in the right panels. At small separation, curved and rounded components overlap substantially in both methods, making the structure difficult to distinguish. With increased separation, UMAP yields smoother, more continuous representations that retain the curvature of the hyperbolic component and improve spacing between clusters. In contrast, tSNE bends and breaks the hyperbolic structure and introduces irregular gaps between points, weakening global shape cues.](05-chap5_files/figure-pdf/fig-three07-miss-1.pdf){#fig-three07-miss fig-align='center' width=100%}
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
![tSNE and UMAP layouts and $2\text{-}D$ projections for the data structure `three_clust_12`, composed of an S-curve, a hemisphere, and a filled hexagonal pyramid, shown under small and large cluster separation. Panels (a1–a2) show two fixed $2\text{-}D$ projections at small separation, and panels (b1–b2) show the same projections at large separation; the corresponding tSNE and UMAP layouts are shown in the right panels. At small separation, curved and rounded components overlap substantially in both methods, making the structure difficult to distinguish. With increased separation, UMAP preserves the distinct geometric character of each component, maintaining an elongated S-curve, a compact hemisphere, and a coherent pyramidal structure. In contrast, tSNE fragments curved and volumetric components into irregular, disconnected pieces, obscuring global shape cues.](05-chap5_files/figure-pdf/fig-three12-miss-1.pdf){#fig-three12-miss fig-align='center' width=100%}
:::
:::


Taken together, these examples indicate that misidentification is not resolved solely by increasing cluster separation. Although UMAP generally benefits more from larger separations than tSNE, both methods may still produce layouts that obscure key geometric features. This helps explain why certain data structures remain difficult to identify in the experiment even under strong separation and underscores that misidentification reflects systematic limitations in how NLDR methods represent complex geometry rather than random perceptual error.

## Limitations {#sec-limitations}

One of the main drawbacks of visual experiments is their reliance on human judgments. In this context, the effectiveness of identifying the $2\text{-}D$ NLDR plot and the tour from the same data can be dependent on the perceptual ability and visual skills of the individual. However, when the results from multiple individuals are combined, the overall quality and robustness of the outcome is considerably high.

It is important to remove HTML widget elements such as controls, interactivity, and $2\text{-}D$ plot elements such as axis labels and text that might introduce bias. We recommend using a crowd-sourcing service like Prolific [@palan2018] to access high-quality data, as it is a time- and cost-effective way.

In this study, we used a specific data structure consisting of three distinct clusters, each with unique shapes. Two of the clusters are in close proximity to one another, while the third cluster is located farther away. Each cluster varies in the number of points it contains. We selected this data structure because it is simple.

To keep the experiment fair and consistent across trials, we approximately fixed the distance between the clusters in each data structure. We also used five distance scale factors to gradually change how far apart the clusters were. While this controlled setup makes it easier to interpret the results, it does limit how well the findings apply to more complex data structures with uneven or irregular cluster arrangements.

## Conclusions {#sec-exp-conclusion}

This study provides empirical evidence that NLDR methods differ substantially in how well they preserve high-dimensional structures that are perceptually meaningful for classification and clustering. By combining a controlled simulation of three clusters with varying separation, shape, and size, and a human recognition experiment, we quantified how structural separability in the original space translates into correct identification of clusters in $2\text{-}D$ representations.

Our results reveal consistent differences among NLDR methods. UMAP and PaCMAP produced layouts where greater high-dimensional separation quantified by both the scaled BW ratio and the exponential of the scaled minimum inter-cluster distance—led to higher probabilities of correct identification. These methods explicitly optimize for both local and global relationships: UMAP through fuzzy topological preservation and PaCMAP through adaptive pairwise constraints that balance local and mid-range distances. This dual emphasis likely explains their superior perceptual alignment with the true $p\text{-}D$ structure. TriMAP showed a similar but less pronounced trend, consistent with its triplet-based loss that prioritizes preservation of global relationships.

In contrast, tSNE exhibited a negative association between separability and correct identification, consistent with prior findings that its Kullback–Leibler divergence loss exaggerates local density differences at the expense of global geometry. As clusters became more distinct in the high-dimensional space, tSNE’s optimization fragmented global relationships, yielding visually appealing but structurally misleading layouts. PHATE, which emphasizes manifold continuity rather than discrete grouping through potential distances, showed no systematic relationship between separability and accuracy, aligning with its design focus on smooth transitions rather than cluster fidelity.

Visual inspection of misidentifications reinforces the quantitative patterns observed across methods and distance scales. Curvilinear and non-linear manifolds—such as *s_curve*, *helical_hyper_spiral*, and *nonlinear_hyperbola* were consistently the most prone to misrepresentation, particularly when situated near compact clusters like *cube*, *blunted_cone*, or *hemisphere*. At smaller distance scales, methods prioritizing local continuity, such as tSNE and PHATE, tended to merge or fragment these curved structures, reducing their distinctness. In contrast, UMAP and PaCMAP often distorted the relative positioning of clusters as inter-cluster distance increased, misaligning global geometry while maintaining local coherence. TriMAP generally preserved the broader spatial layout but frequently compressed curvilinear manifolds against more compact forms, leading to partial overlap or shape loss. Overall, these systematic misidentifications highlight that each NLDR method exhibits characteristic sensitivities to specific geometric structures, driven by the trade-off in their objective functions between local neighborhood preservation and global distance maintenance.

Overall, these findings emphasize that NLDR methods should be evaluated not only by visual appearance but by their alignment between quantitative structure and perceptual interpretation. Methods like UMAP and PaCMAP appear to maintain interpretable geometric fidelity across varying levels of separation, while tSNE and PHATE prioritize alternative aspects of structure. The implication for statistical graphics is that perceptually faithful embeddings are not guaranteed by standard algorithmic performance metrics alone.

Future work should extend these analyses to a wider range of experimental conditions, including different noise levels, sample sizes, and dimensionalities, to test the robustness of perceptual failures occur. Comparing with linear methods such as PCA or supervised embeddings could also clarify whether the observed effects are unique to nonlinear transformations or reflect broader perceptual tendencies in cluster interpretation. In addition, exploring alternative data structures such as overlapping clusters, hierarchical manifolds, or continuous gradients would help determine how general these perceptual biases are across more complex topologies. Integrating automated visual diagnostics, for example using computer-vision or deep-learning–based similarity metrics, could complement human judgment and provide objective measures of structure preservation. Finally, combining interactive visualization environments with eye-tracking or cognitive-load assessments could reveal how users process and trust NLDR layouts in real time. Such advances would not only improve the interpretability of dimension reduction methods but also support the development of human-centered evaluation frameworks.


## Acknowledgments

A pilot study was conducted with sample subjects from the working group of the Department of Econometrics and Business Statistics, Monash University. This pilot study allowed us to estimate the study's completion time and the effect size and fine-tune the application.

These R packages were used for the work: `tidyverse` (@hadley2019), `lme4` (@douglas2015), `broom.mixed` (@ben2024), `ggbeeswarm` (@erik2023), `emmeans` (@russell2025), `patchwork` (@thomas2024), `colorspace` (@achim2020), `kableExtra` (@hao2024), `conflicted` (@hadley2023), `Rtsne` (@jesse2015), `umap` (@tomasz2023), `phateR`(@moon2019), `reticulate` (@kevin2024), `langevitour` (@harisson2024), `gridExtra` (@baptiste2017), `shiny` (@winston2025a), `shinydashboard` (@winston2025b), `shinythemes` (@winston2021), `bslib` (@carson2025), `shinyjs` (@dean2021), `DT` (@yihui2016), `googledrive` (@lucy2025), `googleAuthR` (@mark2024), `googlesheets4` (@jennifer2025), `shinyalert` (@dean2024a), `shinypop` (@fanny2024), `randomNames` (@damian2024), `shinyfullscreen` (@etienne2021), `shinyWidgets` (@victor2025), `hms` (@kirill2025), `shinythemes` (@winston2021), and `shinycssloaders` (@dean2024b). These `python` packages were used for the work: `trimap` (@amid2022) and `pacmap` (@yingfan2021). 

## Supplementary Materials

All the materials to reproduce the paper can be found at [github.com/JayaniLakshika/paper-vis-experiment](https://github.com/JayaniLakshika/paper-vis-experiment).

Appendix: The appendix includes more details about the data structures and their tSNE, UMAP, PHATE, PaCMAP, and TriMAP layouts used in the study.

XXX Add Match-a-roo experiment links
