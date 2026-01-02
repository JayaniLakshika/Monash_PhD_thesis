## This script is to combine attention check and non-attention check data
## of sample_size == 7500, num_noise == 0, bkg_noise == 0 with n_neighbour is default

library(readr)
library(dplyr)

## Combine high-D data

high_d_non_at <- read_rds(here::here("data/high_d_data_three_close_clust_all.rds"))
high_d_at <- read_rds(here::here("data/high_d_data_three_clust_attention_check.rds"))

high_d_all <- bind_rows(high_d_non_at,
                        high_d_at)

write_rds(high_d_all, here::here("data/high_d_data_three_clust_all.rds"))

## Combine embedding data

embedding_non_at <- read_rds(here::here("data/embedding_data_three_clust_default.rds"))
embedding_non_at2 <- read_rds(here::here("data/embedding_data_three_clust_0.6.rds"))
embedding_non_at3 <- read_rds(here::here("data/embedding_data_three_clust_1.7.rds"))

embedding_at <- read_rds(here::here("data/embedding_data_att_three_clust_default.rds"))

embedding_non_at2 <- embedding_non_at2 |>
  mutate(n_neighbors = as.character(n_neighbors))

embedding_non_at3 <- embedding_non_at3 |>
  mutate(n_neighbors = as.character(n_neighbors))

embedding_all <- bind_rows(embedding_non_at,
                           embedding_non_at2,
                           embedding_non_at3,
                           embedding_at)

write_rds(embedding_all, here::here("data/embedding_data_three_clust_all.rds"))

