library(tidyverse)
library(lme4)
library(ggbeeswarm)
library(broom.mixed)

results_df_method_ds <- read_rds(here::here("data/result_method_ds_factor.rds"))

results_df_method_ds <- results_df_method_ds |>
  filter(method != "pca")

results_df_method_ds_missings <- read_rds(here::here("data/result_method_ds_factor_missings.rds"))

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
                         levels = c("tsne", "umap", "phate", "trimap", "pacmap")))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

## To join the distance
knn_prop_clust_df <- read_rds("data/three_clust_knn_prop_df.rds") |>
  mutate(distance_sf = as.factor(distance_sf))

results_df_method_ds <- left_join(results_df_method_ds, knn_prop_clust_df,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))

## To join the distance
min_max_dist <- read_rds("data/three_clust_min_max_dist_df.rds")

min_max_dist <- min_max_dist |>
  mutate(distance_sf = as.factor(distance_sf)) |>
  mutate(min_dist = pmin(min_dist12, min_dist13, min_dist23)) |>
  mutate(avg_dist = rowMeans(across(c(min_dist12, min_dist13, min_dist23)))) |>
  mutate(max_dist = pmin(max_dist12, max_dist13, max_dist23))

results_df_method_ds <- left_join(results_df_method_ds, min_max_dist,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))


# Split data by method
results_by_method <- results_df_method_ds |>
  group_split(method) |>
  set_names(results_df_method_ds |> pull(method) |> unique())

# Fit a model for each method
glmm_models <- map(results_by_method, ~ glmer(
  result ~ cross_cluster_prop + (1 | subject),
  data = .x,
  family = binomial(),
  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 1e5))
))

# Fixed effects only
fixed_effects_data <- imap_dfr(glmm_models,
                               ~ tidy(.x, effects = "fixed") |> mutate(method = .y)) |>
  mutate(p_val_sig = if_else(p.value <= 0.001, "***",
                             if_else(p.value <= 0.01, "**",
                                     if_else(p.value <= 0.05, "*", if_else(p.value <= 0.1, ".", " "))))) |>
  mutate(prop_error = paste0(round(estimate, 3), " (", round(std.error, 3), ")", p_val_sig)) |>
  dplyr::select(method, term, estimate, std.error, statistic, p.value, p_val_sig)

fixed_effects_data

ggplot(data = results_df_method_ds,
       aes(y = cross_cluster_prop,
           x = as.factor(result),
           colour = distance_factor)) +
  geom_quasirandom(alpha = 0.5) +
  stat_summary(colour = "red") +
  facet_wrap(~method) +
  xlab("result") +
  ylab("cluster prop") +
  theme_minimal()
