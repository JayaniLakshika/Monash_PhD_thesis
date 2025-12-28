## This script contains the approaches to compute the optimal sample size with power analysis

library(simr)
library(readr)
library(dplyr)
library(tidyr)

set.seed(20250106)

### Preprocessing

results_df_method_ds <- read_rds(here::here("data/result_method_ds_factor.rds"))

## To reformat the response variable
results_df_method_ds <- results_df_method_ds |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_ds <- results_df_method_ds |>
  mutate(distance_factor = as.factor(distance_factor))

#Set PCA as base
results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("pca", "tsne", "umap", "phate", "trimap", "pacmap")))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

### Approach 1: with existing data (https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.12504)

model1 <- glmer(result ~ distance_factor + (1 | subject),
                data = results_df_method_ds,
                family = "binomial",
                control = glmerControl(optimizer = "bobyqa",
                                       optCtrl = list(maxfun = 1e5)))

#doTest(model1, fixed("distance_factor", "lr"))

#### Simulate power
powerSim(model1)
#powerSim(model1, fixed("distance_factor", "lr"), nsim=500)

#### Power curve
model2 <- extend(model1, along = "subject", n = 100)
#fixef(model2)["distance_factor0.6"] <- 0.3
#fixef(model2)["distance_factor1"] <- 0.5
#powerSim(model2)
#powerSim(model2, fixed("distance_factor", "lr"), nsim=500)
#pc2 <- powerCurve(model2, fixed("distance_factor", "lr"), along = "subject")
#print(pc2)
#plot(pc2)
pc2 <- powerCurve(model2, along = "subject")
print(pc2)

########################################################

### Approach 2: with simulated data

# Define parameters
sim_data <- tibble::tibble(
  distance = factor(c(0.1, 0.6, 1))
)

num_subjects <- seq(5, 200, by = 5)  # Number of subjects from 5 to 100
sim_data <- expand_grid(sim_data, num_subjects)

# Define subject-specific detection proportions
effect_size1 <- runif(length(num_subjects), 0.2, 0.5)  # For distance 0.1
effect_size2 <- runif(length(num_subjects), 0.3, 0.6)  # For distance 0.6
effect_size3 <- runif(length(num_subjects), 0.6, 0.9)  # For distance 1

sim_data <- sim_data |>
  mutate(detection_prop = c(effect_size1, effect_size2, effect_size3))

# Subject-specific variance (random intercept effect)
sim_data <- sim_data |>
  mutate(
    subject_effect = rnorm(nrow(sim_data), mean = 0, sd = 1)  # Random intercept variance
  )

# To generate data from binomial distribution
sim_num_lst <- list()

for (i in 1:NROW(sim_data)) {
  # Extract detection proportion
  prop <- sim_data |>
    filter(row_number() == i) |>
    pull(detection_prop)

  # Extract number of subjects
  num_sbj <- sim_data |>
    filter(row_number() == i) |>
    pull(num_subjects)

  # Generate subject-specific probabilities
  subject_effect <- sim_data |>
    filter(row_number() == i) |>
    pull(subject_effect)

  num_trials <- 18 * num_sbj  # Total trials = 18 per subject

  # Generate random probabilities for subjects (add subject effect)
  subject_probs <- plogis(qlogis(prop) + subject_effect)  # Logistic transformation

  # Generate binomial outcomes for each trial
  sim_num <- rbinom(n = num_trials, size = 1, prob = subject_probs)

  # Append the simulated numbers
  sim_num_lst <- append(sim_num_lst, list(sim_num))
}

# Attach the simulated numbers to the data
sim_data <- sim_data |>
  mutate(sim_num = sim_num_lst)

#### To generate the model

sim_split <- sim_data |>
  group_split(num_subjects)

sim_results <- tibble()

for(i in 1:length(sim_split)) {

  num_sbj <- sim_split[[i]] |>
    pull(num_subjects) |>
    unique()

  df <- sim_split[[i]] |>
        select(-num_subjects) |>
        unnest(sim_num) |>                     # Expand the list column
        group_by(distance) |>                  # Optional grouping for clarity
        mutate(
          success = rbinom(n(), size = 1, prob = detection_prop) # Simulate outcomes
        ) |>
        ungroup()

  df <- df |>
    mutate(subject = rep(rep(paste0("subject", sprintf("%02d", 1:num_sbj)),
                             each = 18), 3))

  model1 <- glmer(sim_num ~ distance + (1 | subject),
                  data = df,
                  family = "binomial",
                  control = glmerControl(optimizer = "bobyqa",
                                         optCtrl = list(maxfun = 1e5)))

  # Extract p-values from the model
  model_summary <- summary(model1)

  # Check if fixed effects exist and extract p-values
  #if ("fixed" %in% names(model_summary)) {
  p_values <- coef(model_summary)[, "Pr(>|z|)"]

  power <- length(p_values[p_values <= 0.05])/(18*num_sbj)
  sim_results <- bind_rows(sim_results,
                           tibble(num_subjects = num_sbj, power = power))

    # # Record significance for distance and interaction effects
    # significant_counts$distance <- significant_counts$distance + (p_values["distance"] < 0.05)
    # significant_counts$interaction <- significant_counts$interaction + (p_values["distance:nldr"] < 0.05)
  #}

}

