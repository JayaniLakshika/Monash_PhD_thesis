## This script describes the analysis steps
### First I need to decide which distance metrics that I need to choose for the analysis.
### Using `fpc` package, computed distance metrics for the different data structures.
### First, what I need to find is the different distance metrics acts different for each data structure
### If they act similar, we don't need to use all types metrics.
### Also, we have to check that is any transformation of metric(s) will interesting to
### identify the patterns.


library(tidyverse)
library(lme4)
library(broom.mixed)
library(patchwork)

library(plotly)

## To join the distance
distance_df <- read_rds("data/three_clust_min_avg_dist_df.rds") |>
  filter(distance_sf != 0.8) |>
  mutate(distance_sf = as.factor(distance_sf)) |>
  mutate(bw_ratio = 1/wb_ratio)

metrics <- c("min_dist", "avg_btw_dist", "bw_ratio", "dunn", "dunn2",
             "pearsongamma", "sindex", "avg_silwidth_dist")

distance_df_scaled <- distance_df |>
  mutate(across(
    all_of(metrics),
    ~ (. - min(.)) / (max(.) - min(.)),
    .names = "{.col}_scaled"
  )) |>
  mutate(exp_min_dist_scaled = exp(min_dist)) |>
  mutate(sqr_avg_btw_dist_scaled = avg_btw_dist_scaled^2) |>
  mutate(sqr_pearsongamma_scaled = pearsongamma_scaled^2) |>
  mutate(sqr_avg_silwidth_dist_scaled = avg_silwidth_dist_scaled^2) |>
  mutate(sqrt_dunn_scaled = sqrt(dunn_scaled)) |>
  mutate(sqrt_dunn2_scaled = sqrt(dunn2_scaled))

metrics_scaled <- c("bw_ratio",
                    "exp_min_dist_scaled",
                    "sqr_avg_btw_dist_scaled",
                    "sqr_pearsongamma_scaled",
                    "sqr_avg_silwidth_dist_scaled",
                    "sqrt_dunn_scaled",
                    "sqrt_dunn2_scaled")

GGally::ggpairs(distance_df_scaled |> select(all_of(metrics_scaled), distance_sf),
                columns = metrics_scaled,
                mapping = aes(color = as.factor(distance_sf)))

## Choosing bw_ratio and exp_min_dist (Ask whether do I need to use scaled value)

### Read the collected data
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

results_df_method_ds |> count(method, result, sort = TRUE) |> filter(result == 1)
## Set TriMAP as base (because highest corrected method: 244/381, others ordered according to the correct proportion)

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

results_df_method_ds <- left_join(results_df_method_ds, distance_df,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))

results_df_method_ds <- results_df_method_ds |>
  mutate(distance_factor = recode(distance_factor,
                                  `0.1` = "small (S)",
                                  `0.6` = "small medium (SM)",
                                  `0.9` = "medium (M)",
                                  `1` = "medium large (ML)",
                                  `1.1` = "large (L)"))
################################################################################

## Fit the model with bw_ratio
glmm_model <- glmer(
  result ~ method*bw_ratio + (1 | subject),
  data = results_df_method_ds,
  family = binomial(),
  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 1e5))
)

fixed_effects_data <- tidy(glmm_model, effects = "fixed") |>
  mutate(estimate = round(estimate, 2),
         std.error = round(std.error, 2),
         statistic = round(statistic, 2),
         p.value = round(p.value, 2)) |>
  mutate(p_val_sig = if_else(p.value <= 0.001, "***",
                             if_else(p.value <= 0.01, "**",
                                     if_else(p.value <= 0.05, "*", if_else(p.value <= 0.1, ".", " "))))) |>
  mutate(prop_error = paste0(round(estimate, 3), " (", round(std.error, 3), ")", p_val_sig)) |>
  dplyr::select(term, estimate, std.error, statistic, p.value, p_val_sig)

fixed_effects_data

## Emmeans with bw_ratio
emm1_1 <- emmeans(glmm_model, specs = ~ method*bw_ratio, type = "response",
                  infer = TRUE, calc = c(n = ".wgt."),
                  at = list(bw_ratio = append(seq(1, 15.6, by = 1.1), 15.6)))
