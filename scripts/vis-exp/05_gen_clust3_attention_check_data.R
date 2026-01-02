#### This script contains functions to generate the data structures for attention check

###Gaussian clusters with different clusters and the number of data points is 7500
library(tibble)
library(readr)
library(dplyr)

set.seed(115472246)

source(here::here("R/01_attention_check_data_structures.R"))

## Generate the all the combinations of data structures

dataset <- "gau_clust"
num_clust <- c(3, 4)
sample_size <- 7500

var_values <- lst(
  c(0.1, 0.1, 0.1),
  c(0.1, 0.1, 0.1, 0.1)
)

mean_matrix_vec <- lst(
  matrix(c(
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 1) , ncol = 4, byrow = TRUE),
  matrix(c(
    1, 0, 0, 1,
    0, 1, 1, 0,
    1, 0, 1, 0,
    0, 1, 0, 1) , ncol = 4, byrow = TRUE)
)

all_dt_strcutures <- tibble(dataset = dataset,
                            num_clust = num_clust,
                            clust_mean = mean_matrix_vec,
                            clust_var = var_values,
                            sample_size = sample_size)

## Added high_d_data into a column
high_d_data <- c()

for (row in 1:2) {

  ## To get the function name
  function_name <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(dataset)

  function_name <- get(function_name[1])

  ## To get the mean
  mean_matrix <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(clust_mean)

  mean_matrix <- mean_matrix[1][[1]]

  ## To get the variance
  var_vec <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(clust_var)

  var_vec <- var_vec[1][[1]]

  ## To get the variance
  num_clust <- all_dt_strcutures |>
    filter(row_number() == row) |>
    pull(num_clust)

  num_clust <- num_clust[1]

  generated_high_d_data <- function_name(n = 7500,
                num_clust = num_clust,
                mean_matrix = mean_matrix,
                var_vec = var_vec,
                num_dims = 4)

  # generated_high_d_data <- generated_high_d_data |>
  #   mutate(across(-cluster, ~ (. - mean(.)) / sd(.)))

  ## To get the high_d data
  high_d_data <- append(high_d_data, lst(generated_high_d_data))

}

all_dt_strcutures <- all_dt_strcutures |>
  mutate(high_d_data = high_d_data) |>
  mutate(start_high_d = 115472246) |>
  mutate(scale_factor = 1) |>
  mutate(num_noise = 0) |>
  mutate(bkg_noise = 0) |>
  mutate(dataset = paste0("three_clust_", sprintf("%02d", 29:30))) |>
  dplyr::select(dataset, num_clust, scale_factor, sample_size, num_noise,
                bkg_noise, high_d_data, start_high_d)

write_rds(all_dt_strcutures, here::here("data/high_d_data_three_clust_attention_check.rds"))

