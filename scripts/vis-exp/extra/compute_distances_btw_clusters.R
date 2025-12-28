## This script is used to compute minimum and maximum distances between the clusters
library(tidyverse)

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


compute_min_dist_btw_clusters <- function(dt_structure, distance_sf = c(0.1, 0.6, 0.9, 1, 1.1)){

  high_d_data <- read_rds(here::here("data/high_d_data_three_clust_all.rds"))
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

    # Compute distance tibbles for each pair of clusters
    dist_highd12 <- compute_dist_btw_clusters(data, "cluster1", "cluster2")
    dist_highd13 <- compute_dist_btw_clusters(data, "cluster1", "cluster3")
    dist_highd23 <- compute_dist_btw_clusters(data, "cluster2", "cluster3")

    # Find the minimum values from each distance tibble
    min_values <- tibble(
      min_dist12 = min(dist_highd12$dist_highd),
      min_dist13 = min(dist_highd13$dist_highd),
      min_dist23 = min(dist_highd23$dist_highd)
    )

    # Filter the rows with minimum dist_highd for each cluster pair
    min_dist12 <- dist_highd12 |> filter(dist_highd == min(dist_highd))
    min_dist13 <- dist_highd13 |> filter(dist_highd == min(dist_highd))
    min_dist23 <- dist_highd23 |> filter(dist_highd == min(dist_highd))

    # Create a tibble with separate columns for each cluster pair
    combined_min_dist <- tibble::tibble(
      from_1_2 = min_dist12$from,
      to_1_2 = min_dist12$to,
      dist_1_2 = min_dist12$dist_highd,

      from_1_3 = min_dist13$from,
      to_1_3 = min_dist13$to,
      dist_1_3 = min_dist13$dist_highd,

      from_2_3 = min_dist23$from,
      to_2_3 = min_dist23$to,
      dist_2_3 = min_dist23$dist_highd
    )

    ## Add relevant columns
    min_values <- min_values |>
      bind_cols(combined_min_dist) |>
      add_column(data_structure = dt_structure) |>
      add_column(distance_sf = sf)

    distance_sf_df <- bind_rows(min_values, distance_sf_df)

  }

  distance_sf_df <- distance_sf_df |>
    arrange(distance_sf)  ## Compute distance from 1

  distance_sf_df

}

compute_max_dist_btw_clusters <- function(dt_structure, distance_sf = c(0.1, 0.6, 0.9, 1, 1.1)){

  high_d_data <- read_rds(here::here("data/high_d_data_three_clust_all.rds"))
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

    # Compute distance tibbles for each pair of clusters
    dist_highd12 <- compute_dist_btw_clusters(data, "cluster1", "cluster2")
    dist_highd13 <- compute_dist_btw_clusters(data, "cluster1", "cluster3")
    dist_highd23 <- compute_dist_btw_clusters(data, "cluster2", "cluster3")

    # Find the minimum values from each distance tibble
    max_values <- tibble(
      max_dist12 = max(dist_highd12$dist_highd),
      max_dist13 = max(dist_highd13$dist_highd),
      max_dist23 = max(dist_highd23$dist_highd)
    )

    # Filter the rows with maximum dist_highd for each cluster pair
    max_dist12 <- dist_highd12 |> filter(dist_highd == max(dist_highd))
    max_dist13 <- dist_highd13 |> filter(dist_highd == max(dist_highd))
    max_dist23 <- dist_highd23 |> filter(dist_highd == max(dist_highd))

    # Create a tibble with separate columns for each cluster pair
    combined_min_dist <- tibble::tibble(
      from_1_2 = max_dist12$from,
      to_1_2 = max_dist12$to,
      dist_1_2 = max_dist12$dist_highd,

      from_1_3 = max_dist13$from,
      to_1_3 = max_dist13$to,
      dist_1_3 = max_dist13$dist_highd,

      from_2_3 = max_dist23$from,
      to_2_3 = max_dist23$to,
      dist_2_3 = max_dist23$dist_highd
    )

    ## Add relevant columns
    max_values <- max_values |>
      bind_cols(combined_min_dist) |>
      add_column(data_structure = dt_structure) |>
      add_column(distance_sf = sf)

    distance_sf_df <- bind_rows(max_values, distance_sf_df)

  }

  distance_sf_df <- distance_sf_df |>
    arrange(distance_sf)  ## Compute distance from 1

  distance_sf_df

}

compute_avg_dist_btw_clusters <- function(dt_structure, distance_sf = c(0.1, 0.6, 0.9, 1, 1.1)){

  high_d_data <- read_rds(here::here("data/high_d_data_three_clust_all.rds"))
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

    # Compute distance tibbles for each pair of clusters
    dist_highd12 <- compute_dist_btw_clusters(data, "cluster1", "cluster2")
    dist_highd13 <- compute_dist_btw_clusters(data, "cluster1", "cluster3")
    dist_highd23 <- compute_dist_btw_clusters(data, "cluster2", "cluster3")

    # Find the minimum values from each distance tibble
    avg_values <- tibble(
      avg_dist12 = mean(dist_highd12$dist_highd),
      avg_dist13 = mean(dist_highd13$dist_highd),
      avg_dist23 = mean(dist_highd23$dist_highd)
    )

    ## Add relevant columns
    avg_values <- avg_values |>
      add_column(data_structure = dt_structure) |>
      add_column(distance_sf = sf)

    distance_sf_df <- bind_rows(avg_values, distance_sf_df)

  }

  distance_sf_df <- distance_sf_df |>
    arrange(distance_sf)  ## Compute distance from 1

  distance_sf_df

}

