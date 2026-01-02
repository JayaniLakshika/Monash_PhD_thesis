#### This script contains functions to generate different NLDR data

library(dplyr)
library(tibble)
library(readr)
library(Rtsne)
library(uwot)
library(phateR)
library(reticulate)
library(tidyr)
library(purrr)

conflicted::conflict_prefer("select", "dplyr")
conflicted::conflict_prefer("filter", "dplyr")

use_python("~/miniforge3/envs/pcamp_env/bin/python")
use_condaenv("pcamp_env")

set.seed(238200481)

#Standardize the data function
standardize_data <- function(data) {
  data |>
    mutate(across(everything(), ~ (. - mean(.)) / sd(.)))
}

## To read the high-d data
#high_d_data <- read_rds(here::here("data/high_d_data_three_close_clust_all.rds"))
#high_d_data <- read_rds(here::here("data/high_d_data_three_clust_attention_check.rds"))
#high_d_data <- read_rds(here::here("data/high_d_data_three_close_clust_bkg_noise_0.4.rds"))
#high_d_data <- read_rds(here::here("data/high_d_data_four_close_clust_all.rds"))
distance_scale_factor <- 1.1 # 0.1, 0.6, 1, 0.9, 1.1

high_d_data <- read_rds(here::here(paste0("data/high_d_data_three_close_clust_sf", distance_scale_factor,".rds")))
high_d_data <- high_d_data |>
  filter(sample_size == 7500)

## add number of neighbors
n_neighbors <- c("default") #"default", 0.6, 1.7, 2.9, 0.4

high_d_data <- expand_grid(high_d_data, n_neighbors)

## Added high_d_data into a column
tsne_data <- c()

## To generate tSNE with default parameter settings
for (row in 1:NROW(high_d_data)) {

  ## To get specific data set
  data <- high_d_data |>
    filter(row == row_number()) |>
    pull(high_d_data)

  data <- data[[1]] |>
    select(-cluster)

  ## Standardized the data
  data <- data |>
    mutate(across(everything(), ~ (. - mean(.)) / sd(.)))

  ## Neighboring parameter
  perplexity <- high_d_data |>
    filter(row == row_number()) |>
    pull(n_neighbors)

  ## Replace defaults
  if (perplexity[1] == "default") {

    perplexity <- 30

  } else {

    perplexity <- as.integer(as.numeric(perplexity[1]) * 30)
  }

  ## To generate tSNE

  tSNE_fit <- data |>
    dplyr::select(where(is.numeric)) |>
    Rtsne::Rtsne(perplexity = perplexity,
                 pca = FALSE,
                 normalize = FALSE)

  tSNE_data <- tSNE_fit$Y |>
    tibble::as_tibble(.name_repair = "unique")
  names(tSNE_data) <- c("emb1", "emb2")

  ## To get the high_d data
  tsne_data <- append(tsne_data, lst(tSNE_data))

}

tSNE_df <- high_d_data |>
  mutate(embedding_data = tsne_data) |>
  mutate(method = "tsne") |>
  mutate(run_2d = 238200481)

write_rds(tSNE_df, here::here("extra/data/tSNE_df.rds"))

## To generate UMAP with default parameter settings

## Added high_d_data into a column
umap_data <- c()

## To generate tSNE with default parameter settings
for (row in 1:NROW(high_d_data)) {

  ## To get specific data set
  data <- high_d_data |>
    filter(row == row_number()) |>
    pull(high_d_data)

  data <- data[[1]] |>
    select(-cluster)

  ## Standardized the data
  data <- data |>
    mutate(across(everything(), ~ (. - mean(.)) / sd(.)))

  ## Neighboring parameter
  n_neighbors <- high_d_data |>
    filter(row == row_number()) |>
    pull(n_neighbors)

  ## Replace defaults
  if (n_neighbors[1] == "default") {

    n_neighbors <- 15

  } else {

    n_neighbors <- as.integer(as.numeric(n_neighbors[1]) * 15)
  }


  ## To generate UMAP
  min_dist <- 0.1

  UMAP_data <- umap(data,
                    n_neighbors = n_neighbors,
                    min_dist = min_dist,
                    n_components =  2,
                    nn_method = "fnn") |>
    as_tibble()

  names(UMAP_data) <- c("emb1", "emb2")

  ## To get the high_d data
  umap_data <- append(umap_data, lst(UMAP_data))

}

