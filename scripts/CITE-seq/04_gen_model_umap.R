## This script is to generate model for CITE-seq data...
library(quollr)
library(tidyverse)

pbmc_data <- read_rds(here::here("data/CITE-seq/cite_seq_pbmc.rds"))

umap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_umap_n-neigbors_30_min-dist_0.3.rds"))

model_obj <- fit_highd_model(
  highd_data = pbmc_data,
  nldr_data = umap_pbmc,
  b1 = 40,
  q = 0.1,
  hd_thresh = 0)

pbmc_umap_scaled <- model_obj$nldr_scaled_obj$scaled_nldr
hex_grid_pbmc <- model_obj$hb_obj$hex_poly
counts_df_pbmc <- model_obj$hb_obj$std_cts
tr_from_to_df_pbmc <- model_obj$trimesh_data
df_bin_centroids_pbmc <- model_obj$model_2d
df_bin_pbmc <- model_obj$model_highd

hex_grid_with_counts_pbmc <- left_join(
  hex_grid_pbmc, counts_df_pbmc,
  by = c("h" = "h"))

write_rds(pbmc_umap_scaled, here::here("data/CITE-seq/pbmc_umap_scaled.rds"))
write_rds(hex_grid_pbmc, here::here("data/CITE-seq/hex_grid_pbmc.rds"))
write_rds(counts_df_pbmc, here::here("data/CITE-seq/counts_df_pbmc.rds"))
write_rds(tr_from_to_df_pbmc, here::here("data/CITE-seq/tr_from_to_df_pbmc.rds"))
write_rds(df_bin_centroids_pbmc, here::here("data/CITE-seq/df_bin_centroids_pbmc.rds"))
write_rds(df_bin_pbmc, here::here("data/CITE-seq/df_bin_pbmc.rds"))
write_rds(hex_grid_with_counts_pbmc, here::here("data/CITE-seq/hex_grid_with_counts_pbmc.rds"))