min_dist_df <- bind_rows(compute_min_dist_btw_clusters("three_clust_01"),
                         compute_min_dist_btw_clusters("three_clust_02"),
                         compute_min_dist_btw_clusters("three_clust_03"),
                         compute_min_dist_btw_clusters("three_clust_04"),
                         compute_min_dist_btw_clusters("three_clust_05"),
                         compute_min_dist_btw_clusters("three_clust_06"),
                         compute_min_dist_btw_clusters("three_clust_07"),
                         compute_min_dist_btw_clusters("three_clust_08"),
                         compute_min_dist_btw_clusters("three_clust_09"),
                         compute_min_dist_btw_clusters("three_clust_10"),
                         compute_min_dist_btw_clusters("three_clust_11"),
                         compute_min_dist_btw_clusters("three_clust_12"),
                         compute_min_dist_btw_clusters("three_clust_13"),
                         compute_min_dist_btw_clusters("three_clust_14"),
                         compute_min_dist_btw_clusters("three_clust_15"),
                         compute_min_dist_btw_clusters("three_clust_16"),
                         compute_min_dist_btw_clusters("three_clust_17"),
                         compute_min_dist_btw_clusters("three_clust_18"))

min_dist_df <- min_dist_df |>
  select(data_structure, distance_sf, min_dist12, min_dist13, min_dist23)

write_rds(min_dist_df, "data/three_clust_min_dist_df.rds")

max_dist_df <- bind_rows(compute_max_dist_btw_clusters("three_clust_01"),
                         compute_max_dist_btw_clusters("three_clust_02"),
                         compute_max_dist_btw_clusters("three_clust_03"),
                         compute_max_dist_btw_clusters("three_clust_04"),
                         compute_max_dist_btw_clusters("three_clust_05"),
                         compute_max_dist_btw_clusters("three_clust_06"),
                         compute_max_dist_btw_clusters("three_clust_07"),
                         compute_max_dist_btw_clusters("three_clust_08"),
                         compute_max_dist_btw_clusters("three_clust_09"),
                         compute_max_dist_btw_clusters("three_clust_10"),
                         compute_max_dist_btw_clusters("three_clust_11"),
                         compute_max_dist_btw_clusters("three_clust_12"),
                         compute_max_dist_btw_clusters("three_clust_13"),
                         compute_max_dist_btw_clusters("three_clust_14"),
                         compute_max_dist_btw_clusters("three_clust_15"),
                         compute_max_dist_btw_clusters("three_clust_16"),
                         compute_max_dist_btw_clusters("three_clust_17"),
                         compute_max_dist_btw_clusters("three_clust_18"))

max_dist_df <- max_dist_df |>
  select(data_structure, distance_sf, max_dist12, max_dist13, max_dist23)

write_rds(max_dist_df, "data/three_clust_max_dist_df.rds")

avg_dist_df <- bind_rows(compute_avg_dist_btw_clusters("three_clust_01"),
                         compute_avg_dist_btw_clusters("three_clust_02"),
                         compute_avg_dist_btw_clusters("three_clust_03"),
                         compute_avg_dist_btw_clusters("three_clust_04"),
                         compute_avg_dist_btw_clusters("three_clust_05"),
                         compute_avg_dist_btw_clusters("three_clust_06"),
                         compute_avg_dist_btw_clusters("three_clust_07"),
                         compute_avg_dist_btw_clusters("three_clust_08"),
                         compute_avg_dist_btw_clusters("three_clust_09"),
                         compute_avg_dist_btw_clusters("three_clust_10"),
                         compute_avg_dist_btw_clusters("three_clust_11"),
                         compute_avg_dist_btw_clusters("three_clust_12"),
                         compute_avg_dist_btw_clusters("three_clust_13"),
                         compute_avg_dist_btw_clusters("three_clust_14"),
                         compute_avg_dist_btw_clusters("three_clust_15"),
                         compute_avg_dist_btw_clusters("three_clust_16"),
                         compute_avg_dist_btw_clusters("three_clust_17"),
                         compute_avg_dist_btw_clusters("three_clust_18"))

avg_dist_df <- avg_dist_df |>
  select(data_structure, distance_sf, avg_dist12, avg_dist13, avg_dist23)

write_rds(avg_dist_df, "data/three_clust_avg_dist_df.rds")

min_max_dist_df <- inner_join(min_dist_df, max_dist_df,
                              by = c("data_structure", "distance_sf"))

min_max_dist_df <- inner_join(min_max_dist_df, avg_dist_df,
                              by = c("data_structure", "distance_sf"))

write_rds(min_max_dist_df, "data/three_clust_min_max_dist_df.rds")

