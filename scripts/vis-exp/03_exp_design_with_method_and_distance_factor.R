## This is the experiment design for the methods and distance factors
library(readr)
library(dplyr)
library(tibble)
library(ggplot2)
library(tidyr)
set.seed(20241101)

conflicted::conflict_prefer("select", "dplyr")
conflicted::conflict_prefer("filter", "dplyr")

## To generate non consecutive attempts
generate_non_consecutive_sample <- function(n, range) {
  repeat {
    sample_vec <- sample(range)
    if (all(diff(sample_vec) != 1)) {
      return(sample_vec)
    }
  }
}

###########SAME
method <- c("tsne", "umap", "phate", "trimap", "pacmap", "pca")
distance_factor <- c(0.1, 0.6, 1)
structure <- paste0("three_clust_", sprintf("%02d", 1:18))
subject_vec <- paste0("subject", sprintf("%02d", 1:36))
## Add remaining columns
sample_size <- 7500
hyper_parameter_setting <- "default"
is_same <- "SAME"
is_attention_check <- "NO"
#attempt <- c(1:4, 6:8, 10, 11, 13:15, 17:20, 22, 23)
#structure <- paste0("three_clust_", sprintf("%02d", 1:18))
num_clust <- 3
num_noise <- 0
bkg_noise <- 0

## Randomize the attempt
structure_vec <- unlist(replicate(36, sample(structure), simplify = FALSE))

design_same <- expand_grid(method = method, distance_factor = distance_factor) |>
  slice(rep(1:n(), times = 36)) |>
  mutate(structure_2d = structure_vec) |>
  mutate(structure_high_d = structure_vec) |>
  mutate(sample_size = sample_size,
         hyper_parameter_setting = hyper_parameter_setting,
         is_same = is_same,
         is_attention_check = is_attention_check,
         num_clust = num_clust,
         num_noise = num_noise,
         bkg_noise = bkg_noise,
         subject = rep(subject_vec, each = 18)) |>
  select(subject, is_same, is_attention_check, sample_size, num_clust, num_noise, bkg_noise,
         hyper_parameter_setting, method, distance_factor, structure_2d, structure_high_d)

###########Attention check

subject <- paste0("subject", sprintf("%02d", 1:36))
method <- c("umap", "pacmap", "trimap")
sample_size <- 7500
hyper_parameter_setting <- "default"
is_same <- rep(c("SAME", "DIFFERENT"), times = 18)
is_attention_check <- "YES"
distance_factor <- 1
structure_2d <- rep(c("three_clust_29", "three_clust_30"), 18)
structure_high_d <- "three_clust_29"
num_noise <- 0
bkg_noise <- 0

design_attention_check <- tibble(
         subject = subject,
         method = rep(method, 12),
         distance_factor = distance_factor,
         sample_size = sample_size,
         hyper_parameter_setting = hyper_parameter_setting,
         is_same = is_same,
         is_attention_check = is_attention_check,
         structure_2d = structure_2d,
         structure_high_d = structure_high_d,
         num_clust = num_clust,
         num_noise = num_noise,
         bkg_noise = bkg_noise) |>
  select(subject, is_same, is_attention_check, sample_size, num_clust, num_noise, bkg_noise,
         hyper_parameter_setting, method, distance_factor, structure_2d, structure_high_d)


###########DIFFERENT

subject <- paste0("subject", sprintf("%02d", 1:36))
method <- c("pacmap", "umap", "trimap", "pacmap",
            "trimap", "pacmap", "umap", "trimap",
            "pacmap", "trimap", "pacmap", "umap")
sample_size <- 7500
hyper_parameter_setting <- "default"
is_same <- "DIFFERENT"
is_attention_check <- "NO"
num_clust <- 3
num_noise <- 0
bkg_noise <- 0

