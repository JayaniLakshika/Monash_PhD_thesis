## To compute the Cross-Cluster k-Nearest Neighbors (kNN) Proportion, follow these steps:

## For each point in a dataset, compute the proportion of its k nearest neighbors that belong to a different cluster.

## This provides a quantitative measure of cluster separation:
### Low values → clusters are well-separated.
### High values → clusters overlap more (i.e., blurry boundaries).

library(FNN)     # For k-nearest neighbors
library(dplyr)   # For data manipulation

high_d_data <- read_rds(here::here("data/high_d_data_three_close_clust_all.rds"))

cross_cluster_knn <- function(dt_structure, distance_sf = c(0.1, 0.6, 1), k = 10) {

  knn_prop_df <- tibble()
  for (sf in distance_sf) {

    data <- high_d_data |>
      filter(dataset == dt_structure) |>
      filter(scale_factor == sf) |>
      filter(sample_size == 7500) |>
      filter(num_noise == 0) |>
      filter(bkg_noise == 0) |>
      pull(high_d_data)

    data <- data[[1]]

    # Remove cluster column to compute kNN on embeddings only
    highd_data <- data |> select(-cluster)
    clusters <- data[["cluster"]]

    # Get k nearest neighbors for each point
    knn_result <- get.knn(as.matrix(highd_data), k = k)

    # For each point, count how many neighbors are from a different cluster
    cross_cluster_counts <- sapply(1:nrow(data), function(i) {
      neighbor_indices <- knn_result$nn.index[i, ]
      sum(clusters[neighbor_indices] != clusters[i])
    })

    # Return a data frame with proportion
    knn_data <- tibble::tibble(
      ID = rownames(data),
      cluster = clusters,
      cross_cluster_prop = cross_cluster_counts / k
    ) |>
      add_column(data_structure = dt_structure) |>
      add_column(distance_sf = sf)

    knn_prop_df <- bind_rows(knn_prop_df, knn_data)

  }

  knn_prop_df <- knn_prop_df |>
    group_by(data_structure, distance_sf) |>
    summarise_at(c("cross_cluster_prop"), mean, na.rm = TRUE)

  knn_prop_df

}

knn_prop_clust_df <- bind_rows(cross_cluster_knn("three_clust_01"),
                               cross_cluster_knn("three_clust_02"),
                               cross_cluster_knn("three_clust_03"),
                               cross_cluster_knn("three_clust_04"),
                               cross_cluster_knn("three_clust_05"),
                               cross_cluster_knn("three_clust_06"),
                               cross_cluster_knn("three_clust_07"),
                               cross_cluster_knn("three_clust_08"),
                               cross_cluster_knn("three_clust_09"),
                               cross_cluster_knn("three_clust_10"),
                               cross_cluster_knn("three_clust_11"),
                               cross_cluster_knn("three_clust_12"),
                               cross_cluster_knn("three_clust_13"),
                               cross_cluster_knn("three_clust_14"),
                               cross_cluster_knn("three_clust_15"),
                               cross_cluster_knn("three_clust_16"),
                               cross_cluster_knn("three_clust_17"),
                               cross_cluster_knn("three_clust_18"))

write_rds(knn_prop_clust_df, "data/three_clust_knn_prop_df.rds")