emm_df <- as_tibble(emm1_1)

# Define your color vector with matching names
color_vec <- c(
  "TriMAP" = "#e41a1c",
  "UMAP" = "#377eb8",
  "PaCMAP" = "#4daf4a",
  "tSNE" = "#984ea3",
  "PHATE" = "#ff7f00"
)

# Make sure factor levels match color_vec
emm_df$method <- factor(emm_df$method, levels = names(color_vec))

emm_df <- emm_df |>
  mutate(
    logit_est = log(prob / (1 - prob)),
    logit_LCL = logit_est - qnorm(0.975) * SE,
    logit_UCL = logit_est + qnorm(0.975) * SE,
    prob_LCL_logit = 1 / (1 + exp(-logit_LCL)),
    prob_UCL_logit = 1 / (1 + exp(-logit_UCL))
  )


# Now plot
trend_plt <- ggplot(emm_df, aes(x = bw_ratio, y = prob, color = method)) +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = prob_LCL_logit, ymax = prob_UCL_logit), width = 0.2, alpha = 0.6) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = append(seq(1, 15.6, by = 1.1), 15.6)[c(1, 3, 5, 7, 9, 11, 13, 15)]) +
  scale_y_continuous(limits = c(0, 1)) +
  scale_color_manual(values = color_vec) +
  labs(x = "BW ratio", y = "estimated probability") +
  theme_light() +
  theme(
    aspect.ratio = 1.3,
    legend.position = "bottom",
    strip.text = element_text(size = 12),
    axis.title = element_text(size = 13),
    legend.title = element_blank(),
    plot.margin = margin(0, 0, 0, 0)
  )

observed_prob_df <- results_df_method_ds |>
  mutate(bw_ratio = round(bw_ratio, 2)) |>
  group_by(method, bw_ratio) |> #, type
  summarise(
    n = n(),
    successes = sum(result == 1),
    observed_prob = mean(result),
    .groups = "drop"
  ) |>
  ungroup()

methods <- unique(observed_prob_df$method)

# Step 3: Named list of plots using purrr::map
method_plots <- map(methods, function(m) {
  obs_df <- filter(observed_prob_df, method == m)
  model_df <- filter(emm_df, method == m)

  ggplot(obs_df, aes(x = bw_ratio, y = observed_prob)) +
    geom_point() + #aes(shape = type)
    geom_line(data = model_df, aes(x = bw_ratio, y = prob), linewidth = 1, color = color_vec[[m]]) +
    labs(x = "BW ratio", y = "observed probability") +
    scale_x_continuous(breaks = append(seq(1, 15.6, by = 1.1), 15.6)[c(1, 3, 5, 7, 9, 11, 13, 15)]) +
    scale_y_continuous(limits = c(0, 1)) +
    #scale_shape_manual(values = c(16, 4)) +
    theme_light() +
    theme(
      aspect.ratio = 1.3,
      strip.text = element_text(size = 12),
      axis.title = element_blank(),
      legend.title = element_blank(),
      plot.margin = margin(10, 10, 10, 10)
    )
}) |> set_names(methods)

trend_plt + wrap_plots(method_plots[[3]], method_plots[[2]], method_plots[[1]], method_plots[[5]], method_plots[[4]], ncol = 3) +
  plot_layout(guides = "collect")

################################################################################

## Fit the model with min_dist
glmm_model_min <- glmer(
  result ~ method*min_dist + (1 | subject),
  data = results_df_method_ds,
  family = binomial(),
  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 1e5))
)

fixed_effects_data_min <- tidy(glmm_model_min, effects = "fixed") |>
  mutate(estimate = round(estimate, 2),
         std.error = round(std.error, 2),
         statistic = round(statistic, 2),
         p.value = round(p.value, 2)) |>
  mutate(p_val_sig = if_else(p.value <= 0.001, "***",
                             if_else(p.value <= 0.01, "**",
                                     if_else(p.value <= 0.05, "*", if_else(p.value <= 0.1, ".", " "))))) |>
  mutate(prop_error = paste0(round(estimate, 3), " (", round(std.error, 3), ")", p_val_sig)) |>
  dplyr::select(term, estimate, std.error, statistic, p.value, p_val_sig)

