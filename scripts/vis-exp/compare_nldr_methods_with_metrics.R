library(dplyr)
library(tidyr)

## To read the results
results_df_method_ds <- read_rds(here::here("data/result_method_ds_factor.rds"))

results_df_method_ds <- results_df_method_ds |>
  filter(method != "pca") |>
  mutate(type = "old")

results_df_method_ds_missings <- read_rds(here::here("data/result_method_ds_factor_missings.rds")) |>
  mutate(type = "new")

results_df_method_ds <- bind_rows(
  results_df_method_ds, results_df_method_ds_missings)

## To reformat the response variable
results_df_method_ds <- results_df_method_ds |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_ds <- results_df_method_ds |>
  mutate(distance_factor = as.factor(distance_factor))

#Set TriMAP as base
results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("trimap", "umap", "pacmap", "tsne", "phate"))) |>
  mutate(method = recode(method,
                         tsne = "tSNE",
                         umap = "UMAP",
                         phate = "PHATE",
                         trimap = "TriMAP",
                         pacmap = "PaCMAP"))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

## To join the distance
distance_df <- read_rds("data/three_clust_min_avg_dist_df.rds") |>
  filter(distance_sf != 0.8) |>
  mutate(distance_sf = as.factor(distance_sf))

results_df_method_ds <- left_join(results_df_method_ds, distance_df,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))

results_df_method_ds <- results_df_method_ds |>
  mutate(bw_ratio = 1/wb_ratio) |>
  mutate(distance_factor = recode(distance_factor,
                                  `0.1` = "small (S)",
                                  `0.6` = "small medium (SM)",
                                  `0.9` = "medium (M)",
                                  `1` = "medium large (ML)",
                                  `1.1` = "large (L)"))