## To obtain different combinations
all_comb_diff <- tibble(
  ds_vec1 = c(19, 21, 25, 26,
              19, 21, 25, 26,
              19, 21, 25, 26),
  ds_vec2 = c(20, 23, 28, 27,
              20, 23, 28, 27,
              20, 23, 28, 27)
)

all_comb_diff_swap <- all_comb_diff[,c(2, 1)] |>
  rename(c("ds_vec1" = "ds_vec2",
           "ds_vec2" = "ds_vec1"))

all_comb_diff <- bind_rows(all_comb_diff, all_comb_diff_swap)

structure_2d <- paste0("three_clust_", sprintf("%02d", all_comb_diff$ds_vec1))
structure_high_d <- paste0("three_clust_", sprintf("%02d", all_comb_diff$ds_vec2))

design_different <- tibble(
  subject = rep(subject, each = 4),
  method = rep(method, times = 12),
  sample_size = sample_size,
  is_same = is_same,
  hyper_parameter_setting = hyper_parameter_setting,
  is_attention_check = is_attention_check,
  structure_2d = rep(structure_2d, times = 6),
  structure_high_d = rep(structure_high_d, times = 6),
  distance_factor = 1,
  num_clust = num_clust,
  num_noise = num_noise,
  bkg_noise = bkg_noise
) |>
  select(subject, is_same, is_attention_check, sample_size, num_clust, num_noise, bkg_noise,
         hyper_parameter_setting, method, distance_factor, structure_2d, structure_high_d)

# design_same <- design_same |>
#   arrange(subject) |>
#   group_by(subject) |> # Group by the 'Group' variable
#   slice_sample(n = 648) |> # Shuffle the rows within each group
#   ungroup()
#
# design_different <- design_different |>
#   arrange(subject) |>
#   group_by(subject) |> # Group by the 'Group' variable
#   slice_sample(n = 144) |> # Shuffle the rows within each group
#   ungroup()

design <- bind_rows(design_same,
                    design_attention_check,
                    design_different)

## Randomize the attempt
#attempt_vec <- unlist(replicate(36, sample(1:23), simplify = FALSE))
attempt_vec <- unlist(replicate(36, generate_non_consecutive_sample(23, 1:23), simplify = FALSE))

design <- design |>
  arrange(subject) |>
  group_by(subject) |> # Group by the 'Group' variable
  slice_sample(n = 828) |> # Shuffle the rows within each group
  ungroup() |>
  mutate(attempt = attempt_vec) |>
  select(subject, attempt,is_same, is_attention_check, sample_size, num_clust, num_noise, bkg_noise,
         hyper_parameter_setting, method, distance_factor, structure_2d, structure_high_d) |>
  arrange(subject, attempt)

write_rds(design, "data/experiment_design_with_methods_and_distance_factor.rds")

### Validate

design_df_same <- design |>
  filter(is_same == "SAME") |>
  filter(is_attention_check == "NO")

# For subject
ggplot(design_df_same, aes(x=subject)) +
  geom_bar() +
  coord_flip()

# Allocation of NLDR
ggplot(design_df_same, aes(x=method)) +
  geom_bar() +
  coord_flip()

# Allocation by participant of 2D data and NLDR
ggplot(design_df_same, aes(y=method, x=structure_2d)) +
  geom_jitter(width=0.3, height=0.2) +
  facet_wrap(~subject, ncol=5) +
  scale_x_discrete(drop=FALSE) +
  scale_y_discrete(drop=FALSE) +
  theme(axis.text.x=element_text(angle=90, size = 5))


# Allocation by participant of 2D data and NLDR
ggplot(design_df_same, aes(y=method, x=as.factor(distance_factor))) +
  geom_jitter(width=0.3, height=0.2) +
  facet_wrap(~structure_2d, ncol=5) +
  scale_x_discrete(drop=FALSE) +
  scale_y_discrete(drop=FALSE) +
  theme(axis.text.x=element_text(angle=90, size = 5))

