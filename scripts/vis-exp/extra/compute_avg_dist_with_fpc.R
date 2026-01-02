## This script used to compute average distances and take the minimum of that
library(tidyverse)
library(fpc)
library(proxy)

compute_min_avg_dist_btw_clusters <- function(dt_structure, distance_sf = c(0.1, 0.6, 0.9, 1, 1.1)){

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

    clust_data <- tibble(data_structure = dt_structure,
                         distance_sf = sf,
                         min_dist = cluster_stats$min.separation,
                         max_diameter = cluster_stats$max.diameter,
                         within_ss = cluster_stats$within.cluster.ss,
                         avg_btw_dist = cluster_stats$average.between,
                         avg_within_dist = cluster_stats$average.within,
                         avg_silwidth_dist = cluster_stats$avg.silwidth,
                         wb_ratio = cluster_stats$wb.ratio,
                         diameter1 = cluster_stats$diameter[1],
                         diameter2 = cluster_stats$diameter[2],
                         diameter3 = cluster_stats$diameter[3],
                         avg_within_dist1 = cluster_stats$average.distance[1],
                         avg_within_dist2 = cluster_stats$average.distance[2],
                         avg_within_dist3 = cluster_stats$average.distance[3],
                         median_within_dist1 = cluster_stats$median.distance[1],
                         median_within_dist2 = cluster_stats$median.distance[2],
                         median_within_dist3 = cluster_stats$median.distance[3],
                         separation_dist1 = cluster_stats$separation[1],
                         separation_dist2 = cluster_stats$separation[2],
                         separation_dist3 = cluster_stats$separation[3],
                         avg_toother_dist1 = cluster_stats$average.toother[1],
                         avg_toother_dist2 = cluster_stats$average.toother[2],
                         avg_toother_dist3 = cluster_stats$average.toother[3],
                         clust_avg_silwidths_dist1 = cluster_stats$clus.avg.silwidths[1],
                         clust_avg_silwidths_dist2 = cluster_stats$clus.avg.silwidths[2],
                         clust_avg_silwidths_dist3 = cluster_stats$clus.avg.silwidths[3],
                         g2 = cluster_stats$g2,
                         g3 = cluster_stats$g3,
                         pearsongamma = cluster_stats$pearsongamma,
                         dunn = cluster_stats$dunn,
                         dunn2 = cluster_stats$dunn2,
                         entropy = cluster_stats$entropy,
                         ch = cluster_stats$ch,
                         cwidegap1 = cluster_stats$cwidegap[1],
                         cwidegap2 = cluster_stats$cwidegap[2],
                         cwidegap3 = cluster_stats$cwidegap[3],
                         widestgap = cluster_stats$widestgap,
                         sindex = cluster_stats$sindex)

    distance_sf_df <- bind_rows(distance_sf_df, clust_data)

  }

  distance_sf_df

}

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

write_rds(avg_dist_df, "data/three_clust_min_avg_dist_df.rds")

### Compute g2 and g3

compute_g2_g3_metrics <- function(dt_structure, distance_sf = c(0.1, 0.6, 0.9, 1, 1.1)){

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
    cluster_stats <- cluster.stats(dist_mat, data$clust, G2 = TRUE, G3 = TRUE)

    clust_data <- tibble(data_structure = dt_structure,
                         distance_sf = sf,
                         g2 = cluster_stats$g2,
                         g3 = cluster_stats$g3)

    distance_sf_df <- bind_rows(distance_sf_df, clust_data)

  }

  distance_sf_df

}

compute_g2_g3_metrics("three_clust_01")