UMAP_df <- high_d_data |>
  mutate(embedding_data = umap_data) |>
  mutate(method = "umap") |>
  mutate(run_2d = 238200481)

write_rds(UMAP_df, here::here("extra/data/UMAP_df.rds"))

## To generate PHATE with default parameter settings

process_phate <- function(data, knn) {
  data <- data |>
    select(-cluster)

  data <- standardize_data(data)

  # Handle the default neighbor parameter
  knn <- ifelse(knn == "default", 5, as.integer(as.numeric(knn) * 5))

  # Generate PHATE embedding
  PHATE_data <- phate(data, knn = knn)
  as_tibble(PHATE_data$embedding) |>
    setNames(c("emb1", "emb2"))
}

# Generate PHATE embeddings for each row
phate_data_list <- high_d_data |>
  mutate(embedding_data = map2(high_d_data, n_neighbors, process_phate),
         method = "phate",
         run_2d = 238200481)

# Save the result
write_rds(phate_data_list, here::here("extra/data/PHATE_df.rds"))

## To generate TriMAP with default parameter settings

## Import the package from python
trimap <- reticulate::import("trimap")

## Added high_d_data into a column
trimap_data <- c()

## To generate tSNE with default parameter settings
for (row in 1:NROW(high_d_data)) {

  ## To get specific data set
  data <- high_d_data |>
    filter(row == row_number()) |>
    pull(high_d_data)

  data <- data[[1]] |>
    select(-cluster)

  # Standardized the data
  data <- data |>
    mutate(across(everything(), ~ (. - mean(.)) / sd(.)))

  data_vector <- unlist(data)
  # Convert the vector into a matrix
  data_matrix <- matrix(data_vector, ncol = NCOL(data))

  ## Neighboring parameter
  n_inliers <- high_d_data |>
    filter(row == row_number()) |>
    pull(n_neighbors)

  ## Replace defaults
  if (n_inliers[1] == "default") {

    n_inliers <- as.integer(12)

  } else {

    n_inliers <- as.integer(as.numeric(n_inliers[1]) * 12)
  }

  n_outliers <- as.integer(4)
  n_random <- as.integer(3)

  # Initialize PaCMAP instance
  reducer <- trimap$TRIMAP(n_dims = as.integer(2),
                           n_inliers = n_inliers,
                           n_outliers = n_outliers,
                           n_random = n_random)

  # Perform dimensionality Reduction
  TriMAP_data <- reducer$fit_transform(data_matrix) |>
    as_tibble()

  names(TriMAP_data) <- c("emb1", "emb2")

  ## To get the high_d data
  trimap_data <- append(trimap_data, lst(TriMAP_data))

}

TriMAP_df <- high_d_data |>
  mutate(embedding_data = trimap_data) |>
  mutate(method = "trimap") |>
  mutate(run_2d = 238200481)

write_rds(TriMAP_df, here::here("extra/data/TriMAP_df.rds"))

## To generate PaCMAP with default parameter settings

## Import the package from python
pacmap <- reticulate::import("pacmap")

## Added high_d_data into a column
pacmap_data <- c()