fixed_effects_data_min

## Emmeans with bw_ratio
emm1_2 <- emmeans(glmm_model_min, specs = ~ method*min_dist, type = "response",
                  infer = TRUE, calc = c(n = ".wgt."),
                  at = list(min_dist = seq(0, 2.2, by = 0.2)))
emm_df_min <- as_tibble(emm1_2)

# Make sure factor levels match color_vec
emm_df_min$method <- factor(emm_df_min$method, levels = names(color_vec))

emm_df_min <- emm_df_min |>
  mutate(
    logit_est = log(prob / (1 - prob)),
    logit_LCL = logit_est - qnorm(0.975) * SE,
    logit_UCL = logit_est + qnorm(0.975) * SE,
    prob_LCL_logit = 1 / (1 + exp(-logit_LCL)),
    prob_UCL_logit = 1 / (1 + exp(-logit_UCL))
  )


# Now plot
trend_plt_min <- ggplot(emm_df_min, aes(x = min_dist, y = prob, color = method)) +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = prob_LCL_logit, ymax = prob_UCL_logit), width = 0.2, alpha = 0.6) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = seq(0, 2.2, by = 0.2)[c(1, 3, 5, 7, 9, 12)]) +
  scale_y_continuous(limits = c(0, 1)) +
  scale_color_manual(values = color_vec) +
  labs(x = "Minimum distance", y = "estimated probability") +
  theme_light() +
  theme(
    aspect.ratio = 1.3,
    legend.position = "bottom",
    strip.text = element_text(size = 12),
    axis.title = element_text(size = 13),
    legend.title = element_blank(),
    plot.margin = margin(0, 0, 0, 0)
  )

observed_prob_df_min <- results_df_method_ds |>
  mutate(min_dist = round(min_dist, 2)) |>
  group_by(method, min_dist) |> #, type
  summarise(
    n = n(),
    successes = sum(result == 1),
    observed_prob = mean(result),
    .groups = "drop"
  ) |>
  ungroup()

methods <- unique(observed_prob_df_min$method)

# Step 3: Named list of plots using purrr::map
method_plots_min <- map(methods, function(m) {
  obs_df <- filter(observed_prob_df_min, method == m)
  model_df <- filter(emm_df_min, method == m)

  ggplot(obs_df, aes(x = min_dist, y = observed_prob)) +
    geom_point() + #aes(shape = type)
    geom_line(data = model_df, aes(x = min_dist, y = prob), linewidth = 1, color = color_vec[[m]]) +
    labs(x = "BW ratio", y = "observed probability") +
    scale_x_continuous(breaks = seq(0, 2.2, by = 0.2)[c(1, 3, 5, 7, 9, 12)]) +
    scale_y_continuous(limits = c(0, 1)) +
    #scale_shape_manual(values = c(16, 4)) +
    theme_light() +
    theme(
      aspect.ratio = 1.3,
      strip.text = element_text(size = 12),
      axis.title = element_blank(),
      legend.title = element_blank(),
      plot.margin = margin(10, 10, 10, 10)
    )
}) |> set_names(methods)

trend_plt_min + wrap_plots(method_plots_min[[3]], method_plots_min[[2]], method_plots_min[[1]], method_plots_min[[5]], method_plots_min[[4]], ncol = 3) +
  plot_layout(guides = "collect")

## Compare different distance metrics for each method
(method_plots[[3]] / method_plots_min[[3]])|(method_plots[[2]] / method_plots_min[[2]])|(method_plots[[1]] / method_plots_min[[1]])|(method_plots[[5]] / method_plots_min[[5]])|(method_plots[[4]] / method_plots_min[[4]])
### Looks similar

### Minimum distance

## For each method tried to find which data structure perform worse and because of which component
observed_prob_df_min |> filter(observed_prob == 0)

### TriMAP have only one data structure which has min_dist 2.06 perform worse
distance_df |> mutate(min_dist = round(min_dist, 2)) |> filter(min_dist == 2.06)
#### It's three_clust_07 with distance category 1.1. It has nonlinear_hyperbola2, hemisphere, and pyramid_triangular_base as data structure components.

