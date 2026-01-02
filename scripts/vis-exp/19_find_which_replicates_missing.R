## This script is to find out what data need to collect to fill the 3 replicates
library(tidyverse)

## Collect data
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

#Set PCA as base
results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("trimap", "umap", "pacmap", "tsne", "phate")))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

## To find combinations that don't have at least 3 responses

missing_combinations <- results_df_method_ds |>
  count(structure_2d, method, distance_factor, sort = TRUE) |>
  filter(n < 3)

## Experiment designs

experiment_design_ds <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor.rds")) |>
  filter(method != "pca") |>
  filter(subject %in% paste0("subject", sprintf("%02d", 1:20)))

experiment_design_ds_missing1 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings.rds")) |>
  filter(method != "pca")

experiment_design_ds_missing2 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch02.rds")) |>
  filter(method != "pca")

experiment_design_ds_missing3 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch03.rds")) |>
  filter(method != "pca")

experiment_design_ds_missing4 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch04.rds")) |>
  filter(method != "pca")

experiment_design_ds_missing5 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch05.rds")) |>
  filter(method != "pca")

experiment_design_ds_missing6 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch06.rds")) |>
  filter(method != "pca")

experiment_design_ds <- bind_rows(experiment_design_ds,
                                  experiment_design_ds_missing1,
                                  experiment_design_ds_missing2,
                                  experiment_design_ds_missing3,
                                  experiment_design_ds_missing4,
                                  experiment_design_ds_missing5 |>
                                    mutate(distance_factor = as.numeric(as.character(distance_factor))),
                                  experiment_design_ds_missing6 |>
                                    mutate(distance_factor = as.numeric(as.character(distance_factor)))) |>
  mutate(distance_factor = as.factor(distance_factor)) |>
  mutate(method = as.factor(method))

## Subject need to cover the missing combinations
subj_missing <- left_join(missing_combinations, experiment_design_ds,
          by = c("structure_2d", "method", "distance_factor")) |>
  select(subject, "structure_2d", "method", "distance_factor") |>
  count(subject) |>
  filter(!(subject %in% results_df_method_ds$subject)) |>
  pull(subject)

subj_missing_experiment <- experiment_design_ds |>
  filter(subject %in% subj_missing) |>
  arrange(subject, attempt) |>
  mutate(subject = rep(paste0("subject", sprintf("%02d", 143:(142 + length(subj_missing)))), each = 20))

write_rds(subj_missing_experiment, here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch06.rds"))
#write_rds(subj_missing_experiment, here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch05.rds"))
