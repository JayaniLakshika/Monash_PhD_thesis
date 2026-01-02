## High_d_data_generation_script 2:
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


## Read data with scale factor 1
all_dt_structures <- read_rds(here::here("data/high_d_data_three_close_clust_sf1.rds"))

## To select data structure only with sample size 7500
all_dt_structures <- all_dt_structures |>
  filter(sample_size == 7500) |>
  filter(num_noise == 0) |>
  filter(bkg_noise == 0)

# Target distances between clusters
# d12_old <- 6.20    # Distance between Cluster 1 and Cluster 2
# d13_old <- 21.5   # Distance between Cluster 1 and Cluster 3
# d23_old <- 25.8   # Distance between Cluster 2 and Cluster 3

scale_factor_assign <- 1.1 #0.1, 0.6, 1, 0.8, 0.9, 1.1

## Added high_d_data into a column
high_d_data <- c()

for (row in 1:NROW(all_dt_structures)) {

  generated_high_d_data <- all_dt_structures |>
    filter(row_number() == row) |>
    pull(high_d_data)

  generated_high_d_data <- generated_high_d_data[[1]]

  dataset <- all_dt_structures |>
    filter(row_number() == row) |>
    pull(dataset)

  dataset <- dataset[[1]]

  # Create clusters and centroids
  clusters <- unique(generated_high_d_data$cluster)

  # Step 1: Create a list of clusters
  cluster_list <- lapply(clusters, function(c) {
    generated_high_d_data |>
      filter(cluster == c) |>
      select(-cluster)
  })

  # Step 2: Calculate centroid for each cluster
  centroid_df <- generated_high_d_data |>
    group_by(cluster) |>
    summarise(across(x1:x4, ~mean(.x, na.rm = TRUE)), .groups = 'drop')

  # Extract centers as vectors in a named list for easier access
  centers <- setNames(as.data.frame(t(centroid_df[-1])), centroid_df$cluster)

  ## Rescale the distance
  # d12 <- d12_old * scale_factor_assign
  # d13 <- d13_old * scale_factor_assign
  # d23 <- d23_old * scale_factor_assign

  dist_highd12 <- compute_dist_btw_clusters(centroid_df, "cluster1", "cluster2")
  dist_highd13 <- compute_dist_btw_clusters(centroid_df, "cluster1", "cluster3")
  dist_highd23 <- compute_dist_btw_clusters(centroid_df, "cluster2", "cluster3")

  if(scale_factor_assign == 0.1) {
    if (dataset %in% paste0("three_clust_", sprintf("%02d", c(3, 4, 8, 11, 12, 13)))) {
      scale_factor_assign1 <- 0.03
      scale_factor_assign2 <- 0.03
      scale_factor_assign3 <- 0.03

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(1, 16)))) {
      scale_factor_assign1 <- 0.03
      scale_factor_assign2 <- 0.03
      scale_factor_assign3 <- 0.015

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(2)))) {
      scale_factor_assign1 <- 0.03
      scale_factor_assign2 <- 0.015
      scale_factor_assign3 <- 0.01

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(5, 15, 18)))) {
      scale_factor_assign1 <- 0.03
      scale_factor_assign2 <- 0.015
      scale_factor_assign3 <- 0.015

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(10)))) {
      scale_factor_assign1 <- 0.015
      scale_factor_assign2 <- 0.015
      scale_factor_assign3 <- 0.015

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(9)))) {
      scale_factor_assign1 <- 0.03
      scale_factor_assign2 <- 0.01
      scale_factor_assign3 <- 0.01

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(14)))) {
      scale_factor_assign1 <- 0.015
      scale_factor_assign2 <- 0.03
      scale_factor_assign3 <- 0.03

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(17)))) {
      scale_factor_assign1 <- 0.015
      scale_factor_assign2 <- 0.015
      scale_factor_assign3 <- 0.01

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(6)))) {
      scale_factor_assign1 <- 0.03
      scale_factor_assign2 <- 0.02
      scale_factor_assign3 <- 0.02

    }else if(dataset %in% paste0("three_clust_", sprintf("%02d", c(7)))) {
      scale_factor_assign1 <- 0.015
      scale_factor_assign2 <- 0.01
      scale_factor_assign3 <- 0.01
    }
  } else if (scale_factor_assign == 0.6) {
      if (dataset %in% paste0("three_clust_", sprintf("%02d", c(3, 9, 13)))) {
        scale_factor_assign1 <- 0.15
        scale_factor_assign2 <- 0.15
        scale_factor_assign3 <- 0.15

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(1, 11, 12)))) {
          scale_factor_assign1 <- 0.18
          scale_factor_assign2 <- 0.18
          scale_factor_assign3 <- 0.18

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(2)))) {
          scale_factor_assign1 <- 0.18
          scale_factor_assign2 <- 0.15
          scale_factor_assign3 <- 0.13

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(4)))) {
          scale_factor_assign1 <- 0.18
          scale_factor_assign2 <- 0.13
          scale_factor_assign3 <- 0.13

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(8, 18)))) {
          scale_factor_assign1 <- 0.25
          scale_factor_assign2 <- 0.18
          scale_factor_assign3 <- 0.18

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(10)))) {
          scale_factor_assign1 <- 0.12
          scale_factor_assign2 <- 0.1
          scale_factor_assign3 <- 0.1

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(5, 15)))) {
          scale_factor_assign1 <- 0.18
          scale_factor_assign2 <- 0.15
          scale_factor_assign3 <- 0.15

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(16)))) {
          scale_factor_assign1 <- 0.18
          scale_factor_assign2 <- 0.17
          scale_factor_assign3 <- 0.18

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(6)))) {
          scale_factor_assign1 <- 0.17
          scale_factor_assign2 <- 0.17
          scale_factor_assign3 <- 0.16

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(14)))) {
          scale_factor_assign1 <- 0.13
          scale_factor_assign2 <- 0.16
          scale_factor_assign3 <- 0.17

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(7)))) {
          scale_factor_assign1 <- 0.13
          scale_factor_assign2 <- 0.14
          scale_factor_assign3 <- 0.14

        } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(17)))) {
          scale_factor_assign1 <- 0.13
          scale_factor_assign2 <- 0.14
          scale_factor_assign3 <- 0.14

        }
  } else if (scale_factor_assign == 0.8){

      if (dataset %in% paste0("three_clust_", sprintf("%02d", c(1)))) {
        scale_factor_assign1 <- 0.36
        scale_factor_assign2 <- 0.33
        scale_factor_assign3 <- 0.29

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(2)))) {
        scale_factor_assign1 <- 0.36
        scale_factor_assign2 <- 0.34
        scale_factor_assign3 <- 0.29

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(3, 4, 5)))) {
        scale_factor_assign1 <- 0.36
        scale_factor_assign2 <- 0.34
        scale_factor_assign3 <- 0.30

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(6)))) {
        scale_factor_assign1 <- 0.36
        scale_factor_assign2 <- 0.33
        scale_factor_assign3 <- 0.30

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(7)))) {
        scale_factor_assign1 <- 0.30
        scale_factor_assign2 <- 0.33
        scale_factor_assign3 <- 0.33

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(8)))) {
        scale_factor_assign1 <- 0.36
        scale_factor_assign2 <- 0.33
        scale_factor_assign3 <- 0.31

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(9)))) {
        scale_factor_assign1 <- 0.36
        scale_factor_assign2 <- 0.315
        scale_factor_assign3 <- 0.28

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(10, 11)))) {
        scale_factor_assign1 <- 0.32
        scale_factor_assign2 <- 0.33
        scale_factor_assign3 <- 0.32

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(12)))) {
        scale_factor_assign1 <- 0.32
        scale_factor_assign2 <- 0.34
        scale_factor_assign3 <- 0.33

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(13)))) {
        scale_factor_assign1 <- 0.32
        scale_factor_assign2 <- 0.34
        scale_factor_assign3 <- 0.34

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(14)))) {
        scale_factor_assign1 <- 0.31
        scale_factor_assign2 <- 0.34
        scale_factor_assign3 <- 0.34

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(15)))) {
        scale_factor_assign1 <- 0.31
        scale_factor_assign2 <- 0.32
        scale_factor_assign3 <- 0.34

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(16)))) {
        scale_factor_assign1 <- 0.31
        scale_factor_assign2 <- 0.32
        scale_factor_assign3 <- 0.33

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(17)))) {
        scale_factor_assign1 <- 0.30
        scale_factor_assign2 <- 0.32
        scale_factor_assign3 <- 0.31

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(18)))) {
        scale_factor_assign1 <- 0.34
        scale_factor_assign2 <- 0.32
        scale_factor_assign3 <- 0.32

      }

  } else if (scale_factor_assign == 0.9){

      if (dataset %in% paste0("three_clust_", sprintf("%02d", c(1)))) {
        scale_factor_assign1 <- 0.45
        scale_factor_assign2 <- 0.44
        scale_factor_assign3 <- 0.44

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(2)))) {
        scale_factor_assign1 <- 0.33
        scale_factor_assign2 <- 0.51
        scale_factor_assign3 <- 0.55

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(3)))) {
        scale_factor_assign1 <- 0.47
        scale_factor_assign2 <- 0.46
        scale_factor_assign3 <- 0.46

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(4)))) {
        scale_factor_assign1 <- 0.47
        scale_factor_assign2 <- 0.44
        scale_factor_assign3 <- 0.43

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(5)))) {
        scale_factor_assign1 <- 0.46
        scale_factor_assign2 <- 0.44
        scale_factor_assign3 <- 0.40

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(6)))) {
        scale_factor_assign1 <- 0.46
        scale_factor_assign2 <- 0.43
        scale_factor_assign3 <- 0.40

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(7)))) {
        scale_factor_assign1 <- 0.40
        scale_factor_assign2 <- 0.43
        scale_factor_assign3 <- 0.43

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(8)))) {
        scale_factor_assign1 <- 0.50
        scale_factor_assign2 <- 0.45
        scale_factor_assign3 <- 0.44

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(9)))) {
        scale_factor_assign1 <- 0.39
        scale_factor_assign2 <- 0.44
        scale_factor_assign3 <- 0.46

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(10)))) {
        scale_factor_assign1 <- 0.41
        scale_factor_assign2 <- 0.41
        scale_factor_assign3 <- 0.41

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(11)))) {
        scale_factor_assign1 <- 0.43
        scale_factor_assign2 <- 0.43
        scale_factor_assign3 <- 0.42

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(12)))) {
        scale_factor_assign1 <- 0.43
        scale_factor_assign2 <- 0.44
        scale_factor_assign3 <- 0.43

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(13)))) {
        scale_factor_assign1 <- 0.42
        scale_factor_assign2 <- 0.44
        scale_factor_assign3 <- 0.44

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(14)))) {
        scale_factor_assign1 <- 0.41
        scale_factor_assign2 <- 0.44
        scale_factor_assign3 <- 0.45

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(15)))) {
        scale_factor_assign1 <- 0.41
        scale_factor_assign2 <- 0.43
        scale_factor_assign3 <- 0.45

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(16)))) {
        scale_factor_assign1 <- 0.41
        scale_factor_assign2 <- 0.42
        scale_factor_assign3 <- 0.43

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(17)))) {
        scale_factor_assign1 <- 0.40
        scale_factor_assign2 <- 0.42
        scale_factor_assign3 <- 0.41

      } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(18)))) {
        scale_factor_assign1 <- 0.45
        scale_factor_assign2 <- 0.42
        scale_factor_assign3 <- 0.42

      }

  } else if (scale_factor_assign == 1.1){

    if (dataset %in% paste0("three_clust_", sprintf("%02d", c(1:5, 7:11, 13, 15:18)))) {
      scale_factor_assign1 <- 1.75
      scale_factor_assign2 <- 2
      scale_factor_assign3 <- 2.2

    } else if (dataset %in% paste0("three_clust_", sprintf("%02d", c(6, 12, 14)))) {
        scale_factor_assign1 <- 1.1
        scale_factor_assign2 <- 1.5
        scale_factor_assign3 <- 1.7

    } else {

      scale_factor_assign1 <- 1.1
      scale_factor_assign2 <- 1.1
      scale_factor_assign3 <- 1.1

    }

  }

  d12 <- dist_highd12$dist_highd * scale_factor_assign1
  d13 <- dist_highd13$dist_highd * scale_factor_assign2
  d23 <- dist_highd23$dist_highd * scale_factor_assign3

  # Step 3: Adjust cluster centers based on target distances
  center1 <- centers[,1]
  center2 <- center1 + c(d12, 0, 0, 0)  # Set Cluster 2 along one axis

  # Optimizing position of Cluster 3
  center3 <- optim(
    par = c(10, 10, 10, 10),
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
  colnames(final_clusters)[1:4] <- paste0("x", 1:4)

  # Convert to tibble
  final_clusters <- as_tibble(final_clusters)

  ## To standardized data
  final_clusters <- final_clusters |>
    mutate(across(-cluster, ~ (. - mean(.)) / sd(.)))

  ## To get the high_d data
  high_d_data <- append(high_d_data, lst(final_clusters))

}

all_dt_structures <- all_dt_structures |>
  select(-high_d_data, -scale_factor) |>
  mutate(high_d_data = high_d_data) |>
  mutate(scale_factor = scale_factor_assign) |>
  dplyr::select(dataset, num_clust, scale_factor, sample_size, num_noise,
                bkg_noise, high_d_data, start_high_d)

write_rds(all_dt_structures, here::here(paste0("data/high_d_data_three_close_clust_sf", scale_factor_assign, ".rds")))

