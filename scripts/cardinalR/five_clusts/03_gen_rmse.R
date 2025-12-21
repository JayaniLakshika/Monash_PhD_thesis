## This script is to generate HBE values with quollr

library(tidyverse)
library(quollr)
library(here)
set.seed(20240412)

quad <- function(a = 3, b = 2 * a2, c = -(a2^2 + a1^2))
{
  a <- as.complex(a)
  answer <- c((-b + sqrt(b^2 - 4 * a * c)) / (2 * a),
              (-b - sqrt(b^2 - 4 * a * c)) / (2 * a))
  if(all(Im(answer) == 0)) answer <- Re(answer)
  if(answer[1] == answer[2]) return(answer[1])
  answer[answer>0] ## only positive
}

# Load data
data <- read_rds(here("data/five_clusts/five_clusts.rds"))
data <- data |>
  select(-cluster) |>
  mutate(ID = 1:NROW(data))

## For PCA

pca_data <- read_rds("data/five_clusts/five_clusts_pca.rds") |>
  select(-cluster) |>
  mutate(ID = row_number())

error_pca <- gen_diffbin1_errors(highd_data = data,
                                  nldr_data = pca_data,
                                  hd_thresh = 0) |>
  dplyr::mutate(side_length = quad(a=3, b = 2 * a2, c = -(a2^2 + a1^2))) |>
  dplyr::mutate(method = "PCA")


## tSNE

tsne_data <- read_rds("data/five_clusts/five_clusts_tsne_perplexity_30.rds") |>
  select(-cluster) |>
  mutate(ID = row_number())

error_tsne <- gen_diffbin1_errors(highd_data = data,
                                 nldr_data = tsne_data,
                                 hd_thresh = 0) |>
  dplyr::mutate(side_length = quad(a=3, b = 2 * a2, c = -(a2^2 + a1^2))) |>
  dplyr::mutate(method = "tSNE")

## UMAP

umap_data <- read_rds("data/five_clusts/five_clusts_umap_n-neigbors_15_min-dist_0.1.rds") |>
  select(-cluster) |>
  mutate(ID = row_number())

error_umap <- gen_diffbin1_errors(highd_data = data,
                                  nldr_data = umap_data,
                                  hd_thresh = 0) |>
  dplyr::mutate(side_length = quad(a=3, b = 2 * a2, c = -(a2^2 + a1^2))) |>
  dplyr::mutate(method = "UMAP")

## PHATE

phate_data <- read_rds("data/five_clusts/five_clusts_phate_knn_5.rds") |>
  select(-cluster) |>
  mutate(ID = row_number())

error_phate <- gen_diffbin1_errors(highd_data = data,
                                  nldr_data = phate_data,
                                  hd_thresh = 0) |>
  dplyr::mutate(side_length = quad(a=3, b = 2 * a2, c = -(a2^2 + a1^2))) |>
  dplyr::mutate(method = "PHATE")

## TriMAP

trimap_data <- read_rds("data/five_clusts/five_clusts_trimap_n-inliers_12_n-outliers_4_n-random_3.rds") |>
  select(-cluster) |>
  mutate(ID = row_number())

error_trimap <- gen_diffbin1_errors(highd_data = data,
                                  nldr_data = trimap_data,
                                  hd_thresh = 0) |>
  dplyr::mutate(side_length = quad(a=3, b = 2 * a2, c = -(a2^2 + a1^2))) |>
  dplyr::mutate(method = "TriMAP")

## PaCMAP

pacmap_data <- read_rds("data/five_clusts/five_clusts_pacmap_n-neighbors_10_init_random_MN-ratio_0.5_FP-ratio_2.rds") |>
  select(-cluster) |>
  mutate(ID = row_number())

error_pacmap <- gen_diffbin1_errors(highd_data = data,
                                  nldr_data = pacmap_data,
                                  hd_thresh = 0) |>
  dplyr::mutate(side_length = quad(a=3, b = 2 * a2, c = -(a2^2 + a1^2))) |>
  dplyr::mutate(method = "PaCMAP")

error_df <- bind_rows(error_pca, error_tsne,
                      error_umap, error_phate,
                      error_trimap, error_pacmap)

write_rds(error_df, "data/five_clusts/five_clusts_hbe.rds")
