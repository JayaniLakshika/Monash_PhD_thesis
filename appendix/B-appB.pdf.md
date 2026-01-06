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
19\_find\_which\_replicates\_missing.R & Identifies missing responses across experimental conditions.\\*
\end{longtable}
\endgroup{}


:::
:::



## Data sets

@tbl-dt-str summarizes the three-cluster data structures used in the experiment. Each data structure was generated using the `cardinalR` package [@jayani2025b] and comprises three clusters with distinct geometric forms. The collection of structures spans a wide range of nonlinear, curved, and density-based configurations in $4\text{-}D$ space, providing controlled yet varied settings for assessing perceptual differences across NLDR methods.


::: {#tbl-dt-str .cell layout-align="center" tbl-cap='Description of the simulated three-cluster data structures. Each data structure consists of three clusters with different geometric shapes.'}
::: {.cell-output-display}

\begin{tabular}{>{\raggedright\arraybackslash}p{2cm}>{\raggedright\arraybackslash}p{4cm}>{\raggedright\arraybackslash}p{2cm}>{\raggedright\arraybackslash}p{3cm}}
\toprule
Data structure & Cluster1 & Cluster2 & Cluster3\\
\midrule
three\_clust\_01 & curv & elliptical & blunted\_cone\\
three\_clust\_02 & s\_curve & cube & pyramid\_rectangular\_base\\
three\_clust\_03 & curvy\_cylinder & hemisphere & pyramid\_triangular\_base\\
three\_clust\_04 & curv2 & gaussian & filled\_hexagonal\_pyramid\\
three\_clust\_05 & nonlinear\_hyperbola & elliptical & blunted\_cone\\
three\_clust\_06 & crescent & cube & pyramid\_rectangular\_base\\
three\_clust\_07 & nonlinear\_hyperbola2 & hemisphere & pyramid\_triangular\_base\\
three\_clust\_08 & conic\_spiral & gaussian & filled\_hexagonal\_pyramid\\
three\_clust\_09 & helical\_hyper\_spiral & cube & blunted\_cone\\
three\_clust\_10 & spherical\_spiral & gaussian & pyramid\_triangular\_base\\
three\_clust\_11 & curv & elliptical & pyramid\_rectangular\_base\\
three\_clust\_12 & s\_curve & hemisphere & filled\_hexagonal\_pyramid\\
three\_clust\_13 & curvy\_cylinder & cube & blunted\_cone\\
three\_clust\_14 & curv2 & gaussian & pyramid\_triangular\_base\\
three\_clust\_15 & nonlinear\_hyperbola & elliptical & pyramid\_rectangular\_base\\
three\_clust\_16 & crescent & hemisphere & filled\_hexagonal\_pyramid\\
three\_clust\_17 & nonlinear\_hyperbola2 & cube & blunted\_cone\\
three\_clust\_18 & conic\_spiral & gaussian & pyramid\_triangular\_base\\
\bottomrule
\end{tabular}


:::
:::


Animations of the $4\text{-}D$ tours that used for the study are available on YouTube at the links given in @tbl-links-html.


::: {.cell layout-align="center"}

:::



::: {#tbl-links-html .cell layout-align="center" tbl-pos='H' tbl-cap='Videos'}
::: {.cell-output-display}
\begingroup\fontsize{12}{14}\selectfont

\begin{longtable}{>{\raggedright\arraybackslash}p{2.5cm}>{\raggedright\arraybackslash}p{2.5cm}>{\raggedright\arraybackslash}p{2.5cm}>{\raggedright\arraybackslash}p{2.5cm}>{\raggedright\arraybackslash}p{2.5cm}>{\raggedright\arraybackslash}p{2.5cm}}
\toprule
\textbf{data structure} & \textbf{small} & \textbf{small-medium} & \textbf{medium} & \textbf{medium-large} & \textbf{large}\\
\midrule
\endfirsthead
\multicolumn{6}{@{}l}{\textit{(continued)}}\\
\toprule
\textbf{data structure} & \textbf{small} & \textbf{small-medium} & \textbf{medium} & \textbf{medium-large} & \textbf{large}\\
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
three\_clust\_06 & \href{https://youtu.be/Mxylk4M67iA}{\url{youtu.be/Mxylk4M67iA}} & \href{https://youtu.be/ABrxozu8F-A}{\url{youtu.be/ABrxozu8F-A}} & \href{https://youtube.com/shorts/FISgM4T2xEI}{\url{youtube.com/shorts/FISgM4T2xEI}} & \href{https://youtu.be/soFQR9UwNsg}{\url{youtu.be/soFQR9UwNsg}} & \href{https://youtu.be/soFQR9UwNsg}{\url{youtu.be/soFQR9UwNsg}}\\
three\_clust\_07 & \href{https://youtu.be/2a89BQGK_iU}{\url{youtu.be/2a89BQGK_iU}} & \href{https://youtu.be/Wt4NwZSACmo}{\url{youtu.be/Wt4NwZSACmo}} & \href{https://youtube.com/shorts/MbGOoTrvVXk}{\url{youtube.com/shorts/MbGOoTrvVXk}} & \href{https://youtu.be/hVwIjSxACoo}{\url{youtu.be/hVwIjSxACoo}} & \href{https://youtu.be/hVwIjSxACoo}{\url{youtu.be/hVwIjSxACoo}}\\
three\_clust\_08 & \href{https://youtu.be/eID-dwpgU44}{\url{youtu.be/eID-dwpgU44}} & \href{https://youtu.be/ILwnlZUMj_U}{\url{youtu.be/ILwnlZUMj_U}} & \href{https://youtube.com/shorts/6k20OE3Fkcg}{\url{youtube.com/shorts/6k20OE3Fkcg}} & \href{https://youtu.be/oSBaMH9HJZ4}{\url{youtu.be/oSBaMH9HJZ4}} & \href{https://youtu.be/oSBaMH9HJZ4}{\url{youtu.be/oSBaMH9HJZ4}}\\
three\_clust\_09 & \href{https://youtu.be/6uGCDUSL60Q}{\url{youtu.be/6uGCDUSL60Q}} & \href{https://youtu.be/RvlSY3drV5I}{\url{youtu.be/RvlSY3drV5I}} & \href{https://youtube.com/shorts/TIyP-a75YmQ}{\url{youtube.com/shorts/TIyP-a75YmQ}} & \href{https://youtu.be/mh_rG2qy2Pc}{\url{youtu.be/mh_rG2qy2Pc}} & \href{https://youtu.be/mh_rG2qy2Pc}{\url{youtu.be/mh_rG2qy2Pc}}\\
three\_clust\_10 & \href{https://youtu.be/CX5O4eNZW5o}{\url{youtu.be/CX5O4eNZW5o}} & \href{https://youtu.be/fHxflXa9i-s}{\url{youtu.be/fHxflXa9i-s}} & \href{https://youtube.com/shorts/hUzYOFS8o4M}{\url{youtube.com/shorts/hUzYOFS8o4M}} & \href{https://youtu.be/R6vD1xJH21w}{\url{youtu.be/R6vD1xJH21w}} & \href{https://youtu.be/R6vD1xJH21w}{\url{youtu.be/R6vD1xJH21w}}\\
three\_clust\_11 & \href{https://youtu.be/1f8S7HiZ8dc}{\url{youtu.be/1f8S7HiZ8dc}} & \href{https://youtu.be/Fki5vIuPupE}{\url{youtu.be/Fki5vIuPupE}} & \href{https://youtube.com/shorts/Ar0gbKEfzQk}{\url{youtube.com/shorts/Ar0gbKEfzQk}} & \href{https://youtu.be/ciVOD8_sWR0}{\url{youtu.be/ciVOD8_sWR0}} & \href{https://youtu.be/ciVOD8_sWR0}{\url{youtu.be/ciVOD8_sWR0}}\\
three\_clust\_12 & \href{https://youtu.be/AZv45NGkuC4}{\url{youtu.be/AZv45NGkuC4}} & \href{https://youtu.be/qQ4LqHYH_c4}{\url{youtu.be/qQ4LqHYH_c4}} & \href{https://youtube.com/shorts/-WtgmbfY_Qo}{\url{youtube.com/shorts/-WtgmbfY_Qo}} & \href{https://youtu.be/Y2sfVoemVZo}{\url{youtu.be/Y2sfVoemVZo}} & \href{https://youtu.be/Y2sfVoemVZo}{\url{youtu.be/Y2sfVoemVZo}}\\
three\_clust\_13 & \href{https://youtu.be/U-bbZjzvaiE}{\url{youtu.be/U-bbZjzvaiE}} & \href{https://youtu.be/0MznMYr5gfo}{\url{youtu.be/0MznMYr5gfo}} & \href{https://youtube.com/shorts/PtAWhAz8bz8}{\url{youtube.com/shorts/PtAWhAz8bz8}} & \href{https://youtu.be/E7ge3kw5Q0Q}{\url{youtu.be/E7ge3kw5Q0Q}} & \href{https://youtu.be/E7ge3kw5Q0Q}{\url{youtu.be/E7ge3kw5Q0Q}}\\
three\_clust\_14 & \href{https://youtu.be/ynu2oUxv08I}{\url{youtu.be/ynu2oUxv08I}} & \href{https://youtu.be/gHDLMn5AG-8}{\url{youtu.be/gHDLMn5AG-8}} & \href{https://youtube.com/shorts/OSakdYTdbmU}{\url{youtube.com/shorts/OSakdYTdbmU}} & \href{https://youtu.be/HyCJEiwCVv0}{\url{youtu.be/HyCJEiwCVv0}} & \href{https://youtu.be/HyCJEiwCVv0}{\url{youtu.be/HyCJEiwCVv0}}\\
three\_clust\_15 & \href{https://youtu.be/xsdWsBek0eQ}{\url{youtu.be/xsdWsBek0eQ}} & \href{https://youtu.be/SDY64MrcWQg}{\url{youtu.be/SDY64MrcWQg}} & \href{https://youtube.com/shorts/w7V49k4GkEI}{\url{youtube.com/shorts/w7V49k4GkEI}} & \href{https://youtu.be/CFIyW7ftF9M}{\url{youtu.be/CFIyW7ftF9M}} & \href{https://youtube.com/shorts/SsyhvN6L7ks}{\url{youtube.com/shorts/SsyhvN6L7ks}}\\
three\_clust\_16 & \href{https://youtu.be/VyYyYOqhOVs}{\url{youtu.be/VyYyYOqhOVs}} & \href{https://youtu.be/zi-TvgVR8a4}{\url{youtu.be/zi-TvgVR8a4}} & \href{https://youtube.com/shorts/bRVl9y0JT8k}{\url{youtube.com/shorts/bRVl9y0JT8k}} & \href{https://youtu.be/hdQmD499yo8}{\url{youtu.be/hdQmD499yo8}} & \href{https://youtu.be/hdQmD499yo8}{\url{youtu.be/hdQmD499yo8}}\\
three\_clust\_17 & \href{https://youtu.be/yojgjcf2NQk}{\url{youtu.be/yojgjcf2NQk}} & \href{https://youtu.be/UJPMJ5irRbQ}{\url{youtu.be/UJPMJ5irRbQ}} & \href{https://youtube.com/shorts/zI-JNpMRYxY}{\url{youtube.com/shorts/zI-JNpMRYxY}} & \href{https://youtu.be/zdQYQvqTyGA}{\url{youtu.be/zdQYQvqTyGA}} & \href{https://youtu.be/zdQYQvqTyGA}{\url{youtu.be/zdQYQvqTyGA}}\\
three\_clust\_18 & \href{https://youtu.be/r-Z1Yyf2c4s}{\url{youtu.be/r-Z1Yyf2c4s}} & \href{https://youtu.be/2Rf2L8iey2w}{\url{youtu.be/2Rf2L8iey2w}} & \href{https://youtube.com/shorts/_x7kGF4xRz4}{\url{youtube.com/shorts/_x7kGF4xRz4}} & \href{https://youtu.be/e_-IQycglVE}{\url{youtu.be/e_-IQycglVE}} & \href{https://youtu.be/e_-IQycglVE}{\url{youtu.be/e_-IQycglVE}}\\*
\end{longtable}
\endgroup{}


:::
:::



## $2\text{-}D$ NLDR layouts

All $2\text{-}D$ NLDR layouts used in the experiment are available in the supplementary repository: [github.com/JayaniLakshika/Monash_PhD_thesis/figures/vis-exp/layouts](https://github.com/JayaniLakshika/Monash_PhD_thesis/tree/main/figures/vis-exp/layouts). These include all $2\text{-}D$ embeddings generated under different NLDR methods (tSNE, UMAP, PHATE, TriMAP, and PaCMAP) with default hyper-parameter settings for the simulated $4\text{-}D$ data structures.

## Distance metrics

To quantify cluster separation in the high-dimensional space, we considered several inter-cluster distance metrics that capture different aspects of separability (@fig-distance-metrics). Together, these metrics reflect both global separation between clusters and more local boundary proximity.


::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![Pairwise relationships among six distance metrics used to quantify cluster separation in the high-dimensional space: between–within (BW) ratio, exponentiated scaled minimum distance, quantile-ranked average between-cluster distance, Pearson–Gamma coefficient, average silhouette distance, and square-root–transformed Dunn and Dunn2 indices. The diagonal panels show the distribution of each metric, while the lower panels show scatterplots colored by distance scaling factor (S, SM, M, ML, L). Upper panels report Pearson correlation coefficients for all pairs, with significance indicated by asterisks ($p < 0.001$ '`***`'). Metrics show high positive correlation, confirming that they capture consistent structural variation. The BW ratio and exponentiated minimum distance were chosen for the main analysis because they provide complementary summaries of global cluster separation and local boundary distance.](B-appB_files/figure-pdf/fig-distance-metrics-1.pdf){#fig-distance-metrics fig-align='center' width=100%}
:::
:::


As shown in @fig-distance-metrics, most metric pairs are strongly positively correlated, indicating that they respond similarly as cluster separation increases. This suggests that the distance scaling used in the simulations effectively controls separability and that the metrics capture related structural changes. The scatterplots also show differences in sensitivity across scaling levels, with some metrics responding more clearly at smaller separations and others providing better discrimination at larger separations.

Based on these patterns, we selected the BW ratio and the exponentiated scaled minimum distance for the main analyses. The BW ratio captures overall separation by contrasting between- and within-cluster dispersion, while the exponentiated minimum distance focuses on the closest boundaries between clusters. Both measures are strongly correlated with the other metrics (upper panels of @fig-distance-metrics) but reflect complementary aspects of separability, allowing us to assess whether perceptual accuracy is driven more by global structure, local proximity, or both.

## Data collection process

### Recruite participants

Subjects were recruited from Prolific [@palan2018], an online platform, to evaluate the trials. The study expects that the participants are uninvolved judges with no prior knowledge of the data to avoid inadvertently affecting results. Potential subjects needed with fluent in English and have completed at least $10$ Prolific studies with a $98\%$ approval rate. The Prolific server only considers participants who are age $18$ and older.

All subjects were trained using three example displays to orient them to the evaluation trials and provided [introductory materials](https://drive.google.com/file/d/14o-nSjy50Qw2eoQArK5AhjowLIOe6m14/view). All subjects who completed the task were compensated $9.96$ GBP per hour for their time via the Prolific payment system.

### Web application to collect responses

The survey web application, [Match-a-roo](https://ebsmonash.shinyapps.io/web_game/), is designed to collect survey responses and demographics using the `shiny` [@winston2025a] package in R. Each subject had access to the survey via the [shiny.io server](https://www.shinyapps.io/). The first interface of the survey app contained an introduction, instructions for the survey (@fig-intro-page), a consent form (@fig-consent), and buttons to access, for example, actual trials. Participants can try three examples prior to the study where the answers were not recorded (@fig-example). The subjects were first asked for their consent to the responses being used for analysis.

A total of $1905$ evaluations from $127$ participants has been collected.

After giving consent, the participant can start the trials. Two visual displays of data are shown where the data may be the same or different (@fig-act). One of the visual displays is a $2\text{-}D$ NLDR plot, and the other is a tour made of many $2\text{-}D$ plots. The participants were asked to decide whether that data was the same in both displays and to report their confidence about their choice and any comments about the answer.

When the participants completed the twenty-three evaluations, they were asked for their demographics which included preferred pronoun, the highest level of education achieved, their age category, whether they used principal component analysis in their work, and whether they applied NLDR techniques such as tSNE and UMAP (@fig-demo). Finally, the participants need to click on prolific URL ([https://app.prolific.co/submissions/](https://app.prolific.co/submissions/complete?cc=CLDDOZ10)) to redirect back to the Prolific app (@fig-end). 


::: {.cell layout-align="center"}
::: {.cell-output-display}
![Diagram of online experiment setup.](../figures/vis-exp/experiment.png){#fig-exp-setup fig-align='center' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The introduction page of the study app.](../figures/vis-exp/introduction.png){#fig-intro-page fig-align='center' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The consent form provided in the study app.](../figures/vis-exp/consent.png){#fig-consent fig-align='center' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The example trial page of the study app.](../figures/vis-exp/example.png){#fig-example fig-align='center' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The actual trial page of the study app.](../figures/vis-exp/attempt.png){#fig-act fig-align='center' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The demographics page of the study app.](../figures/vis-exp/demographics.png){#fig-demo fig-align='center' width=100%}
:::
:::



::: {.cell layout-align="center"}
::: {.cell-output-display}
![The end page of the study app.](../figures/vis-exp/end_page.png){#fig-end fig-align='center' width=100%}
:::
:::


Once a participant starts the study (@fig-exp-setup), the "eligibility_subject_IDs" Google Sheet is connected and read in the Shiny app to identify which subject IDs have not yet been assigned to anyone, as indicated by the "used" column. If the "used" column is marked as NA, it means that the subject ID has not been assigned. 

After identifying the eligible subject IDs, one is randomly assigned to the participant, and "1" is recorded in the "used" column corresponding to that subject ID. This subject ID will later assist in connecting the experiment design, high-dimensional data, and embedding data.

Once a subject ID is allocated to a participant, the experiment design data is loaded, and the relevant attempts, data structure, and methods are presented to the participant. This process continues until the participant completes all attempts. After determining the data structure and methods, the relevant high-dimensional and embedding data is loaded from "high_d_data_three_clust_all.rds" and "embedding_data_three_clust_all.rds," respectively, and displayed in both tour and $2\text{-}D$ NLDR plots. 

Once the participant records their answers, a new row is added to the "result_df" Google Sheet with their responses. This continues until the participant finishes the study. Finally, after completing the evaluations, participants are asked to fill out a demographics questionnaire. Their responses are then recorded in a new row of the "demographic_details" Google Sheet.

## Analysis of results relative to data collection process

### Data cleaning

The initial step in the data cleaning process involves the selection of subjects who have completed the requisite twenty-three trials, including the demographics and the attention check trial. Participants who exceeded the average time of $5-10$ minutes were excluded, as determined from the pilot study. Following this, individuals who didn't accurately detect the attention check trial were also removed. Furthermore, the attention check trials were removed, as they did not contribute to the further analyses. Finally, the collected data set is further refined by filtering out all the responses, which showed the same data structures in $2\text{-}D$ NLDR plot and tour.

### Demographics

Along with the responses to the trials, we have collected a series of demographic information including preferred pronoun, age range category, education background, and previous experience in PCA and Non-linear dimension reduction techniques. @tbl-pronoun, @tbl-age, @tbl-education, @tbl-pca, and @tbl-nldr provide summaries of the demographic data.  

The participants are fairly balanced in terms of pronouns, with similar proportions identifying as *she/her* ($50.4\%$) and *he/him* ($48.0\%$), and a small number identifying as *they/them* ($1.6\%$). Participants cover a wide age range, with most between $25$ and $34$ years old ($35.4\%$), followed by those aged $18–24$ ($20.5\%$) and $35–44$ ($19.7\%$). The sample has more younger and mid-adult age groups, while still including representation from older participants.

Most participants have completed an undergraduate degree ($44.9\%$) or a postgraduate qualification ($26.8\%$), with others reporting some undergraduate study ($21.3\%$). Only a small proportion did not complete high school. Prior experience with dimension reduction methods is limited: the majority report no previous experience with PCA ($84.2\%$) or nonlinear dimension reduction techniques ($86.6\%$). This suggests that most participants approached the task without strong prior familiarity, allowing the results to reflect general perceptual interpretation rather than expert knowledge.


::: {.cell layout-align="center"}

:::



::: {#tbl-pronoun .cell layout-align="center" tbl-cap='Summary of the pronoun distribution of participants recruited for this study.'}
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



::: {#tbl-age .cell layout-align="center" tbl-cap='Summary of the age distribution of participants recruited for this study.'}
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



::: {#tbl-education .cell layout-align="center" tbl-cap='Summary of the educational distribution of participants recruited for this study.'}
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



::: {#tbl-pca .cell layout-align="center" tbl-cap='Summary of the previous experience in PCA of participants recruited for this study.'}
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



::: {#tbl-nldr .cell layout-align="center" tbl-cap='Summary of the previous experience in Nonlinear dimension reduction techniques of participants recruited for this study.'}
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



