# Perception and Misperception of Clustering in Nonlinear Dimension Reduction: A User Study {#sec-second-paper}

Non-linear dimension reduction (NLDR) methods such as tSNE, UMAP, PHATE, TriMAP, and PaCMAP generate low-dimensional representations of high-dimensional data. However, identifying meaningful low-dimensional representations can be challenging due to factors such as closely spaced clusters. In this study, we use data simulated with the `cardinalR` package containing three clusters of different shapes to assess how well NLDR methods preserve inter-cluster structure. We focus on a specific metric; Between-to-within (BW) ratio as an indicator of global separation. The results reveal that UMAP and tSNE most effectively maintain meaningful global structure by preserving larger inter-cluster distances. PHATE, in contrast, emphasizes local connectivity, sometimes at the expense of global separation. PaCMAP and TriMAP appear less responsive to inter-cluster distance in this context.




::: {.cell layout-align="center"}

:::



::: {.cell layout-align="center"}

:::