ggplot(sim_results, aes(x = num_subjects, y = power)) +
  geom_line() +
  #geom_hline(yintercept = 0.8, linetype = "dashed", color = "red") +  # 80% power threshold
  labs(
    title = "Power Analysis for GLMM",
    x = "Number of Subjects",
    y = "Power"
  ) +
  theme_minimal()

########################################################

### Approach 3: with existing data

summary(model1)
fixef(model1)["distance0.6"] <- 0.3
fixef(model1)["distance1"] <- 0.5

powerSim(model1, fixed("distance", "lr"), nsim=50)
xtabs(~distance_factor+subject, data = results_df_method_ds)

#### extend by increasing number of subjects
full1 <- extend(model1, along = "subject", n=36)
powerSim(full1, fixed("distance", "lr"), nsim=50)
powerCurve(full1, fixed("distance", "lr"), along = "subject")

########################################################

### Approach 3: with simulate data

# Define parameters
sim_data <- tibble::tibble(
  distance = factor(c(0.1, 0.6, 1))
)

num_subjects <- seq(5, 200, by = 5)  # Number of subjects from 5 to 100
sim_data <- expand_grid(sim_data, num_subjects)

# Define subject-specific detection proportions
effect_size1 <- runif(length(num_subjects), 0.2, 0.5)  # For distance 0.1
effect_size2 <- runif(length(num_subjects), 0.3, 0.6)  # For distance 0.6
effect_size3 <- runif(length(num_subjects), 0.6, 0.9)  # For distance 1

sim_data <- sim_data |>
  mutate(detection_prop = c(effect_size1, effect_size2, effect_size3))

# Subject-specific variance (random intercept effect)
sim_data <- sim_data |>
  mutate(
    subject_effect = rnorm(nrow(sim_data), mean = 0, sd = 0.2)  # Random intercept variance
  )

# To generate data from binomial distribution
sim_num_lst <- list()

for (i in 1:NROW(sim_data)) {
  # Extract detection proportion
  prop <- sim_data |>
    filter(row_number() == i) |>
    pull(detection_prop)

  # Extract number of subjects
  num_sbj <- sim_data |>
    filter(row_number() == i) |>
    pull(num_subjects)

  # Generate subject-specific probabilities
  subject_effect <- sim_data |>
    filter(row_number() == i) |>
    pull(subject_effect)

  num_trials <- 18 * num_sbj  # Total trials = 18 per subject

  # Generate random probabilities for subjects (add subject effect)
  subject_probs <- plogis(qlogis(prop) + subject_effect)  # Logistic transformation

  # Generate binomial outcomes for each trial
  sim_num <- rbinom(n = num_trials, size = 1, prob = subject_probs)

  # Append the simulated numbers
  sim_num_lst <- append(sim_num_lst, list(sim_num))
}

# Attach the simulated numbers to the data
sim_data <- sim_data |>
  mutate(sim_num = sim_num_lst)

######################################################
### With effectsize pkg (https://easystats.github.io/effectsize/articles/interpret.html)
library(effectsize)

full_model <- glmer(result ~ method * distance_factor + (1 | subject),
                data = results_df_method_ds,
                family = "binomial",
                control = glmerControl(optimizer = "bobyqa",
                                       optCtrl = list(maxfun = 1e5)))

parameters::model_parameters(full_model)

# Convert OR (the coefficient) to d
oddsratio_to_d(0.25755, log = FALSE)
oddsratio_to_d(5.26709666872577e-08, log = FALSE)

interpret_oddsratio(0.586625, rules = "cohen1988")
interpret_oddsratio(1.161564, rules = "cohen1988")
interpret_oddsratio(0.244402, rules = "cohen1988")
interpret_oddsratio(0.871621, rules = "cohen1988")
interpret_oddsratio(1.985074, rules = "cohen1988")

interpret_oddsratio(-0.005722, rules = "cohen1988")
interpret_oddsratio(2.339003, rules = "cohen1988")
interpret_oddsratio(0.244406, rules = "cohen1988")
interpret_oddsratio(1.208965, rules = "cohen1988")
interpret_oddsratio(2.862424, rules = "cohen1988")