### UMAP have only one data structure which has min_dist 1.13 perform worse
distance_df |> mutate(min_dist = round(min_dist, 2)) |> filter(min_dist == 1.13)
#### It's three_clust_05 with distance category 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.

### PaCMAP have 6 data structure (10 obs)
pacmap_worse_min_dist <- observed_prob_df_min |> filter(observed_prob == 0) |> filter(method == "PaCMAP") |> pull(min_dist)
distance_df |> mutate(min_dist = round(min_dist, 2)) |> filter(min_dist %in% pacmap_worse_min_dist)
#### It's three_clust_02 with distance category 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_03 with distance category 0.6, and 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_06 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_07 with distance category 0.6, 1, and 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_10 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_17 with distance category 0.6, and 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.

### tSNE have 6 data structure (10 obs)
tsne_worse_min_dist <- observed_prob_df_min |> filter(observed_prob == 0) |> filter(method == "tSNE") |> pull(min_dist)
distance_df |> mutate(min_dist = round(min_dist, 2)) |> filter(min_dist %in% tsne_worse_min_dist)
#### It's three_clust_02 with distance category 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_03 with distance category 0.9 and 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_04 with distance category 0.6. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_05 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_07 with distance category 0.9 nd 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_08 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_09 with distance category 0.9 and 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_10 with distance category 1.1 and 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_12 with distance category 0.9, 1.1 and 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_14 with distance category 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_15 with distance category 1.1 and 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_16 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_17 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_18 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.


### PHATE have 6 data structure (10 obs)
phate_worse_min_dist <- observed_prob_df_min |> filter(observed_prob == 0) |> filter(method == "PHATE") |> pull(min_dist)
distance_df |> mutate(min_dist = round(min_dist, 2)) |> filter(min_dist %in% phate_worse_min_dist)
#### It's three_clust_01 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_03 with distance category 0.9. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_04 with distance category 0.9. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_05 with distance category 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_06 with distance category 0.9. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_07 with distance category 0.9. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_09 with distance category 0.9. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_10 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_11 with distance category 1.1 and 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_14 with distance category 1.1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_16 with distance category 0.6. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.
#### It's three_clust_18 with distance category 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.

--------------------------------------------------------------------------------

### BW ratio
## For each method tried to find which data structure perform worse and because of which component
observed_prob_df |> filter(observed_prob == 0)

### TriMAP have only one data structure which has bw_ratio 2.06 perform worse
distance_df |> mutate(bw_ratio = round(bw_ratio, 2)) |> filter(bw_ratio == 9.49)
#### It's three_clust_07 with distance category 1.1. It has nonlinear_hyperbola2, hemisphere, and pyramid_triangular_base as data structure components.

### UMAP have only one data structure which has bw_ratio 7.2 perform worse
distance_df |> mutate(bw_ratio = round(bw_ratio, 2)) |> filter(bw_ratio == 7.2)
#### It's three_clust_05 with distance category 1. It has nonlinear_hyperbola2, elliptical, and blunted_cone as data structure components.

## PaCMAP have 6 data structure (10 obs)
pacmap_worse_bw_ratio <- observed_prob_df |> filter(observed_prob == 0) |> filter(method == "PaCMAP") |> pull(bw_ratio)
distance_df |> mutate(bw_ratio = round(bw_ratio, 2)) |> filter(bw_ratio %in% pacmap_worse_bw_ratio)

### tSNE have 6 data structure (10 obs)
tsne_worse_bw_ratio <- observed_prob_df |> filter(observed_prob == 0) |> filter(method == "tSNE") |> pull(bw_ratio)
distance_df |> mutate(bw_ratio = round(bw_ratio, 2)) |> filter(bw_ratio %in% tsne_worse_bw_ratio)

### PHATE have 6 data structure (10 obs)
phate_worse_bw_ratio <- observed_prob_df |> filter(observed_prob == 0) |> filter(method == "PHATE") |> pull(bw_ratio)
distance_df |> mutate(bw_ratio = round(bw_ratio, 2)) |> filter(bw_ratio %in% phate_worse_bw_ratio)
