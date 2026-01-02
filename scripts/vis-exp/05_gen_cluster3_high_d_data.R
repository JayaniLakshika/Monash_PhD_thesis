## High_d_data_generation_script 1: This script contains functions to generate the data structures with different
## no noise dimensions, no background noise, and distance scale factor 1, and
## different sample sizes.

library(tibble)
library(readr)
library(tidyr)
library(dplyr)
library(purrr)
library(stringr)
conflicted::conflict_prefer("select", "dplyr")
conflicted::conflict_prefer("filter", "dplyr")

set.seed(115472246)

source(here::here("R/01_data_structure_components.R"))
source(here::here("R/02_data_structures.R"))

# Helper function to relocate a center at a specific distance from a reference point
relocate_center <- function(ref_center, current_center, target_dist) {
  direction <- (current_center - ref_center) / sqrt(sum((current_center - ref_center)^2))
  new_center <- ref_center + direction * target_dist
  return(new_center)
}

## Generate the all the combinations of data structures

dataset <- paste0("three_clust_", sprintf("%02d", 1:28))

scale_factor <- c(1)#c(0.1, 0.6, 1)
sample_size <- c(375, 1500, 7500)
num_noise <- c(0)#c(0, 2, 6)
bkg_noise <- c(0)#c(0, 0.2, 0.4)

all_dt_strcutures <- expand_grid(dataset, scale_factor, sample_size, num_noise,
                                 bkg_noise)

## To filter only useful combinations
all_dt_strcutures <- all_dt_strcutures |>
  filter(
    (sample_size == 7500 & (
      (num_noise == 0 & bkg_noise == 0) |
        (num_noise == 0 & bkg_noise == 0.2) |
        (num_noise == 0 & bkg_noise == 0.4) |
        (num_noise == 2 & bkg_noise == 0) |
        (num_noise == 6 & bkg_noise == 0)
    )) |
      (sample_size != 7500 & num_noise == 0 & bkg_noise == 0)
  )

# Target distances between clusters
d12 <- 6.20    # Distance between Cluster 1 and Cluster 2
d13 <- 18.5   # Distance between Cluster 1 and Cluster 3
d23 <- 17.8   # Distance between Cluster 2 and Cluster 3

# Define the coordinates for the vertices of an equilateral triangle in 4D
triangle_vertices_clust3 <- matrix(c(
  0, 0, 0, 0,
  5, 0, 0, 0,
  3, 4, 10, 7  # height of smaller equilateral triangle in 2D
), ncol = 4, byrow = TRUE)

triangle_vertices_clust6 <- matrix(c(
  # Two close clusters (small distance between them)
  0, 0, 0, 0,         # Cluster 1
  0.5, 0.5, 0, 0,     # Cluster 2 (very close to Cluster 1)

  # Three somewhat close clusters
  5, 0, 0, 0,         # Cluster 3
  5, 5, 0, 0,         # Cluster 4
  4, 1, 0, 0,         # Cluster 5 (somewhat close to 3 and 4)

  # One distant cluster
  8, 8, 8, 8      # Cluster 6 (far from all others)
), ncol = 4, byrow = TRUE)

triangle_vertices_clust9 <- matrix(c(
  # Clusters 1, 2, and 3 (very close to each other)
  0, 0, 0, 0,        # Cluster 1
  0.5, 0.5, 0, 0,    # Cluster 2 (very close to Cluster 1)
  1, 0.2, 0, 0,      # Cluster 3 (close to Cluster 1 and 2)

  # Cluster 4 close to Cluster 3
  2, 1, 0, 0,        # Cluster 4 (close to Cluster 3)

  # Cluster 5 close to Cluster 4
  3, 1.5, 0, 0,      # Cluster 5 (close to Cluster 4)

  # Clusters 6 and 8 (close to each other, but farther from 1-5)
  6, 6, 0, 0,        # Cluster 6 (a bit far from 1-5)
  6.5, 6.5, 0, 0,    # Cluster 8 (close to Cluster 6)

  # Clusters 7 and 9 (far from each other and far from the rest)
  9, 9, 9, 9,    # Cluster 7 (far from all other clusters)
  13, 12, 11, 9     # Cluster 9 (far from Cluster 7 and the rest)
), ncol = 4, byrow = TRUE)

