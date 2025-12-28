plot_data_structures_with_diff_dist <- function(structure, nldr){

  nldr1 <- get_embeddings(dt_structutre = structure) |>
    filter(method == nldr)

  nld_plt1 <- ggplot(
    data = nldr1,
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(alpha=0.2, size=1, colour = clr_choice) +
    facet_wrap(~scale_factor, scales = "free") +
    theme(aspect.ratio = 1)

  nld_plt1


}

results_df_tsne_all <- results_df_method_ds |>
  filter(method == "tsne")

## To fit the logistic model
model_main_results_tsne_all <- glmer(result ~ distance_factor + (1 | subject),
                                  data = results_df_tsne_all,
                                  family = "binomial",
                                  control = glmerControl(optimizer = "bobyqa",
                                                         optCtrl = list(maxfun = 1e5)))

library(ggplot2)

emm1_1 <- emmeans(model_main_results_tsne_all, specs = ~ distance_factor,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."))

emm1_1 <- tidy(emm1_1, effects = "fixed")

# Plot the estimated probabilities with confidence intervals
p_tsne <- ggplot(emm1_1, aes(x = distance_factor, y = prob, group = 1)) +
  geom_line(position = position_dodge(width = 0.2)) +
  geom_point(size = 3, position = position_dodge(width = 0.2)) +  # Adjust for separation
  # geom_errorbar(aes(ymin = prob - std.error, ymax = prob + std.error),
  #               width = 0.1, position = position_dodge(width = 0.2)) +
  theme_minimal() +
  theme(legend.position = "none") +
  xlab("Distance Scale Factors") +
  ylab("Estimated Probability")

plot_data_structures_with_diff_dist("three_clust_18", "tsne")

results_df_tsne1 <- results_df_method_ds |>
  filter(structure_2d == "three_clust_18") |>
  filter(method == "tsne")

## To fit the logistic model
model_main_results_tsne1 <- glmer(result ~ distance_factor + (1 | subject),
                                  data = results_df_tsne1,
                                  family = "binomial",
                                  control = glmerControl(optimizer = "bobyqa",
                                                         optCtrl = list(maxfun = 1e5)))

emm1_2 <- emmeans(model_main_results_tsne1, specs = ~ distance_factor,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."))

emm1_2 <- tidy(emm1_2, effects = "fixed")

p_tsne +
  geom_line(data = emm1_2,
            aes(x = distance_factor, y = prob, group = 1),
            position = position_dodge(width = 0.2),
            colour = "red") +
  geom_point(data = emm1_2,
            aes(x = distance_factor, y = prob, group = 1),
            position = position_dodge(width = 0.2),
            colour = "red")
