# This code is used to create the result_method_ds_factor_missings.rds file
# You should only have to do this once.

library(readr)
library(dplyr)
library(janitor)
library(conflicted)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::lag)

## To read the design
design_df <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings.rds"))
design_df2 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch02.rds"))
design_df3 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch03.rds"))

design_df <- bind_rows(design_df, design_df2, design_df3)

## To read the results
results_df <- read_csv(here::here("data/collected_data/method_with_distance_sf/result_df_missings.csv"))
demographics_df <- read_csv(here::here("data/collected_data/method_with_distance_sf/demographic_details_missings.csv"))

## To combine results with demographics
data_all <- inner_join(results_df, demographics_df,
                       by = c("prolific_id", "user_id"))

## To combine with the experiment design
data_all <- left_join(data_all, design_df,
                      c("subject", "attempt"))

## Who completed 20 trials

prolific_users_keep_df <- data_all |>
  count(prolific_id, user_id, subject) |>
  filter(n == 20)

data_all <- inner_join(data_all, prolific_users_keep_df,
                       by = c("prolific_id", "user_id", "subject"))

## Removed the subjects who didn't attempt the attention check correctly
subject_keep <- data_all |>
  filter(is_attention_check == "YES") |>
  filter(result == "Correct") |>
  pull(subject)

data_all <- data_all |>
  filter(subject %in% subject_keep)

## Removed the prolific users that didn't complete the 23 attempts
# prolific_users_keep <- data_all |>
#   count(prolific_id, subject) |>
#   filter(n == 23) |>
#   pull(prolific_id)
#
# data_all <- data_all |>
#   filter(prolific_id %in% prolific_users_keep)



## Reformat the start_time column
data_all <- data_all |>
  group_by(subject) |>
  mutate(start_time = if_else(row_number() == 1, start_time, lag(end_time))) |>
  ungroup()

## Compute the time taken by each participant in each attempt
data_all <- data_all |>
  mutate(time_taken_in_minutes = difftime(end_time, start_time, units = "mins"))

## Remove user_id and prolific_id
data_all <- data_all |>
  select(-user_id, -prolific_id)

## Only filter the is_same ==SAME and non-attention check

data_all <- data_all |>
  filter(is_same == "SAME") |>
  filter(is_attention_check == "NO")

write_rds(data_all, here::here("data/result_method_ds_factor_missings.rds"))
