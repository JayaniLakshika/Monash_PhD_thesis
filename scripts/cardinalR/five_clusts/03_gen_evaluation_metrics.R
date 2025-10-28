library(tidyverse)
# Load the reticulate library
library(reticulate)
library(here)
library(FNN)
set.seed(20240412)

# Configure Python
use_python("~/miniforge3/envs/pcamp_env/bin/python")
use_condaenv("pcamp_env")

# Run the Python evaluation script
py_run_file("~/Desktop/PhD Monash research files/Research papers/paper-nldr-vis-algorithm/scripts/evaluation.py")

## R_NX

R_NX <- function(highd, lowd, max_k = 50) {
  n <- nrow(highd)
  Ks <- 1:max_k
  R_values <- numeric(length(Ks))

  # Get high-D and low-D neighbor indices
  nn_high <- get.knn(highd, k = max_k)$nn.index
  nn_low  <- get.knn(lowd, k = max_k)$nn.index

  for (k in Ks) {
    overlaps <- sapply(1:n, function(i) {
      length(intersect(nn_high[i, 1:k], nn_low[i, 1:k]))
    })

    Q_NX <- mean(overlaps / k)
    R_values[k] <- ((n - 1) * Q_NX - k) / (n - 1 - k)
  }

  tibble::tibble(K = Ks, R_NX = R_values)
}

R_NX_AUC <- function(res) {
  Ks <- res$K
  R <- res$R_NX
  sum(R / Ks) / sum(1 / Ks)
}

## Shepard Diagram
## There is a R package: flipDimensionReduction and function GoodnessOfFitPlot()

Shepard_diagram <- function(X, Y, sample_pairs = 5000) {
  n <- nrow(X)

  # Compute all pairwise distances
  dX <- as.vector(dist(X))
  dY <- as.vector(dist(Y))

  # To avoid plotting all ~n^2 points, subsample
  if (length(dX) > sample_pairs) {
    idx <- sample(seq_along(dX), sample_pairs)
    dX <- dX[idx]
    dY <- dY[idx]
  }

  tibble(dX = dX, dY = dY)
}

# Load data
data <- read_rds(here("data/five_clusts/five_clusts.rds"))
data_features <- data |> select(-cluster)

# Define list of DR methods and file paths
dr_methods <- c(
  tSNE   = "data/five_clusts/five_clusts_tsne_perplexity_30.rds",
  UMAP   = "data/five_clusts/five_clusts_umap_n-neigbors_15_min-dist_0.1.rds",
  PHATE  = "data/five_clusts/five_clusts_phate_knn_5.rds",
  TriMAP = "data/five_clusts/five_clusts_trimap_n-inliers_12_n-outliers_4_n-random_3.rds",
  PaCMAP = "data/five_clusts/five_clusts_pacmap_n-neighbors_10_init_random_MN-ratio_0.5_FP-ratio_2.rds",
  PCA    = "data/five_clusts/five_clusts_pca.rds"
)

# Loop over methods and combine results
all_results <- map2_dfr(names(dr_methods), dr_methods, ~{
  dr_data <- read_rds(.y) |> select(-cluster)
  py$evaluate_output(
    X       = as.matrix(data_features),
    X_new   = as.matrix(dr_data),
    y       = data$cluster,
    name    = .x,
    baseline = FALSE,
    labelled = TRUE
  )
})

# Create an instance of the Python class
my_instance <- py$MyClass()

all_results_gl <- map2_dfr(names(dr_methods), dr_methods, ~{
  dr_data <- read_rds(.y) |> select(-cluster)
  # R_NX AUC
  RNX_df <- R_NX(as.matrix(data_features), as.matrix(dr_data), max_k = 100) #(NROW(data_features) - 2)
  RNX_AUC <- R_NX_AUC(RNX_df)

  # Shepard correlation (Spearman)
  shepard_df <- Shepard_diagram(as.matrix(data_features), as.matrix(dr_data))
  shepard_corr <- cor(shepard_df$dX, shepard_df$dY, method = "spearman")

  list(
    name = .x,
    global_score = my_instance$global_score(
    as.matrix(data_features),
    as.matrix(dr_data)
  ),
  RNX_AUC = RNX_AUC,
  shepard_corr = shepard_corr
  )
})

# View results
all_results <- all_results |>
  select(-knn) |>
  distinct()

all_results <- dplyr::inner_join(all_results, all_results_gl, by = "name")

write_rds(all_results, "data/five_clusts/dr_summary.rds")
