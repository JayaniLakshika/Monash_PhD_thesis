run_simulation <- function(num_subjects_seq, num_trials_per_subject = 18, sd_subject_effect = 0.8) {
  # Generate data
  sim_data <- expand_grid(
    distance = factor(c(0.1, 1), levels = c(0.1, 1)),
    num_subjects = num_subjects_seq
  ) |>
    mutate(
      detection_prop = ifelse(distance == 0.1, 0.3, 0.6),
      subject_effect = rnorm(n(), mean = 0, sd = sd_subject_effect)
    )

  # Simulate binomial outcomes
  sim_data <- sim_data |>
    rowwise() |>
    mutate(
      sim_num = list(rbinom(
        n = num_trials_per_subject * num_subjects,
        size = 1,
        prob = plogis(qlogis(detection_prop) + subject_effect)
      ))
    ) |>
    ungroup()

  # Fit models for each number of subjects
  sim_split <- sim_data |>
    group_split(num_subjects)

  fit_model <- function(df) {
    df <- df |>
      unnest(sim_num) |>
      mutate(subject = rep(paste0("subject", sprintf("%02d", 1:unique(df$num_subjects))),
                           each = num_trials_per_subject * 2))
    glmer(
      sim_num ~ distance + (1 | subject),
      data = df,
      family = binomial(link = "logit"),
      control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 1e5))
    )
  }

  models <- map(sim_split, fit_model)

  # Extract p-values
  get_p_value <- function(model) {
    summary(model)$coefficients["distance1", "Pr(>|z|)"]
  }

  p_values <- map_dbl(models, get_p_value)

  tibble(
    num_subjects = num_subjects_seq,
    p_values = p_values
  )
}

# Parameters
num_subjects_seq <- seq(5, 100, by = 5)  # Range of subject sizes
num_simulations <- 1000                   # Number of iterations

# Run simulations
all_results <- map_dfr(1:num_simulations, ~ run_simulation(num_subjects_seq))

# Compute power for each number of subjects
power_results <- all_results |>
  group_by(num_subjects) |>
  summarise(power = mean(p_values < 0.05))

print(power_results)

library(ggplot2)

ggplot(power_results, aes(x = num_subjects, y = power)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Power Curve",
    x = "Number of Subjects",
    y = "Power"
  ) +
  theme_minimal()
