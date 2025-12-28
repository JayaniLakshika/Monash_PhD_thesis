# This code is to summarise the results of the experiment

# Load libraries
library(quollr)
library(tibble)
library(dplyr)
library(purrr)
library(lme4)
library(broom.mixed)

library(ggplot2)
library(ggbeeswarm)
library(readr)
library(tidyr)
library(emmeans)
library(simr)

library(patchwork)
library(png)
library(colorspace)
library(kableExtra)
library(ggResidpanel)
library(ggpcp)
library(stringr)

library(boot)

library(conflicted)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)

library(plotly)
library(forcats)

# Code as per chunk "read-collected-data-method-ds"
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

results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("tsne", "umap", "phate", "trimap", "pacmap")))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

# Subjects (user_id is not unique)
results_df_method_ds |>
  count(subject) |> nrow()

# results_df_method_ds |>
#   group_by(prolific_id) |>
#   summarise(p = sum(result)/n()) |>
#   ggplot(aes(x=p, y=1)) +
#     geom_quasirandom(alpha=0.5)
#
# results_df_method_ds |>
#   group_by(prolific_id) |>
#   summarise(m = mean(time_taken_in_minutes)) |>
#   ggplot(aes(x=m, y=1)) +
#     geom_quasirandom(alpha=0.5)

# Datasets(structure and distance)
results_df_method_ds |>
  count(structure_high_d) |> nrow() # ~47 for each

results_df_method_ds |>
  count(structure_high_d, distance_factor) |> nrow() # ~16 for each

results_df_method_ds |>
  group_by(structure_high_d) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=1, label=structure_high_d)) +
    geom_quasirandom(alpha=0.5)
ggplotly()

results_df_method_ds |>
  group_by(structure_high_d, distance_factor) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=1, label=structure_high_d)) +
    geom_quasirandom(alpha=0.5) +
    facet_wrap(~distance_factor, ncol=3)

results_df_method_ds |>
  group_by(structure_high_d, distance_factor) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=distance_factor, colour=distance_factor)) +
    geom_point() +
    facet_wrap(~structure_high_d, ncol=3)

results_df_method_ds |>
  group_by(structure_high_d, distance_factor) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(structure_high_d, p, median), colour=distance_factor)) +
    geom_point() +
    ylab("")
  # Distance might not be comparable across data sets

# Methods

results_df_method_ds |>
  count(structure_high_d, method) # ~9 for each

results_df_method_ds |>
  group_by(structure_high_d, method) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=1, label=structure_high_d)) +
  geom_quasirandom(alpha=0.5) +
  facet_wrap(~method, ncol=3)

results_df_method_ds |>
  group_by(structure_high_d, method) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=method, colour=method)) +
  geom_point() +
  facet_wrap(~structure_high_d, ncol=3)

results_df_method_ds |>
  group_by(structure_high_d, method) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(structure_high_d, p, median), colour=method)) +
  geom_point() +
  ylab("")

# Need to do similar analysis for time next

results_df_method_ds |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result) |>
  summarise(avg_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=avg_time, y=1, label=structure_high_d)) +
  geom_quasirandom(alpha=0.5) +
  facet_wrap(~result)
ggplotly()

results_df_method_ds |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, distance_factor) |>
  summarise(avg_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=avg_time, y=1, label=structure_high_d)) +
  geom_quasirandom(alpha=0.5) +
  facet_grid(result~distance_factor)

results_df_method_ds |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, distance_factor) |>
  summarise(avg_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=avg_time, y=distance_factor, colour=distance_factor)) +
  geom_point() +
  facet_grid(result~structure_high_d)

results_df_method_ds |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, distance_factor) |>
  summarise(avg_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=avg_time, y=fct_reorder(structure_high_d, avg_time, median), colour=distance_factor)) +
  geom_point() +
  facet_wrap(~result) +
  ylab("") # Most of the participants took less time to correctly identify data structures with large distances

# Subject and method
results_df_method_ds |>
  ungroup() |>
  group_by(method, subject) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(subject, p, max), colour=method)) +
    geom_jitter(width=0.1, height=0) +
    ylab("")

# Fixed effects
results_df_method_ds |>
  ungroup() |>
  group_by(method, distance_factor) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=as.numeric(as.character(distance_factor)), y=p, colour=method)) +
    geom_line() +
    xlab("distance")
  # Should add bootstrap samples to provide some confidence bounds

