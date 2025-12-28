
# Simulation function for power analysis
simulate_power <- function(effect_size, num_trials, alpha = 0.05) {
  # Generate random binomial outcomes under the alternative hypothesis
  successes <- rbinom(num_trials, size = 1, prob = effect_size)

  # Compute Z-scores for each simulation
  z_scores <- (successes - num_trials * effect_size) /
    sqrt(num_trials * effect_size * (1 - effect_size))

  # Compute two-sided p-values
  p_values <- 2 * (1 - pnorm(abs(z_scores)))

  # Calculate power as the proportion of significant tests
  power <- mean(p_values < alpha)
  return(power)
}

distance_factor <- c(0.1, 0.6, 1)
num_trials <- seq(6, 100, by = 3)
sim_design <- expand_grid(distance_factor = distance_factor,
                          num_trials = num_trials)

sim_design1 <- sim_design |>
  filter(distance_factor == 0.1) |>
  mutate(effect_size = sample(seq(0.2, 0.5, 0.1), 32, replace = TRUE)) |>
  mutate(detect_prop = 0.3)

# Perform power simulations for each design combination
sim_results <- sim_design1 |>
  rowwise() |>
  mutate(power = simulate_power(effect_size, num_trials)) |>
  ungroup()

ggplot(sim_results, aes(x = num_trials, y = power, color = factor(effect_size))) +
  geom_line() +
  facet_wrap(~ distance_factor, scales = "free") +
  labs(
    title = "Power Analysis for Binomial Test",
    x = "Number of Trials",
    y = "Power",
    color = "Effect Size"
  ) +
  theme_minimal()

# sim_design <- sim_design |>
#   mutate(effect_size = if_else(
#     distance_factor == 0.1, sample(seq(0.2, 0.5, 0.05), 32, replace = TRUE),
#     if_else(
#       distance_factor == 0.6, sample(seq(0.3, 0.6, 0.05), 32, replace = TRUE),
#       sample(seq(0.6, 0.9, 0.05), 32, replace = TRUE)
#     )
#   ))
