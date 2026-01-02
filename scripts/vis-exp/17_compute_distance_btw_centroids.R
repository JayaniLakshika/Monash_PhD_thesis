## This script is to compute the distance between the cluster centroids

library(tidyverse)
library(fpc)
library(proxy)

high_d_data <- read_rds(here::here("data/high_d_data_three_close_clust_all.rds"))

compute_min_avg_dist_btw_clusters <- function(dt_structure, distance_sf = c(1.1)){ #0.1, 0.6, 1

  high_d_data <- read_rds(here::here("data/high_d_data_three_close_clust_all.rds"))
  distance_sf_df <- tibble()

  for (sf in distance_sf) {

    data <- high_d_data |>
      filter(dataset == dt_structure) |>
      filter(scale_factor == sf) |>
      filter(sample_size == 7500) |>
      filter(num_noise == 0) |>
      filter(bkg_noise == 0) |>
      pull(high_d_data)

    data <- data[[1]] |>
      dplyr::mutate(
        clust = as.integer(str_extract(cluster, "\\d+"))
      ) |>
      select(-cluster)

    dist_mat <- proxy::dist(data[, 1:4])
    cluster_stats <- cluster.stats(dist_mat, data$clust)

    clust_data <- tibble(min_avg_dist = min(cluster_stats$average.distance),
                         min_dist = cluster_stats$min.separation,
                         avg_dist = cluster_stats$average.between,
                         wb_ratio = cluster_stats$wb.ratio) |>
      add_column(data_structure = dt_structure) |>
      add_column(distance_sf = sf) |>
      select(data_structure, distance_sf, min_avg_dist, min_dist, avg_dist, wb_ratio)

    distance_sf_df <- bind_rows(distance_sf_df, clust_data)

  }

  distance_sf_df

}
# Define a function to compute distances and create a tibble
compute_dist_btw_clusters <- function(data, cluster_a, cluster_b) {
  data_a <- data |> filter(cluster == cluster_a)
  data_b <- data |> filter(cluster == cluster_b)
  columns_to_use <- paste0("x", 1:4)

  dist_vec <- proxy::dist(x = data_a[, columns_to_use], y = data_b[, columns_to_use], method = "Euclidean") |> as.vector()

  from_vec <- rep(1:nrow(data_a), nrow(data_b))
  to_vec <- rep(1:nrow(data_b), each = nrow(data_a))

  tibble(from = from_vec, to = to_vec, dist_highd = dist_vec)
}

compute_centroid_clusters <- function(dt_structure, distance_sf = c(1.1, 1)){ #c(0.1, 0.6, 0.8, 1)

  distance_sf_df <- tibble()

  for (sf in distance_sf) {

    data <- high_d_data |>
      filter(dataset == dt_structure) |>
      filter(scale_factor == sf) |>
      filter(sample_size == 7500) |>
      filter(num_noise == 0) |>
      filter(bkg_noise == 0) |>
      pull(high_d_data)

    data <- data[[1]]

    centroid_df <- data |>
      group_by(cluster) |>
      summarise(across(x1:x4, \(x) mean(x, na.rm = TRUE)))

    # Compute distance tibbles for each pair of clusters
    dist_highd12 <- compute_dist_btw_clusters(centroid_df, "cluster1", "cluster2")
    dist_highd13 <- compute_dist_btw_clusters(centroid_df, "cluster1", "cluster3")
    dist_highd23 <- compute_dist_btw_clusters(centroid_df, "cluster2", "cluster3")

    centroid_dist <- tibble(
      data_structure = dt_structure,
      distance_sf = sf,
      centroid_dist12 = dist_highd12$dist_highd,
      centroid_dist13 = dist_highd13$dist_highd,
      centroid_dist23 = dist_highd23$dist_highd
    )

    distance_sf_df <- bind_rows(centroid_dist, distance_sf_df)

  }

  distance_sf_df <- distance_sf_df |>
    arrange(distance_sf) |> ## Compute distance from 1
    mutate(
      prop12 = round(centroid_dist12/centroid_dist12[distance_sf == 1], 1),
      prop13 = round(centroid_dist13/centroid_dist13[distance_sf == 1], 1),
      prop23 = round(centroid_dist23/centroid_dist23[distance_sf == 1], 1)
    )

  distance_sf_df

}