# Define the bootstrap function
boot_func <- function(data, indices) {
  mean(data[indices])  # Bootstraps the mean
}

# Compute bootstrap confidence intervals
bootstrap_results <- results_df_method_ds |>
  ungroup() |>
  group_by(method, distance_factor) |>
  summarise(
    boot = list(boot(pull(cur_data(), result), statistic = boot_func, R = 1000)),  # Use pull() to extract a vector
    .groups = "drop"
  ) |>
  mutate(
    p = map_dbl(boot, ~ mean(.x$t)),  # Extract mean estimate
    lower = map_dbl(boot, ~ quantile(.x$t, 0.025)),  # Lower 95% CI
    upper = map_dbl(boot, ~ quantile(.x$t, 0.975))   # Upper 95% CI
  )

# Plot with confidence bounds
ggplot(bootstrap_results, aes(x = as.numeric(as.character(distance_factor)), y = p, colour = method)) +
  geom_line() +
  geom_ribbon(aes(ymin = lower, ymax = upper, fill = method), alpha = 0.2, color = NA) +  # Confidence interval
  xlab("Distance") +
  ylab("Estimated Probability") +
  theme_minimal()

## What is learned?
### With correct proportion

#### According to the current data collection, the data structures behave differently (distance and method wise).
#### Therefore, we can't make decision with all the data structure at once.

####################----------------------------------------####################
#### Let's try to group the data structures (data + distance factor) that have similar behavior of correct proportions.

results_df_method_ds_temp <- results_df_method_ds |>
  mutate(group = if_else(structure_high_d %in% paste0("three_clust_", sprintf("%02d", c(1, 4, 15))), "group1",
                         if_else(structure_high_d %in% paste0("three_clust_", sprintf("%02d", c(3, 6, 9, 10, 12, 13))), "group2",
                                 if_else(structure_high_d %in% paste0("three_clust_", sprintf("%02d", c(7, 18))), "group3",
                                         if_else(structure_high_d %in% paste0("three_clust_", sprintf("%02d", c(2, 5, 8, 14))), "group3",
                                                 if_else(structure_high_d %in% paste0("three_clust_", sprintf("%02d", c(17))), "group1", "group2"))))))

results_df_method_ds_temp |>
  group_by(structure_high_d, group, distance_factor) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(structure_high_d, p, median), colour=distance_factor)) +
  geom_point() +
  facet_wrap(~group) +
  ylab("")
# We have 3 groups (Data structures have highest correct proportion for distances)

results_df_method_ds_temp |>
  filter(group == "group1") |>
  group_by(structure_high_d, method) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(structure_high_d, p, median), colour=method)) +
  geom_point(alpha = 0.5) +
  ylab("") # TriMAP is good to identify large distances

results_df_method_ds_temp |>
  filter(group == "group2") |>
  group_by(structure_high_d, method) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(structure_high_d, p, median), colour=method)) +
  geom_point(alpha = 0.5) +
  ylab("") # PaCMAP, TriMAP, tSNE, UMAP, PHATE are good to identify median distances

results_df_method_ds_temp |>
  filter(group == "group3") |>
  group_by(structure_high_d, method) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(structure_high_d, p, median), colour=method)) +
  geom_point(alpha = 0.5) +
  ylab("") # PaCMAP, TriMAP, UMAP are good to identify small distances


#### Let's investigate the same groups with time as well
## Distance + time

results_df_method_ds_temp |>
  filter(group == "group1")  |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, distance_factor) |>
  summarise(total_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=total_time, y=fct_reorder(structure_high_d, total_time, mean), colour=distance_factor)) +
  geom_point() +
  facet_wrap(~result) +
  ylab("")

results_df_method_ds_temp |>
  filter(group == "group2")  |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, distance_factor) |>
  summarise(total_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=total_time, y=fct_reorder(structure_high_d, total_time, mean), colour=distance_factor)) +
  geom_point() +
  facet_wrap(~result) +
  ylab("")

results_df_method_ds_temp |>
  filter(group == "group3")  |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, distance_factor) |>
  summarise(total_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=total_time, y=fct_reorder(structure_high_d, total_time, mean), colour=distance_factor)) +
  geom_point() +
  facet_wrap(~result) +
  ylab("")

