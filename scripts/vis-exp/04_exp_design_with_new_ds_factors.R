## This script is to design the experiment with new distance categories along
## with 0.1, 0.6, and 1

library(tidyverse)
set.seed(20241103)

experiment_design_ds <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor.rds")) |>
  filter(method != "pca") |>
  filter(subject %in% paste0("subject", sprintf("%02d", 1:20)))

experiment_design_ds_missing1 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings.rds")) |>
  filter(method != "pca")

experiment_design_ds_missing2 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch02.rds")) |>
  filter(method != "pca")

experiment_design_ds_missing3 <- read_rds(here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch03.rds")) |>
  filter(method != "pca")

experiment_design_ds <- bind_rows(experiment_design_ds, experiment_design_ds_missing1, experiment_design_ds_missing2, experiment_design_ds_missing3)

uniq_subj <- length(unique(experiment_design_ds$subject))

## Replace all 0.6 by 0.9

experiment_design_ds_new <- experiment_design_ds |>
  mutate(distance_factor = if_else(distance_factor == 0.1, 0.9, distance_factor))

## Replace all 1 by 1.1 (is_attention_check == FALSE, is_same == SAME)

experiment_design_ds_new <- experiment_design_ds_new |>
  mutate(distance_factor = if_else(distance_factor == 1 & is_attention_check == "NO" & is_same == "SAME", 1.1, distance_factor))

## Replace 0.1 by 0.1, 0.6 and 1. But considering the number of occurrences.
# --- 1. Identify and order unique subjects ---
# Get all unique subject IDs and sort them numerically.
unique_subjects <- sort(unique(experiment_design_ds_new$subject))
n_unique_subjects <- length(unique_subjects)

# Check if there are enough subjects for the desired groups
if (n_unique_subjects < (22 * 3)) {
  message("Warning: Not enough unique subjects to fill three groups of 22. Adjusting group sizes.")
  # You might want to handle this warning more robustly, e.g., by stopping
  # or adjusting the logic based on available subjects.
}

# --- 2. Define subject groups randomly without replacement ---
# Randomly shuffle the unique subjects.
shuffled_subjects <- sample(unique_subjects, size = n_unique_subjects, replace = FALSE)

# Assign subjects to groups sequentially from the shuffled list.
# Ensure not to go out of bounds if there are fewer than 66 subjects.
subjects_group_0.1 <- shuffled_subjects[1:min(22, n_unique_subjects)]

# Determine the start and end indices for the second group.
# It starts after the first group and takes up to 22 subjects.
start_idx_0.6 <- min(22, n_unique_subjects) + 1
end_idx_0.6 <- min(44, n_unique_subjects)
subjects_group_0.6 <- shuffled_subjects[start_idx_0.6:end_idx_0.6]

# Determine the start and end indices for the third group.
# It starts after the second group and takes the rest of the subjects.
start_idx_1.0 <- min(44, n_unique_subjects) + 1
end_idx_1.0 <- n_unique_subjects
subjects_group_1.0 <- shuffled_subjects[start_idx_1.0:end_idx_1.0]

# --- 3. Apply conditional replacement based on subject groups ---
experiment_design_ds_new <- experiment_design_ds_new |>
  mutate(
    distance_factor = if_else(
      # Condition for the first group of subjects (0.1 assignment)
      subject %in% subjects_group_0.1 & distance_factor == 0.6,
      0.1,
      if_else(
        # Condition for the second group of subjects (0.6 assignment)
        subject %in% subjects_group_0.6 & distance_factor == 0.6,
        0.6,
        if_else(
          # Condition for the third group of subjects (1.0 assignment)
          subject %in% subjects_group_1.0 & distance_factor == 0.6,
          1.0,
          # Default: if none of the above conditions met, keep original distance_factor
          distance_factor
        )
      )
    )
  )

experiment_design_ds_new <- experiment_design_ds_new |>
  # group_by(subject, structure_2d) |>
  # mutate(distance_factor = ifelse(distance_factor == 0.6,
  #                                 {
  #                                   # Get how many need replacing in this group
  #                                   n_replace <- sum(distance_factor == 0.6)
  #
  #                                   # Values to assign equally
  #                                   vals <- c(0.1, 0.6, 1.0)
  #
  #                                   # Repeat equally, then sample for randomness
  #                                   rep_vals <- rep(vals, length.out = n_replace)
  #                                   sample(rep_vals, size = n_replace)
  #                                 },
  #                                 distance_factor)) |>
  # ungroup() |>
  arrange(subject, attempt) |>
  mutate(subject = rep(paste0("subject", sprintf("%02d", 67:(66 + uniq_subj))), each = 20)) |>
  mutate(attempt = rep(1:20, 66))

## To check number of distance factors
experiment_design_ds_new |>
  filter(is_same == "SAME", is_attention_check == "NO") |>
  count(distance_factor, sort = TRUE) |>
  View()

## Write to file
write_rds(experiment_design_ds_new, here::here("data/experiment_design_with_methods_and_distance_factor_missings_batch04.rds"))

## To check all responses are worth of adding
experiment_design_ds_all <- bind_rows(experiment_design_ds, experiment_design_ds_new)

## To check that each have at least 3 responses
experiment_design_ds_all |>
  filter(is_same == "SAME", is_attention_check == "NO") |>
  count(structure_2d, method, distance_factor, sort = TRUE) |>
  View()

## To check number of distance factors
experiment_design_ds_all |>
  filter(is_same == "SAME", is_attention_check == "NO") |>
  count(distance_factor, sort = TRUE) |>
  View()