all_dist_centroids <- bind_rows(compute_centroid_clusters("three_clust_01"),
                                compute_centroid_clusters("three_clust_02"),
                                compute_centroid_clusters("three_clust_03"),
                                compute_centroid_clusters("three_clust_04"),
                                compute_centroid_clusters("three_clust_05"),
                                compute_centroid_clusters("three_clust_06"),
                                compute_centroid_clusters("three_clust_07"),
                                compute_centroid_clusters("three_clust_08"),
                                compute_centroid_clusters("three_clust_09"),
                                compute_centroid_clusters("three_clust_10"),
                                compute_centroid_clusters("three_clust_11"),
                                compute_centroid_clusters("three_clust_12"),
                                compute_centroid_clusters("three_clust_13"),
                                compute_centroid_clusters("three_clust_14"),
                                compute_centroid_clusters("three_clust_15"),
                                compute_centroid_clusters("three_clust_16"),
                                compute_centroid_clusters("three_clust_17"),
                                compute_centroid_clusters("three_clust_18"))


a <- all_dist_centroids |>
  rename(c("structure" = "data_structure",
           "dist_sf" = "distance_sf",
           "dist12" = "centroid_dist12",
           "dist13" = "centroid_dist13",
           "dist23" = "centroid_dist23")) |>
  mutate(dist12 = round(dist12, 2),
         dist13 = round(dist13, 2),
         dist23 = round(dist23, 2))

a

avg_dist_df <- bind_rows(compute_min_avg_dist_btw_clusters("three_clust_01"),
                         compute_min_avg_dist_btw_clusters("three_clust_02"),
                         compute_min_avg_dist_btw_clusters("three_clust_03"),
                         compute_min_avg_dist_btw_clusters("three_clust_04"),
                         compute_min_avg_dist_btw_clusters("three_clust_05"),
                         compute_min_avg_dist_btw_clusters("three_clust_06"),
                         compute_min_avg_dist_btw_clusters("three_clust_07"),
                         compute_min_avg_dist_btw_clusters("three_clust_08"),
                         compute_min_avg_dist_btw_clusters("three_clust_09"),
                         compute_min_avg_dist_btw_clusters("three_clust_10"),
                         compute_min_avg_dist_btw_clusters("three_clust_11"),
                         compute_min_avg_dist_btw_clusters("three_clust_12"),
                         compute_min_avg_dist_btw_clusters("three_clust_13"),
                         compute_min_avg_dist_btw_clusters("three_clust_14"),
                         compute_min_avg_dist_btw_clusters("three_clust_15"),
                         compute_min_avg_dist_btw_clusters("three_clust_16"),
                         compute_min_avg_dist_btw_clusters("three_clust_17"),
                         compute_min_avg_dist_btw_clusters("three_clust_18"))

all_dist_centroids <- all_dist_centroids |>
  full_join(avg_dist_df, by = c("data_structure", "distance_sf")) |>
  rename(c("structure" = "data_structure",
           "dist_sf" = "distance_sf",
           "dist12" = "centroid_dist12",
           "dist13" = "centroid_dist13",
           "dist23" = "centroid_dist23")) |>
  mutate(dist12 = round(dist12, 2),
         dist13 = round(dist13, 2),
         dist23 = round(dist23, 2))

bw_ratio <- read_rds("~/Desktop/PhD Monash research files/Research papers/paper-vis-experiment/data/three_clust_min_avg_dist_df.rds")

bw_ratio <- bind_rows(bw_ratio, avg_dist_df)

write_rds(bw_ratio, "~/Desktop/PhD Monash research files/Research papers/paper-vis-experiment/data/three_clust_min_avg_dist_df.rds")

avg_dist_df |>
  mutate(bw_ratio = 1/wb_ratio)