## Method + time

results_df_method_ds_temp |>
  filter(group == "group1")  |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, method) |>
  summarise(total_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=total_time, y=fct_reorder(structure_high_d, total_time, mean), colour=method)) +
  geom_point() +
  facet_wrap(~result) +
  ylab("")

results_df_method_ds_temp |>
  filter(group == "group2")  |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, method) |>
  summarise(total_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=total_time, y=fct_reorder(structure_high_d, total_time, mean), colour=method)) +
  geom_point() +
  facet_wrap(~result) +
  ylab("")

results_df_method_ds_temp |>
  filter(group == "group3")  |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, method) |>
  summarise(total_time = mean(time_taken_in_minutes)) |>
  ggplot(aes(x=total_time, y=fct_reorder(structure_high_d, total_time, mean), colour=method)) +
  geom_point() +
  facet_wrap(~result) +
  ylab("")


####################

results_df_method_ds |>
  count(structure_high_d, distance_factor, method) #~At least 3

results_df_method_ds |>
  group_by(structure_high_d, distance_factor, method) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=p, y=fct_reorder(structure_high_d, p, median), colour=method)) +
  geom_point() +
  facet_wrap(~distance_factor) +
  ylab("")

results_df_method_ds |>
  mutate(result = if_else(result == 1, "correct", "wrong")) |>
  group_by(structure_high_d, result, distance_factor, method) |>
  summarise(avg_time = mean(time_taken_in_minutes)) |>
  filter(avg_time < 3) |>
  ggplot(aes(x=avg_time, y=fct_reorder(structure_high_d, avg_time, mean), colour=method)) +
  geom_point() +
  facet_grid(result~distance_factor) +
  ylab("") +
  theme_bw()

####################################
#To combine the min and max distances
min_max_dist <- read_rds("data/three_clust_min_max_dist_df.rds")

min_max_dist <- min_max_dist |>
  mutate(distance_sf = as.factor(distance_sf)) |>
  mutate(min_dist = pmin(min_dist12, min_dist13, min_dist23)) |>
  mutate(max_dist = pmin(max_dist12, max_dist13, max_dist23))

results_df_method_ds <- left_join(results_df_method_ds, min_max_dist,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))

results_df_method_ds |>
  ungroup() |>
  group_by(method, structure_high_d, min_dist) |>
  summarise(p = sum(result) / n(), .groups = "drop") |>
  group_by(structure_high_d) |>
  mutate(scaled_p = (p - min(p)) / (max(p) - min(p))) |>
  ungroup() |>
  ggplot(aes(x=min_dist, y=scaled_p, colour=structure_high_d)) +
  geom_line(alpha = 0.5) +
  facet_wrap(~method) +
  xlab("distance")

## To have more look, let's investigate each separately
results_df_method_ds |>
  ungroup() |>
  group_by(method, structure_high_d, min_dist) |>
  summarise(p = sum(result) / n(), .groups = "drop") |>
  group_by(structure_high_d) |>
  mutate(scaled_p = (p - min(p)) / (max(p) - min(p))) |>
  ungroup() |>
  filter(method == "pacmap") |>
  ggplot(aes(x=min_dist, y=scaled_p, colour=structure_high_d)) +
  geom_line(alpha = 0.5) +
  facet_wrap(~structure_high_d) +
  xlab("distance")



# model_main_results_ds <- glmer(result ~ method * min_dist + (1 | subject), data = results_df_method_ds,
#                                family = "binomial",
#                                control = glmerControl(optimizer = "bobyqa",
#                                                       optCtrl = list(maxfun = 1e5)))
#
# summary(model_main_results_ds)

results_df_method_ds |>
  ungroup() |>
  group_by(method, structure_high_d, max_dist) |>
  summarise(p = sum(result)/n()) |>
  ggplot(aes(x=max_dist, y=p)) +
  geom_line() +
  facet_grid(method~structure_high_d) +
  xlab("distance")

model_main_results_ds <- glmer(result ~ method * max_dist + (1 | subject), data = results_df_method_ds,
                               family = "binomial",
                               control = glmerControl(optimizer = "bobyqa",
                                                      optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds)
