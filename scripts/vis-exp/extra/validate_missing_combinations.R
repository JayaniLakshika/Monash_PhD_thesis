## To find missing combinations
library(tidyverse)

results_df_method_ds <- read_rds(here::here("data/result_method_ds_factor.rds"))

## To reformat the response variable
results_df_method_ds <- results_df_method_ds |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_ds <- results_df_method_ds |>
  mutate(distance_factor = as.factor(distance_factor))

#Set PCA as base
results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("pca", "tsne", "umap", "phate", "trimap", "pacmap")))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

results_df_method_ds |>
  select(subject, distance_factor, method) |>
  filter(distance_factor != 0.6) |>
  filter(method != "pca") |>
  count(subject, distance_factor, method)

comb_dt <- results_df_method_ds |>
  select(distance_factor, method, structure_2d) |>
  filter(distance_factor != 0.6) |>
  filter(method != "pca") |>
  count(structure_2d, distance_factor, method)

## Find the missing combinations
structure_2d <- paste0("three_clust_", sprintf("%02d", 1:18))
distance_factor <- c(0.1, 1)
method <- c("tsne", "umap", "phate", "trimap", "pacmap")

all_comb <- expand_grid(structure_2d, distance_factor, method)
all_comb <- all_comb |>
  mutate(distance_factor = as.factor(distance_factor))

all_comb <- full_join(all_comb, comb_dt,
          by = c("structure_2d", "distance_factor", "method"))

all_comb |>
  count(method, distance_factor)

## Check with experiment design
experiment_design <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor.rds"))
experiment_design <- experiment_design |>
  filter(subject %in% unique(results_df_method_ds$subject)) |>
  filter(distance_factor != 0.6) |>
  filter(method != "pca") |>
  select(subject, distance_factor, method, structure_2d)

experiment_design |>
  count(subject, distance_factor, method)

experiment_design |>
  count(structure_2d, distance_factor, method)
