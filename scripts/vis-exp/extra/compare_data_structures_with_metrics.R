library(tidyverse)
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
  mutate(log_bw_ratio_scaled = log(bw_ratio)) |>
  mutate(sqr_avg_btw_dist_scaled = avg_btw_dist_scaled^2) |>
  mutate(sqr_pearsongamma_scaled = pearsongamma_scaled^2) |>
  mutate(sqr_avg_silwidth_dist_scaled = avg_silwidth_dist_scaled^2) |>
  mutate(sqrt_dunn_scaled = sqrt(dunn_scaled)) |>
  mutate(sqrt_dunn2_scaled = sqrt(dunn2_scaled))

metrics_scaled <- append(paste0(metrics[c(1, 7)], "_scaled"), c("log_bw_ratio_scaled",
                                                                     "sqr_avg_btw_dist_scaled",
                                                                     "sqr_pearsongamma_scaled",
                                                                     "sqr_avg_silwidth_dist_scaled",
                                                                     "sqrt_dunn_scaled",
                                                                     "sqrt_dunn2_scaled"))

langevitour::langevitour(distance_df_scaled |> select(all_of(metrics_scaled)),
                         group = distance_df_scaled$distance_sf)

GGally::ggpairs(distance_df_scaled |> select(all_of(metrics_scaled), distance_sf),
                columns = metrics_scaled,
                mapping = aes(color = as.factor(distance_sf)))

## For each distance factor
distance_df_scaled_filtered <- distance_df_scaled |> filter(distance_sf == 1)
metrics_scaled <- c("min_dist_scaled", "log_bw_ratio_scaled")

langevitour::langevitour(distance_df_scaled_filtered |> select(all_of(metrics_scaled)),
                         group = distance_df_scaled_filtered$data_structure)

# GGally::ggpairs(distance_df_scaled_filtered |> select(all_of(metrics_scaled), data_structure),
#                 columns = metrics_scaled,
#                 mapping = aes(color = data_structure),
#                 upper = list(continuous = "blank"),
#                 diag = list(continuous = "blankDiag"))

distance_df_scaled_filtered <- distance_df_scaled_filtered |>
  mutate(cluster = if_else(data_structure %in% c("three_clust_08", "three_clust_18"), "cluster1",
                           if_else(data_structure %in% c("three_clust_05", "three_clust_15"), "cluster2",
                                   if_else(data_structure %in% c("three_clust_01", "three_clust_11"), "cluster3",
                                           if_else(data_structure %in% c("three_clust_09", "three_clust_10", "three_clust_17"), "cluster4",
                                                   "cluster5")))))

ggplot(distance_df_scaled_filtered, aes(x = min_dist_scaled, y = log_bw_ratio_scaled, color = cluster)) +
  geom_point()
ggplotly()

## 8, 18 looks in one cluster (conic_spiral and gaussian are common)
## 5, 15 looks in one cluster (nonlinear_hyperbola and elliptical are common)
## 1, 11 looks in one cluster (curv and elliptical are common)
## 10, 17 looks in one cluster (cube and blunted_cone are common) 9 is here also, but no common strictures
## 2, 3, 4, 5, 6, 7, 12, 13, 14, 16 looks in one cluster
### 2, 3, 6, 7, 14 (pyramid_rectangular_base is common)
### 4, 12, 16 (filled_hexagonal_pyramid is common)
