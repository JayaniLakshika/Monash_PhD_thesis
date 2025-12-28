library(pwr)
library(tidyverse)

# Define proportions
p1 <- 0.333  # Proportion for group 1
p2 <- 0.5   # Proportion for group 2

# Calculate effect size
h <- ES.h(p1, p2)

# Generate power values for a range of sample sizes
sample_sizes <- seq(10, 200, by = 10)  # Sample sizes to evaluate
power_values <- sapply(sample_sizes, function(n) {
  pwr.2p.test(h = h, n = n, sig.level = 0.05, alternative = "less")$power
})

# Create a data frame for plotting
power_curve_df <- data.frame(SampleSize = sample_sizes, Power = power_values)

# Plot the power curve using ggplot2
ggplot(power_curve_df, aes(x = SampleSize, y = Power)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  geom_hline(yintercept = 0.8, linetype = "dashed", color = "darkgreen") +
  labs(
    title = "Power Curve",
    x = "Sample Size per Group",
    y = "Power"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  )
