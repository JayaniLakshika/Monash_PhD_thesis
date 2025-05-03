# Conclusion and future plans {#sec-conclusion}

The five pieces of work assembled in this thesis share a common theme of advancing Non-linear dimension reduction (NLDR) diagnostics, with a focus on improving the NLDR methods, visual inference, and developing innovative solutions to automate diagnostic processes.

## Contributions

The primary contributions of this research are fivefold. Firstly, we develop an algorithm. Secondly, we develop a package. Next, package for high-dimensional data structures. Then, a user study to explore perception and misperception in NLDR representations. Lastly, we share a user-focused R package and Shiny app, making the automated diagnostic tools accessible to a broad range of analysts and practitioners.

The aforementioned R package (and its dependency) is available on CRAN with the latest development versions in the links below:

- `quollr` (<https://github.com/jayanilakshika/quollr>), and
- `cardinalR` (<https://github.com/jayanilakshika/cardinalR>).

The Shiny app for `quollr` is available at one of the mirror sites listed at <https://vimror.netlify.app/> with the source code available at <https://github.com/jayanilakshika/ViMRoR>.

Principles of transparency and reproducible research have guided the work with all materials related to the thesis at <https://github.com/JayaniLakshika/Monash_PhD_thesis>. The thesis is written using Quarto [@Allaire_Quarto_2024] and is available online at <https://jayani-lakshika-phd-thesis.netlify.app>. The R packages used throughout the thesis include `tidyverse` [@tidyverse], `lmtest` [@lmtest], `kableExtra` [@kableextra], `patchwork` [@patchwork], `glue` [@glue], `ggpcp` [@ggpcp], `here` [@here], and `knitr` [@knitr].

## Future work

There are several directions that this work can be developed.

- Prediction with model built
- More diagnostics for NLDR (diadem app)
- Visualizations to validate experiment design/results
- Investigate perception and misperception happening with background noise, number of clusters, noise dimensions, sample size, seed.


