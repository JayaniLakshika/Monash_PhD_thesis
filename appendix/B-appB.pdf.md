# Appendix to "Perception and Misperception of Clustering in Nonlinear Dimension Reduction: A User Study" {#sec-appendix-b}




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::


## Scripts


::: {#tbl-script-desc .cell layout-align="center" tbl-pos='H' tbl-cap='R script files used to generate outputs in the main paper.'}
::: {.cell-output-display}
\begingroup\fontsize{12}{14}\selectfont

\begin{longtable}{>{\raggedright\arraybackslash}p{8.7cm}>{\raggedright\arraybackslash}p{6cm}>{\raggedright\arraybackslash}p{8.7cm}}
\toprule
\textbf{Script} & \textbf{Description}\\
\midrule
\endfirsthead
\multicolumn{2}{@{}l}{\textit{(continued)}}\\
\toprule
\textbf{Script} & \textbf{Description}\\
\midrule
\endhead

\endfoot
\bottomrule
\endlastfoot
additional\_functions.R & Helper functions to render the main paper.\\
01\_attention\_check\_data\_structures.R & Function to generate three- and four- Gaussian clusters data  for attention check.\\
01\_data\_structure\_components.R & Functions to generate data structure components for non-attention check.\\
02\_data\_structures.R & Functions to generate three clusters data structure for non-attention check.\\
03\_exp\_design\_with\_method\_and\_distance\_factor.R & Creates the experimental design, varying NLDR method and distance scale factors.\\
04\_exp\_design\_with\_new\_ds\_factors.R & Extends the experimental design to include additional distance scale factor.\\
05\_gen\_clust3\_attention\_check\_data.R & Generates three-cluster data for attention check.\\
05\_gen\_cluster3\_high\_d\_data.R & Generates three-cluster data with medium-large distance scale factor.\\
06\_gen\_clusters3\_with\_diff\_dist.R & Generates three-cluster data with varying inter-cluster distance scale factors.\\
09\_gen\_clusters\_merge\_all\_data.R & Merges all generated cluster data (attention and non-attention check) into a single combined dataset.\\
10\_gen\_embeddings.R & Computes multiple NLDR embeddings for specific distance scale factor.\\
11\_comb\_emb\_default\_data.R & Combines NLDR embeddings for all distance scale factors.\\
12\_comb\_data.R & Merge all NLDR embeddings generated for attention and non-attention check.\\
13\_data\_processing\_method\_ds\_factor\_missings.R & Processes collected experimental data and generates the file, containing all relevant details for the same data structure shown in both displays.\\
13\_data\_processing\_method\_ds\_factor.R & Processes collected experimental data and generates the  file, containing all relevant details for the same data structure shown in both displays.\\
17\_compute\_distance\_btw\_centroids.R & Computes different distance metrics between cluster in the high-dimensional space.\\
19\_find\_which\_replicates\_missing.R & Identifies missing responses across experimental conditions.\\
pwr\_analysis\_umap\_0.1\_0.6.R & Power analysis to decide the number of responses needed to detect the difference between UMAP 0.1 and 0.6 distance scale factors.\\
pwr\_analysis\_tsne\_0.1\_0.6.R & Power analysis to decide the number of responses needed to detect the difference between tSNE 0.1 and 0.6 distance scale factors.\\*
\end{longtable}
\endgroup{}


:::
:::



## Data sets

@tbl-dt-str summarizes the three-cluster data sets used in the experiment. Each data set was generated using the `cardinalR` package [@jayani2025b] and comprises three clusters with distinct structures. The collection of structures spans a wide range of nonlinear, curved, and density-based configurations in $4\text{-}D$ space, providing controlled yet varied settings for assessing perceptual differences across NLDR methods. All data sets used in this experiment are available at [https://github.com/JayaniLakshika/Monash_PhD_thesis/blob/main/data/vis-exp/high_d_data_three_clust_all.rds](https://github.com/JayaniLakshika/Monash_PhD_thesis/blob/main/data/vis-exp/high_d_data_three_clust_all.rds).


::: {#tbl-dt-str .cell layout-align="center" tbl-cap='Description of the simulated three-cluster data structures. Each data structure consists of three clusters with different geometric shapes.'}
::: {.cell-output-display}

\begin{tabular}{>{\raggedright\arraybackslash}p{3cm}>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{2cm}>{\raggedright\arraybackslash}p{4cm}}
\toprule
Data structure & Cluster1 & Cluster2 & Cluster3\\
\midrule
three\_clust\_01 & curv & elliptical & blunted\_cone\\
three\_clust\_02 & s\_curve & cube & pyramid\_rectangular\_base\\
three\_clust\_03 & curvy\_cylinder & hemisphere & pyramid\_triangular\_base\\
three\_clust\_04 & curv2 & Gaussian & filled\_hexagonal\_pyramid\\
three\_clust\_05 & nonlinear\_hyperbola & elliptical & blunted\_cone\\
three\_clust\_06 & crescent & cube & pyramid\_rectangular\_base\\
three\_clust\_07 & nonlinear\_hyperbola2 & hemisphere & pyramid\_triangular\_base\\
three\_clust\_08 & conic\_spiral & Gaussian & filled\_hexagonal\_pyramid\\
three\_clust\_09 & helical\_hyper\_spiral & cube & blunted\_cone\\
three\_clust\_10 & spherical\_spiral & Gaussian & pyramid\_triangular\_base\\
three\_clust\_11 & curv & elliptical & pyramid\_rectangular\_base\\
three\_clust\_12 & s\_curve & hemisphere & filled\_hexagonal\_pyramid\\
three\_clust\_13 & curvy\_cylinder & cube & blunted\_cone\\
three\_clust\_14 & curv2 & Gaussian & pyramid\_triangular\_base\\
three\_clust\_15 & nonlinear\_hyperbola & elliptical & pyramid\_rectangular\_base\\
three\_clust\_16 & crescent & hemisphere & filled\_hexagonal\_pyramid\\
three\_clust\_17 & nonlinear\_hyperbola2 & cube & blunted\_cone\\
three\_clust\_18 & conic\_spiral & Gaussian & pyramid\_triangular\_base\\
three\_clust\_19 & helical\_hyper\_spiral & hemisphere & filled\_hexagonal\_pyramid\\
three\_clust\_20 & spherical\_spiral & elliptical & blunted\_cone\\
three\_clust\_21 & curv & Gaussian & pyramid\_rectangular\_base\\
three\_clust\_22 & s\_curve & cube & pyramid\_triangular\_base\\
three\_clust\_23 & curvy\_cylinder & hemisphere & filled\_hexagonal\_pyramid\\
three\_clust\_24 & curv2 & elliptical & blunted\_cone\\
three\_clust\_25 & nonlinear\_hyperbola2 & Gaussian & pyramid\_rectangular\_base\\
three\_clust\_26 & crescent & cube & pyramid\_triangular\_base\\
three\_clust\_27 & nonlinear\_hyperbola2 & hemisphere & filled\_hexagonal\_pyramid\\
three\_clust\_28 & conic\_spiral & elliptical & blunted\_cone\\
three\_clust\_29 & Gaussian & Gaussian & Gaussian\\
three\_clust\_30 & Gaussian & Gaussian & Gaussian\\
\bottomrule
\end{tabular}


:::
:::


Animations of the $4\text{-}D$ tours that were used for the study’s non-attention check SAME trials, non-attention check DIFFERENT trials, and attention-check trials are available on YouTube at the links given in @tbl-links-same-html, @tbl-links-diff-html, and @tbl-links-at-html.


::: {.cell layout-align="center"}

:::



::: {#tbl-links-same-html .cell layout-align="center" tbl-pos='H' tbl-cap='Videos of datasets used for non-attention check SAME trials.'}
::: {.cell-output-display}
\begingroup\fontsize{12}{14}\selectfont

\begin{longtable}{>{\raggedright\arraybackslash}p{2.3cm}>{\raggedright\arraybackslash}p{2.3cm}>{\raggedright\arraybackslash}p{2.4cm}>{\raggedright\arraybackslash}p{2cm}>{\raggedright\arraybackslash}p{2.4cm}>{\raggedright\arraybackslash}p{2cm}}
\toprule
\textbf{Data structure} & \textbf{Small} & \textbf{Small-medium} & \textbf{Medium} & \textbf{Medium-large} & \textbf{Large}\\
\midrule
\endfirsthead
\multicolumn{6}{@{}l}{\textit{(continued)}}\\
\toprule
\textbf{Data structure} & \textbf{Small} & \textbf{Small-medium} & \textbf{Medium} & \textbf{Medium-large} & \textbf{Large}\\
\midrule
\endhead

\endfoot
\bottomrule
\endlastfoot
three\_clust\_01 & \href{https://youtu.be/kZyZxujDz58}{\url{youtu.be/kZyZxujDz58}} & \href{https://youtu.be/Jz3k4uIAiRo}{\url{youtu.be/Jz3k4uIAiRo}} & \href{https://youtube.com/shorts/QqMDQxShke0}{\url{youtube.com/shorts/QqMDQxShke0}} & \href{https://youtu.be/E9msE_XX0KA}{\url{youtu.be/E9msE_XX0KA}} & \href{https://youtube.com/shorts/07Ya6SjNDV0}{\url{youtube.com/shorts/07Ya6SjNDV0}}\\
three\_clust\_02 & \href{https://youtu.be/CLMlOU4Fb2w}{\url{youtu.be/CLMlOU4Fb2w}} & \href{https://youtu.be/TFj0satlBBE}{\url{youtu.be/TFj0satlBBE}} & \href{https://youtube.com/shorts/jKarI60euSw}{\url{youtube.com/shorts/jKarI60euSw}} & \href{https://youtu.be/_f2WvtD2xog}{\url{youtu.be/f2WvtD2xog}} & \href{https://youtube.com/shorts/Vk7K5vlXiVM}{\url{youtube.com/shorts/Vk7K5vlXiVM}}\\
three\_clust\_03 & \href{https://youtu.be/K2oKM4mUBXM}{\url{youtu.be/K2oKM4mUBXM}} & \href{https://youtu.be/b-43HKN30ws}{\url{youtu.be/b-43HKN30ws}} & \href{https://youtube.com/shorts/edCnIfgfoU0}{\url{youtube.com/shorts/edCnIfgfoU0}} & \href{https://youtu.be/7NwNcD4qlLc}{\url{youtu.be/7NwNcD4qlLc}} & \href{https://youtube.com/shorts/-aB3PwE676E}{\url{youtube.com/shorts/-aB3PwE676E}}\\
three\_clust\_04 & \href{https://youtu.be/7yvvpPgiWNw}{\url{youtu.be/7yvvpPgiWNw}} & \href{https://youtu.be/1PhZO7cUEaI}{\url{youtu.be/1PhZO7cUEaI}} & \href{https://youtu.be/XO61YVXAdr8}{\url{youtu.be/XO61YVXAdr8}} & \href{https://youtu.be/XO61YVXAdr8}{\url{youtu.be/XO61YVXAdr8}} & \href{https://youtube.com/shorts/7e60CeOM50Q}{\url{youtube.com/shorts/7e60CeOM50Q}}\\
three\_clust\_05 & \href{https://youtu.be/pbI7UXFgc0k}{\url{youtu.be/pbI7UXFgc0k}} & \href{https://youtu.be/G-TvOIBj-14}{\url{youtu.be/G-TvOIBj-14}} & \href{https://youtube.com/shorts/I9xxCinW4Ec}{\url{youtube.com/shorts/I9xxCinW4Ec}} & \href{https://youtu.be/ardE0G7zevk}{\url{youtu.be/ardE0G7zevk}} & \href{https://youtube.com/shorts/21xj8nnnvec}{\url{youtube.com/shorts/21xj8nnnvec}}\\
three\_clust\_06 & \href{https://youtu.be/Mxylk4M67iA}{\url{youtu.be/Mxylk4M67iA}} & \href{https://youtu.be/ABrxozu8F-A}{\url{youtu.be/ABrxozu8F-A}} & \href{https://youtube.com/shorts/FISgM4T2xEI}{\url{youtube.com/shorts/FISgM4T2xEI}} & \href{https://youtu.be/soFQR9UwNsg}{\url{youtu.be/soFQR9UwNsg}} & \href{https://youtube.com/shorts/pX0E8E-Dbxc}{\url{youtube.com/shorts/pX0E8E-Dbxc}}\\
three\_clust\_07 & \href{https://youtu.be/2a89BQGK_iU}{\url{youtu.be/2a89BQGK_iU}} & \href{https://youtu.be/Wt4NwZSACmo}{\url{youtu.be/Wt4NwZSACmo}} & \href{https://youtube.com/shorts/MbGOoTrvVXk}{\url{youtube.com/shorts/MbGOoTrvVXk}} & \href{https://youtu.be/hVwIjSxACoo}{\url{youtu.be/hVwIjSxACoo}} & \href{https://youtube.com/shorts/y0kitUPbAoQ}{\url{youtube.com/shorts/y0kitUPbAoQ}}\\
three\_clust\_08 & \href{https://youtu.be/eID-dwpgU44}{\url{youtu.be/eID-dwpgU44}} & \href{https://youtu.be/ILwnlZUMj_U}{\url{youtu.be/ILwnlZUMj_U}} & \href{https://youtube.com/shorts/6k20OE3Fkcg}{\url{youtube.com/shorts/6k20OE3Fkcg}} & \href{https://youtu.be/oSBaMH9HJZ4}{\url{youtu.be/oSBaMH9HJZ4}} & \href{https://youtube.com/shorts/B4OiM4sfZ4g}{\url{youtube.com/shorts/B4OiM4sfZ4g}}\\
three\_clust\_09 & \href{https://youtu.be/6uGCDUSL60Q}{\url{youtu.be/6uGCDUSL60Q}} & \href{https://youtu.be/RvlSY3drV5I}{\url{youtu.be/RvlSY3drV5I}} & \href{https://youtube.com/shorts/TIyP-a75YmQ}{\url{youtube.com/shorts/TIyP-a75YmQ}} & \href{https://youtu.be/mh_rG2qy2Pc}{\url{youtu.be/mh_rG2qy2Pc}} & \href{https://youtube.com/shorts/hlaX3J8ibsA}{\url{youtube.com/shorts/hlaX3J8ibsA}}\\
three\_clust\_10 & \href{https://youtu.be/CX5O4eNZW5o}{\url{youtu.be/CX5O4eNZW5o}} & \href{https://youtu.be/fHxflXa9i-s}{\url{youtu.be/fHxflXa9i-s}} & \href{https://youtube.com/shorts/hUzYOFS8o4M}{\url{youtube.com/shorts/hUzYOFS8o4M}} & \href{https://youtu.be/R6vD1xJH21w}{\url{youtu.be/R6vD1xJH21w}} & \href{https://youtube.com/shorts/lM2sohLJS2s}{\url{youtube.com/shorts/lM2sohLJS2s}}\\
three\_clust\_11 & \href{https://youtu.be/1f8S7HiZ8dc}{\url{youtu.be/1f8S7HiZ8dc}} & \href{https://youtu.be/Fki5vIuPupE}{\url{youtu.be/Fki5vIuPupE}} & \href{https://youtube.com/shorts/Ar0gbKEfzQk}{\url{youtube.com/shorts/Ar0gbKEfzQk}} & \href{https://youtu.be/ciVOD8_sWR0}{\url{youtu.be/ciVOD8_sWR0}} & \href{https://youtube.com/shorts/jMWtm5gh-wU}{\url{youtube.com/shorts/jMWtm5gh-wU}}\\
three\_clust\_12 & \href{https://youtu.be/AZv45NGkuC4}{\url{youtu.be/AZv45NGkuC4}} & \href{https://youtu.be/qQ4LqHYH_c4}{\url{youtu.be/qQ4LqHYH_c4}} & \href{https://youtube.com/shorts/-WtgmbfY_Qo}{\url{youtube.com/shorts/-WtgmbfY_Qo}} & \href{https://youtu.be/Y2sfVoemVZo}{\url{youtu.be/Y2sfVoemVZo}} & \href{https://youtube.com/shorts/NsDzGdKsCyw}{\url{youtube.com/shorts/NsDzGdKsCyw}}\\
three\_clust\_13 & \href{https://youtu.be/U-bbZjzvaiE}{\url{youtu.be/U-bbZjzvaiE}} & \href{https://youtu.be/0MznMYr5gfo}{\url{youtu.be/0MznMYr5gfo}} & \href{https://youtube.com/shorts/PtAWhAz8bz8}{\url{youtube.com/shorts/PtAWhAz8bz8}} & \href{https://youtu.be/E7ge3kw5Q0Q}{\url{youtu.be/E7ge3kw5Q0Q}} & \href{https://youtube.com/shorts/6yc5gzPi6to}{\url{youtube.com/shorts/6yc5gzPi6to}}\\
three\_clust\_14 & \href{https://youtu.be/ynu2oUxv08I}{\url{youtu.be/ynu2oUxv08I}} & \href{https://youtu.be/gHDLMn5AG-8}{\url{youtu.be/gHDLMn5AG-8}} & \href{https://youtube.com/shorts/OSakdYTdbmU}{\url{youtube.com/shorts/OSakdYTdbmU}} & \href{https://youtu.be/HyCJEiwCVv0}{\url{youtu.be/HyCJEiwCVv0}} & \href{https://youtube.com/shorts/UJXFzkfoMH0}{\url{youtube.com/shorts/UJXFzkfoMH0}}\\
three\_clust\_15 & \href{https://youtu.be/xsdWsBek0eQ}{\url{youtu.be/xsdWsBek0eQ}} & \href{https://youtu.be/SDY64MrcWQg}{\url{youtu.be/SDY64MrcWQg}} & \href{https://youtube.com/shorts/w7V49k4GkEI}{\url{youtube.com/shorts/w7V49k4GkEI}} & \href{https://youtu.be/CFIyW7ftF9M}{\url{youtu.be/CFIyW7ftF9M}} & \href{https://youtube.com/shorts/SsyhvN6L7ks}{\url{youtube.com/shorts/SsyhvN6L7ks}}\\
three\_clust\_16 & \href{https://youtu.be/VyYyYOqhOVs}{\url{youtu.be/VyYyYOqhOVs}} & \href{https://youtu.be/zi-TvgVR8a4}{\url{youtu.be/zi-TvgVR8a4}} & \href{https://youtube.com/shorts/bRVl9y0JT8k}{\url{youtube.com/shorts/bRVl9y0JT8k}} & \href{https://youtu.be/hdQmD499yo8}{\url{youtu.be/hdQmD499yo8}} & \href{https://youtube.com/shorts/Uuy8xrnP_HU}{\url{youtube.com/shorts/Uuy8xrnP_HU}}\\
three\_clust\_17 & \href{https://youtu.be/yojgjcf2NQk}{\url{youtu.be/yojgjcf2NQk}} & \href{https://youtu.be/UJPMJ5irRbQ}{\url{youtu.be/UJPMJ5irRbQ}} & \href{https://youtube.com/shorts/zI-JNpMRYxY}{\url{youtube.com/shorts/zI-JNpMRYxY}} & \href{https://youtu.be/zdQYQvqTyGA}{\url{youtu.be/zdQYQvqTyGA}} & \href{https://youtube.com/shorts/P4E78ewAEJs}{\url{youtube.com/shorts/P4E78ewAEJs}}\\
three\_clust\_18 & \href{https://youtu.be/r-Z1Yyf2c4s}{\url{youtu.be/r-Z1Yyf2c4s}} & \href{https://youtu.be/2Rf2L8iey2w}{\url{youtu.be/2Rf2L8iey2w}} & \href{https://youtube.com/shorts/_x7kGF4xRz4}{\url{youtube.com/shorts/_x7kGF4xRz4}} & \href{https://youtu.be/e_-IQycglVE}{\url{youtu.be/e_-IQycglVE}} & \href{https://youtube.com/shorts/rY8hIqDaHKw}{\url{youtube.com/shorts/rY8hIqDaHKw}}\\*
\end{longtable}
\endgroup{}


:::
:::



::: {.cell layout-align="center"}

:::



::: {#tbl-links-diff-html .cell layout-align="center" tbl-pos='H' tbl-cap='Videos of datasets used for non-attention check DIFFERENT trials.'}
::: {.cell-output-display}
\begingroup\fontsize{12}{14}\selectfont

\begin{longtable}{>{\raggedright\arraybackslash}p{3cm}>{\raggedright\arraybackslash}p{10cm}>{\raggedright\arraybackslash}p{3cm}>{\raggedright\arraybackslash}p{10cm}>{}p{3cm}>{}p{10cm}}
\toprule
\textbf{Data structure} & \textbf{URL}\\
\midrule
\endfirsthead
\multicolumn{2}{@{}l}{\textit{(continued)}}\\
\toprule
\textbf{Data structure} & \textbf{URL}\\
\midrule
\endhead

\endfoot
\bottomrule
\endlastfoot
three\_clust\_19 & \href{https://youtube.com/shorts/fb-gQ064JdI}{\url{youtube.com/shorts/fb-gQ064JdI}}\\
three\_clust\_20 & \href{https://youtube.com/shorts/5Lm03LMiC2s}{\url{youtube.com/shorts/5Lm03LMiC2s}}\\
three\_clust\_21 & \href{https://youtube.com/shorts/BmKzrqTWUbI}{\url{youtube.com/shorts/BmKzrqTWUbI}}\\
three\_clust\_22 & \href{https://youtube.com/shorts/wrn6lj7-RrQ}{\url{youtube.com/shorts/wrn6lj7-RrQ}}\\
three\_clust\_23 & \href{https://youtube.com/shorts/AWgG3tbfYpA}{\url{youtube.com/shorts/AWgG3tbfYpA}}\\
three\_clust\_24 & \href{https://youtube.com/shorts/JR_6QorZjj8}{\url{youtube.com/shorts/JR_6QorZjj8}}\\
three\_clust\_25 & \href{https://youtube.com/shorts/gKEZGGZcE6c}{\url{youtube.com/shorts/gKEZGGZcE6c}}\\
three\_clust\_26 & \href{https://youtube.com/shorts/Ar7OAtuwWsc}{\url{youtube.com/shorts/Ar7OAtuwWsc}}\\
three\_clust\_27 & \href{https://youtube.com/shorts/BXcLP-qqPWo}{\url{youtube.com/shorts/BXcLP-qqPWo}}\\
three\_clust\_28 & \href{https://youtube.com/shorts/e6cP4jC2xGM}{\url{youtube.com/shorts/e6cP4jC2xGM}}\\*
\end{longtable}
\endgroup{}


:::
:::



::: {.cell layout-align="center"}

:::



::: {#tbl-links-at-html .cell layout-align="center" tbl-pos='H' tbl-cap='Videos of datasets used for attention check trials.'}
::: {.cell-output-display}
\begingroup\fontsize{12}{14}\selectfont

\begin{longtable}{>{\raggedright\arraybackslash}p{3cm}>{\raggedright\arraybackslash}p{10cm}>{\raggedright\arraybackslash}p{3cm}>{\raggedright\arraybackslash}p{10cm}>{}p{3cm}>{}p{10cm}}
\toprule
\textbf{Data structure} & \textbf{URL}\\
\midrule
\endfirsthead
\multicolumn{2}{@{}l}{\textit{(continued)}}\\
\toprule
\textbf{Data structure} & \textbf{URL}\\
\midrule
\endhead

\endfoot
\bottomrule
\endlastfoot
three\_clust\_29 & \href{https://youtube.com/shorts/bqZporzHQ5U}{\url{youtube.com/shorts/bqZporzHQ5U}}\\
three\_clust\_30 & \href{https://youtube.com/shorts/onAg2AgT2P4}{\url{youtube.com/shorts/onAg2AgT2P4}}\\*
\end{longtable}
\endgroup{}


:::
:::



## $2\text{-}D$ NLDR layouts

All $2\text{-}D$ NLDR layouts used in the experiment are available in the supplementary repository: [https://github.com/JayaniLakshika/Monash_PhD_thesis/tree/main/figures/vis-exp/layouts](https://github.com/JayaniLakshika/Monash_PhD_thesis/tree/main/figures/vis-exp/layouts). These include all $2\text{-}D$ embeddings generated under different NLDR methods (tSNE, UMAP, PHATE, TriMAP, and PaCMAP) with default hyper-parameter settings for the simulated $4\text{-}D$ data sets. All embedding data used to generate the $2\text{-}D$ NLDR layouts are available at [https://github.com/JayaniLakshika/Monash_PhD_thesis/blob/main/data/vis-exp/embedding_data_three_clust_all.rds](https://github.com/JayaniLakshika/Monash_PhD_thesis/blob/main/data/vis-exp/embedding_data_three_clust_all.rds).

## Distance metrics

To quantify cluster separation in the high-dimensional space, we considered several inter-cluster distance metrics that capture different aspects of separability (@fig-distance-metrics). Together, these metrics reflect both global separation between clusters and more local boundary proximity. All distance metrics were computed using standard implementations provided by the `fpc` [@christian2024] R package.

Because the metrics operate on different scales and respond differently to changes in cluster geometry, all distance-based measures were min–max scaled prior to analysis. Several metrics were additionally transformed (using exponential, square-root, or squared transformations) to improve comparability across datasets. These transformations were not intended to alter the interpretation of the measures, but rather to reduce strong nonlinearities and place the metrics on roughly similar scales.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Pairwise relationships among six distance metrics used to quantify cluster separation in the high-dimensional space: between–within (BW) ratio, exponentiated scaled minimum distance, quantile-ranked average between-cluster distance, Pearson–Gamma coefficient, average silhouette distance, and square-root–transformed Dunn and Dunn2 indices. The diagonal panels show the distribution of each metric, while the lower panels show scatterplots colored by distance scaling factor (S, SM, M, ML, L). Upper panels report Pearson correlation coefficients for all pairs, with significance indicated by asterisks ($p < 0.001$ '`***`'). Metrics show high positive correlation, confirming that they capture consistent structural variation. The BW ratio and exponentiated minimum distance were chosen for the main analysis because they provide complementary summaries of global cluster separation and local boundary distance.](B-appB_files/figure-pdf/fig-distance-metrics-1.pdf){#fig-distance-metrics fig-align='center' fig-alt='A matrix of pairwise plots showing relationships among six cluster separation metrics. Each row and column corresponds to one metric. The diagonal panels display the distribution of each metric, shown as smooth density curves. The lower triangular panels contain scatterplots comparing pairs of metrics, with points colored by distance scaling factor levels labeled S, SM, M, ML, and L. The scatterplots show strong positive associations across most metric pairs, with points forming tight upward-sloping clouds. The upper triangular panels display Pearson correlation coefficients, many of which are large and positive, with asterisks indicating statistically significant correlations. Overall, the figure shows that all metrics vary consistently with distance scaling, while still capturing slightly different aspects of cluster separation.' width=100%}
:::
:::


As shown in @fig-distance-metrics, most metric pairs are strongly positively correlated, indicating that they respond similarly as cluster separation increases. This suggests that the distance scaling used in the simulations effectively controls separability and that the metrics capture related structural changes. The scatterplots also show differences in sensitivity across scaling levels, with some metrics responding more clearly at smaller separations and others providing better discrimination at larger separations.

Based on these patterns, we selected the BW ratio and the exponentiated scaled minimum distance for the main analyses. The BW ratio captures overall separation by contrasting between-cluster and within-cluster dispersion, while the exponentiated minimum distance focuses on the closest boundaries between clusters. Both measures are strongly correlated with the other metrics (upper panels of @fig-distance-metrics) but reflect complementary aspects of separability, allowing us to assess whether perceptual accuracy is driven more by global structure, local proximity, or both.

## Determining the number of responses per treatment

Before running the main experiment, we examined how many responses were needed for each treatment (method × distance factor) to reliably detect meaningful differences in performance. Rather than attempting to cover all possible combinations, we focused on representative comparisons that are most informative for the study. In particular, we compared UMAP and tSNE under two distance conditions ($0.1$ and $0.6$), which showed clear differences in correct identification rates in the pilot data.

Using pilot estimates of the correct proportion, we conducted a simulation-based power analysis based on a difference in proportions framework. The baseline probability was taken from the estimated performance at the smaller distance factor ($0.1$), and a range of effect sizes was explored. We focused on an effect size of approximately $0.22$, which corresponds to a change of about $20$ percentage points in correct identification and reflects a perceptually meaningful improvement in the ability to distinguish whether two views show the same data.

<!-- Targeting moderate to large effects is appropriate in perceptual studies of visualization, where small statistical differences may not translate into noticeable or reliable changes in what users actually see or report. In this context, effects of practical interest are those that lead to clear differences in perception rather than marginal improvements that are difficult for subjects to detect consistently. -->

<!--script/vis-exp/pwr_analysis_umap_0.1_0.6.R, script/vis-exp/pwr_analysis_tsne_0.1_0.6.R-->

::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Power curves showing the relationship between the number of responses and detection probability for differences in correct identification rates between distance factors $0.1$ and $0.6$. Panel (a) shows results for tSNE and panel (b) for UMAP. Curves correspond to different effect sizes (difference in proportions), with darker lines indicating larger effects. The horizontal line marks the target power of $0.8$, and the vertical dashed lines indicate the approximate number of responses required to reach this level for a moderate–large effect ($\approx 0.22$). UMAP reaches the target power with fewer responses than tSNE, reflecting lower variability in participant responses.](B-appB_files/figure-pdf/fig-num-res-detect-1.pdf){#fig-num-res-detect fig-align='center' fig-alt='Two side-by-side line plots show detection probability as a function of the number of responses per condition. Panel (a) corresponds to tSNE and panel (b) to UMAP. In both panels, the x-axis shows the number of responses per condition, ranging from about 10 to 100, and the y-axis shows detection probability from 0 to 1. Multiple lines are shown in each panel, corresponding to different effect sizes, with darker lines indicating larger effects. Detection probability increases as the number of responses increases for all effect sizes. A horizontal reference line marks a detection probability of 0.8, and a vertical dashed line indicates the approximate number of responses required to reach this level for a moderate–large effect (around 0.22). UMAP reaches this threshold with fewer responses (around 70) than tSNE (around 80), indicating higher sensitivity and lower variability for UMAP at this effect size.' width=100%}
:::
:::


The results show that (@fig-num-res-detect), for this effect size, UMAP reaches a detection probability of $0.8$ with around $70$ responses per condition, while tSNE requires approximately $80$ responses to achieve the same level of power. This difference reflects the higher variability observed in tSNE responses compared to UMAP. Importantly, these results indicate that the number of responses collected in the main experiment (typically between $75$ and $80$ per condition) is sufficient to detect moderate to large effects for both methods.

## Data collection process

### Recruit subjects

Subjects were recruited from Prolific [@palan2018], an online platform, to evaluate the trials. The study expects that the subjects are uninvolved judges with no prior knowledge of the data to avoid inadvertently affecting results. Potential subjects needed with fluent in English and have completed at least $10$ Prolific studies with a $98\%$ approval rate. The Prolific server only considers subjects who are age $18$ and older.

All subjects were trained using three example displays to orient them to the evaluation trials and provided [introductory materials](https://drive.google.com/file/d/14o-nSjy50Qw2eoQArK5AhjowLIOe6m14/view). All subjects who completed the task were compensated $9.96$ GBP per hour for their time via the Prolific payment system.

### Web application to collect responses

The survey web application, [Match-a-roo](https://ebsmonash.shinyapps.io/web_game/), is designed to collect survey responses and demographics using the `shiny` [@winston2025a] package in R. Each subject had access to the survey via the `shiny.io server` [@posit2022]. The first interface of the survey app contained an introduction, instructions for the survey (@fig-intro-page), a consent form (@fig-consent), and buttons to access, for example, actual trials. Subjects can try three examples prior to the study where the answers were not recorded (@fig-example). The subjects were first asked for their consent for the responses to be used for analysis.

A total of $150$ participants took part in the study. Of these, $127$ completed the attention check correctly, while $23$ provided incorrect responses. The analysis was therefore conducted using data from the $127$ participants who passed the attention check.

After giving consent, the participant can start the trials. Two visual displays of data are shown, where the data may be the same or different (@fig-act). One of the visual displays is a $2\text{-}D$ NLDR plot, and the other is a tour made of many $2\text{-}D$ plots. The subjects were asked to decide whether the data was the same in both displays and to report their confidence about their choice and any comments about the answer.

When the subjects completed the twenty evaluations, they were asked for their demographics, which included preferred pronoun, the highest level of education achieved, their age category, whether they used principal component analysis in their work, and whether they applied NLDR techniques such as tSNE and UMAP (@fig-demo). Finally, the subjects need to click on the prolific URL ([https://app.prolific.co/submissions/](https://app.prolific.co/submissions/complete?cc=CLDDOZ10)) to redirect back to the Prolific app (@fig-end). 


::: {.cell layout-align="center"}
::: {.cell-output-display}
![Diagram of online experiment setup.](../figures/vis-exp/experiment.png){#fig-exp-setup fig-align='center' fig-alt='A flow diagram showing the experimental workflow implemented in the Shiny application. The process begins when a participant starts the study. The app connects to a Google Sheet containing subject IDs and checks which IDs are available by reading a column that indicates whether an ID has been used. One eligible subject ID is randomly selected and marked as used, ensuring it cannot be assigned again. The assigned subject ID is then used to link the participant to the experiment design and the corresponding high-dimensional and embedding data. The participant is shown a sequence of trials, where each trial displays both a tour of linear projections and two-dimensional NLDR embeddings based on the assigned data. After each trial, the participant records their response, which is saved to a results Google Sheet. Once all trials are completed, the participant fills out a demographics questionnaire, and these responses are saved to a separate demographics Google Sheet. The diagram shows this process proceeding sequentially from study start to completion.' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The introduction page of the study app.](../figures/vis-exp/introduction.png){#fig-intro-page fig-align='center' fig-alt='Each subject had access to the survey via the [shiny.io server](https://www.shinyapps.io/). The first interface of the survey app contained an introduction, instructions for the survey (@fig-intro-page), a consent form (@fig-consent), and buttons to access, for example, actual trials. Subjects can try three examples prior to the study where the answers were not recorded (@fig-example). The subjects were first asked for their consent to the responses being used for analysis.' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The consent form provided in the study app.](../figures/vis-exp/consent.png){#fig-consent fig-align='center' fig-alt='A screenshot of the introduction page of the Shiny survey application. The page contains a title and several paragraphs explaining the purpose of the study and providing instructions on how to complete the visual comparison tasks. Text explains what subjects will see during the experiment and how to submit responses. Navigation buttons are shown at the bottom of the page, allowing subjects to proceed to the consent form, try example trials, or begin the study.' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The example trial page of the study app.](../figures/vis-exp/example.png){#fig-example fig-align='center' fig-alt='A screenshot of the example trials interface in the survey application. The page displays sample visualizations similar to those used in the main experiment, allowing subjects to practice the task. Instructions explain that these examples are for familiarization only and that responses are not recorded. Controls are shown for navigating through three example trials before starting the actual study.' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The actual trial page of the study app.](../figures/vis-exp/attempt.png){#fig-act fig-align='center' fig-alt='A screenshot of the main trial interface of the survey application. Two visual displays are shown side by side. One display shows a two-dimensional nonlinear dimensionality reduction (NLDR) embedding, while the other shows a tour consisting of many two-dimensional linear projections of the same or different high-dimensional data. Below the visualizations, subjects are asked to indicate whether the data shown in the two displays are the same or different. Additional interface elements allow subjects to report their confidence in the decision and to enter optional comments before submitting the response.' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The demographics page of the study app.](../figures/vis-exp/demographics.png){#fig-demo fig-align='center' fig-alt='A screenshot of the demographics questionnaire displayed after the completion of all trials. The page contains several questions asking subjects about their preferred pronoun, highest level of education attained, age category, and experience with statistical techniques. Checkboxes or selection inputs ask whether subjects have used principal component analysis and nonlinear dimensionality reduction methods such as tSNE or UMAP. A button is provided to submit the demographic information.' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The end page of the study app.](../figures/vis-exp/end_page.png){#fig-end fig-align='center' fig-alt='A screenshot of the final page of the survey application shown after all responses have been submitted. The page includes a short message thanking subjects for completing the study and provides instructions for returning to the Prolific platform. A clickable link or button is displayed that redirects subjects to the Prolific submission URL to complete the study and receive credit.' width=100%}
:::
:::


Once a participant starts the study (@fig-exp-setup), the "eligibility_subject_IDs" Google Sheet is connected and read in the Shiny app to identify which subject IDs have not yet been assigned to anyone, as indicated by the "used" column. If the "used" column is marked as NA, it means that the subject ID has not been assigned. 

After identifying the eligible subject IDs, one is randomly assigned to the participant, and "1" is recorded in the "used" column corresponding to that subject ID. This subject ID will later assist in connecting the experiment design, high-dimensional data, and embedding data.

Once a subject ID is allocated to a participant, the experiment design data are loaded, and the relevant attempts, data structure, and methods are presented to the participant. This process continues until the participant completes all attempts. After determining the data structure and methods, the relevant high-dimensional and embedding data are loaded from "high_d_data_three_clust_all.rds" and "embedding_data_three_clust_all.rds", respectively, and displayed in both tour and $2\text{-}D$ NLDR plots. 

Once the participant records their answers, a new row is added to the "result_df" Google Sheet with their responses. This continues until the participant finishes the study. Finally, after completing the evaluations, subjects are asked to fill out a demographics questionnaire. Their responses are then recorded in a new row of the "demographic_details" Google Sheet.

## Variability across data sets and subjects

Two sources of variability in the experimental design that are important to assess relative to the fitted model: data sets and subjects. Data sets are effectively treated as replicates in the experiment, providing random samples of a range of types of clusters. Humans have different perceptual skills, which is why it is important to include a subject random effect in the model. 

Across the data sets used in the experiment, the proportion of correct responses ranges from approximately $0.3$ to $0.7$ (@fig-var-sum a). Because data sets were assigned at random, in a way unrelated to other factors in the experiment, this represents a source of variation that can safely be treated as noise.
<!-- Many data sets behave similarly, which is not surprising given that they are constructed from a shared set of underlying data structures. Because the data sets exhibit comparable levels of difficulty rather than forming distinct groups, treating data set as a separate experimental factor is unlikely to add explanatory power. Instead, variation across data sets reflects structural differences already captured by the design of the simulation.-->

The proportion correct across subjects is symmetric and unimodal, reasonably consistent with the assumption that they are normally distributed random effects (@fig-var-sum b). Some subjects performed extremely well, and others poorly. This is similar to what has been observed in other human subject experiments involving visual tasks. A high score could be obtained by selecting SAME on each trial, but this was not the case when all their data was examined. <!-- Most subjects achieve moderate accuracy, centred around a correct proportion of roughly $0.5$ , with fewer subjects at the lower and higher ends. Importantly, this distribution is balanced rather than polarized. High-accuracy subjects do not succeed simply by always choosing "SAME"; they still make occasional errors. Similarly, subjects with lower accuracy are not consistently choosing "DIFFERENT" and do show some correct responses. As a result, no subject has a correct proportion of exactly $0$ or $1$.--> 

<!-- This pattern suggests that subjects differ in overall sensitivity to visual structure, but not in a way that reflects systematic bias or disengagement. These individual differences are therefore well-represented as random effects, allowing us to account for baseline variation in performance without attributing it to the experimental conditions themselves. Modeling subjects as a random effect captures this heterogeneity while preserving the focus on how NLDR methods and cluster separation influence perceptual accuracy.-->

<!-- #### Summary -->
<!-- data structure wise analysis-->



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Examining the variability of proportion correct across data sets and subjects. Panel (a) shows the proportion of correct responses for each data set. The variation in correct response rates ranges from $0.3$ to $0.7$. Given the randomized and balanced design, this variation is largely consistent with expected replication variability and does not add a substantial amount of random noise to the overall results. Panel (b) shows the distribution of proportion correct across subjects. It is relatively Gaussian, with a few subjects performing exceptionally well and some poorly. This is consistent with other human subject experiments and reflects individual visual skills, illustrating the need to include subject-specific random effects in the model.](B-appB_files/figure-pdf/fig-var-sum-1.pdf){#fig-var-sum fig-align='center' fig-alt='The figure has two panels summarizing variability in proportion correct. Panel (a) shows a plot of proportion correct for each data set, with values ranging approximately from 0.3 to 0.7. The proportions vary across data sets but cluster within a moderate range. Panel (b) shows a histogram of subjects’ proportion of correct responses. The horizontal axis is the correct proportion, ranging from 0 to 1, and the vertical axis is the number of subjects. The distribution is roughly symmetric and unimodal, centered near 0.5. Most subjects cluster around the middle accuracy range, with fewer subjects at the lower and higher ends. A small number of subjects perform notably better or worse than average, and no subject has perfect or zero accuracy.' width=100%}
:::
:::


## Analysis of results relative to the data collection process

### Data cleaning

The initial step in the data cleaning process involves the selection of subjects who have completed the requisite twenty trials, including the demographics and the attention check trial. Subjects who exceeded the average time of $5-10$ minutes were excluded, as determined from the pilot study. Following this, individuals who didn't accurately detect the attention check trial were also removed. Furthermore, the attention check trials were removed, as they did not contribute to the further analyses. Finally, the collected data set is further refined by filtering out all the responses which showed the same data structures in $2\text{-}D$ NLDR plot and tour.

### Demographics

Along with the responses to the trials, we have collected a series of demographic information, including preferred pronoun, age range category, educational background, and previous experience in PCA and Non-linear dimension reduction techniques. @tbl-pronoun, @tbl-age, @tbl-education, @tbl-pca, and @tbl-nldr provide summaries of the demographic data.  

The subjects are fairly balanced in terms of pronouns, with similar proportions identifying as *she/her* ($50.4\%$) and *he/him* ($48.0\%$), and a small number identifying as *they/them* ($1.6\%$). Subjects cover a wide age range, with most between $25$ and $34$ years old ($35.4\%$), followed by those aged $18-24$ ($20.5\%$) and $35-44$ ($19.7\%$). The sample has more younger and mid-adult age groups, while still including representation from older subjects.

Most subjects have completed an undergraduate degree ($44.9\%$) or a postgraduate qualification ($26.8\%$), with others reporting some undergraduate study ($21.3\%$). Only a small proportion did not complete high school. Prior experience with dimension reduction methods is limited: the majority report no previous experience with PCA ($84.2\%$) or nonlinear dimension reduction techniques ($86.6\%$). This suggests that most subjects approached the task without strong prior familiarity, allowing the results to reflect general perceptual interpretation rather than expert knowledge.


::: {.cell layout-align="center"}

:::



::: {#tbl-pronoun .cell layout-align="center" tbl-cap='Summary of the pronoun distribution of subjects recruited for this study.'}
::: {.cell-output-display}

\begin{tabular}{>{\raggedright\arraybackslash}p{2cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}}
\toprule
Pronoun & Period I & Period II & Total & \%\\
\midrule
he/him & 7 & 54 & 61 & 48.03\\
she/her & 11 & 53 & 64 & 50.39\\
they/them & 0 & 2 & 2 & 1.57\\
Total & 18 & 109 & 127 & 100.00\\
\bottomrule
\end{tabular}


:::
:::



::: {#tbl-age .cell layout-align="center" tbl-cap='Summary of the age distribution of subjects recruited for this study.'}
::: {.cell-output-display}

\begin{tabular}{>{\raggedright\arraybackslash}p{2cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}}
\toprule
Age group & Period I & Period II & Total & \%\\
\midrule
18 - 24 & 3 & 23 & 26 & 20.47\\
25 - 34 & 9 & 36 & 45 & 35.43\\
35 - 44 & 3 & 22 & 25 & 19.69\\
45 - 54 & 1 & 12 & 13 & 10.24\\
Over 55 & 2 & 16 & 18 & 14.17\\
Total & 18 & 109 & 127 & 100.00\\
\bottomrule
\end{tabular}


:::
:::



::: {#tbl-education .cell layout-align="center" tbl-cap='Summary of the educational distribution of subjects recruited for this study.'}
::: {.cell-output-display}

\begin{tabular}{>{\raggedright\arraybackslash}p{2cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}}
\toprule
Education & Period I & Period II & Total & \%\\
\midrule
Completed some undergraduate courses & 4 & 23 & 27 & 21.26\\
Did not complete high school & 0 & 4 & 4 & 3.15\\
Higher degree master or doctorate & 3 & 31 & 34 & 26.77\\
Prefer not to answer & 3 & 2 & 5 & 3.94\\
Undergraduate degree (A bachelor) & 8 & 49 & 57 & 44.88\\
Total & 18 & 109 & 127 & 100.00\\
\bottomrule
\end{tabular}


:::
:::



::: {#tbl-pca .cell layout-align="center" tbl-cap='Summary of the previous experience in PCA of subjects recruited for this study.'}
::: {.cell-output-display}

\begin{tabular}{>{\raggedright\arraybackslash}p{2cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}}
\toprule
Experience with PCA & Period I & Period II & Total & \%\\
\midrule
No & 15 & 92 & 107 & 84.25\\
Yes & 3 & 17 & 20 & 15.75\\
Total & 18 & 109 & 127 & 100.00\\
\bottomrule
\end{tabular}


:::
:::



::: {#tbl-nldr .cell layout-align="center" tbl-cap='Summary of the previous experience in Nonlinear dimension reduction techniques of subjects recruited for this study.'}
::: {.cell-output-display}

\begin{tabular}{>{\raggedright\arraybackslash}p{2cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}>{\raggedleft\arraybackslash}p{3cm}}
\toprule
Experience with NLDR & Period I & Period II & Total & \%\\
\midrule
No & 15 & 95 & 110 & 86.61\\
Yes & 3 & 14 & 17 & 13.39\\
Total & 18 & 109 & 127 & 100.00\\
\bottomrule
\end{tabular}


:::
:::



