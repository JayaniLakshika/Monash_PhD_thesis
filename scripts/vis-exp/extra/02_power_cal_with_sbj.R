library(tidyverse)

# Define parameters
sim_data <- tibble::tibble(
  distance = factor(c(0.1, 0.6, 1))
)

num_subjects <- seq(5, 200, by = 5)  # Number of subjects from 5 to 100
sim_data <- expand_grid(sim_data, num_subjects)

ntrials <- 10
prob <- NULL
dif <- NULL; pval <- NULL; pdetect <- NULL
for (i in 1:ntrials) {
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
      ungroup()

    df <- df |>
      mutate(subject = rep(rep(paste0("subject", sprintf("%02d", 1:num_sbj)),
                               each = 18), 3))

    d1 <- df |> filter(distance == 0.1) |> pull(sim_num)
    d2 <- df |> filter(distance == 1) |> pull(sim_num)
    n <- length(unique(df$subject)) * 18

    dif <- c(dif, (sum(d1)-sum(d2))/n)
    pval <- c(pval, prop.test(x=c(sum(d1), sum(d2)), n=c(n, n),
                              alternative="less")$p.value)
    pdetect <- c(pdetect,
                 ifelse(prop.test(x=c(sum(d1), sum(d2)), n=c(n, n),
                                  alternative="less")$p.value < 0.05, 1, 0))


  }
  prob <- rbind(prob, cbind(n, p2, mean(dif), mean(pval), sum(pdetect)/ntrials))

}

prob_tb <- tibble(n = prob[,1],
                  p = prob[,2]-p1,
                  dif = prob[,3],
                  pval = prob[,4],
                  pdetect = prob[,5]
) |>
  mutate(sig = ifelse(pval < 0.05, "yes", "no"))
ggplot(prob_tb, aes(x=n, y=p, fill=sig)) +
  geom_tile() +
  theme_minimal()

ggplot(prob_tb, aes(x=n, y=pval, group=p, colour=p)) +
  geom_hline(yintercept=0.05) +
  geom_line() +
  theme_minimal()

ggplot(prob_tb, aes(x=n, y=pdetect, group=p, colour=p)) +
  geom_line() +
  geom_hline(yintercept = 0.95) +
  theme_minimal()
