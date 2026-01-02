## Embedding data with defaults
library(readr)
library(dplyr)

## Combine dist data
data_df1 <- read_rds(here::here("data/embedding_data_three_close_clust_sf1.rds")) #All (Done)
data_df2 <- read_rds(here::here("data/embedding_data_three_close_clust_sf0.1.rds")) #All (Done)
data_df3 <- read_rds(here::here("data/embedding_data_three_close_clust_sf0.6.rds")) #All (Done)
data_df4 <- read_rds(here::here("data/embedding_data_three_close_clust_sf0.9_scaled.rds")) #All (Done)
data_df5 <- read_rds(here::here("data/embedding_data_three_close_clust_sf1.1_scaled.rds")) #All (Done)

## Combine noise data
data_noise1 <- read_rds(here::here("data/embedding_data_three_close_clust_noise_dim2.rds")) #All (Done)
data_noise2 <- read_rds(here::here("data/embedding_data_three_close_clust_noise_dim6.rds")) #All (Done)

## Combine bkg noise data
data_bkgnoise1 <- read_rds(here::here("data/embedding_data_three_close_clust_bkg_noise_0.2.rds")) #All (Done)
data_bkgnoise2 <- read_rds(here::here("data/embedding_data_three_close_clust_bkg_noise_0.4.rds")) #All

data <- bind_rows(data_df1,
                  data_df2,
                  data_df3,
                  data_df4,
                  data_df5,
                  data_noise1,
                  data_noise2,
                  data_bkgnoise1,
                  data_bkgnoise2)

write_rds(data, here::here(paste0("data/embedding_data_three_clust_default.rds")))