## Add num_clust

all_dt_strcutures <- all_dt_strcutures |>
  mutate(num_clust = if_else(str_detect(dataset, "^three"), 3,
                             if_else(str_detect(dataset, "^six"), 6, 9)))

## Added scale the triangle vertices to increase distances between clusters

all_dt_strcutures <- all_dt_strcutures |>
  rowwise() |> # Apply row-wise operations
  mutate(triangle_vertices = if_else(num_clust == 3, lst(scale_factor * triangle_vertices_clust3),
                                     if_else(num_clust == 6, lst(scale_factor * triangle_vertices_clust6),
                                             lst(scale_factor * triangle_vertices_clust9)))) |>
  ungroup()  # Ensure the result is ungrouped


## Added high_d_data into a column
high_d_data <- c()

for (row in 1:NROW(all_dt_strcutures)) {

  ## To get the function name
  function_name <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(dataset)

  function_name <- get(function_name[1])

  ## To get the triangle_vertices
  tri_matrix <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(triangle_vertices)

  tri_matrix <- tri_matrix[1][[1]]

  ## To obtain the sample size
  sample_size_assign <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(sample_size)

  sample_size_assign <- sample_size_assign[1]

  ## To obtain scale factor
  scale_factor_assign <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(scale_factor)

  scale_factor_assign <- scale_factor_assign[1]

  ## To obtain the number of noise dimensions
  num_noise <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(num_noise)

  num_noise <- num_noise[1]

  ## To obtain the number of noise dimensions
  bkg_noise <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(bkg_noise)

  bkg_noise <- bkg_noise[1]

  generated_high_d_data <- function_name(n = sample_size_assign,
                                         triangle_vertices = tri_matrix)

  # if (num_noise == 2) {
  #
  #   generated_high_d_data <- generated_high_d_data |>
  #     mutate(x5 = rnorm(sample_size_assign, mean = 0, sd = 4),
  #            x6 = runif(n=sample_size_assign, min=-7, max=7))
  #
  #   generated_high_d_data <- generated_high_d_data |>
  #     select(paste0("x", 1:6), cluster)
  #
  #
  # } else if (num_noise == 6) {
  #
  #   generated_high_d_data <- generated_high_d_data |>
  #     mutate(x5 = rnorm(sample_size_assign, mean = 0, sd = 4),
  #            x6 = runif(n=sample_size_assign, min=-7, max=7),
  #            x7 = rnorm(sample_size_assign, mean = 2, sd = 4),
  #            x8 = rexp(sample_size_assign, rate = 0.3),
  #            x9 = rt(sample_size_assign, df = 2),
  #            x10 = rgamma(sample_size_assign, shape = 5, rate = 1))
  #
  #   generated_high_d_data <- generated_high_d_data |>
  #     select(paste0("x", 1:10), cluster)
  #
  # } else { #num_noise == 0
  #
  # }
  #
  # if (bkg_noise != 0) {
  #   ## To generate a column which specify the observation is bkg or not
  #   generated_high_d_data_sample <- generated_high_d_data |>
  #     group_by(cluster) |>
  #     group_split() |>
  #     map_dfr(~ {
  #       sampled_data <- .x |> slice_sample(n = NROW(.x) * (1 - bkg_noise))
  #       remaining_data <- .x |> anti_join(sampled_data, by = names(.x))
  #
  #       bind_rows(
  #         mutate(sampled_data, subset = "no_bkg_noise"),
  #         mutate(remaining_data, subset = "bkg_noise")
  #       )
  #     })
  #
  #   ## To generate bkg_noise from different distributions
  #   bkg_noise_sample1 <- rnorm(sample_size_assign * bkg_noise, mean = 0, sd = 1)
  #   bkg_noise_sample2 <- runif(n=sample_size_assign * bkg_noise, min=-0.05, max=0.05)
  #   bkg_noise_sample3 <- rbinom(sample_size_assign * bkg_noise, size = 1, prob = 0.5)
  #   bkg_noise_sample4 <- rexp(sample_size_assign * bkg_noise, rate = 1)
  #
  #   ## To randomize the bkg_noise
  #   bkg_sample <- c(bkg_noise_sample1, bkg_noise_sample2,
  #                   bkg_noise_sample3, bkg_noise_sample4)
  #
  #   randomized_bkg_sample <- sample(1:length(bkg_sample))
  #   bkg_sample <- bkg_sample[randomized_bkg_sample]
  #
  #   # Number of sub-vectors
  #   num_splits <- 4
  #
  #   # Split into 4 sub-vectors using split and a grouping factor
  #   split_vec <- split(bkg_sample, ceiling(seq_along(bkg_sample) / (length(bkg_sample) / num_splits)))
  #
  #   ## Add noise to the existing observations
  #   bkg_noise_df <- generated_high_d_data_sample |>
  #     filter(subset == "bkg_noise") |>
  #     mutate(x1 = x1 + split_vec[[1]],
  #            x2 = x2 + split_vec[[2]],
  #            x3 = x3 + split_vec[[3]],
  #            x4 = x4 + split_vec[[4]]) |>
  #     select(-subset)
  #
  #   ## To filter no bkg_noise data
  #   no_bkg_noise_df <- generated_high_d_data_sample |>
  #     filter(subset == "no_bkg_noise") |>
  #     select(-subset)
  #
  #   ## To bind all the data together
  #   generated_high_d_data <- bind_rows(no_bkg_noise_df, bkg_noise_df)
  #
  #
  # }else { #bkg_noise == 0
  #
  # }

  # generated_high_d_data <- generated_high_d_data |>
  #   dplyr::select(-cluster)

  ## To standardized data
  # generated_high_d_data <- generated_high_d_data |>
  #   mutate(across(-cluster, ~ (. - mean(.)) / sd(.)))

  # generated_high_d_data <- generated_high_d_data |>
  #   group_by(cluster) |>
  #   mutate(across(starts_with("x"), ~ (. - mean(.)) / sd(.))) |>
  #   ungroup()

  # Create clusters and centroids
  clusters <- unique(generated_high_d_data$cluster)

  # Step 1: Create a list of clusters
  cluster_list <- lapply(clusters, function(c) {
    generated_high_d_data |>
      filter(cluster == c) |>
      dplyr::select(-cluster)
  })

  # Step 2: Calculate centroid for each cluster
  centroid_df <- generated_high_d_data |>
    group_by(cluster) |>
    summarise(across(starts_with("x"), ~mean(.x, na.rm = TRUE)), .groups = 'drop')

  # Extract centers as vectors in a named list for easier access
  centers <- setNames(as.data.frame(t(centroid_df[-1])), centroid_df$cluster)

  ## Rescale the distance
  d12 <- d12 * scale_factor_assign
  d13 <- d13 * scale_factor_assign
  d23 <- d23 * scale_factor_assign

  # Step 3: Adjust cluster centers based on target distances
  center1 <- centers[,1]
  center2 <- center1 + c(d12, rep(0, (length(center1) - 1)))  # Set Cluster 2 along one axis

  # Optimizing position of Cluster 3
  center3 <- optim(
    par = rep(10, length(center1)),
    fn = function(center3) {
      dist_13 <- sqrt(sum((center3 - center1)^2))
      dist_23 <- sqrt(sum((center3 - center2)^2))
      (dist_13 - d13)^2 + (dist_23 - d23)^2
    }
  )$par

  # Step 4: Calculate shifts to move clusters to these new centers
  shifts <- sapply(cluster_list, colMeans)
  shifts <- cbind(center1, center2, center3) - shifts

  # Step 5: Shift all points in each cluster
  cluster_list <- lapply(1:length(cluster_list), function(i) {
    sweep(cluster_list[[i]], 2, shifts[, i], "+")
  })

  # Combine adjusted clusters into a final data frame
  final_clusters <- do.call(rbind, lapply(1:length(cluster_list), function(i) {
    cbind(as_tibble(cluster_list[[i]]), cluster = clusters[i])
  }))

  # Rename columns
  colnames(final_clusters)[1:length(center1)] <- paste0("x", 1:length(center1))

  # Convert to tibble
  final_clusters <- as_tibble(final_clusters)

  # To standardized data
  final_clusters <- final_clusters |>
    mutate(across(-cluster, ~ (. - mean(.)) / sd(.)))

  # cluster1 <- generated_high_d_data |>
  #   filter(cluster == "cluster1") |>
  #   select(-cluster)
  #
  # cluster2 <- generated_high_d_data |>
  #   filter(cluster == "cluster2") |>
  #   select(-cluster)
  #
  # cluster3 <- generated_high_d_data |>
  #   filter(cluster == "cluster3") |>
  #   select(-cluster)
  #
  # centroid_df <- generated_high_d_data |>
  #   group_by(cluster) |>
  #   summarise(across(x1:x4, \(x) mean(x, na.rm = TRUE)))
  #
  # center1 <- centroid_df |>
  #   filter(row_number() == 1) |>
  #   select(-cluster) |>
  #   as_vector()
  #
  # center2 <- centroid_df |>
  #   filter(row_number() == 2) |>
  #   select(-cluster) |>
  #   as_vector()
  #
  # center3 <- centroid_df |>
  #   filter(row_number() == 3) |>
  #   select(-cluster) |>
  #   as_vector()
  #
  # # Step 3: Adjust cluster centers based on target distances
  # center2 <- center1 + c(d12, 0, 0, 0)  # Set Cluster 2 along one axis
  # center3 <- optim(
  #   par = c(10, 10, 10, 10),
  #   fn = function(center3) {
  #     dist_13 <- sqrt(sum((center3 - center1)^2))
  #     dist_23 <- sqrt(sum((center3 - center2)^2))
  #     (dist_13 - d13)^2 + (dist_23 - d23)^2
  #   }
  # )$par
  #
  # # Calculate shifts to move clusters to these new centers
  # shift1 <- center1 - colMeans(cluster1)
  # shift2 <- center2 - colMeans(cluster2)
  # shift3 <- center3 - colMeans(cluster3)
  #
  # # Step 4: Shift all points in each cluster
  # cluster1 <- sweep(cluster1, 2, shift1, "+")
  # cluster2 <- sweep(cluster2, 2, shift2, "+")
  # cluster3 <- sweep(cluster3, 2, shift3, "+")
  #
  # # Combine adjusted clusters into a final data frame
  # final_clusters <- rbind(
  #   cbind(as_tibble(cluster1), cluster = "Cluster1"),
  #   cbind(as_tibble(cluster2), cluster = "Cluster2"),
  #   cbind(as_tibble(cluster3), cluster = "Cluster3")
  # )
  #
  # final_clusters <- as_tibble(final_clusters)
  # colnames(final_clusters)[1:4] <- paste0("x", 1:4)

  ## To get the high_d data
  high_d_data <- append(high_d_data, lst(final_clusters))

}

all_dt_strcutures <- all_dt_strcutures |>
  mutate(high_d_data = high_d_data) |>
  mutate(start_high_d = 115472246) |>
  dplyr::select(dataset, num_clust, scale_factor, sample_size, num_noise,
                bkg_noise, high_d_data, start_high_d)

#write_rds(all_dt_strcutures, here::here("data/high_d_data_three_close_clust_all.rds"))
write_rds(all_dt_strcutures, here::here("data/high_d_data_three_close_clust_sf1.rds"))