## To generate tSNE with default parameter settings
for (row in 1:NROW(high_d_data)) {

  ## To get specific data set
  data <- high_d_data |>
    filter(row == row_number()) |>
    pull(high_d_data)

  data <- data[[1]] |>
    select(-cluster)

  ## Standardized the data
  data <- data |>
    mutate(across(everything(), ~ (. - mean(.)) / sd(.)))

  ## To generate PaCMAP
  data_vector <- unlist(data)
  # Convert the vector into a matrix
  data_matrix <- matrix(data_vector, ncol = NCOL(data))

  ## Neighboring parameter
  n_neighbors <- high_d_data |>
    filter(row == row_number()) |>
    pull(n_neighbors)

  ## Replace defaults
  if (n_neighbors[1] == "default") {

    n_neighbors <- as.integer(10)

  } else {

    n_neighbors <- as.integer(as.numeric(n_neighbors[1]) * 10)
  }

  MN_ratio <- 0.5
  FP_ratio <- as.integer(2)
  init <- "random"

  # Initialize PaCMAP instance
  reducer <- pacmap$PaCMAP(n_components = as.integer(2),
                           n_neighbors = n_neighbors,
                           MN_ratio = MN_ratio,
                           FP_ratio = FP_ratio)


  # Perform dimensionality Reduction
  PacMAP_data <- reducer$fit_transform(data_matrix, init = init) |>
    as_tibble()

  names(PacMAP_data) <- c("emb1", "emb2")

  ## To get the high_d data
  pacmap_data <- append(pacmap_data, lst(PacMAP_data))

}


PaCMAP_df <- high_d_data |>
  mutate(embedding_data = pacmap_data) |>
  mutate(method = "pacmap") |>
  mutate(run_2d = 238200481)

write_rds(PaCMAP_df, here::here("extra/data/PaCMAP_df.rds"))

###PCA
calculate_pca <- function(feature_dataset){
  pcaY_cal <- prcomp(feature_dataset, center = TRUE, scale = FALSE)
  PCAresults <- data.frame(pcaY_cal$x[, 1:2])
  summary_pca <- summary(pcaY_cal)
  var_explained_df <- data.frame(PC= paste0("PC",1:2),
                                 var_explained=(pcaY_cal$sdev[1:2])^2/sum((pcaY_cal$sdev[1:2])^2))
  return(list(prcomp_out = pcaY_cal,pca_components = PCAresults, summary = summary_pca, var_explained_pca  = var_explained_df))
}

process_pca <- function(data) {
  data <- data |>
    select(-cluster)

  #data <- standardize_data(data)

  pca_ref_calc <- calculate_pca(data)
  data_pca <- pca_ref_calc$pca_components |>
    setNames(c("emb1", "emb2"))

}

high_d_data <- high_d_data |>
  select(-n_neighbors)

# Generate PHATE embeddings for each row
PCA_df <- high_d_data |>
  mutate(embedding_data = map(high_d_data, process_pca),
         method = "pca",
         run_2d = 238200481,
         n_neighbors = NA)

# Save the result
write_rds(PCA_df, here::here("extra/data/PCA_df.rds"))

PCA_df <- read_rds(here::here("extra/data/PCA_df.rds"))
tSNE_df <- read_rds(here::here("extra/data/tSNE_df.rds"))
UMAP_df <- read_rds(here::here("extra/data/UMAP_df.rds"))
PHATE_df <- read_rds(here::here("extra/data/PHATE_df.rds"))
TriMAP_df <- read_rds(here::here("extra/data/TriMAP_df.rds"))
PaCMAP_df <- read_rds(here::here("extra/data/PaCMAP_df.rds"))

embedding_df <- bind_rows(tSNE_df, UMAP_df, PHATE_df, TriMAP_df, PaCMAP_df, PCA_df) |>
  dplyr::select(dataset, num_clust, scale_factor, sample_size, num_noise,
                bkg_noise, method, n_neighbors, embedding_data, run_2d)

#write_rds(embedding_df, here::here("data/embedding_data_four_clust_all.rds"))
#write_rds(embedding_df, here::here("data/embedding_data_three_close_clust_bkg_noise_0.4.rds"))
#write_rds(embedding_df, here::here("data/embedding_data_three_close_clust_sf1.rds"))
#write_rds(embedding_df, here::here("data/embedding_data_three_clust_default.rds"))
#write_rds(embedding_df, here::here("data/embedding_data_att_three_clust_default.rds"))
#write_rds(embedding_df, here::here("data/embedding_data_three_close_clust_sf1_diff_n_neighbor.rds"))
write_rds(embedding_df, here::here(paste0("data/embedding_data_three_close_clust_sf", distance_scale_factor, "_scaled.rds")))
